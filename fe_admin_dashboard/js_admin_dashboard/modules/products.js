// ==========================================
// MODULE - PRODUCTS
// ==========================================

let __productsState = {
    products: [],
    categories: []
};

function __normalizeStatusToUi(status) {
    const s = String(status || '').toLowerCase();
    if (s === 'active' || s === 'enabled' || s === 'true' || s === '1' || s === 'available' || s === 'in_stock' || s === 'in stock' || s === 'instock') return 'active';
    if (s === 'inactive' || s === 'disabled' || s === 'false' || s === '0') return 'inactive';
    if (s === 'active') return 'active';
    if (s === 'inactive') return 'inactive';
    if (s === 'productstatus.active' || s === 'active_status' || s === 'status_active') return 'active';
    if (s === 'productstatus.inactive' || s === 'inactive_status' || s === 'status_inactive') return 'inactive';
    if (s === 'active'.toLowerCase()) return 'active';
    if (s === 'inactive'.toLowerCase()) return 'inactive';
    if (s === 'active') return 'active';
    // Backend enum often returns "ACTIVE"/"INACTIVE"
    if (s === 'active') return 'active';
    if (s === 'inactive') return 'inactive';
    if (s === 'active'.toLowerCase()) return 'active';
    if (s === 'inactive'.toLowerCase()) return 'inactive';
    if (s === 'active'.toLowerCase()) return 'active';
    if (s === 'inactive'.toLowerCase()) return 'inactive';
    if (s === 'active') return 'active';
    if (s === 'inactive') return 'inactive';
    if (s === 'active') return 'active';
    if (s === 'inactive') return 'inactive';
    if (s === 'active') return 'active';
    if (s === 'inactive') return 'inactive';
    if (s === 'active') return 'active';
    // Default
    return s === 'active' ? 'active' : (s === 'inactive' ? 'inactive' : 'active');
}

function __statusUiToBackend(uiStatus) {
    return String(uiStatus || '').toLowerCase() === 'inactive' ? 'INACTIVE' : 'ACTIVE';
}

function __getCategoryName(product) {
    return (
        product?.categoryName ||
        product?.category?.name ||
        product?.category ||
        ''
    );
}

function __getStock(product) {
    const v = product?.stockQuantity ?? product?.stock ?? 0;
    const n = Number(v);
    return Number.isFinite(n) ? n : 0;
}

function __getPrice(product) {
    const v = product?.finalPrice ?? product?.price ?? product?.basePrice ?? 0;
    const n = Number(v);
    return Number.isFinite(n) ? n : 0;
}

function __templateKeyFromAny(value) {
    if (!value) return null;
    const s = String(value).trim();
    // Keep strict: only allow product01..product09.png
    const m = s.match(/(?:^|\/)(?:img\/)?(product0[1-9]\.png)$/i);
    return m ? m[1].toLowerCase() : null;
}

function __getTemplateKey(product) {
    const imgs = Array.isArray(product?.productImages) ? product.productImages : [];
    if (imgs.length) {
        const primary = imgs.find?.(i => i && i.primary) || imgs[0];
        const key = __templateKeyFromAny(primary?.imageUrl);
        if (key) return key;
    }
    return __templateKeyFromAny(product?.imageUrl) || null;
}

function __setProductImagePreviewFromKey(key) {
    const img = document.getElementById('productImagePreview');
    if (!img) return;
    const safeKey = __templateKeyFromAny(key) || 'product01.png';
    img.src = `/img/${safeKey}`;
}

function __bindProductImageSelector() {
    const sel = document.getElementById('productImageKey');
    if (!sel || sel.__bound) return;
    sel.__bound = true;
    sel.addEventListener('change', function() {
        __setProductImagePreviewFromKey(sel.value);
    });

    const modalEl = document.getElementById('productModal');
    if (modalEl && !modalEl.__imgBound) {
        modalEl.__imgBound = true;
        modalEl.addEventListener('show.bs.modal', function() {
            if (!appState?.editingId) {
                if (sel) sel.value = 'product01.png';
                __setProductImagePreviewFromKey('product01.png');
            }
        });
    }
}

