// ==========================================
// MODULE - SHOP
// ==========================================

function renderShop() {
    const grid = document.getElementById('productsGrid');
    if (!grid) return;

    const templateKeyFromAny = (value) => {
        if (!value) return null;
        const s = String(value).trim();
        const m = s.match(/(?:^|\/)(?:img\/)?(product0[1-9]\.png)$/i);
        return m ? m[1].toLowerCase() : null;
    };

    const stableTemplateById = (product) => {
        const idNum = Number(product && product.id);
        if (!isNaN(idNum) && idNum > 0) {
            const idx = ((idNum - 1) % 9) + 1;
            const suffix = idx < 10 ? ('0' + idx) : String(idx);
            return `product${suffix}.png`;
        }
        return 'product01.png';
    };

    const productImageSrc = (product) => {
        const imgs = Array.isArray(product?.productImages) ? product.productImages : [];
        const primary = imgs.find?.(i => i && (i.isPrimary || i.primary)) || imgs[0];
        const fromTemplate = templateKeyFromAny(primary?.imageUrl) || templateKeyFromAny(product?.imageUrl);
        const file = fromTemplate || stableTemplateById(product);
        // Nginx phục vụ ảnh template tại /img/...
        return `/img/${file}`;
    };

    const getProducts = async () => {
        try {
            const p = await API.getProducts();
            return Array.isArray(p) ? p : (p?.items || p?.products || []);
        } catch (e) {
            console.warn('shop:getProducts fallback mock', e);
            return Array.isArray(mockData?.products) ? mockData.products : [];
        }
    };

    const getCategories = async () => {
        try {
            const c = await API.getCategories();
            return Array.isArray(c) ? c : (c?.items || c?.categories || []);
        } catch (e) {
            console.warn('shop:getCategories fallback mock', e);
            return Array.isArray(mockData?.categories) ? mockData.categories : [];
        }
    };

    (async () => {
        grid.innerHTML = '<div class="col-12 text-center text-muted py-5">Loading...</div>';
        const products = await getProducts();
        grid.innerHTML = '';
        if (!products.length) {
            grid.innerHTML = '<div class="col-12 text-center text-muted py-5">No products</div>';
            setupShopFilters();
            return;
        }

        products.forEach(product => {
            const id = product?.id ?? product?.productId;
            const productCard = document.createElement('div');
            productCard.className = 'product-card';
            productCard.dataset.category = product?.categoryName || product?.category?.name || product?.category || '';
            productCard.innerHTML = `
                <img src="${productImageSrc(product)}" alt="${product?.name || ''}" class="product-image">
                <div class="product-info">
                    <h6 class="product-name">${product?.name || ''}</h6>
                    <p class="product-price">${formatCurrency(Number(product?.finalPrice ?? product?.price ?? 0))}</p>
                    <div class="product-actions">
                        <button class="btn" onclick="addToWishlist(${Number(id)})" title="Add to wishlist"><i class="fas fa-heart"></i></button>
                        <button class="btn" onclick="addStock(${Number(id)})" title="Add more stock"><i class="fas fa-plus"></i></button>
                    </div>
                </div>
            `;
            grid.appendChild(productCard);
        });

        setupShopFilters(await getCategories());
    })();
}

function setupShopFilters(categories) {
    const searchInput = document.getElementById('shopSearch');
    const categoryFilter = document.getElementById('shopCategoryFilter');
    const minPrice = document.getElementById('minPrice');
    const maxPrice = document.getElementById('maxPrice');
    categoryFilter.innerHTML = '<option value="">All Categories</option>';
    (categories || []).forEach(cat => {
        const option = document.createElement('option');
        option.value = cat.name || cat.categoryName || cat.id;
        option.textContent = cat.name || cat.categoryName || `Category ${cat.id}`;
        categoryFilter.appendChild(option);
    });
    const filterShop = () => {
        const searchTerm = searchInput.value.toLowerCase();
        const categoryValue = categoryFilter.value;
        const minVal = minPrice.value ? parseInt(minPrice.value) : 0;
        const maxVal = maxPrice.value ? parseInt(maxPrice.value) : Infinity;
        document.querySelectorAll('.product-card').forEach(card => {
            const name = card.querySelector('.product-name').textContent.toLowerCase();
            const priceText = card.querySelector('.product-price').textContent;
            const price = parseInt(priceText.replace(/[^0-9]/g, ''));
            const nameMatch = name.includes(searchTerm);
            const categoryMatch = !categoryValue || card.dataset.category === categoryValue;
            const priceMatch = price >= minVal && price <= maxVal;
            card.style.display = nameMatch && categoryMatch && priceMatch ? '' : 'none';
        });
    };
    searchInput.addEventListener('input', filterShop);
    categoryFilter.addEventListener('change', filterShop);
    minPrice.addEventListener('input', filterShop);
    maxPrice.addEventListener('input', filterShop);
}

async function addStock(productId) {
    const delta = parseInt(prompt('Nhập số lượng cần nhập thêm:'), 10);
    if (!delta || isNaN(delta) || delta <= 0) return;
    try {
        // call new backend endpoint to add stock on variant/product
        // Ưu tiên variant đầu tiên nếu có
        const prod = await API.getProduct(productId);
        const variantId = (prod?.variants && prod.variants[0] && prod.variants[0].id) ? prod.variants[0].id : productId;
        await API.addStock(variantId, delta);
        showNotification(`Đã nhập thêm ${delta} đơn vị cho sản phẩm ID ${productId}`, 'success');
    } catch (e) {
        console.warn('addStock fallback mock', e);
        if (Array.isArray(mockData?.products)) {
            const p = mockData.products.find(x => Number(x.id) === Number(productId));
            if (p) p.stock = (p.stock || 0) + delta;
        }
        showNotification('Không gọi được API, đã cập nhật tạm thời mock data', 'warning');
    }
}
