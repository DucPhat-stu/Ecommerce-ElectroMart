(() => {
    const API_BASE = "http://localhost:8080/api/v1";

    // ---------- DOM ----------
    const dom = {
        // header search
        headerSearchForm: document.getElementById("header-search-form"),
        headerCategorySelect: document.getElementById("header-category-select"),
        headerSearchInput: document.getElementById("header-search-input"),

        // filters
        asideCategories: document.getElementById("aside-categories"),
        asideBrands: document.getElementById("aside-brands"),
        priceSlider: document.getElementById("price-slider"),
        priceMinInput: document.getElementById("price-min"),
        priceMaxInput: document.getElementById("price-max"),

        // store controls
        sortSelect: document.getElementById("sort-select"),
        perPageSelect: document.getElementById("perpage-select"),
        viewToggle: document.getElementById("view-toggle"),

        // store render targets
        storeProducts: document.getElementById("store-products"),
        storeQty: document.getElementById("store-qty"),
        pagination: document.getElementById("store-pagination"),

        // counters
        wishlistQty: document.getElementById("wishlist-qty"),
        cartQty: document.getElementById("cart-qty"),
        cartList: document.getElementById("cart-list"),
        cartSummaryCount: document.getElementById("cart-summary-count"),
        cartSummarySubtotal: document.getElementById("cart-summary-subtotal"),
    };

    // ---------- Axios ----------
    const http = axios.create({
        baseURL: API_BASE,
        timeout: 15000,
    });

    // ---------- State ----------
    const state = {
        products: [],
        categories: [],
        brands: [],

        selectedCategories: new Set(), // by categoryName
        selectedBrands: new Set(), // by brandName

        priceMin: 0,
        priceMax: 0,

        searchQuery: "",
        searchCategory: "0", // "0" = all

        sortBy: "popular", // popular | position
        perPage: 20,
        page: 1,
        view: "grid", // grid | list

        // demo cart/wishlist
        wishlistCount: 0,
        cartCount: 0,
        cartSubtotal: 0,
    };

    // ---------- Helpers ----------
    const escapeHtml = (s) =>
        String(s ?? "")
            .replaceAll("&", "&amp;")
            .replaceAll("<", "&lt;")
            .replaceAll(">", "&gt;")
            .replaceAll('"', "&quot;")
            .replaceAll("'", "&#039;");

    const formatMoney = (n) => {
        const num = Number(n || 0);
        return "$" + num.toFixed(2);
    };

    const debounce = (fn, ms = 300) => {
        let t;
        return (...args) => {
            clearTimeout(t);
            t = setTimeout(() => fn(...args), ms);
        };
    };

    const unique = (arr) => [...new Set(arr.filter(Boolean))];

    function getPrimaryImageUrl(product) {
        const imgs = product?.images || [];
        const primary =
            imgs.find((i) => i.isPrimary) ||
            imgs.sort((a, b) => (a.position || 0) - (b.position || 0))[0];
        return primary?.imageUrl || "./img/product01.png";
    }

    function getPriceInfo(product) {
        const variants = product?.variants || [];
        if (!variants.length) return { price: 0, oldPrice: null, discountPercent: 0 };

        const sorted = [...variants].sort(
            (a, b) => Number(a.finalPrice) - Number(b.finalPrice)
        );
        const v = sorted[0];

        const price = Number(v.finalPrice || v.basePrice || 0);
        const discountPercent = Number(v.discountPercent || 0);

        let oldPrice = null;
        if (discountPercent > 0) {
            const base = Number(v.basePrice || 0);
            oldPrice = base > 0 ? base : price / (1 - discountPercent / 100);
        }

        return { price, oldPrice, discountPercent };
    }

    function isNewProduct(product) {
        try {
            const created = new Date(product.createdAt);
            if (Number.isNaN(created.getTime())) return false;
            const now = new Date();
            const diffDays = (now - created) / (1000 * 60 * 60 * 24);
            return diffDays <= 30;
        } catch {
            return false;
        }
    }

    // ---------- API ----------
    async function fetchProducts() {
        const res = await http.get("/products");
        const data = res?.data?.data ?? [];
        return Array.isArray(data) ? data : [];
    }

    async function fetchCategories() {
        // response đúng như bạn gửi:
        // { success, message, data:[{id,name,status...}] }
        const res = await http.get("/category");
        const data = res?.data?.data ?? [];
        return Array.isArray(data)
            ? data
                .filter((c) => String(c.status || "").toLowerCase() === "active")
                .map((c) => ({ id: c.id, name: c.name }))
            : [];
    }

    // ---------- Render: Category Filter ----------
    function renderCategoryFilter() {
        if (!dom.asideCategories) return;

        const cats = state.categories.map((c) => c.name);

        const html = cats
            .map((name, idx) => {
                const id = `cat-${idx}-${name.replace(/\s+/g, "-").toLowerCase()}`;
                const checked = state.selectedCategories.has(name) ? "checked" : "";
                const count = state.products.filter((p) => p.categoryName === name).length;

                return `
          <div class="input-checkbox">
            <input type="checkbox" id="${escapeHtml(id)}" data-category="${escapeHtml(
                    name
                )}" ${checked}>
            <label for="${escapeHtml(id)}">
              <span></span>
              ${escapeHtml(name)}
              <small>(${count})</small>
            </label>
          </div>
        `;
            })
            .join("");

        dom.asideCategories.innerHTML = html || `<p style="margin:0;">No categories</p>`;

        // events + sync dropdown
        dom.asideCategories
            .querySelectorAll("input[type=checkbox][data-category]")
            .forEach((cb) => {
                cb.addEventListener("change", () => {
                    const c = cb.getAttribute("data-category");
                    if (cb.checked) state.selectedCategories.add(c);
                    else state.selectedCategories.delete(c);

                    // sync dropdown header (1 cat -> select that, multi -> all)
                    if (dom.headerCategorySelect) {
                        if (state.selectedCategories.size === 1) {
                            const onlyCat = [...state.selectedCategories][0];
                            state.searchCategory = onlyCat;
                            dom.headerCategorySelect.value = onlyCat;
                        } else {
                            state.searchCategory = "0";
                            dom.headerCategorySelect.value = "0";
                        }
                    }

                    state.page = 1;
                    applyAndRender();
                });
            });
    }

    // ---------- Render: Brand Filter ----------
    function renderBrandFilter() {
        if (!dom.asideBrands) return;

        const brands = state.brands;

        const html = brands
            .map((name, idx) => {
                const id = `brand-${idx}-${name.replace(/\s+/g, "-").toLowerCase()}`;
                const checked = state.selectedBrands.has(name) ? "checked" : "";
                const count = state.products.filter((p) => p.brandName === name).length;

                return `
          <div class="input-checkbox">
            <input type="checkbox" id="${escapeHtml(id)}" data-brand="${escapeHtml(
                    name
                )}" ${checked}>
            <label for="${escapeHtml(id)}">
              <span></span>
              ${escapeHtml(name)}
              <small>(${count})</small>
            </label>
          </div>
        `;
            })
            .join("");

        dom.asideBrands.innerHTML = html || `<p style="margin:0;">No brands</p>`;

        dom.asideBrands
            .querySelectorAll("input[type=checkbox][data-brand]")
            .forEach((cb) => {
                cb.addEventListener("change", () => {
                    const b = cb.getAttribute("data-brand");
                    if (cb.checked) state.selectedBrands.add(b);
                    else state.selectedBrands.delete(b);
                    state.page = 1;
                    applyAndRender();
                });
            });
    }

    // ---------- Render: Header Category Select ----------
    function renderHeaderCategorySelect() {
        if (!dom.headerCategorySelect) return;

        const cats = state.categories.map((c) => c.name);

        dom.headerCategorySelect.innerHTML =
            `<option value="0">All Categories</option>` +
            cats.map((c) => `<option value="${escapeHtml(c)}">${escapeHtml(c)}</option>`).join("");

        dom.headerCategorySelect.value = state.searchCategory;
    }

    // ---------- Price Slider ----------
    function setupPriceSlider() {
        if (!dom.priceSlider || typeof noUiSlider === "undefined") return;

        const prices = state.products
            .map((p) => getPriceInfo(p).price)
            .filter((n) => Number.isFinite(n) && n > 0);

        const minP = prices.length ? Math.floor(Math.min(...prices)) : 0;
        const maxP = prices.length ? Math.ceil(Math.max(...prices)) : 1000;

        state.priceMin = state.priceMin || minP;
        state.priceMax = state.priceMax || maxP;

        if (dom.priceSlider.noUiSlider) dom.priceSlider.noUiSlider.destroy();

        noUiSlider.create(dom.priceSlider, {
            start: [state.priceMin, state.priceMax],
            connect: true,
            range: { min: minP, max: maxP },
            step: 1,
        });

        dom.priceMinInput.value = String(state.priceMin);
        dom.priceMaxInput.value = String(state.priceMax);

        dom.priceSlider.noUiSlider.on("update", (values) => {
            const [v1, v2] = values.map((v) => Math.round(Number(v)));
            dom.priceMinInput.value = String(v1);
            dom.priceMaxInput.value = String(v2);
        });

        dom.priceSlider.noUiSlider.on("change", (values) => {
            const [v1, v2] = values.map((v) => Math.round(Number(v)));
            state.priceMin = v1;
            state.priceMax = v2;
            state.page = 1;
            applyAndRender();
        });

        const onManual = debounce(() => {
            let v1 = Math.max(minP, Math.min(maxP, Number(dom.priceMinInput.value || minP)));
            let v2 = Math.max(minP, Math.min(maxP, Number(dom.priceMaxInput.value || maxP)));
            if (v1 > v2) [v1, v2] = [v2, v1];

            state.priceMin = Math.round(v1);
            state.priceMax = Math.round(v2);

            dom.priceSlider.noUiSlider.set([state.priceMin, state.priceMax]);

            state.page = 1;
            applyAndRender();
        }, 350);

        dom.priceMinInput.addEventListener("input", onManual);
        dom.priceMaxInput.addEventListener("input", onManual);
    }

    // ---------- Apply Filters ----------
    function applyFilters(products) {
        let list = [...products];

        // category checkbox
        if (state.selectedCategories.size) {
            list = list.filter((p) => state.selectedCategories.has(p.categoryName));
        }

        // brand
        if (state.selectedBrands.size) {
            list = list.filter((p) => state.selectedBrands.has(p.brandName));
        }

        // price
        list = list.filter((p) => {
            const price = getPriceInfo(p).price;
            return price >= state.priceMin && price <= state.priceMax;
        });

        // search query
        const q = state.searchQuery.trim().toLowerCase();
        if (q) {
            list = list.filter((p) => {
                const name = (p.name || "").toLowerCase();
                const short = (p.shortDescription || "").toLowerCase();
                const desc = (p.description || "").toLowerCase();
                return name.includes(q) || short.includes(q) || desc.includes(q);
            });
        }

        // header category dropdown (single)
        if (state.searchCategory && state.searchCategory !== "0") {
            list = list.filter((p) => p.categoryName === state.searchCategory);
        }

        return list;
    }

    // ---------- Sort ----------
    function applySort(products) {
        const list = [...products];

        if (state.sortBy === "position") {
            // Price asc
            list.sort((a, b) => getPriceInfo(a).price - getPriceInfo(b).price);
        } else {
            // Popular (demo) = newest first
            list.sort((a, b) => new Date(b.createdAt || 0) - new Date(a.createdAt || 0));
        }
        return list;
    }

    // ---------- Pagination ----------
    function paginate(products) {
        const total = products.length;
        const totalPages = Math.max(1, Math.ceil(total / state.perPage));
        const page = Math.min(Math.max(1, state.page), totalPages);

        const start = (page - 1) * state.perPage;
        const end = start + state.perPage;

        return { total, totalPages, page, items: products.slice(start, end) };
    }

    // ---------- Product Cards ----------
    function productCardGrid(p) {
        const img = getPrimaryImageUrl(p);
        const { price, oldPrice, discountPercent } = getPriceInfo(p);
        const newTag = isNewProduct(p);

        const detailUrl = `product.html?id=${encodeURIComponent(p.id)}`;

        const labelHtml = `
    <div class="product-label">
      ${discountPercent > 0 ? `<span class="sale">-${Math.round(discountPercent)}%</span>` : ""}
      ${newTag ? `<span class="new">NEW</span>` : ""}
    </div>
  `;

        const stars = `<i class="fa fa-star"></i>`.repeat(4) + `<i class="fa fa-star-o"></i>`;

        return `
    <div class="col-md-4 col-xs-6">
      <div class="product" data-id="${escapeHtml(p.id)}">
        
        <!-- CLICK để sang trang chi tiết -->
        <a href="${escapeHtml(detailUrl)}" class="product-link" aria-label="${escapeHtml(p.name)}">
          <div class="product-img">
            <img src="${escapeHtml(img)}" alt="${escapeHtml(p.name)}">
            ${labelHtml}
          </div>

          <div class="product-body">
            <p class="product-category">${escapeHtml(p.categoryName || "")}</p>
            <h3 class="product-name">${escapeHtml(p.name)}</h3>
            <h4 class="product-price">
              ${formatMoney(price)}
              ${oldPrice ? `<del class="product-old-price">${formatMoney(oldPrice)}</del>` : ""}
            </h4>
            <div class="product-rating">${stars}</div>
          </div>
        </a>

        <!-- buttons giữ riêng -->
        <div class="product-btns">
          <button class="add-to-wishlist" type="button">
            <i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span>
          </button>

          <!-- Quick View -> chuyển trang chi tiết -->
          <button class="quick-view" type="button" data-detail-url="${escapeHtml(detailUrl)}">
            <i class="fa fa-eye"></i><span class="tooltipp">quick view</span>
          </button>
        </div>

        <div class="add-to-cart">
          <button class="add-to-cart-btn" type="button">
            <i class="fa fa-shopping-cart"></i> add to cart
          </button>
        </div>

      </div>
    </div>
  `;
    }


    function productCardList(p) {
        const img = getPrimaryImageUrl(p);
        const { price, oldPrice, discountPercent } = getPriceInfo(p);
        const newTag = isNewProduct(p);

        const detailUrl = `product.html?id=${encodeURIComponent(p.id)}`;

        return `
    <div class="col-md-12 col-xs-12">
      <div class="product" data-id="${escapeHtml(p.id)}" style="display:flex;gap:16px;align-items:stretch;">

        <a href="${escapeHtml(detailUrl)}" class="product-link" style="width:220px;flex:0 0 220px;">
          <div class="product-img">
            <img src="${escapeHtml(img)}" alt="${escapeHtml(p.name)}" style="width:100%;height:auto;">
            <div class="product-label">
              ${discountPercent > 0 ? `<span class="sale">-${Math.round(discountPercent)}%</span>` : ""}
              ${newTag ? `<span class="new">NEW</span>` : ""}
            </div>
          </div>
        </a>

        <div class="product-body" style="flex:1;">
          <p class="product-category">
            ${escapeHtml(p.categoryName || "")} • ${escapeHtml(p.brandName || "")}
          </p>

          <h3 class="product-name">
            <a href="${escapeHtml(detailUrl)}">${escapeHtml(p.name)}</a>
          </h3>

          <p style="margin:8px 0;opacity:.9;">${escapeHtml(p.shortDescription || "")}</p>

          <h4 class="product-price">
            ${formatMoney(price)}
            ${oldPrice ? `<del class="product-old-price">${formatMoney(oldPrice)}</del>` : ""}
          </h4>

          <div class="product-btns" style="margin-top:12px;">
            <button class="add-to-wishlist" type="button">
              <i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span>
            </button>
            <button class="quick-view" type="button" data-detail-url="${escapeHtml(detailUrl)}">
              <i class="fa fa-eye"></i><span class="tooltipp">quick view</span>
            </button>
          </div>
        </div>

        <div class="add-to-cart" style="display:flex;align-items:center;padding-right:10px;">
          <button class="add-to-cart-btn" type="button">
            <i class="fa fa-shopping-cart"></i> add to cart
          </button>
        </div>

      </div>
    </div>
  `;
    }


    function renderProducts(items) {
        dom.storeProducts.innerHTML =
            items.length === 0
                ? `<div class="col-md-12"><p>No products found.</p></div>`
                : items.map((p) => (state.view === "grid" ? productCardGrid(p) : productCardList(p))).join("");

        // events for wishlist/cart/quick view
       dom.storeProducts.querySelectorAll(".product").forEach((el) => {
            const id = Number(el.getAttribute("data-id"));
            const p = state.products.find((x) => x.id === id);

            el.querySelector(".add-to-cart-btn")?.addEventListener("click", () => {
                if (!p) return;

                const { price } = getPriceInfo(p);
                state.cartCount += 1;
                state.cartSubtotal += price;

                if (dom.cartQty) dom.cartQty.textContent = String(state.cartCount);
                if (dom.cartSummaryCount) dom.cartSummaryCount.textContent = `${state.cartCount} Item(s) selected`;
                if (dom.cartSummarySubtotal) dom.cartSummarySubtotal.textContent = `SUBTOTAL: ${formatMoney(state.cartSubtotal)}`;

                // demo item list
                if (dom.cartList) {
                    const item = document.createElement("div");
                    item.className = "product-widget";
                    item.innerHTML = `
            <div class="product-img">
              <img src="${escapeHtml(getPrimaryImageUrl(p))}" alt="">
            </div>
            <div class="product-body">
              <h3 class="product-name"><a href="#">${escapeHtml(p.name)}</a></h3>
              <h4 class="product-price"><span class="qty">1x</span>${formatMoney(price)}</h4>
            </div>
            <button class="delete"><i class="fa fa-close"></i></button>
          `;
                    item.querySelector(".delete")?.addEventListener("click", () => {
                        item.remove();
                        // demo: không trừ subtotal để đơn giản (muốn trừ thì cần lưu cart items)
                    });
                    dom.cartList.prepend(item);
                }
            });

            el.querySelector(".add-to-wishlist")?.addEventListener("click", () => {
                state.wishlistCount += 1;
                if (dom.wishlistQty) dom.wishlistQty.textContent = String(state.wishlistCount);
            });

            el.querySelector(".quick-view")?.addEventListener("click", () => {
                if (!p) return;
                // lấy giá chính xác từ variants
                const { price, oldPrice } = getPriceInfo(p);
                const detail = `${p.name}\n\n${p.shortDescription || ""}\n\nBrand: ${p.brandName || ""}\nCategory: ${p.categoryName || ""}\nPrice: ${formatMoney(price)}${oldPrice ? ` (old: ${formatMoney(oldPrice)})` : ""}`;
                alert(detail);
            });
        });
    }

    // ---------- Pagination Render ----------
    function renderPagination(totalPages) {
        const page = state.page;
        const pages = [];

        const start = Math.max(1, page - 2);
        const end = Math.min(totalPages, page + 2);

        if (page > 1) pages.push({ label: "«", page: page - 1 });
        for (let p = start; p <= end; p++) pages.push({ label: String(p), page: p });
        if (page < totalPages) pages.push({ label: "»", page: page + 1 });

        dom.pagination.innerHTML = pages
            .map((x) => {
                const isActive = x.page === page && /^\d+$/.test(x.label);
                return isActive
                    ? `<li class="active">${escapeHtml(x.label)}</li>`
                    : `<li><a href="#" data-page="${x.page}">${escapeHtml(x.label)}</a></li>`;
            })
            .join("");

        dom.pagination.querySelectorAll("a[data-page]").forEach((a) => {
            a.addEventListener("click", (e) => {
                e.preventDefault();
                state.page = Number(a.getAttribute("data-page"));
                applyAndRender();
            });
        });
    }

    // ---------- Apply & Render ----------
    function applyAndRender() {
        const filtered = applyFilters(state.products);
        const sorted = applySort(filtered);
        const { total, totalPages, page, items } = paginate(sorted);

        state.page = page;

        const start = total === 0 ? 0 : (page - 1) * state.perPage + 1;
        const end = Math.min(page * state.perPage, total);
        dom.storeQty.textContent = `Showing ${start}-${end} products (Total: ${total})`;

        renderProducts(items);
        renderPagination(totalPages);
    }

    // ---------- Events Setup ----------
    function setupControls() {
        // sort
        dom.sortSelect?.addEventListener("change", () => {
            state.sortBy = dom.sortSelect.value;
            state.page = 1;
            applyAndRender();
        });

        // per page
        dom.perPageSelect?.addEventListener("change", () => {
            state.perPage = Number(dom.perPageSelect.value) || 20;
            state.page = 1;
            applyAndRender();
        });

        // view toggle
        dom.viewToggle?.querySelectorAll("li[data-view]")?.forEach((li) => {
            li.addEventListener("click", (e) => {
                e.preventDefault();
                const v = li.getAttribute("data-view");
                state.view = v === "list" ? "list" : "grid";

                dom.viewToggle.querySelectorAll("li").forEach((x) => x.classList.remove("active"));
                li.classList.add("active");

                applyAndRender();
            });
        });

        // header search submit
        dom.headerSearchForm?.addEventListener("submit", (e) => {
            e.preventDefault();
            state.searchQuery = dom.headerSearchInput.value || "";
            state.searchCategory = dom.headerCategorySelect.value || "0";
            state.page = 1;
            applyAndRender();
        });

        // header search typing (auto filter)
        dom.headerSearchInput?.addEventListener(
            "input",
            debounce(() => {
                state.searchQuery = dom.headerSearchInput.value || "";
                state.page = 1;
                applyAndRender();
            }, 350)
        );

        // dropdown category change -> sync checkbox
        dom.headerCategorySelect?.addEventListener("change", () => {
            state.searchCategory = dom.headerCategorySelect.value || "0";

            state.selectedCategories.clear();
            if (state.searchCategory !== "0") state.selectedCategories.add(state.searchCategory);

            // rerender checkbox to reflect checked
            renderCategoryFilter();

            state.page = 1;
            applyAndRender();
        });
    }

    // ---------- Init ----------
    async function init() {
        try {
            const [products, categories] = await Promise.all([
                fetchProducts(),
                fetchCategories(),
            ]);

            state.products = products;
            state.categories = categories;

            // brands from products
            state.brands = unique(products.map((p) => p.brandName)).sort((a, b) => a.localeCompare(b));

            // render UI parts
            renderHeaderCategorySelect();
            renderCategoryFilter();
            renderBrandFilter();
            setupPriceSlider();

            // controls
            setupControls();

            // default selects
            if (dom.sortSelect) dom.sortSelect.value = state.sortBy;
            if (dom.perPageSelect) dom.perPageSelect.value = String(state.perPage);

            // first render
            applyAndRender();
        } catch (err) {
            console.error(err);
            alert("Không load được dữ liệu từ API. Kiểm tra server chạy + CORS + endpoint.");
        }
    }

    document.addEventListener("DOMContentLoaded", init);
})();
