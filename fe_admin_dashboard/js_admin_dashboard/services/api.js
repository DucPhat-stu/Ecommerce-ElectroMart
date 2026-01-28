/**
 * ==========================================
 * API Service - Kết nối với Backend
 * ==========================================
 */

// Auto-detect API base URL
// Nếu chạy qua Nginx (cùng domain), dùng relative path
// Nếu chạy local (khác port), dùng absolute URL
const API_BASE_URL = (() => {
    const hostname = window.location.hostname;
    const port = window.location.port;
    
    // Nếu chạy trên localhost và port 80 (Nginx), dùng relative path
    if (hostname === 'localhost' && (port === '' || port === '80')) {
        return '/api/v1';
    }
    
    // Nếu chạy local development, dùng port 8080
    return 'http://localhost:8080/api/v1';
})();

/**
 * Generic API call function
 */
async function apiCall(endpoint, options = {}) {
    try {
        const url = `${API_BASE_URL}${endpoint}`;
        const config = {
            headers: {
                'Content-Type': 'application/json',
                ...options.headers
            },
            ...options
        };

        const response = await fetch(url, config);
        const data = await response.json();

        if (!response.ok) {
            throw new Error(data.message || 'API request failed');
        }

        return data.data || data;
    } catch (error) {
        console.error('API Error:', error);
        throw error;
    }
}

/**
 * API Methods
 */
const API = {
    // Dashboard
    getDashboardSummary: () => apiCall('/admin/dashboard/summary'),
    getRecentOrders: (limit = 5) => apiCall(`/admin/dashboard/recent-orders?limit=${limit}`),
    getTopProducts: (limit = 5) => apiCall(`/admin/dashboard/top-products?limit=${limit}`),

    // Statistics
    getStatisticsSummary: () => apiCall('/admin/statistics/summary'),
    getRevenueByMonth: () => apiCall('/admin/statistics/revenue-by-month'),
    getOrderStatusDistribution: () => apiCall('/admin/statistics/order-status-distribution'),
    getProfitDetails: () => apiCall('/admin/statistics/profit-details'),

    // Users
    getUsers: () => apiCall('/users'),
    getUser: (id) => apiCall(`/user/${id}`),
    createUser: (userData) => apiCall('/user', {
        method: 'POST',
        body: JSON.stringify(userData)
    }),
    updateUser: (id, userData) => apiCall(`/user/${id}`, {
        method: 'PUT',
        body: JSON.stringify(userData)
    }),
    deleteUser: (id) => apiCall(`/user/${id}`, {
        method: 'DELETE'
    }),

    // Products
    getProducts: () => apiCall('/products'),
    getProduct: async (id) => {
        // Some builds expose /product/{id}, others use /products/{id}
        try { return await apiCall(`/product/${id}`); } catch (_) { return await apiCall(`/products/${id}`); }
    },
    getProductsByCategory: (categoryId) => apiCall(`/products/category/${categoryId}`),
    createProduct: async (productData) => {
        try {
            return await apiCall('/product', { method: 'POST', body: JSON.stringify(productData) });
        } catch (_) {
            return await apiCall('/products', { method: 'POST', body: JSON.stringify(productData) });
        }
    },
    updateProduct: async (id, productData) => {
        try {
            return await apiCall(`/product/${id}`, { method: 'PUT', body: JSON.stringify(productData) });
        } catch (_) {
            return await apiCall(`/products/${id}`, { method: 'PUT', body: JSON.stringify(productData) });
        }
    },
    deleteProduct: async (id) => {
        try {
            return await apiCall(`/product/${id}`, { method: 'DELETE' });
        } catch (_) {
            return await apiCall(`/products/${id}`, { method: 'DELETE' });
        }
    },

    // Categories
    getCategories: () => apiCall('/categories'),
    getCategory: (id) => apiCall(`/category/${id}`),
    createCategory: (categoryData) => apiCall('/category', {
        method: 'POST',
        body: JSON.stringify(categoryData)
    }),
    updateCategory: (id, categoryData) => apiCall(`/category/${id}`, {
        method: 'PUT',
        body: JSON.stringify(categoryData)
    }),
    deleteCategory: (id) => apiCall(`/category/${id}`, {
        method: 'DELETE'
    }),

    // Discounts
    getDiscounts: () => apiCall('/discounts'),
    getDiscount: (id) => apiCall(`/discount/${id}`),
    createDiscount: (discountData) => apiCall('/discount', {
        method: 'POST',
        body: JSON.stringify(discountData)
    }),
    updateDiscount: (id, discountData) => apiCall(`/discount/${id}`, {
        method: 'PUT',
        body: JSON.stringify(discountData)
    }),
    deleteDiscount: (id) => apiCall(`/discount/${id}`, {
        method: 'DELETE'
    }),

    // Orders
    getOrders: (status = null) => {
        const endpoint = status ? `/orders?status=${status}` : '/orders';
        return apiCall(endpoint);
    },
    getOrder: (id) => apiCall(`/orders/${id}`),
    updateOrderStatus: (id, status) => apiCall(`/orders/${id}/status`, {
        method: 'PUT',
        body: JSON.stringify({ status })
    }),
    deleteOrder: (id) => apiCall(`/orders/${id}`, {
        method: 'DELETE'
    })
};
