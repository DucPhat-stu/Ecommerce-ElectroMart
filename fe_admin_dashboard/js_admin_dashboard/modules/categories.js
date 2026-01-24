// ==========================================
// MODULE - CATEGORIES
// ==========================================

function renderCategoriesTable() {
    const tableBody = document.getElementById('categoriesTableBody');
    tableBody.innerHTML = '';
    mockData.categories.forEach(category => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>#${category.id}</td>
            <td>${category.name}</td>
            <td>${category.description}</td>
            <td>${category.productCount}</td>
            <td>
                <button class="btn btn-sm" onclick="editCategory(${category.id})"><i class="fas fa-edit"></i></button>
                <button class="btn btn-sm btn-danger" onclick="deleteCategory(${category.id})"><i class="fas fa-trash"></i></button>
            </td>
        `;
        tableBody.appendChild(row);
    });
    setupCategoryFilters();
}

function setupCategoryFilters() {
    const searchInput = document.getElementById('categorySearch');
    searchInput.addEventListener('input', (e) => {
        const searchTerm = e.target.value.toLowerCase();
        document.querySelectorAll('#categoriesTableBody tr').forEach(row => {
            const nameMatch = row.cells[1].textContent.toLowerCase().includes(searchTerm);
            row.style.display = nameMatch ? '' : 'none';
        });
    });
}

function editCategory(categoryId) {
    const category = mockData.categories.find(c => c.id === categoryId);
    if (category) {
        appState.editingId = categoryId;
        document.getElementById('categoryName').value = category.name;
        document.getElementById('categoryDesc').value = category.description;
        const modal = new bootstrap.Modal(document.getElementById('categoryModal'));
        modal.show();
    }
}

function deleteCategory(categoryId) {
    if (confirm('Are you sure?')) {
        mockData.categories = mockData.categories.filter(c => c.id !== categoryId);
        renderCategoriesTable();
        showNotification('Category deleted', 'success');
    }
}

function saveCategory() {
    const name = document.getElementById('categoryName').value;
    const description = document.getElementById('categoryDesc').value;
    if (!name) { showNotification('Enter category name', 'danger'); return; }
    if (appState.editingId) {
        const category = mockData.categories.find(c => c.id === appState.editingId);
        if (category) { category.name = name; category.description = description; }
        showNotification('Category updated', 'success');
    } else {
        mockData.categories.push({ id: mockData.categories.length + 1, name, description, productCount: 0 });
        showNotification('Category added', 'success');
    }
    appState.editingId = null;
    renderCategoriesTable();
    bootstrap.Modal.getInstance(document.getElementById('categoryModal')).hide();
}
