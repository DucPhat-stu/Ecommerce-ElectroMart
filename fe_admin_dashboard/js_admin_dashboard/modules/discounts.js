// ==========================================
// MODULE - DISCOUNTS
// ==========================================

function renderDiscountsTable() {
    const tableBody = document.getElementById('discountsTableBody');
    tableBody.innerHTML = '';
    mockData.discounts.forEach(discount => {
        const row = document.createElement('tr');
        const statusBadge = discount.status === 'active' ? '<span class="badge-success">Active</span>' : '<span class="badge-danger">Expired</span>';
        row.innerHTML = `
            <td>#${discount.id}</td>
            <td>${discount.code}</td>
            <td>${discount.percent}%</td>
            <td>${discount.startDate}</td>
            <td>${discount.endDate}</td>
            <td>${statusBadge}</td>
            <td>
                <button class="btn btn-sm" onclick="editDiscount(${discount.id})"><i class="fas fa-edit"></i></button>
                <button class="btn btn-sm btn-danger" onclick="deleteDiscount(${discount.id})"><i class="fas fa-trash"></i></button>
            </td>
        `;
        tableBody.appendChild(row);
    });
    setupDiscountFilters();
}

function setupDiscountFilters() {
    const searchInput = document.getElementById('discountSearch');
    const statusFilter = document.getElementById('discountStatusFilter');
    const filterDiscounts = () => {
        const searchTerm = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value;
        document.querySelectorAll('#discountsTableBody tr').forEach(row => {
            const codeMatch = row.cells[1].textContent.toLowerCase().includes(searchTerm);
            const statusMatch = !statusValue || row.cells[5].textContent.includes(statusValue);
            row.style.display = codeMatch && statusMatch ? '' : 'none';
        });
    };
    searchInput.addEventListener('input', filterDiscounts);
    statusFilter.addEventListener('change', filterDiscounts);
}

function editDiscount(discountId) {
    const discount = mockData.discounts.find(d => d.id === discountId);
    if (discount) {
        appState.editingId = discountId;
        document.getElementById('discountCode').value = discount.code;
        document.getElementById('discountPercent').value = discount.percent;
        document.getElementById('discountStart').value = discount.startDate;
        document.getElementById('discountEnd').value = discount.endDate;
        const modal = new bootstrap.Modal(document.getElementById('discountModal'));
        modal.show();
    }
}

function deleteDiscount(discountId) {
    if (confirm('Are you sure?')) {
        mockData.discounts = mockData.discounts.filter(d => d.id !== discountId);
        renderDiscountsTable();
        showNotification('Discount deleted', 'success');
    }
}

function saveDiscount() {
    const code = document.getElementById('discountCode').value;
    const percent = parseInt(document.getElementById('discountPercent').value);
    const startDate = document.getElementById('discountStart').value;
    const endDate = document.getElementById('discountEnd').value;
    if (!code || !percent || !startDate || !endDate) { showNotification('Fill all fields', 'danger'); return; }
    const status = new Date(endDate) > new Date() ? 'active' : 'expired';
    if (appState.editingId) {
        const discount = mockData.discounts.find(d => d.id === appState.editingId);
        if (discount) { discount.code = code; discount.percent = percent; discount.startDate = startDate; discount.endDate = endDate; discount.status = status; }
        showNotification('Discount updated', 'success');
    } else {
        mockData.discounts.push({ id: mockData.discounts.length + 1, code, percent, startDate, endDate, status });
        showNotification('Discount added', 'success');
    }
    appState.editingId = null;
    renderDiscountsTable();
    bootstrap.Modal.getInstance(document.getElementById('discountModal')).hide();
}
