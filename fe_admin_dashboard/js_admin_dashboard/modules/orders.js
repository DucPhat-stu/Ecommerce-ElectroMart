// ==========================================
// MODULE - ORDERS (API-based with mock fallback)
// ==========================================
// Mapping theo admin-chuc-nang.md:
// - API: /orders, /orders/{id}, /orders/{id}/status (GET/PUT/DELETE)
// - DTO tham chiếu: getOrderAPI.json

async function renderOrdersTable() {
    const tableBody = document.getElementById('ordersTableBody');
    if (!tableBody) return;

    tableBody.innerHTML = '<tr><td colspan="6" class="text-center text-muted">Loading...</td></tr>';

    const statusFilter = document.getElementById('orderStatusFilter');
    const selectedStatus = statusFilter?.value || null;

    let orders = [];
    try {
        const res = await API.getOrders(selectedStatus || null);
        const raw = Array.isArray(res) ? res : (res?.items || res?.orders || []);
        orders = Array.isArray(raw) ? raw : [];
    } catch (e) {
        console.warn('renderOrdersTable: using mockData.orders fallback', e);
        orders = Array.isArray(mockData?.orders) ? mockData.orders : [];
    }

    tableBody.innerHTML = '';
    if (!orders.length) {
        tableBody.innerHTML = '<tr><td colspan="6" class="text-center text-muted">No data</td></tr>';
        setupOrderFilters();
        return;
    }

    orders.forEach(order => {
        const id = order?.id ?? order?.orderId;
        const customer = order?.customer
            || order?.shippingName
            || (order?.user && order.user.name)
            || `User #${order?.userId ?? ''}`;
        const total = order?.totalPrice ?? order?.total ?? order?.totalAmount ?? 0;
        const createdAt = order?.createdAt ?? '';
        const statusRaw = (order?.status || 'PENDING').toString().toLowerCase();
        const statusBadge = getStatusBadge(statusRaw);

        const row = document.createElement('tr');
        row.innerHTML = `
            <td>#${id ?? ''}</td>
            <td>${customer}</td>
            <td>${formatCurrency(total)}</td>
            <td>${statusBadge}</td>
            <td>${createdAt}</td>
            <td>
                <button class="btn btn-sm" onclick="editOrder(${Number(id)})"><i class="fas fa-edit"></i></button>
                <button class="btn btn-sm btn-danger" onclick="deleteOrder(${Number(id)})"><i class="fas fa-trash"></i></button>
            </td>
        `;
        tableBody.appendChild(row);
    });

    setupOrderFilters();
}

function setupOrderFilters() {
    const searchInput = document.getElementById('orderSearch');
    const statusFilter = document.getElementById('orderStatusFilter');
    if (!searchInput || !statusFilter) return;
    if (searchInput.__bound) return;
    searchInput.__bound = true;

    const filterOrders = () => {
        const searchTerm = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value;
        document.querySelectorAll('#ordersTableBody tr').forEach(row => {
            const idCell = row.cells[0];
            const statusCell = row.cells[3];
            if (!idCell || !statusCell) return;
            const idMatch = idCell.textContent.toLowerCase().includes(searchTerm);
            const statusMatch = !statusValue || statusCell.textContent.toLowerCase().includes(statusValue.toLowerCase());
            row.style.display = idMatch && statusMatch ? '' : 'none';
        });
    };

    searchInput.addEventListener('input', filterOrders);
    statusFilter.addEventListener('change', async () => {
        // Khi đổi filter status, reload từ API để backend lọc luôn
        await renderOrdersTable();
        filterOrders();
    });
}

async function editOrder(orderId) {
    const id = Number(orderId);
    if (!id) return;

    let order = null;
    try {
        order = await API.getOrder(id);
    } catch (e) {
        console.warn('editOrder: fallback to mockData', e);
        order = (mockData?.orders || []).find(o => Number(o.id) === id) || null;
    }

    if (!order) return;

    appState.editingId = id;

    // Tạm thời dùng alert chi tiết đơn, có thể nâng cấp thành modal chi tiết theo getOrderAPI.json
    const total = order?.totalPrice ?? order?.total ?? order?.totalAmount ?? 0;
    const status = order?.status ?? 'PENDING';
    const shippingName = order?.shippingName ?? '';
    const shippingAddress = order?.shippingAddress ?? '';
    const shippingPhone = order?.shippingPhone ?? '';

    alert(
        `Order #${id}\n` +
        `Customer: ${shippingName}\n` +
        `Phone: ${shippingPhone}\n` +
        `Address: ${shippingAddress}\n` +
        `Status: ${status}\n` +
        `Total: ${formatCurrency(total)}`
    );
}

async function deleteOrder(orderId) {
    const id = Number(orderId);
    if (!id) return;
    if (!confirm('Are you sure?')) return;

    try {
        try {
            await API.deleteOrder(id);
        } catch (e) {
            console.warn('deleteOrder: backend failed, updating mockData only', e);
            if (Array.isArray(mockData?.orders)) {
                mockData.orders = mockData.orders.filter(o => Number(o.id) !== id);
            }
        }
        await renderOrdersTable();
        showNotification('Order deleted', 'success');
    } catch (e) {
        console.error(e);
        showNotification('Delete order failed', 'danger');
    }
}

