// ==========================================
// MODULE - DASHBOARD
// ==========================================

async function renderDashboard() {
    try {
        // Load dashboard summary from API
        const summary = await API.getDashboardSummary();
        document.getElementById('totalUsers').textContent = summary.totalUsers || 0;
        document.getElementById('totalProducts').textContent = summary.totalProducts || 0;
        document.getElementById('totalOrders').textContent = summary.totalOrders || 0;
        document.getElementById('totalRevenue').textContent = formatCurrency(summary.totalRevenue || 0);
        
        // Load recent orders and top products
        await renderRecentOrders();
        await renderTopProducts();
    } catch (error) {
        console.error('Error loading dashboard:', error);
        showNotification('Failed to load dashboard data', 'danger');
        // Fallback to mock data
        document.getElementById('totalUsers').textContent = mockData.users.length;
        document.getElementById('totalProducts').textContent = mockData.products.length;
        document.getElementById('totalOrders').textContent = mockData.orders.length;
        const totalRevenue = mockData.orders.reduce((sum, order) => sum + order.total, 0);
        document.getElementById('totalRevenue').textContent = formatCurrency(totalRevenue);
    }
}

async function renderRecentOrders() {
    const tableBody = document.getElementById('recentOrdersTable');
    tableBody.innerHTML = '<tr><td colspan="4" class="text-center">Loading...</td></tr>';
    
    try {
        const orders = await API.getRecentOrders(5);
        tableBody.innerHTML = '';
        
        if (orders.length === 0) {
            tableBody.innerHTML = '<tr><td colspan="4" class="text-center text-muted">No orders</td></tr>';
            return;
        }
        
        orders.forEach(order => {
            const row = document.createElement('tr');
            const statusBadge = getStatusBadge(order.status?.toLowerCase() || 'pending');
            row.innerHTML = `
                <td>#${order.id}</td>
                <td>${order.customer || 'N/A'}</td>
                <td>${formatCurrency(order.total || 0)}</td>
                <td>${statusBadge}</td>
            `;
            tableBody.appendChild(row);
        });
    } catch (error) {
        console.error('Error loading recent orders:', error);
        tableBody.innerHTML = '<tr><td colspan="4" class="text-center text-danger">Error loading orders</td></tr>';
    }
}

async function renderTopProducts() {
    const tableBody = document.getElementById('topProductsTable');
    tableBody.innerHTML = '<tr><td colspan="3" class="text-center">Loading...</td></tr>';
    
    try {
        const products = await API.getTopProducts(5);
        tableBody.innerHTML = '';
        
        if (products.length === 0) {
            tableBody.innerHTML = '<tr><td colspan="3" class="text-center text-muted">No products</td></tr>';
            return;
        }
        
        products.forEach(product => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${product.productName || 'N/A'}</td>
                <td>${product.sold || 0}</td>
                <td>${formatCurrency(product.revenue || 0)}</td>
            `;
            tableBody.appendChild(row);
        });
    } catch (error) {
        console.error('Error loading top products:', error);
        tableBody.innerHTML = '<tr><td colspan="3" class="text-center text-danger">Error loading products</td></tr>';
    }
}
