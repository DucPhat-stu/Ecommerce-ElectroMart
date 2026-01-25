// ==========================================
// MODULE - ORDERS
// ==========================================

function renderOrdersTable() {
    const tableBody = document.getElementById('ordersTableBody');
    tableBody.innerHTML = '';
    mockData.orders.forEach(order => {
        const row = document.createElement('tr');
        const statusBadge = getStatusBadge(order.status);
        row.innerHTML = `
            <td>#${order.id}</td>
            <td>${order.customer}</td>
            <td>${formatCurrency(order.total)}</td>
            <td>${statusBadge}</td>
            <td>${order.createdAt}</td>
            <td>
                <button class="btn btn-sm" onclick="editOrder(${order.id})"><i class="fas fa-edit"></i></button>
                <button class="btn btn-sm btn-danger" onclick="deleteOrder(${order.id})"><i class="fas fa-trash"></i></button>
            </td>
        `;
        tableBody.appendChild(row);
    });
    setupOrderFilters();
}

function setupOrderFilters() {
    const searchInput = document.getElementById('orderSearch');
    const statusFilter = document.getElementById('orderStatusFilter');
    const filterOrders = () => {
        const searchTerm = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value;
        document.querySelectorAll('#ordersTableBody tr').forEach(row => {
            const idMatch = row.cells[0].textContent.toLowerCase().includes(searchTerm);
            const statusMatch = !statusValue || row.cells[3].textContent.includes(statusValue);
            row.style.display = idMatch && statusMatch ? '' : 'none';
        });
    };
    searchInput.addEventListener('input', filterOrders);
    statusFilter.addEventListener('change', filterOrders);
}

function editOrder(orderId) {
    const order = mockData.orders.find(o => o.id === orderId);
    if (order) { appState.editingId = orderId; alert(`Edit order #${orderId}`); }
}

function deleteOrder(orderId) {
    if (confirm('Are you sure?')) {
        mockData.orders = mockData.orders.filter(o => o.id !== orderId);
        renderOrdersTable();
        showNotification('Order deleted', 'success');
    }
}
