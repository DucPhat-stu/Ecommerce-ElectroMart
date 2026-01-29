/**
 * Product Detail Page Handler
 * Xử lý hiển thị thông tin chi tiết sản phẩm
 */

// API Configuration
const API_BASE_URL = "http://localhost:8080/api/v1";
const REQUEST_TIMEOUT = 8000;
const MAX_RETRIES = 3;
const RETRY_DELAY_MS = 500;
const CACHE_TTL_MS = 5 * 60 * 1000;

function wait(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function shouldRetry(error) {
  if (!error) return false;
  if (!error.response) return true;
  const status = error.response.status;
  return status >= 500 || status === 429;
}

function getWithRetry(url, options, retriesLeft) {
  const finalOptions = Object.assign({ timeout: REQUEST_TIMEOUT }, options || {});
  return axios.get(url, finalOptions).catch((error) => {
    if (retriesLeft > 0 && shouldRetry(error)) {
      return wait(RETRY_DELAY_MS).then(() => getWithRetry(url, options, retriesLeft - 1));
    }
    throw error;
  });
}

function saveCache(key, data) {
  try {
    window.localStorage.setItem(
      key,
      JSON.stringify({
        timestamp: Date.now(),
        data: data,
      })
    );
  } catch (_) {}
}

function loadCache(key) {
  try {
    const raw = window.localStorage.getItem(key);
    if (!raw) return null;
    const parsed = JSON.parse(raw);
    if (!parsed || !parsed.timestamp) return null;
    if (Date.now() - parsed.timestamp > CACHE_TTL_MS) return null;
    return parsed.data || null;
  } catch (_) {
    return null;
  }
}

/**
 * Lấy product ID từ URL query parameter
 * @returns {string|null} Product ID hoặc null nếu không tìm thấy
 */
function getProductIdFromURL() {
  const urlParams = new URLSearchParams(window.location.search);
  return urlParams.get("id");
}

/**
 * Lấy thông tin chi tiết sản phẩm từ API
 * @param {string} productId - ID của sản phẩm
 * @returns {Promise<Object>} Promise chứa dữ liệu sản phẩm
 */
async function fetchProductDetail(productId) {
  try {
    const response = await getWithRetry(`${API_BASE_URL}/product/${productId}`, null, MAX_RETRIES).catch(() =>
      getWithRetry(`${API_BASE_URL}/products/${productId}`, null, MAX_RETRIES)
    );

    console.log("Product API Response:", response.data);

    let product = response.data;

    // Nếu API trả wrapper { success, data }
    if (product && product.data) product = product.data;

    if (product) saveCache(`product_detail_${productId}`, product);

    return product;
  } catch (error) {
    console.error("Error loading product details:", error);
    const cached = loadCache(`product_detail_${productId}`);
    if (cached) {
      console.warn("Using cached product detail due to error");
      return cached;
    }
    throw error;
  }
}

/**
 * Hiển thị hình ảnh sản phẩm
 * @param {Array} images - Mảng các hình ảnh sản phẩm
 */
function renderProductImages(images) {
  if (!Array.isArray(images) || images.length === 0) return;

  // RESET DOM tuyệt đối (FIX ảnh thừa khi F5)
  const mainImgContainer = document.getElementById("product-main-img");
  const thumbImgContainer = document.getElementById("product-imgs");

  if (mainImgContainer) mainImgContainer.innerHTML = "";
  if (thumbImgContainer) thumbImgContainer.innerHTML = "";

  // Loại duplicate theo ID
  const uniqueImages = Array.from(new Map(images.map((img) => [img.id, img])).values());

  // Sắp xếp: primary -> position
  uniqueImages.sort((a, b) => {
    if (a.isPrimary !== b.isPrimary) return b.isPrimary - a.isPrimary;
    return (a.position || 0) - (b.position || 0);
  });

  // Render main images
  if (mainImgContainer) {
    mainImgContainer.innerHTML = uniqueImages
      .map(
        (img) => `
        <div class="product-preview">
          <img src="${img.imageUrl}" alt="${escapeHtml(img.imageName || "Product image")}">
        </div>
      `
      )
      .join("");
  }

  // Render thumbnails
  if (thumbImgContainer) {
    thumbImgContainer.innerHTML = uniqueImages
      .map(
        (img) => `
        <div class="product-preview">
          <img src="${img.imageUrl}" alt="${escapeHtml(img.imageName || "Product image")}">
        </div>
      `
      )
      .join("");
  }

  // Re-init slick
  if (typeof $.fn.slick !== "undefined") {
    if ($("#product-main-img").hasClass("slick-initialized")) $("#product-main-img").slick("unslick");
    if ($("#product-imgs").hasClass("slick-initialized")) $("#product-imgs").slick("unslick");

    $("#product-main-img").slick({
      infinite: true,
      speed: 300,
      slidesToShow: 1,
      adaptiveHeight: true,
      fade: true,
      asNavFor: "#product-imgs",
    });

    $("#product-imgs").slick({
      slidesToShow: Math.min(3, uniqueImages.length),
      slidesToScroll: 1,
      arrows: true,
      centerMode: true,
      focusOnSelect: true,
      centerPadding: 0,
      vertical: true,
      asNavFor: "#product-main-img",
    });
  }

  console.log("[Images]", uniqueImages.length, uniqueImages);
}

/**
 * Tính toán giá thấp nhất từ các variants
 * @param {Array} variants - Mảng các biến thể sản phẩm
 * @returns {Object} Đối tượng chứa giá hiện tại và giá gốc
 */
function calculatePrices(variants) {
  if (!variants || variants.length === 0) {
    return { currentPrice: 0, basePrice: 0 };
  }

  let minFinalPrice = Infinity;
  let minBasePrice = Infinity;

  variants.forEach((variant) => {
    if (variant.finalPrice < minFinalPrice) minFinalPrice = variant.finalPrice;
    if (variant.basePrice && variant.basePrice < minBasePrice) minBasePrice = variant.basePrice;
  });

  return {
    currentPrice: minFinalPrice === Infinity ? 0 : minFinalPrice,
    basePrice: minBasePrice === Infinity ? 0 : minBasePrice,
  };
}

/**
 * Tính số sao trung bình từ reviews
 * @param {number} averageRating - Điểm đánh giá trung bình
 * @returns {string} HTML string cho stars rating
 */
function renderStarRating(averageRating) {
  const fullStars = Math.floor(averageRating);
  const hasHalfStar = averageRating % 1 >= 0.5;
  let starsHTML = "";

  for (let i = 0; i < fullStars; i++) starsHTML += '<i class="fa fa-star"></i>';
  if (hasHalfStar) starsHTML += '<i class="fa fa-star-half-o"></i>';

  const emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
  for (let i = 0; i < emptyStars; i++) starsHTML += '<i class="fa fa-star-o"></i>';

  return starsHTML;
}

/**
 * Hiển thị thông tin chi tiết sản phẩm
 * @param {Object} product - Dữ liệu sản phẩm
 */
function renderProductDetails(product) {
  const productNameEl = document.getElementById("product-name");
  if (productNameEl) productNameEl.textContent = product.name;

  const breadcrumbProductName = document.getElementById("breadcrumb-product-name");
  if (breadcrumbProductName) breadcrumbProductName.textContent = product.name;

  const breadcrumbCategory = document.getElementById("breadcrumb-category");
  if (breadcrumbCategory) breadcrumbCategory.textContent = product.categoryName || "Category";

  const prices = calculatePrices(product.variants);

  const priceEl = document.getElementById("product-price");
  if (priceEl) {
    let priceHTML = `$${prices.currentPrice.toFixed(2)}`;
    if (prices.basePrice > prices.currentPrice) {
      priceHTML += ` <del class="product-old-price">$${prices.basePrice.toFixed(2)}</del>`;
    }
    priceEl.innerHTML = priceHTML;
  }

  const availabilityEl = document.getElementById("product-availability");
  if (availabilityEl) {
    const isInStock = product.variants && product.variants.some((v) => v.status === "ACTIVE");
    availabilityEl.textContent = isInStock ? "In Stock" : "Out of Stock";
    availabilityEl.className = isInStock ? "product-available" : "product-unavailable";
  }

  const shortDescEl = document.getElementById("product-short-description");
  if (shortDescEl) shortDescEl.textContent = product.shortDescription || product.description || "No description available";

  const descriptionTabEl = document.getElementById("product-description-content");
  if (descriptionTabEl) {
    const description = product.description || "No detailed description available";
    descriptionTabEl.innerHTML = `<p>${escapeHtml(description)}</p>`;
  }

  const detailsTabEl = document.getElementById("product-details-content");
  if (detailsTabEl && product.details && product.details.length > 0) {
    const sortedDetails = [...product.details].sort((a, b) => a.id - b.id);
    detailsTabEl.innerHTML = sortedDetails
      .map(
        (detail) => `
        <div class="row">
          <div class="col-md-4"><strong>${escapeHtml(detail.attributeName)}:</strong></div>
          <div class="col-md-8">${escapeHtml(detail.attributeValue)}</div>
        </div>
      `
      )
      .join("");
  }

  const categoryLinksEl = document.getElementById("product-category-links");
  if (categoryLinksEl) {
    categoryLinksEl.innerHTML = `
      <li>Category:</li>
      <li><a href="#">${escapeHtml(product.categoryName || "N/A")}</a></li>
      ${product.brandName ? `<li><a href="#">${escapeHtml(product.brandName)}</a></li>` : ""}
    `;
  }

  const ratingEl = document.querySelector(".product-rating");
  if (ratingEl) {
    const averageRating = 4.0;
    ratingEl.innerHTML = renderStarRating(averageRating);
  }
}

/* =========================
   OPTION DYNAMIC (FIX RAM/CPU/GPU...)
   ========================= */

/**
 * Title case label name cho optionCode
 */
function optionLabelName(code) {
  const map = {
    storage: "Storage",
    color: "Color",
    ram: "RAM",
    cpu: "CPU",
    gpu: "GPU",
  };
  if (map[code]) return map[code];

  // fallback: Title Case
  return String(code)
    .replace(/_/g, " ")
    .replace(/\b\w/g, (c) => c.toUpperCase());
}

/**
 * Lấy danh sách optionCode từ variants (dynamic)
 * @param {Array} variants
 * @returns {string[]} ví dụ ['storage','color','ram','cpu','gpu', ...]
 */
function discoverOptionCodes(variants) {
  const set = new Set();

  variants.forEach((v) => {
    (v.options || []).forEach((opt) => {
      if (!opt || !opt.optionCode) return;
      set.add(String(opt.optionCode).toLowerCase());
    });
  });

  // ưu tiên thứ tự hiển thị
  const priority = ["storage", "color", "ram", "cpu", "gpu"];
  const arr = Array.from(set);

  arr.sort((a, b) => {
    const ia = priority.indexOf(a);
    const ib = priority.indexOf(b);
    if (ia !== -1 || ib !== -1) return (ia === -1 ? 999 : ia) - (ib === -1 ? 999 : ib);
    return a.localeCompare(b);
  });

  return arr;
}

/**
 * Build optionsData: { storage:[...], cpu:[...], ... }
 */
function buildOptionsData(variants, codes) {
  const data = {};
  (codes || []).forEach((c) => (data[c] = []));

  variants.forEach((variant) => {
    (variant.options || []).forEach((option) => {
      const code = option?.optionCode ? String(option.optionCode).toLowerCase() : null;
      if (!code || !data[code]) return;

      const value = option?.value;
      if (value === null || value === undefined || value === "") return;

      if (!data[code].includes(value)) data[code].push(value);
    });
  });

  return data;
}

/**
 * Parse giá trị option thành số để so sánh (TB/GB/MB)
 */
function parseOptionNumeric(value) {
  if (value === null || value === undefined) return null;
  const raw = String(value).trim().toLowerCase();
  const match = raw.match(/([0-9]+(?:\.[0-9]+)?)\s*(tb|gb|mb)?/);
  if (!match) return null;

  let num = parseFloat(match[1]);
  const unit = match[2];
  if (unit === "tb") num *= 1024;
  if (unit === "mb") num /= 1024;

  return isNaN(num) ? null : num;
}

/**
 * Sort optionsData ổn định: ưu tiên số nếu parse được
 */
function sortOptionsData(optionsData) {
  Object.keys(optionsData || {}).forEach((code) => {
    optionsData[code].sort((a, b) => {
      const aNum = parseOptionNumeric(a);
      const bNum = parseOptionNumeric(b);
      if (aNum !== null && bNum !== null && aNum !== bNum) return aNum - bNum;
      return String(a).localeCompare(String(b));
    });
  });
}

/**
 * Ẩn toàn bộ option label trong .product-options,
 * sau đó chỉ hiển thị những code có trong sản phẩm
 */
function hideAllOptionsExcept(keepCodes) {
  const container = document.querySelector(".product-details .product-options");
  if (!container) return;

  const keep = new Set((keepCodes || []).map((c) => String(c).toLowerCase()));
  const labels = container.querySelectorAll('label[id^="product-"]');

  labels.forEach((label) => {
    const m = label.id.match(/^product-(.+)-option$/);
    const code = m ? m[1] : null;
    if (!code) {
      label.style.display = "none";
      return;
    }
    label.style.display = keep.has(code.toLowerCase()) ? "block" : "none";
  });
}

/**
 * Render/Populate select cho tất cả option codes:
 * - Nếu HTML đã có label/select thì dùng lại
 * - Nếu chưa có thì tự tạo append vào .product-options
 */
function renderOptionControls(codes, optionsData) {
  const container = document.querySelector(".product-details .product-options");
  if (!container) return;

  (codes || []).forEach((code) => {
    const values = optionsData?.[code] || [];
    if (!values.length) return;

    let labelEl = document.getElementById(`product-${code}-option`);
    let selectEl = document.getElementById(`product-${code}-select`);

    if (!labelEl || !selectEl) {
      labelEl = document.createElement("label");
      labelEl.id = `product-${code}-option`;
      labelEl.style.display = "block";
      labelEl.innerHTML = `${escapeHtml(optionLabelName(code))}\n`;

      selectEl = document.createElement("select");
      selectEl.className = "input-select";
      selectEl.id = `product-${code}-select`;

      labelEl.appendChild(selectEl);
      container.appendChild(labelEl);
    } else {
      // đảm bảo label text đúng nếu trước đó chỉ có Color/Storage
      const firstChildText = labelEl.childNodes[0];
      if (firstChildText && firstChildText.nodeType === Node.TEXT_NODE) {
        firstChildText.textContent = `${optionLabelName(code)}\n`;
      }
    }

    selectEl.innerHTML = values
      .map((v, idx) => `<option value="${escapeHtml(String(v))}" ${idx === 0 ? "selected" : ""}>${escapeHtml(String(v))}</option>`)
      .join("");

    labelEl.style.display = "block";
    selectEl.disabled = values.length <= 1;
  });
}

/**
 * Render các options cho variants (DYNAMIC)
 * @param {Array} variants
 */
function renderProductVariants(variants) {
  if (!variants || variants.length === 0) return;

  // 1) Discover codes from API
  const codes = discoverOptionCodes(variants);

  // 2) Hide all except those codes (and allow created ones)
  hideAllOptionsExcept(codes);

  // 3) Build & sort option values
  const optionsData = buildOptionsData(variants, codes);
  sortOptionsData(optionsData);

  // 4) Render select controls
  renderOptionControls(codes, optionsData);

  // 5) Save to global
  window.productVariants = variants;
  window.categoryOptions = codes;

  // 6) Attach listeners
  attachOptionChangeListeners();

  // 7) Auto select best default
  const lowestVariant = getLowestComparableVariant(variants);
  if (lowestVariant) applyVariantSelection(lowestVariant);

  // 8) Update price
  updatePrice();
}

/**
 * Lấy variant được chọn dựa trên options hiện tại
 * Nếu không match, trả variant rẻ nhất
 */
function getSelectedVariant() {
  const selectedOptions = {};
  let hasAny = false;

  (window.categoryOptions || []).forEach((code) => {
    const selectEl = document.getElementById(`product-${code}-select`);
    if (selectEl && selectEl.value) {
      selectedOptions[code] = selectEl.value;
      hasAny = true;
    }
  });

  const variants = window.productVariants || [];
  if (!variants.length) return null;

  // Nếu chưa có lựa chọn, trả variant rẻ nhất
  if (!hasAny) {
    return variants.reduce((min, v) => (v.finalPrice < min.finalPrice ? v : min), variants[0]);
  }

  // Match tất cả selected options
  const matched = variants.find((variant) => {
    if (!variant.options || !Array.isArray(variant.options)) return false;

    return Object.keys(selectedOptions).every((code) => {
      const val = selectedOptions[code];
      return variant.options.some(
        (opt) => opt.optionCode && String(opt.optionCode).toLowerCase() === String(code).toLowerCase() && opt.value === val
      );
    });
  });

  return matched || variants.reduce((min, v) => (v.finalPrice < min.finalPrice ? v : min), variants[0]);
}

/**
 * Chọn variant thấp nhất dựa trên storage/ram và giá
 */
function getLowestComparableVariant(variants) {
  if (!variants || variants.length === 0) return null;

  const getOptionValue = (variant, code) => {
    const opt = (variant.options || []).find((o) => o.optionCode && String(o.optionCode).toLowerCase() === String(code).toLowerCase());
    return opt ? opt.value : null;
  };

  const compareVariant = (a, b) => {
    const aStorage = parseOptionNumeric(getOptionValue(a, "storage"));
    const bStorage = parseOptionNumeric(getOptionValue(b, "storage"));
    if (aStorage !== null && bStorage !== null && aStorage !== bStorage) return aStorage - bStorage;

    const aRam = parseOptionNumeric(getOptionValue(a, "ram"));
    const bRam = parseOptionNumeric(getOptionValue(b, "ram"));
    if (aRam !== null && bRam !== null && aRam !== bRam) return aRam - bRam;

    if (a.finalPrice !== b.finalPrice) return a.finalPrice - b.finalPrice;

    return (a.id || 0) - (b.id || 0);
  };

  return [...variants].sort(compareVariant)[0];
}

/**
 * Áp dụng selection của variant lên UI options
 */
function applyVariantSelection(variant) {
  if (!variant || !variant.options || !window.categoryOptions) return;

  window.categoryOptions.forEach((code) => {
    const selectEl = document.getElementById(`product-${code}-select`);
    if (!selectEl) return;

    const matched = (variant.options || []).find((opt) => opt.optionCode && String(opt.optionCode).toLowerCase() === String(code).toLowerCase());
    if (matched && selectEl.querySelector(`option[value="${CSS.escape(matched.value)}"]`)) {
      selectEl.value = matched.value;
    }
  });
}

/**
 * Cập nhật giá hiển thị theo variant được chọn
 */
function updatePrice() {
  const selectedVariant = getSelectedVariant();
  const priceEl = document.getElementById("product-price");
  if (!priceEl) return;

  if (selectedVariant) {
    let priceHTML = `$${Number(selectedVariant.finalPrice || 0).toFixed(2)}`;
    if (selectedVariant.basePrice > selectedVariant.finalPrice) {
      priceHTML += ` <del class="product-old-price">$${Number(selectedVariant.basePrice || 0).toFixed(2)}</del>`;
    }
    priceEl.innerHTML = priceHTML;

    const availabilityEl = document.getElementById("product-availability");
    if (availabilityEl) {
      const isInStock = selectedVariant.status === "ACTIVE";
      availabilityEl.textContent = isInStock ? "In Stock" : "Out of Stock";
      availabilityEl.className = isInStock ? "product-available" : "product-unavailable";
    }
  }
}

/**
 * Gắn event listeners cho option selects để cập nhật giá
 */
function attachOptionChangeListeners() {
  (window.categoryOptions || []).forEach((code) => {
    const selectEl = document.getElementById(`product-${code}-select`);
    if (selectEl) {
      // tránh add trùng listener khi re-render
      selectEl.onchange = updatePrice;
    }
  });
}

/**
 * Xử lý sự kiện thêm vào giỏ hàng
 */
function handleAddToCart() {
  const addToCartBtn = document.getElementById("add-to-cart-btn");
  if (!addToCartBtn) return;

  addToCartBtn.addEventListener("click", function () {
    const quantity = parseInt(document.getElementById("product-quantity").value) || 1;
    const selectedVariant = getSelectedVariant();

    if (!selectedVariant) {
      alert("Please select a valid product variant");
      return;
    }

    if (selectedVariant.status !== "ACTIVE") {
      alert("This variant is currently unavailable");
      return;
    }

    const selectedOptionsForLog = {};
    (window.categoryOptions || []).forEach((code) => {
      const selectEl = document.getElementById(`product-${code}-select`);
      if (selectEl && selectEl.value) selectedOptionsForLog[code] = selectEl.value;
    });

    console.log("Adding to cart:", {
      variantId: selectedVariant.id,
      quantity: quantity,
      price: selectedVariant.finalPrice,
      selectedOptions: selectedOptionsForLog,
    });

    alert("Product added to cart successfully!");
  });
}

/**
 * Xử lý quantity input
 */
function initQuantityControls() {
  const quantityInput = document.getElementById("product-quantity");
  const qtyUpBtn = document.querySelector(".qty-up");
  const qtyDownBtn = document.querySelector(".qty-down");

  if (qtyUpBtn) {
    qtyUpBtn.addEventListener("click", function () {
      let currentVal = parseInt(quantityInput.value) || 1;
      quantityInput.value = currentVal + 1;
    });
  }

  if (qtyDownBtn) {
    qtyDownBtn.addEventListener("click", function () {
      let currentVal = parseInt(quantityInput.value) || 1;
      if (currentVal > 1) quantityInput.value = currentVal - 1;
    });
  }
}

/**
 * Lấy danh sách sản phẩm cùng category
 */
async function fetchRelatedProducts(categoryName) {
  try {
    const response = await getWithRetry(
      `${API_BASE_URL}/products`,
      {
        params: {
          category: categoryName,
          limit: 4,
        },
      },
      MAX_RETRIES
    );

    let products = response.data;

    if (products.data && Array.isArray(products.data)) products = products.data;
    else if (!Array.isArray(products)) products = [];

    return products;
  } catch (error) {
    console.warn("Error loading related products:", error);
    return [];
  }
}

/**
 * Hiển thị các sản phẩm related
 */
function renderRelatedProducts(products) {
  if (!products || products.length === 0) return;

  const allSections = document.querySelectorAll(".section");
  let relatedSection = null;

  for (let section of allSections) {
    const titleEl = section.querySelector(".section-title h3");
    if (titleEl && titleEl.textContent === "Related Products") {
      relatedSection = section;
      break;
    }
  }

  if (!relatedSection) return;

  const row = relatedSection.querySelector(".row");
  if (!row) return;

  // remove old cards (keep title block)
  const productDivs = row.querySelectorAll(".col-md-3.col-xs-6");
  productDivs.forEach((div) => div.remove());

  products.slice(0, 4).forEach((product) => {
    let discountLabel = "";
    let priceDisplay = "$0.00";

    if (product.variants && product.variants.length > 0) {
      const minVariant = product.variants.reduce((min, v) => (v.finalPrice < min.finalPrice ? v : min), product.variants[0]);
      priceDisplay = `$${Number(minVariant.finalPrice || 0).toFixed(2)}`;
      if (minVariant.discountPercent > 0) discountLabel = `<span class="sale">-${minVariant.discountPercent}%</span>`;
    }

    const imgUrl = product.images && product.images[0] ? product.images[0].imageUrl : "./img/product01.png";

    const productHTML = `
      <div class="col-md-3 col-xs-6">
        <div class="product">
          <a href="product.html?id=${encodeURIComponent(product.id)}" class="product-link" aria-label="${escapeHtml(product.name)}">
            <div class="product-img">
              <img src="${escapeHtml(imgUrl)}" alt="${escapeHtml(product.name)}">
              <div class="product-label">${discountLabel}</div>
            </div>
            <div class="product-body">
              <p class="product-category">${escapeHtml(product.categoryName || "Category")}</p>
              <h3 class="product-name">${escapeHtml(product.name)}</h3>
              <h4 class="product-price">${priceDisplay}</h4>
              <div class="product-rating"></div>
            </div>
          </a>

          <div class="product-btns">
            <button class="add-to-wishlist" type="button">
              <i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span>
            </button>
            <button class="quick-view" type="button" onclick="window.location.href='product.html?id=${encodeURIComponent(product.id)}'">
              <i class="fa fa-eye"></i><span class="tooltipp">quick view</span>
            </button>
          </div>
        </div>
      </div>
    `;

    row.insertAdjacentHTML("beforeend", productHTML);
  });
}

/**
 * Escape HTML để tránh XSS
 */
function escapeHtml(text) {
  if (!text) return "";
  const div = document.createElement("div");
  div.textContent = text;
  return div.innerHTML;
}

/**
 * Hiển thị thông báo lỗi
 */
function showError(message) {
  const container = document.querySelector(".container");
  if (container) {
    const errorHTML = `
      <div class="alert alert-danger alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <strong>Error!</strong> ${escapeHtml(message)}
      </div>
    `;
    container.insertAdjacentHTML("afterbegin", errorHTML);
  }
}

/**
 * Khởi tạo trang chi tiết sản phẩm
 */
async function initProductDetailPage() {
  try {
    const productId = getProductIdFromURL();

    if (!productId) {
      showError("Product ID not found in URL");
      return;
    }

    console.log("Loading product details...");

    const product = await fetchProductDetail(productId);

    if (!product) {
      showError("Product data is empty");
      return;
    }

    renderProductImages(product.images);
    renderProductDetails(product);

    // ✅ CHỈ CẦN variants (DYNAMIC)
    renderProductVariants(product.variants);

    const relatedProducts = await fetchRelatedProducts(product.categoryName);
    renderRelatedProducts(relatedProducts);

    handleAddToCart();
    initQuantityControls();

    console.log("Product details loaded successfully");
  } catch (error) {
    console.error("Failed to initialize product detail page:", error);
    showError("Failed to load product details. Please try again later.");
  }
}

document.addEventListener("DOMContentLoaded", initProductDetailPage);
