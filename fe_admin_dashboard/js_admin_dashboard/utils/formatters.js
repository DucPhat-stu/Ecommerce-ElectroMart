/**
 * Utility: Format Currency
 */
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(amount);
}

/**
 * Utility: Get Status Badge
 */
function getStatusBadge(status) {
    const badges = {
        'pending': '<span class="badge-warning">Pending</span>',
        'confirmed': '<span class="badge-info">Confirmed</span>',
        'shipped': '<span class="badge-success">Shipped</span>',
        'cancelled': '<span class="badge-danger">Cancelled</span>',
        'active': '<span class="badge-success">Active</span>',
        'inactive': '<span class="badge-warning">Inactive</span>',
        'expired': '<span class="badge-danger">Expired</span>'
    };
    return badges[status] || '<span class="badge-secondary">Unknown</span>';
}
