CREATE DATABASE IF NOT EXISTS ElectroStore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE ElectroStore;

-- Tắt kiểm tra khóa ngoại tạm thời để tạo bảng
SET FOREIGN_KEY_CHECKS=0;

-- ============================================
-- AUTHENTICATION & AUTHORIZATION TABLES
-- ============================================

-- Roles table
CREATE TABLE IF NOT EXISTS roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE COMMENT 'USER, ADMIN',
    description VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_role_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Users table (enhanced with authentication)
CREATE TABLE IF NOT EXISTS users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL COMMENT 'BCrypt hashed password',
    full_name VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    role_id INT NOT NULL DEFAULT 1 COMMENT '1=USER, 2=ADMIN',
    status VARCHAR(20) DEFAULT 'ACTIVE' COMMENT 'ACTIVE, INACTIVE, BANNED',
    email_verified TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login DATETIME NULL,
    INDEX idx_user_email (email),
    INDEX idx_user_username (username),
    INDEX idx_user_role (role_id),
    CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Authentication tokens/sessions table
CREATE TABLE IF NOT EXISTS auth_tokens (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    token VARCHAR(500) NOT NULL UNIQUE,
    token_type VARCHAR(50) DEFAULT 'BEARER' COMMENT 'BEARER, REFRESH',
    expires_at DATETIME NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    revoked TINYINT(1) DEFAULT 0,
    INDEX idx_token (token),
    INDEX idx_user_token (user_id),
    INDEX idx_expires_at (expires_at),
    CONSTRAINT fk_auth_tokens_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- PRODUCT MANAGEMENT TABLES
-- ============================================

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE,
    parent_id BIGINT NULL,
    description TEXT,
    status VARCHAR(50) DEFAULT 'ACTIVE' COMMENT 'ACTIVE, INACTIVE',
    display_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category_parent (parent_id),
    INDEX idx_category_status (status),
    CONSTRAINT fk_categories_parent FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Products table
CREATE TABLE IF NOT EXISTS products (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE,
    sku VARCHAR(100) UNIQUE COMMENT 'Stock Keeping Unit',
    price DECIMAL(10,2) NOT NULL,
    discount_percent INT DEFAULT 0,
    final_price DECIMAL(10,2) GENERATED ALWAYS AS (price * (1 - discount_percent / 100)) STORED,
    short_description VARCHAR(512),
    description TEXT,
    stock_quantity INT DEFAULT 0,
    min_stock_level INT DEFAULT 10 COMMENT 'Cảnh báo khi tồn kho thấp',
    status VARCHAR(50) DEFAULT 'ACTIVE' COMMENT 'ACTIVE, INACTIVE, OUT_OF_STOCK',
    category_id BIGINT,
    created_by BIGINT COMMENT 'Admin user who created this product',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_product_category (category_id),
    INDEX idx_product_status (status),
    INDEX idx_product_sku (sku),
    INDEX idx_product_slug (slug),
    INDEX idx_product_price (price),
    CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_products_created_by FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Product images table
CREATE TABLE IF NOT EXISTS product_images (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT,
    image_url VARCHAR(255),
    position INT,
    is_primary TINYINT(1) DEFAULT 0,
    INDEX (product_id),
    CONSTRAINT fk_product_images_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Product details table
CREATE TABLE IF NOT EXISTS product_details (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT NOT NULL,
    attribute_name VARCHAR(255) NOT NULL,
    attribute_value VARCHAR(1024),
    display_order INT DEFAULT 0,
    INDEX idx_product_details_product (product_id),
    CONSTRAINT fk_product_details_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Inventory tracking table (for detailed inventory management)
CREATE TABLE IF NOT EXISTS inventory (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT NOT NULL,
    quantity_change INT NOT NULL COMMENT 'Số lượng thay đổi (+/-)',
    change_type VARCHAR(50) NOT NULL COMMENT 'PURCHASE, SALE, RETURN, ADJUSTMENT, DAMAGED',
    reference_id BIGINT NULL COMMENT 'ID của đơn hàng hoặc phiếu nhập',
    reference_type VARCHAR(50) NULL COMMENT 'ORDER, PURCHASE_ORDER, ADJUSTMENT',
    notes TEXT,
    created_by BIGINT COMMENT 'User/admin who made the change',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_inventory_product (product_id),
    INDEX idx_inventory_date (created_at),
    CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_inventory_created_by FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- SHOPPING CART TABLES
-- ============================================

-- Shopping cart table
CREATE TABLE IF NOT EXISTS cart (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_cart_user_product (user_id, product_id),
    INDEX idx_cart_user (user_id),
    INDEX idx_cart_product (product_id),
    CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cart_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- ORDER MANAGEMENT TABLES
-- ============================================

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_number VARCHAR(50) UNIQUE NOT NULL COMMENT 'Mã đơn hàng tự động',
    user_id BIGINT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL COMMENT 'Tổng tiền trước giảm giá',
    discount_amount DECIMAL(10,2) DEFAULT 0 COMMENT 'Số tiền giảm giá',
    shipping_fee DECIMAL(10,2) DEFAULT 0,
    final_amount DECIMAL(10,2) NOT NULL COMMENT 'Tổng tiền cuối cùng',
    status VARCHAR(50) DEFAULT 'PENDING' COMMENT 'PENDING, CONFIRMED, PROCESSING, SHIPPED, DELIVERED, CANCELLED, REFUNDED',
    shipping_address TEXT NOT NULL,
    shipping_phone VARCHAR(20) NOT NULL,
    shipping_name VARCHAR(255) NOT NULL,
    notes TEXT COMMENT 'Ghi chú của khách hàng',
    admin_notes TEXT COMMENT 'Ghi chú của admin',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    confirmed_at DATETIME NULL,
    shipped_at DATETIME NULL,
    delivered_at DATETIME NULL,
    cancelled_at DATETIME NULL,
    INDEX idx_order_user (user_id),
    INDEX idx_order_number (order_number),
    INDEX idx_order_status (status),
    INDEX idx_order_date (created_at),
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Order items table
CREATE TABLE IF NOT EXISTS order_items (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    product_name VARCHAR(255) NOT NULL COMMENT 'Lưu tên sản phẩm tại thời điểm đặt hàng',
    product_price DECIMAL(10,2) NOT NULL COMMENT 'Giá tại thời điểm đặt hàng',
    discount_percent INT DEFAULT 0 COMMENT 'Phần trăm giảm giá tại thời điểm đặt hàng',
    quantity INT NOT NULL CHECK (quantity > 0),
    subtotal DECIMAL(10,2) NOT NULL COMMENT 'Tổng tiền của item này',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_order_items_order (order_id),
    INDEX idx_order_items_product (product_id),
    CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- PAYMENT MANAGEMENT TABLES
-- ============================================

-- Payment methods table
CREATE TABLE IF NOT EXISTS payment_methods (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50) UNIQUE NOT NULL COMMENT 'BANK_ACCOUNT, MOMO, COD',
    name VARCHAR(100) NOT NULL COMMENT 'Tài khoản ngân hàng, Thanh toán Momo, Thanh toán khi nhận hàng',
    description TEXT,
    icon_url VARCHAR(255),
    status VARCHAR(20) DEFAULT 'ACTIVE' COMMENT 'ACTIVE, INACTIVE',
    display_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_payment_method_code (code),
    INDEX idx_payment_method_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Payments table
CREATE TABLE IF NOT EXISTS payments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT NOT NULL,
    payment_method_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDING' COMMENT 'PENDING, PROCESSING, COMPLETED, FAILED, REFUNDED',
    transaction_id VARCHAR(255) UNIQUE COMMENT 'Mã giao dịch từ payment gateway',
    payment_data JSON COMMENT 'Dữ liệu bổ sung từ payment gateway (số tài khoản, số điện thoại Momo, etc.)',
    paid_at DATETIME NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_payment_order (order_id),
    INDEX idx_payment_method (payment_method_id),
    INDEX idx_payment_status (status),
    INDEX idx_payment_transaction (transaction_id),
    CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_payments_method FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- INDEXES & CONSTRAINTS SUMMARY
-- ============================================

-- Bật lại kiểm tra khóa ngoại sau khi tạo bảng
SET FOREIGN_KEY_CHECKS=1;
