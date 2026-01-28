// ==========================================
// MODULE - CATEGORIES
// ==========================================
// Mapping theo admin-chuc-nang.md:
// - Ưu tiên gọi API /categories, /category
// - Fallback sang mockData.categories khi backend chưa sẵn sàng

async function renderCategoriesTable() {
    const tableBody = document.getElementById('categoriesTableBody');
    if (!tableBody) return;

    tableBody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">Loading...</td></tr>';

    let categories = [];
    try {
        const res = await API.getCategories();
        const raw = Array.isArray(res) ? res : (res?.items || res?.categories || []);
        categories = Array.isArray(raw) ? raw : [];
    } catch (e) {
        console.warn('renderCategoriesTable: using mockData.categories fallback', e);
        categories = Array.isArray(mockData?.categories) ? mockData.categories : [];
    }

    tableBody.innerHTML = '';
    if (!categories.length) {
        tableBody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">No data</td></tr>';
        setupCategoryFilters();
        return;
    }

    categories.forEach(category => {
        const id = category?.id ?? category?.categoryId;
        const name = category?.name ?? category?.categoryName ?? '';
        const description = category?.description ?? '';
        const productCount = category?.productCount ?? category?.totalProducts ?? '';

        const row = document.createElement('tr');
        row.innerHTML = `
            <td>#${id ?? ''}</td>
            <td>${name}</td>
            <td>${description}</td>
            <td>${productCount}</td>
            <td>
                <button class="btn btn-sm" onclick="editCategory(${Number(id)})"><i class="fas fa-edit"></i></button>
                <button class="btn btn-sm btn-danger" onclick="deleteCategory(${Number(id)})"><i class="fas fa-trash"></i></button>
            </td>
        `;
        tableBody.appendChild(row);
    });

    setupCategoryFilters();
}

function setupCategoryFilters() {
    const searchInput = document.getElementById('categorySearch');
    if (!searchInput) return;
    if (searchInput.__bound) return;
    searchInput.__bound = true;

    searchInput.addEventListener('input', (e) => {
        const searchTerm = e.target.value.toLowerCase();
        document.querySelectorAll('#categoriesTableBody tr').forEach(row => {
            const nameCell = row.cells[1];
            if (!nameCell) return;
            const nameMatch = nameCell.textContent.toLowerCase().includes(searchTerm);
            row.style.display = nameMatch ? '' : 'none';
        });
    });
}

async function editCategory(categoryId) {
    const id = Number(categoryId);
    if (!id) return;

    let category = null;
    try {
        category = await API.getCategory(id);
    } catch (e) {
        console.warn('editCategory: fallback to mockData', e);
        category = (mockData?.categories || []).find(c => Number(c.id) === id) || null;
    }

    if (!category) return;

    appState.editingId = id;
    document.getElementById('categoryName').value = category?.name ?? category?.categoryName ?? '';
    document.getElementById('categoryDesc').value = category?.description ?? '';
    const modal = new bootstrap.Modal(document.getElementById('categoryModal'));
    modal.show();
}

async function deleteCategory(categoryId) {
    const id = Number(categoryId);
    if (!id) return;
    if (!confirm('Are you sure?')) return;

    try {
        try {
            await API.deleteCategory(id);
        } catch (e) {
            console.warn('deleteCategory: backend failed, updating mockData only', e);
            if (Array.isArray(mockData?.categories)) {
                mockData.categories = mockData.categories.filter(c => Number(c.id) !== id);
            }
        }
        await renderCategoriesTable();
        showNotification('Category deleted', 'success');
    } catch (e) {
        console.error(e);
        showNotification('Delete category failed', 'danger');
    }
}

async function saveCategory() {
    const name = document.getElementById('categoryName').value?.trim();
    const description = document.getElementById('categoryDesc').value?.trim() || '';
    if (!name) {
        showNotification('Enter category name', 'danger');
        return;
    }

    const payload = { name, description };

    try {
        if (appState.editingId) {
            const id = appState.editingId;
            try {
                await API.updateCategory(id, payload);
                showNotification('Category updated', 'success');
            } catch (e) {
                console.warn('saveCategory(update): backend failed, updating mockData only', e);
                const category = (mockData.categories || []).find(c => Number(c.id) === Number(id));
                if (category) {
                    category.name = name;
                    category.description = description;
                }
                showNotification('Category updated (mock mode)', 'warning');
            }
        } else {
            try {
                await API.createCategory(payload);
                showNotification('Category added', 'success');
            } catch (e) {
                console.warn('saveCategory(create): backend failed, adding to mockData only', e);
                mockData.categories = mockData.categories || [];
                mockData.categories.push({
                    id: mockData.categories.length + 1,
                    name,
                    description,
                    productCount: 0
                });
                showNotification('Category added (mock mode)', 'warning');
            }
        }
    } finally {
        appState.editingId = null;
        await renderCategoriesTable();
        bootstrap.Modal.getInstance(document.getElementById('categoryModal'))?.hide();
    }
}

