/**
 * ==========================================
 * ADMIN DASHBOARD - MAIN FILE
 * Core initialization & routing only
 * All features in separate modules
 * ==========================================
 */

// ==========================================
// 1. DATA & STATE
// ==========================================

let mockData = {
    users: [
        { id: 1, name: 'John Doe', email: 'john@example.com', role: 'admin', createdAt: '2025-01-01' },
        { id: 2, name: 'Jane Smith', email: 'jane@example.com', role: 'user', createdAt: '2025-01-05' }
    ],
    products: [
        { id: 1, name: 'Laptop Dell XPS', category: 'Laptop', price: 25000000, stock: 5, status: 'active' },
        { id: 2, name: 'iPhone 15', category: 'Smartphone', price: 20000000, stock: 8, status: 'active' }
    ],
    categories: [
        { id: 1, name: 'Laptop', description: 'Laptops and Notebooks', productCount: 10 },
        { id: 2, name: 'Smartphone', description: 'Mobile Phones', productCount: 15 }
    ],
    discounts: [
        { id: 1, code: 'SUMMER25', percent: 15, startDate: '2025-01-01', endDate: '2025-12-31', status: 'active' }
    ],
    orders: [
        { id: 1, customer: 'Michael Johnson', total: 35000000, status: 'shipped', createdAt: '2025-01-10' }
    ],
    wishlist: []
};

let appState = {
    currentSection: 'dashboard',
    editingId: null,
    filters: {}
};

// ==========================================
// 2. HASH ROUTING
// ==========================================

const navLinks = document.querySelectorAll('.nav-link');
const contentSections = document.querySelectorAll('.content-section');
const pageTitle = document.getElementById('pageTitle');
const toggleSidebarBtn = document.getElementById('toggleSidebar');
const sidebar = document.querySelector('.sidebar');

function initHashRouting() {
    window.addEventListener('hashchange', handleRouteChange);
    handleRouteChange();
}

function handleRouteChange() {
    let hash = window.location.hash.slice(1) || 'dashboard';
    if (!hash) {
        hash = 'dashboard';
        window.location.hash = '#dashboard';
    }
    showSection(hash);
    updateActiveNavLink(hash);
    updatePageTitle(hash);
}

function showSection(sectionName) {
    contentSections.forEach(section => section.classList.remove('active'));
    const targetSection = document.getElementById(`${sectionName}-section`);
    if (targetSection) {
        targetSection.classList.add('active');
        appState.currentSection = sectionName;
        loadSectionData(sectionName);
    } else {
        window.location.hash = '#dashboard';
    }
}

function updateActiveNavLink(sectionName) {
    navLinks.forEach(link => link.classList.remove('active'));
    const activeLink = document.querySelector(`[data-section="${sectionName}"]`);
    if (activeLink) activeLink.classList.add('active');
    if (window.innerWidth < 768) sidebar.classList.remove('open');
}

function updatePageTitle(sectionName) {
    const titles = {
        'dashboard': 'Dashboard', 'users': 'User Management', 'products': 'Product Management',
        'categories': 'Category Management', 'discounts': 'Discount Management',
        'orders': 'Order Management', 'statistics': 'Sales Statistics',
        'shop': 'View Store', 'wishlist': 'Wishlist'
    };
    pageTitle.textContent = titles[sectionName] || 'Dashboard';
}

function loadSectionData(sectionName) {
    const sectionMap = {
        'users': renderUsersTable, 'products': renderProductsTable,
        'categories': renderCategoriesTable, 'discounts': renderDiscountsTable,
        'orders': renderOrdersTable, 'statistics': renderStatistics,
        'shop': renderShop, 'wishlist': renderWishlist,
        'dashboard': renderDashboard
    };
    const renderFunc = sectionMap[sectionName];
    if (renderFunc) renderFunc();
}

// ==========================================
// 3. NAVIGATION SETUP
// ==========================================

function setupNavigation() {
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const sectionName = this.getAttribute('data-section');
            window.location.hash = `#${sectionName}`;
        });
    });
}

function setupSidebarToggle() {
    if (toggleSidebarBtn) {
        toggleSidebarBtn.addEventListener('click', function(e) {
            e.preventDefault();
            sidebar.classList.toggle('open');
        });
    }
}

// ==========================================
// 4. MODAL EVENT LISTENERS
// ==========================================

document.getElementById('saveUserBtn')?.addEventListener('click', saveUser);
document.getElementById('saveProductBtn')?.addEventListener('click', saveProduct);
document.getElementById('saveCategoryBtn')?.addEventListener('click', saveCategory);
document.getElementById('saveDiscountBtn')?.addEventListener('click', saveDiscount);

document.getElementById('userModal')?.addEventListener('show.bs.modal', function() {
    if (!appState.editingId) document.getElementById('userForm').reset();
});

document.getElementById('productModal')?.addEventListener('show.bs.modal', function() {
    if (!appState.editingId) document.getElementById('productForm').reset();
});

document.getElementById('categoryModal')?.addEventListener('show.bs.modal', function() {
    if (!appState.editingId) document.getElementById('categoryForm').reset();
});

document.getElementById('discountModal')?.addEventListener('show.bs.modal', function() {
    if (!appState.editingId) document.getElementById('discountForm').reset();
});

document.querySelectorAll('.modal').forEach(modal => {
    modal.addEventListener('hidden.bs.modal', function() {
        appState.editingId = null;
    });
});

// ==========================================
// 5. INITIALIZATION
// ==========================================

document.addEventListener('DOMContentLoaded', function() {
    initHashRouting();
    setupNavigation();
    setupSidebarToggle();
    updateWishlistBadge();
    console.log('✓ Admin Dashboard initialized');
    console.log('✓ Modular structure loaded');
});
