CREATE DATABASE IF NOT EXISTS ElectroStore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE ElectroStore;


CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE
);

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    parent_id BIGINT NULL,
    status VARCHAR(50),
    created_at DATETIME,
    INDEX (parent_id)
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    discount_percent INT DEFAULT 0,
    short_description VARCHAR(512),
    description TEXT,
    stock_quantity INT DEFAULT 0,
    status VARCHAR(50),
    created_at DATETIME,
    updated_at DATETIME,
    category_id BIGINT,
    INDEX (category_id),
    CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL ON UPDATE CASCADE
);

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
    product_id BIGINT,
    attribute_name VARCHAR(255),
    attribute_value VARCHAR(1024),
    INDEX (product_id),
    CONSTRAINT fk_product_details_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Bật lại kiểm tra khóa ngoại sau khi tạo bảng
SET FOREIGN_KEY_CHECKS=1;
