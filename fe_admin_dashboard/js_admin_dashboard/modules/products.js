// ==========================================
// MODULE - PRODUCTS
// ==========================================

function renderProductsTable() {
    const tableBody = document.getElementById('productsTableBody');
    tableBody.innerHTML = '';
    const categorySelect = document.getElementById('productCategoryFilter');
    const formCategorySelect = document.getElementById('productCategory');
    categorySelect.innerHTML = '<option value="">All Categories</option>';
    formCategorySelect.innerHTML = '';
    mockData.categories.forEach(cat => {
        const opt1 = document.createElement('option');
        opt1.value = cat.id;
        opt1.textContent = cat.name;
        formCategorySelect.appendChild(opt1);
        const opt2 = document.createElement('option');
        opt2.value = cat.name;
        opt2.textContent = cat.name;
        categorySelect.appendChild(opt2);
    });
    mockData.products.forEach(product => {
        const row = document.createElement('tr');
        const statusBadge = product.status === 'active' ? '<span class="badge-success">Active</span>' : '<span class="badge-warning">Inactive</span>';
        row.innerHTML = `
            <td>#${product.id}</td>
            <td>${product.name}</td>
            <td>${product.category}</td>
            <td>${formatCurrency(product.price)}</td>
            <td>${product.stock}</td>
            <td>${statusBadge}</td>
            <td>
                <button class="btn btn-sm" onclick="editProduct(${product.id})"><i class="fas fa-edit"></i></button>
                <button class="btn btn-sm btn-danger" onclick="deleteProduct(${product.id})"><i class="fas fa-trash"></i></button>
            </td>
        `;
        tableBody.appendChild(row);
    });
    setupProductFilters();
}

function setupProductFilters() {
    const searchInput = document.getElementById('productSearch');
    const categoryFilter = document.getElementById('productCategoryFilter');
    const statusFilter = document.getElementById('productStatusFilter');
    const filterProducts = () => {
        const searchTerm = searchInput.value.toLowerCase();
        const categoryValue = categoryFilter.value;
        const statusValue = statusFilter.value;
        document.querySelectorAll('#productsTableBody tr').forEach(row => {
            const nameMatch = row.cells[1].textContent.toLowerCase().includes(searchTerm);
            const categoryMatch = !categoryValue || row.cells[2].textContent.includes(categoryValue);
            const statusMatch = !statusValue || row.cells[5].textContent.includes(statusValue);
            row.style.display = nameMatch && categoryMatch && statusMatch ? '' : 'none';
        });
    };
    searchInput.addEventListener('input', filterProducts);
    categoryFilter.addEventListener('change', filterProducts);
    statusFilter.addEventListener('change', filterProducts);
}

function editProduct(productId) {
    const product = mockData.products.find(p => p.id === productId);
    if (product) {
        appState.editingId = productId;
        document.getElementById('productName').value = product.name;
        document.getElementById('productCategory').value = mockData.categories.find(c => c.name === product.category)?.id || '';
        document.getElementById('productPrice').value = product.price;
        document.getElementById('productStock').value = product.stock;
        document.getElementById('productStatus').value = product.status;
        const modal = new bootstrap.Modal(document.getElementById('productModal'));
        modal.show();
    }
}

function deleteProduct(productId) {
    if (confirm('Are you sure?')) {
        mockData.products = mockData.products.filter(p => p.id !== productId);
        renderProductsTable();
        showNotification('Product deleted', 'success');
    }
}

function saveProduct() {
    const name = document.getElementById('productName').value;
    const categoryId = document.getElementById('productCategory').value;
    const price = parseInt(document.getElementById('productPrice').value);
    const stock = parseInt(document.getElementById('productStock').value);
    const status = document.getElementById('productStatus').value;
    if (!name || !categoryId || !price || stock === undefined) { showNotification('Fill all fields', 'danger'); return; }
    const category = mockData.categories.find(c => c.id == categoryId);
    if (appState.editingId) {
        const product = mockData.products.find(p => p.id === appState.editingId);
        if (product) { product.name = name; product.category = category.name; product.price = price; product.stock = stock; product.status = status; }
        showNotification('Product updated', 'success');
    } else {
        mockData.products.push({ id: mockData.products.length + 1, name, category: category.name, price, stock, status });
        showNotification('Product added', 'success');
    }
    appState.editingId = null;
    renderProductsTable();
    bootstrap.Modal.getInstance(document.getElementById('productModal')).hide();
}
