// ==========================================
// MODULE - DASHBOARD
// ==========================================

function renderDashboard() {
    document.getElementById('totalUsers').textContent = mockData.users.length;
    document.getElementById('totalProducts').textContent = mockData.products.length;
    document.getElementById('totalOrders').textContent = mockData.orders.length;
    const totalRevenue = mockData.orders.reduce((sum, order) => sum + order.total, 0);
    document.getElementById('totalRevenue').textContent = formatCurrency(totalRevenue);
    renderRecentOrders();
    renderTopProducts();
}

function renderRecentOrders() {
    const tableBody = document.getElementById('recentOrdersTable');
    tableBody.innerHTML = '';
    mockData.orders.slice(0, 5).forEach(order => {
        const row = document.createElement('tr');
        const statusBadge = getStatusBadge(order.status);
        row.innerHTML = `
            <td>#${order.id}</td>
            <td>${order.customer}</td>
            <td>${formatCurrency(order.total)}</td>
            <td>${statusBadge}</td>
        `;
        tableBody.appendChild(row);
    });
}

function renderTopProducts() {
    const tableBody = document.getElementById('topProductsTable');
    tableBody.innerHTML = '';
    const topProducts = mockData.products.slice(0, 5);
    topProducts.forEach(product => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${product.name}</td>
            <td>5</td>
            <td>${formatCurrency(product.price * 5)}</td>
        `;
        tableBody.appendChild(row);
    });
}
