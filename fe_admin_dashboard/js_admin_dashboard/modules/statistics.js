// ==========================================
// MODULE - STATISTICS (API-based with mock fallback)
// ==========================================
// Mapping theo admin-chuc-nang.md:
// - API: /admin/statistics/summary
// - API: /admin/statistics/profit-details

async function renderStatistics() {
    const revenueEl = document.getElementById('statsRevenue');
    const costEl = document.getElementById('statsCost');
    const profitEl = document.getElementById('statsProfit');
    const rateEl = document.getElementById('statsProfitRate');

    let summary = null;
    try {
        summary = await API.getStatisticsSummary();
    } catch (e) {
        console.warn('renderStatistics: using mockData fallback', e);
        const totalRevenue = (mockData.orders || []).reduce((sum, order) => sum + (order.total || 0), 0);
        const totalCost = (mockData.products || []).reduce(
            (sum, product) => sum + ((product.price || 0) * (product.stock || 0) * 0.6),
            0
        );
        const profit = totalRevenue - totalCost;
        const profitRate = totalRevenue > 0 ? ((profit / totalRevenue) * 100) : 0;
        summary = {
            totalRevenue,
            totalCost,
            totalProfit: profit,
            profitRate
        };
    }

    const totalRevenue = Number(summary?.totalRevenue || 0);
    const totalCost = Number(summary?.totalCost || 0);
    const totalProfit = Number(summary?.totalProfit || (totalRevenue - totalCost));
    const profitRate = Number(
        summary?.profitRate != null
            ? summary.profitRate
            : (totalRevenue > 0 ? (totalProfit / totalRevenue) * 100 : 0)
    );

    if (revenueEl) revenueEl.textContent = formatCurrency(totalRevenue);
    if (revenueEl) revenueEl.nextElementSibling?.remove();
    if (revenueEl) revenueEl.insertAdjacentHTML('afterend','<small class="text-muted">Revenue = Σ order totals</small>');
    if (costEl) costEl.textContent = formatCurrency(totalCost);
    if (costEl) costEl.nextElementSibling?.remove();
    if (costEl) costEl.insertAdjacentHTML('afterend','<small class="text-muted">Cost = Σ cost per order/product</small>');
    if (profitEl) profitEl.textContent = formatCurrency(totalProfit);
    if (profitEl) profitEl.nextElementSibling?.remove();
    if (profitEl) profitEl.insertAdjacentHTML('afterend','<small class="text-muted">Profit = Revenue - Cost</small>');
    if (rateEl) rateEl.textContent = `${profitRate.toFixed(2)}%`;
    if (rateEl) rateEl.nextElementSibling?.remove();
    if (rateEl) rateEl.insertAdjacentHTML('afterend','<small class="text-muted">Profit Rate = Profit / Revenue</small>');

    await renderProfitDetail();
}

async function renderProfitDetail() {
    const tableBody = document.getElementById('profitDetailTable');
    if (!tableBody) return;

    tableBody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">Loading...</td></tr>';

    let rows = [];
    try {
        const res = await API.getProfitDetails();
        const raw = Array.isArray(res) ? res : (res?.items || res?.details || []);
        rows = Array.isArray(raw) ? raw : [];
    } catch (e) {
        console.warn('renderProfitDetail: falling back to random mock data', e);
        const months = ['January', 'February', 'March', 'April', 'May', 'June'];
        rows = months.map(month => {
            const revenue = Math.random() * 500000000 + 100000000;
            const cost = revenue * 0.6;
            const profit = revenue - cost;
            const rate = (profit / revenue) * 100;
            return { month, revenue, cost, profit, profitRate: rate };
        });
    }

    tableBody.innerHTML = '';
    if (!rows.length) {
        tableBody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">No data</td></tr>';
        return;
    }

    rows.forEach(item => {
        const month = item?.month ?? item?.label ?? '';
        const revenue = Number(item?.revenue || item?.totalRevenue || 0);
        const cost = Number(item?.cost || item?.totalCost || 0);
        const profit = Number(item?.profit || item?.totalProfit || (revenue - cost));
        const rate = Number(
            item?.profitRate != null
                ? item.profitRate
                : (revenue > 0 ? (profit / revenue) * 100 : 0)
        );

        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${month}</td>
            <td>${formatCurrency(revenue)}</td>
            <td>${formatCurrency(cost)}</td>
            <td>${formatCurrency(profit)}</td>
            <td>${rate.toFixed(2)}%</td>
        `;
        tableBody.appendChild(row);
    });
}
