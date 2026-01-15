# Database to API Mapping Documentation

## Overview

This document describes the mapping between the MySQL database schema and the REST API response format, ensuring consistency and data integrity across the application.

---

## 1. User Entity Mapping

### 1.1 Database Table: `users`

```sql
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    role_id INT NOT NULL DEFAULT 1,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    email_verified TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login DATETIME NULL
);
```

### 1.2 Java Entity Class

```java
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "username", unique = true, nullable = false)
    private String username;
    
    @Column(name = "email", unique = true, nullable = false)
    private String email;
    
    @Column(name = "password_hash", nullable = false)
    @JsonIgnore  // Never expose in API responses
    private String passwordHash;
    
    @Column(name = "full_name")
    private String fullName;
    
    @Column(name = "phone")
    private String phone;
    
    @Column(name = "address")
    private String address;
    
    @Column(name = "role_id", nullable = false)
    private Integer roleId;  // 1=USER, 2=ADMIN
    
    @Column(name = "status")
    private String status;  // ACTIVE, INACTIVE, BANNED
    
    @Column(name = "email_verified")
    private Boolean emailVerified;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @Column(name = "last_login")
    private LocalDateTime lastLogin;
}
```

### 1.3 API Response Format

```json
{
    "id": 1,
    "username": "john_doe",
    "email": "john@example.com",
    "fullName": "John Doe",
    "phone": "0901234567",
    "address": "123 Main St, City",
    "roleId": 1,
    "status": "ACTIVE",
    "emailVerified": false,
    "createdAt": "2024-01-15T10:30:00",
    "updatedAt": "2024-01-15T10:30:00",
    "lastLogin": "2024-01-15T14:22:00"
}
```

### 1.4 Field Mapping Table

| Database Column | Java Field | API Field | Type | Notes |
|---|---|---|---|---|
| id | id | id | Long | Primary key |
| username | username | username | String | Unique, not exposed in update |
| email | email | email | String | Unique |
| password_hash | passwordHash | (hidden) | String | Never in API response, @JsonIgnore |
| full_name | fullName | fullName | String | Optional |
| phone | phone | phone | String | Optional |
| address | address | address | String | Optional |
| role_id | roleId | roleId | Integer | 1=USER, 2=ADMIN |
| status | status | status | String | ACTIVE, INACTIVE, BANNED |
| email_verified | emailVerified | emailVerified | Boolean | false by default |
| created_at | createdAt | createdAt | LocalDateTime | Auto-set |
| updated_at | updatedAt | updatedAt | LocalDateTime | Auto-updated |
| last_login | lastLogin | lastLogin | LocalDateTime | Null until first login |

---

## 2. Product Entity Mapping

### 2.1 Database Table: `products`

