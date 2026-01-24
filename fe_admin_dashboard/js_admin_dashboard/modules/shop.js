// ==========================================
// MODULE - SHOP
// ==========================================

function renderShop() {
    const grid = document.getElementById('productsGrid');
    grid.innerHTML = '';
    mockData.products.forEach(product => {
        const productCard = document.createElement('div');
        productCard.className = 'product-card';
        productCard.innerHTML = `
            <img src="https://via.placeholder.com/200" alt="${product.name}" class="product-image">
            <div class="product-info">
                <h6 class="product-name">${product.name}</h6>
                <p class="product-price">${formatCurrency(product.price)}</p>
                <div class="product-actions">
                    <button class="btn" onclick="addToWishlist(${product.id})" title="Add to wishlist"><i class="fas fa-heart"></i></button>
                    <button class="btn" onclick="addToCart(${product.id})" title="Add to cart"><i class="fas fa-shopping-cart"></i></button>
                </div>
            </div>
        `;
        grid.appendChild(productCard);
    });
    setupShopFilters();
}

function setupShopFilters() {
    const searchInput = document.getElementById('shopSearch');
    const categoryFilter = document.getElementById('shopCategoryFilter');
    const minPrice = document.getElementById('minPrice');
    const maxPrice = document.getElementById('maxPrice');
    categoryFilter.innerHTML = '<option value="">All Categories</option>';
    mockData.categories.forEach(cat => {
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
