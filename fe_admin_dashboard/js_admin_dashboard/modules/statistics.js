// ==========================================
// MODULE - STATISTICS
// ==========================================

function renderStatistics() {
    const totalRevenue = mockData.orders.reduce((sum, order) => sum + order.total, 0);
    const totalCost = mockData.products.reduce((sum, product) => sum + (product.price * product.stock * 0.6), 0);
    const profit = totalRevenue - totalCost;
    const profitRate = totalRevenue > 0 ? ((profit / totalRevenue) * 100).toFixed(2) : 0;
    document.getElementById('statsRevenue').textContent = formatCurrency(totalRevenue);
    document.getElementById('statsCost').textContent = formatCurrency(totalCost);
    document.getElementById('statsProfit').textContent = formatCurrency(profit);
    document.getElementById('statsProfitRate').textContent = `${profitRate}%`;
    renderProfitDetail();
}

function renderProfitDetail() {
    const tableBody = document.getElementById('profitDetailTable');
    tableBody.innerHTML = '';
    const months = ['January', 'February', 'March', 'April', 'May', 'June'];
    months.forEach((month, index) => {
        const revenue = Math.random() * 500000000 + 100000000;
        const cost = revenue * 0.6;
        const profit = revenue - cost;
        const rate = ((profit / revenue) * 100).toFixed(2);
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${month}</td>
            <td>${formatCurrency(revenue)}</td>
            <td>${formatCurrency(cost)}</td>
            <td>${formatCurrency(profit)}</td>
            <td>${rate}%</td>
        `;
        tableBody.appendChild(row);
    });
}