```sql
CREATE TABLE products (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE,
    sku VARCHAR(100) UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    discount_percent INT DEFAULT 0,
    final_price DECIMAL(10,2) GENERATED,
    short_description VARCHAR(512),
    description TEXT,
    stock_quantity INT DEFAULT 0,
    min_stock_level INT DEFAULT 10,
    status VARCHAR(50) DEFAULT 'ACTIVE',
    category_id BIGINT,
    created_by BIGINT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### 2.2 API Response Format

```json
{
    "id": 1,
    "name": "iPhone 14 Pro",
    "slug": "iphone-14-pro",
    "sku": "SKU001",
    "price": 999.00,
    "discountPercent": 10,
    "finalPrice": 899.10,
    "shortDescription": "Latest Apple flagship",
    "description": "Full description...",
    "stockQuantity": 50,
    "status": "ACTIVE",
    "categoryId": 1,
    "createdAt": "2024-01-15T10:30:00",
    "updatedAt": "2024-01-15T10:30:00",
    "productImages": [
        {
            "id": 1,
            "imageUrl": "/img/products/1-1.jpg",
            "isPrimary": true
        }
    ],
    "productDetails": [
        {
            "id": 1,
            "key": "Color",
            "value": "Space Black"
        }
    ]
}
```

### 2.3 Field Mapping Table

| Database Column | Java Field | API Field | Type | Notes |
|---|---|---|---|---|
| id | id | id | Long | Primary key |
| name | name | name | String | Required |
| slug | slug | slug | String | URL-friendly, auto-generated |
| sku | sku | sku | String | Unique identifier |
| price | price | price | BigDecimal | Original price |
| discount_percent | discountPercent | discountPercent | Integer | 0-100 |
| final_price | finalPrice | finalPrice | BigDecimal | Generated (price × (1 - discount/100)) |
| short_description | shortDescription | shortDescription | String | Optional |
| description | description | description | String | Optional |
| stock_quantity | stockQuantity | stockQuantity | Integer | Available units |
| min_stock_level | minStockLevel | minStockLevel | Integer | Low stock warning |
| status | status | status | String | ACTIVE, INACTIVE, OUT_OF_STOCK |
| category_id | categoryId | categoryId | Long | Foreign key |
| created_by | createdBy | createdBy | Long | Admin user ID |
| created_at | createdAt | createdAt | LocalDateTime | Auto-set |
| updated_at | updatedAt | updatedAt | LocalDateTime | Auto-updated |

---

## 3. Cart Entity Mapping

### 3.1 Database Table: `cart`

```sql
CREATE TABLE cart (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT NOT NULL,
    added_at DATETIME,
    updated_at DATETIME,
    UNIQUE KEY (user_id, product_id)
);
```

### 3.2 API Response Format

```json
{
    "userId": 1,
    "items": [
        {
            "id": 1,
            "product": {
                "id": 1,
                "name": "iPhone 14 Pro",
                "price": 999.00,
                "finalPrice": 899.10,
                "imageUrl": "/img/products/1-1.jpg"
            },
            "quantity": 2,
            "subtotal": 1798.20,
            "addedAt": "2024-01-15T10:30:00",
            "updatedAt": "2024-01-15T10:30:00"
        }
    ],
    "totalItems": 2,
    "totalAmount": 1798.20
}
```

### 3.3 Field Mapping Table

| Database Column | Java Field | API Field | Type | Notes |
|---|---|---|---|---|
| id | id | id | Long | Primary key |
| user_id | userId | userId | Long | Foreign key to users |
| product_id | productId | productId | Long | Foreign key to products |
| quantity | quantity | quantity | Integer | Number of units |
| added_at | addedAt | addedAt | LocalDateTime | Auto-set |
| updated_at | updatedAt | updatedAt | LocalDateTime | Auto-updated |

---

## 4. Order Entity Mapping

### 4.1 Database Table: `orders`

```sql
CREATE TABLE orders (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    user_id BIGINT NOT NULL,
    total_amount DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    shipping_fee DECIMAL(10,2),
    final_amount DECIMAL(10,2),
    status VARCHAR(50),
    shipping_address TEXT,
    shipping_phone VARCHAR(20),
    shipping_name VARCHAR(255),
    notes TEXT,
    created_at DATETIME,
    confirmed_at DATETIME,
    shipped_at DATETIME,
    delivered_at DATETIME
);
```

### 4.2 API Response Format

```json
{
    "id": 1,
    "orderNumber": "ORD20240115001",
    "userId": 1,
    "totalAmount": 1998.00,
    "discountAmount": 199.80,
    "shippingFee": 20.00,
    "finalAmount": 1818.20,
    "status": "CONFIRMED",
    "shippingAddress": "123 Đường ABC...",
    "shippingPhone": "0901234567",
    "shippingName": "Nguyễn Văn An",
    "notes": "Giao hàng trong giờ hành chính",
    "createdAt": "2024-01-15T11:00:00",
    "confirmedAt": "2024-01-15T11:05:00",
    "shippedAt": "2024-01-16T08:00:00",
    "deliveredAt": null,
    "orderItems": [
        {
            "id": 1,
            "productName": "iPhone 14 Pro",
            "productPrice": 999.00,
            "quantity": 2,
            "subtotal": 1998.00
        }
    ]
}
```

### 4.3 Field Mapping Table

| Database Column | Java Field | API Field | Type | Notes |
|---|---|---|---|---|
| id | id | id | Long | Primary key |
| order_number | orderNumber | orderNumber | String | Format: ORDYYYYMMDDxxx |
| user_id | userId | userId | Long | Foreign key |
| total_amount | totalAmount | totalAmount | BigDecimal | Before discount & shipping |
| discount_amount | discountAmount | discountAmount | BigDecimal | Total discount |
| shipping_fee | shippingFee | shippingFee | BigDecimal | Delivery cost |
| final_amount | finalAmount | finalAmount | BigDecimal | Total to pay |
| status | status | status | String | PENDING, CONFIRMED, etc. |
| shipping_address | shippingAddress | shippingAddress | String | Delivery address |
| shipping_phone | shippingPhone | shippingPhone | String | Contact phone |
| shipping_name | shippingName | shippingName | String | Recipient name |
| notes | notes | notes | String | Order notes |
| created_at | createdAt | createdAt | LocalDateTime | Auto-set |
| confirmed_at | confirmedAt | confirmedAt | LocalDateTime | When confirmed |
| shipped_at | shippedAt | shippedAt | LocalDateTime | When shipped |
| delivered_at | deliveredAt | deliveredAt | LocalDateTime | When delivered |

---

## 5. Review Entity Mapping

### 5.1 Database Table: `reviews`

```sql
CREATE TABLE reviews (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    product_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at DATETIME,
    updated_at DATETIME
);
```

### 5.2 API Response Format

```json
{
    "data": [
        {
            "id": 1,
            "user": {
                "id": 1,
                "name": "John Doe"
            },
            "rating": 5,
            "comment": "Great product!",
            "createdAt": "2024-01-20T10:00:00",
            "updatedAt": "2024-01-20T10:00:00"
        }
    ],
    "summary": {
        "averageRating": 4.5,
        "totalReviews": 10,
        "ratingDistribution": {
            "5": 6,
            "4": 2,
            "3": 1,
            "2": 1,
            "1": 0
        }
    }
}
```

### 5.3 Field Mapping Table

| Database Column | Java Field | API Field | Type | Notes |
|---|---|---|---|---|
| id | id | id | Long | Primary key |
| product_id | productId | productId | Long | Foreign key |
| user_id | userId | userId | Long | Foreign key |
| rating | rating | rating | Integer | 1-5 stars |
| comment | comment | comment | String | Review text |
| created_at | createdAt | createdAt | LocalDateTime | Auto-set |
| updated_at | updatedAt | updatedAt | LocalDateTime | Auto-updated |

---

## 6. Data Type Conversion

### 6.1 Database to Java/JSON Conversion

| DB Type | Java Type | JSON Type | Format |
|---|---|---|---|
| BIGINT | Long | Number | Long integer |
| INT | Integer | Number | Integer |
| VARCHAR(n) | String | String | Plain text |
| TEXT | String | String | Plain text |
| DECIMAL(10,2) | BigDecimal | Number | With decimals (2 places) |
| DATETIME | LocalDateTime | String | ISO 8601: "2024-01-15T10:30:00" |
| TINYINT(1) | Boolean | Boolean | true/false |
| ENUM | String | String | Enum value |

### 6.2 Naming Conventions

**Database**: snake_case
```
user_id, first_name, created_at
```

**Java**: camelCase
```
userId, firstName, createdAt
```

**JSON API**: camelCase (Jackson annotation)
```json
{
    "userId": 1,
    "firstName": "John",
    "createdAt": "2024-01-15T10:30:00"
}
```

---

## 7. Relationships and Foreign Keys

### 7.1 User to Roles
```
users.role_id → roles.id
Relationship: Many-to-One (Many users can have one role)
```

### 7.2 User to Orders
```
orders.user_id → users.id
Relationship: One-to-Many (One user can have many orders)
```

### 7.3 User to Cart
```
cart.user_id → users.id
Relationship: One-to-Many (One user can have many cart items)
```

### 7.4 User to Reviews
```
reviews.user_id → users.id
Relationship: One-to-Many (One user can write many reviews)
```

### 7.5 Product to Category
```
products.category_id → categories.id
Relationship: Many-to-One (Many products in one category)
```

### 7.6 Product to Cart
```
cart.product_id → products.id
Relationship: One-to-Many (One product in many carts)
```

### 7.7 Product to Orders
```
order_items.product_id → products.id
Relationship: One-to-Many (One product in many orders)
```

### 7.8 Product to Reviews
```
reviews.product_id → products.id
Relationship: One-to-Many (One product can have many reviews)
```

---

## 8. Data Validation Rules

### 8.1 User Fields
- **username**: 3-50 chars, alphanumeric + underscore, unique
- **email**: Valid email format, unique
- **password_hash**: BCrypt hashed, never expose
- **phone**: 10-20 digits, optional
- **roleId**: 1 (USER) or 2 (ADMIN)
- **status**: ACTIVE, INACTIVE, BANNED

### 8.2 Product Fields
- **name**: 1-255 chars, required
- **price**: > 0, 2 decimal places
- **discountPercent**: 0-100
- **stockQuantity**: >= 0
- **categoryId**: Must exist in categories table

### 8.3 Order Fields
- **orderNumber**: Unique, format ORDYYYYMMDDxxx
- **finalAmount**: > 0, automatically calculated
- **status**: PENDING, CONFIRMED, PROCESSING, SHIPPED, DELIVERED

### 8.4 Review Fields
- **rating**: 1-5, required
- **comment**: Max 1000 chars, optional

---

## 9. Indexes for Performance

### 9.1 User Indexes
```sql
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_user_username ON users(username);
CREATE INDEX idx_user_role ON users(role_id);
```

### 9.2 Product Indexes
```sql
CREATE INDEX idx_product_category ON products(category_id);
CREATE INDEX idx_product_status ON products(status);
CREATE INDEX idx_product_sku ON products(sku);
```

### 9.3 Order Indexes
```sql
CREATE INDEX idx_order_user ON orders(user_id);
CREATE INDEX idx_order_status ON orders(status);
CREATE INDEX idx_order_number ON orders(order_number);
```

### 9.4 Cart Indexes
```sql
CREATE UNIQUE INDEX idx_cart_user_product ON cart(user_id, product_id);
```

### 9.5 Review Indexes
```sql
CREATE INDEX idx_review_product ON reviews(product_id);
CREATE INDEX idx_review_user ON reviews(user_id);
CREATE UNIQUE INDEX idx_review_product_user ON reviews(product_id, user_id);
```

---

## 10. Stored Procedures (Optional)

### 10.1 Calculate Product Final Price
```sql
CREATE TRIGGER update_product_final_price
BEFORE INSERT ON products
FOR EACH ROW
SET NEW.final_price = NEW.price * (1 - NEW.discount_percent / 100);
```

### 10.2 Update User Last Login
```sql
CREATE PROCEDURE UpdateLastLogin(IN userId BIGINT)
BEGIN
    UPDATE users SET last_login = NOW() WHERE id = userId;
END;
```

---

## 11. Data Migration Guide

### 11.1 From Old User Table
```sql
-- If migrating from old schema
INSERT INTO users (username, email, password_hash, full_name, created_at)
SELECT username, email, CONCAT('$2a$10$', password_hash), name, NOW()
FROM old_users;
```

---

## 12. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2024-01-15 | Initial mapping documentation |

---

## 13. Notes and Considerations

1. **Timestamps**: All datetime fields are in UTC and returned as ISO 8601 format
2. **Passwords**: Never stored in plain text, always hashed with BCrypt
3. **Foreign Keys**: Enabled with CASCADE ON UPDATE/DELETE for data consistency
4. **Soft Deletes**: Not currently used, hard delete is performed
5. **Auditing**: Consider adding `created_by` and `updated_by` fields for admin actions
6. **Encryption**: Sensitive data (addresses, phone) could be encrypted in production

