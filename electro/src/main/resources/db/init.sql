CREATE DATABASE IF NOT EXISTS ElectroStore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE ElectroStore;

SET FOREIGN_KEY_CHECKS=0;

-- ============================================
-- USERS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    role_id INT NOT NULL DEFAULT 1 COMMENT '1=USER, 2=ADMIN',
    status VARCHAR(50) DEFAULT 'ACTIVE' COMMENT 'ACTIVE, INACTIVE, BANNED',
    email_verified BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login DATETIME,
    INDEX idx_user_email (email),
    INDEX idx_user_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- CATEGORIES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS categories (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    parent_id BIGINT NULL,
    status VARCHAR(50),
    created_at DATETIME,
    INDEX (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- BRANDS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS brands (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    logo_url VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- PRODUCTS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS products (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    short_description VARCHAR(512),
    description TEXT,
    status VARCHAR(50),
    created_at DATETIME,
    updated_at DATETIME,
    category_id BIGINT,
    brand_id BIGINT,
    INDEX (category_id),
    INDEX (brand_id),
    CONSTRAINT fk_products_category 
        FOREIGN KEY (category_id) 
        REFERENCES categories(id) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    CONSTRAINT fk_products_brand
        FOREIGN KEY (brand_id)
        REFERENCES brands(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- PRODUCT VARIANTS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS product_variants (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    discount_percent INT DEFAULT 0,
    status VARCHAR(50) NOT NULL,
    created_at DATETIME,
    updated_at DATETIME,
    version BIGINT DEFAULT 0,
    INDEX (product_id),
    CONSTRAINT fk_product_variants_product 
        FOREIGN KEY (product_id) 
        REFERENCES products(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- INVENTORIES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS inventories (
    variant_id BIGINT PRIMARY KEY,
    total_quantity INT NOT NULL DEFAULT 0,
    reserved_quantity INT NOT NULL DEFAULT 0,
    version BIGINT NOT NULL DEFAULT 0,
    CONSTRAINT fk_inventories_product 
        FOREIGN KEY (variant_id) 
        REFERENCES product_variants(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- PRODUCT IMAGES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS product_images (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT,
    image_name VARCHAR(255),
    image_url VARCHAR(255),
    position INT,
    is_primary TINYINT(1) DEFAULT 0,
    INDEX (product_id),
    CONSTRAINT fk_product_images_product 
        FOREIGN KEY (product_id) 
        REFERENCES products(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- PRODUCT OPTIONS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS product_options (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(100) UNIQUE NOT NULL,
    UNIQUE KEY uk_product_options_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- VARIANT OPTIONS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS variant_options (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    variant_id BIGINT NOT NULL,
    option_id BIGINT NOT NULL,
    value VARCHAR(255) NOT NULL,
    extra_price DECIMAL(10,2) DEFAULT 0,
    INDEX (variant_id),
    INDEX (option_id),
    CONSTRAINT fk_variant_options_variant 
        FOREIGN KEY (variant_id) 
        REFERENCES product_variants(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_variant_options_option 
        FOREIGN KEY (option_id) 
        REFERENCES product_options(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- PRODUCT DETAILS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS product_details (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT,
    attribute_name VARCHAR(255),
    attribute_value VARCHAR(1024),
    INDEX (product_id),
    CONSTRAINT fk_product_details_product 
        FOREIGN KEY (product_id) 
        REFERENCES products(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- CART TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS cart (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_cart_user_product (user_id, product_id),
    INDEX idx_cart_user (user_id),
    INDEX idx_cart_product (product_id),
    CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cart_product FOREIGN KEY (product_id) REFERENCES product_variants(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- WISHLIST TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS wishlist (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_wishlist_user_product (user_id, product_id),
    INDEX idx_wishlist_user (user_id),
    INDEX idx_wishlist_product (product_id),
    CONSTRAINT fk_wishlist_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_wishlist_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- ORDERS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS orders (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDING' COMMENT 'PENDING, CONFIRMED, SHIPPED, DELIVERED, CANCELLED',
    shipping_address TEXT NOT NULL,
    shipping_phone VARCHAR(20) NOT NULL,
    shipping_name VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_order_user (user_id),
    INDEX idx_order_status (status),
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- ORDER ITEMS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS order_details (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    subtotal DECIMAL(10,2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_order_details_order (order_id),
    INDEX idx_order_details_product (product_id),
    CONSTRAINT fk_order_details_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_order_details_product FOREIGN KEY (product_id) REFERENCES product_variants(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS=1;
