// ==========================================
// MODULE - WISHLIST
// ==========================================

function renderWishlist() {
    const grid = document.getElementById('wishlistGrid');
    const count = document.getElementById('wishlistItemCount');
    count.textContent = mockData.wishlist.length;
    if (mockData.wishlist.length === 0) {
        grid.innerHTML = '<div class="col-12 text-center text-muted py-5">No items in wishlist</div>';
        return;
    }
    grid.innerHTML = '';
    mockData.wishlist.forEach(productId => {
        const product = mockData.products.find(p => p.id === productId);
        if (!product) return;
        const productCard = document.createElement('div');
        productCard.className = 'product-card';
        productCard.innerHTML = `
            <img src="https://via.placeholder.com/200" alt="${product.name}" class="product-image">
            <div class="product-info">
                <h6 class="product-name">${product.name}</h6>
                <p class="product-price">${formatCurrency(product.price)}</p>
                <div class="product-actions">
                    <button class="btn btn-danger" onclick="removeFromWishlist(${product.id})" title="Remove"><i class="fas fa-heart-broken"></i> Unwish</button>
                </div>
            </div>
        `;
        grid.appendChild(productCard);
    });
}

function addToWishlist(productId) {
    if (!mockData.wishlist.includes(productId)) {
        mockData.wishlist.push(productId);
        updateWishlistBadge();
        showNotification('Added to wishlist', 'success');
    }
}

function removeFromWishlist(productId) {
    mockData.wishlist = mockData.wishlist.filter(id => id !== productId);
    updateWishlistBadge();
    if (appState.currentSection === 'wishlist') { renderWishlist(); }
    showNotification('Removed from wishlist', 'info');
}

function updateWishlistBadge() {
    const badge = document.getElementById('wishlistCount');
    if (badge) {
        badge.textContent = mockData.wishlist.length;
        badge.style.display = mockData.wishlist.length > 0 ? 'inline-block' : 'none';
    }
}
