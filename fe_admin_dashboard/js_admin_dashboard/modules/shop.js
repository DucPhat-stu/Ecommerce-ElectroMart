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

    const productImageSrc = (product) => {
        const imgs = Array.isArray(product?.productImages) ? product.productImages : [];
        const primary = imgs.find?.(i => i && i.primary) || imgs[0];
        const key = templateKeyFromAny(primary?.imageUrl) || templateKeyFromAny(product?.imageUrl) || 'product01.png';
        return `/img/${key}`;
    };

    const getProducts = async () => {
        try {
            const p = await API.getProducts();
            return Array.isArray(p) ? p : (p?.items || p?.products || []);
        } catch (_) {
            return Array.isArray(mockData?.products) ? mockData.products : [];
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
                        <button class="btn" onclick="addToCart(${Number(id)})" title="Add to cart"><i class="fas fa-shopping-cart"></i></button>
                    </div>
                </div>
            `;
            grid.appendChild(productCard);
        });

        setupShopFilters();
    })();
}

function setupShopFilters() {
    const searchInput = document.getElementById('shopSearch');
    const categoryFilter = document.getElementById('shopCategoryFilter');
    const minPrice = document.getElementById('minPrice');
    const maxPrice = document.getElementById('maxPrice');
    categoryFilter.innerHTML = '<option value="">All Categories</option>';
    const cats = Array.isArray(mockData?.categories) ? mockData.categories : [];
    cats.forEach(cat => {
        const option = document.createElement('option');
        option.value = cat.name;
        option.textContent = cat.name;
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

function addToCart(productId) {
    const product = mockData.products.find(p => p.id === productId);
    if (product) { showNotification(`Added "${product.name}" to cart`, 'success'); }
}