async function __loadProductsData() {
    // Prefer backend API; fallback to mockData if backend not available.
    let categories = [];
    let products = [];

    try {
        const c = await API.getCategories();
        categories = Array.isArray(c) ? c : (c?.items || c?.categories || []);
    } catch (_) {
        categories = Array.isArray(mockData?.categories) ? mockData.categories : [];
    }

    try {
        const p = await API.getProducts();
        products = Array.isArray(p) ? p : (p?.items || p?.products || []);
    } catch (_) {
        products = Array.isArray(mockData?.products) ? mockData.products : [];
    }

    __productsState.categories = categories;
    __productsState.products = products;
}

async function renderProductsTable() {
    __bindProductImageSelector();

    const tableBody = document.getElementById('productsTableBody');
    const categorySelect = document.getElementById('productCategoryFilter');
    const formCategorySelect = document.getElementById('productCategory');
    if (!tableBody || !categorySelect || !formCategorySelect) return;

    tableBody.innerHTML = '<tr><td colspan="7" class="text-center text-muted">Loading...</td></tr>';
    await __loadProductsData();

    // Categories
    categorySelect.innerHTML = '<option value="">All Categories</option>';
    formCategorySelect.innerHTML = '';
    (__productsState.categories || []).forEach(cat => {
        const id = cat?.id ?? cat?.categoryId;
        const name = cat?.name ?? cat?.categoryName ?? '';
        if (!name) return;

        const opt1 = document.createElement('option');
        opt1.value = id;
        opt1.textContent = name;
        formCategorySelect.appendChild(opt1);

        const opt2 = document.createElement('option');
        opt2.value = name;
        opt2.textContent = name;
        categorySelect.appendChild(opt2);
    });

    // Products
    tableBody.innerHTML = '';
    const products = __productsState.products || [];
    if (!products.length) {
        tableBody.innerHTML = '<tr><td colspan="7" class="text-center text-muted">No data available</td></tr>';
        setupProductFilters();
        return;
    }

    products.forEach(product => {
        const id = product?.id ?? product?.productId;
        const name = product?.name ?? '';
        const categoryName = __getCategoryName(product) || '—';
        const price = __getPrice(product);
        const stock = __getStock(product);
        const uiStatus = __normalizeStatusToUi(product?.status);
        const statusBadge = uiStatus === 'active'
            ? '<span class="badge-success">Active</span>'
            : '<span class="badge-warning">Inactive</span>';

        const row = document.createElement('tr');
        row.innerHTML = `
            <td>#${id ?? ''}</td>
            <td>${name || ''}</td>
            <td>${categoryName}</td>
            <td>${formatCurrency(price)}</td>
            <td>${stock}</td>
            <td>${statusBadge}</td>
            <td>
                <button class="btn btn-sm" onclick="editProduct(${Number(id)})"><i class="fas fa-edit"></i></button>
                <button class="btn btn-sm btn-danger" onclick="deleteProduct(${Number(id)})"><i class="fas fa-trash"></i></button>
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
    (async () => {
        try {
            let product = null;
            try {
                product = await API.getProduct(productId);
            } catch (_) {
                product = (mockData?.products || []).find(p => p.id === productId) || null;
            }

            if (!product) return;

            appState.editingId = productId;
            document.getElementById('productName').value = product?.name || '';
            document.getElementById('productShortDescription').value = product?.shortDescription || '';
            document.getElementById('productDescription').value = product?.description || '';

            // Category (try id first, fallback by name)
            const categoryId = product?.categoryId ?? product?.category?.id ?? '';
            const categoryName = __getCategoryName(product);
            const catSelect = document.getElementById('productCategory');
            if (categoryId) {
                catSelect.value = String(categoryId);
            } else if (categoryName) {
                const match = (__productsState.categories || []).find(c => (c?.name || c?.categoryName) === categoryName);
                if (match) catSelect.value = String(match.id);
            }

            document.getElementById('productPrice').value = __getPrice(product);
            document.getElementById('productDiscountPercent').value = Number(product?.discountPercent || 0);
            document.getElementById('productStock').value = __getStock(product);
            document.getElementById('productStatus').value = __normalizeStatusToUi(product?.status);

            const key = __getTemplateKey(product) || 'product01.png';
            const sel = document.getElementById('productImageKey');
            if (sel) sel.value = key;
            __setProductImagePreviewFromKey(key);

            const modal = new bootstrap.Modal(document.getElementById('productModal'));
            modal.show();
        } catch (e) {
            console.error(e);
            showNotification('Cannot load product for editing', 'danger');
        }
    })();
}

function deleteProduct(productId) {
    (async () => {
        if (!confirm('Are you sure?')) return;
        try {
            try {
                await API.deleteProduct(productId);
            } catch (_) {
                // fallback to mock
                if (Array.isArray(mockData?.products)) {
                    mockData.products = mockData.products.filter(p => p.id !== productId);
                }
            }
            await renderProductsTable();
            showNotification('Product deleted', 'success');
        } catch (e) {
            console.error(e);
            showNotification('Delete failed', 'danger');
        }
    })();
}

function saveProduct() {
    (async () => {
        const name = document.getElementById('productName').value?.trim();
        const shortDescription = document.getElementById('productShortDescription').value?.trim() || '';
        const description = document.getElementById('productDescription').value?.trim() || '';
        const categoryId = document.getElementById('productCategory').value;
        const price = Number(document.getElementById('productPrice').value);
        const discountPercent = Number(document.getElementById('productDiscountPercent').value || 0);
        const stockQuantity = Number(document.getElementById('productStock').value);
        const statusUi = document.getElementById('productStatus').value;
        const imageKey = document.getElementById('productImageKey')?.value || 'product01.png';

        if (!name || !categoryId || !Number.isFinite(price) || !Number.isFinite(stockQuantity)) {
            showNotification('Fill all fields', 'danger');
            return;
        }

        const payload = {
            name,
            shortDescription,
            description,
            status: __statusUiToBackend(statusUi),
            categoryId: Number(categoryId),
            price,
            discountPercent: Math.max(0, Math.min(100, discountPercent || 0)),
            stockQuantity,
            productImages: [
                { imageUrl: __templateKeyFromAny(imageKey) || 'product01.png', primary: true }
            ]
        };

        try {
            if (appState.editingId) {
                await API.updateProduct(appState.editingId, payload);
                showNotification('Product updated', 'success');
            } else {
                await API.createProduct(payload);
                showNotification('Product added', 'success');
            }
        } catch (e) {
            // fallback: keep admin UI usable without backend
            console.warn('Backend product save failed, falling back to mockData', e);
            const category = (__productsState.categories || mockData.categories || []).find(c => String(c.id) === String(categoryId) || String(c.name) === String(categoryId));
            const categoryName = category?.name || category?.categoryName || (category?.id ? String(category.id) : '');

            if (appState.editingId) {
                const product = (mockData.products || []).find(p => p.id === appState.editingId);
                if (product) {
                    product.name = name;
                    product.category = categoryName;
                    product.price = price;
                    product.stock = stockQuantity;
                    product.status = statusUi;
                    product.shortDescription = shortDescription;
                    product.description = description;
                    product.discountPercent = discountPercent;
                    product.productImages = [{ imageUrl: __templateKeyFromAny(imageKey) || 'product01.png', primary: true }];
                }
                showNotification('Product updated (mock mode)', 'warning');
            } else {
                mockData.products = mockData.products || [];
                mockData.products.push({
                    id: mockData.products.length + 1,
                    name,
                    category: categoryName,
                    price,
                    stock: stockQuantity,
                    status: statusUi,
                    shortDescription,
                    description,
                    discountPercent,
                    productImages: [{ imageUrl: __templateKeyFromAny(imageKey) || 'product01.png', primary: true }]
                });
                showNotification('Product added (mock mode)', 'warning');
            }
        }

        appState.editingId = null;
        await renderProductsTable();
        bootstrap.Modal.getInstance(document.getElementById('productModal'))?.hide();
    })();
}
