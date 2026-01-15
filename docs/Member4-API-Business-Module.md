# Member 4 - API Business Module Documentation

## 📋 Tổng quan dự án

Tài liệu này mô tả chi tiết về việc xây dựng API Business Module cho hệ thống ElectroMart - một ứng dụng thương mại điện tử bán thiết bị điện tử.

**Thành viên thực hiện:** Member 4  
**Module:** API - Business Module (Product, Cart, Order)  
**Công nghệ:** Spring Boot + MySQL + Postman

---

## 🎯 Mục tiêu Module

Module này cung cấp các REST API để quản lý nghiệp vụ chính của hệ thống:

1. **Product Management (Quản lý sản phẩm)**
   - CRUD operations cho sản phẩm
   - Tìm kiếm, lọc sản phẩm theo danh mục
   - Quản lý hình ảnh và thông số kỹ thuật

2. **Shopping Cart (Giỏ hàng)**
   - Thêm sản phẩm vào giỏ
   - Cập nhật số lượng
   - Xóa sản phẩm khỏi giỏ
   - Xem giỏ hàng

3. **Order Management (Quản lý đơn hàng)**
   - Tạo đơn hàng từ giỏ hàng
   - Xem danh sách đơn hàng
   - Xem chi tiết đơn hàng
   - Cập nhật trạng thái đơn hàng

4. **Review System (Đánh giá sản phẩm)**
   - Thêm đánh giá
   - Xem đánh giá theo sản phẩm
   - Xóa/sửa đánh giá

---

## 🏗️ Kiến trúc hệ thống

### Layered Architecture

```
┌─────────────────────────────────────────┐
│         Controller Layer                 │
│  (REST API Endpoints - HTTP Handling)    │
├─────────────────────────────────────────┤
│          Service Layer                   │
│    (Business Logic & Validation)         │
├─────────────────────────────────────────┤
│        Repository Layer                  │
│    (Data Access - JPA/Hibernate)         │
├─────────────────────────────────────────┤
│          Database Layer                  │
│         (MySQL Database)                 │
└─────────────────────────────────────────┘
```

### Package Structure

```
com.store.electro/
├── Controllers/
│   ├── ProductController.java
│   ├── CartController.java
│   ├── OrderController.java
│   └── ReviewController.java
├── Services/
│   ├── ProductService.java
│   ├── CartService.java
│   ├── OrderService.java
│   └── ReviewService.java
├── Repositories/
│   ├── ProductRepository.java
│   ├── CartRepository.java
│   ├── OrderRepository.java
│   ├── OrderItemRepository.java
│   └── ReviewRepository.java
├── Models/
│   ├── Entity/
│   │   ├── Product.java
│   │   ├── Cart.java
│   │   ├── Order.java
│   │   ├── OrderItem.java
│   │   └── Review.java
│   ├── DTO/
│   │   ├── ProductDTO.java
│   │   ├── CartDTO.java
│   │   ├── OrderDTO.java
│   │   └── ReviewDTO.java
│   └── Enums/
│       └── OrderStatus.java
└── Utils/
    ├── ApiResponse.java
    └── ResponseUtil.java
```

---

## 📊 Database Schema

### Products Table
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
    status VARCHAR(50),
    category_id BIGINT,
    created_at DATETIME,
    updated_at DATETIME
);
```

### Cart Table
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

### Orders Table
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

### Reviews Table
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

---

## 🔧 Chi tiết từng API

### 1. Product API

#### 1.1 GET /api/v1/products
**Mục đích:** Lấy danh sách tất cả sản phẩm

**Response Format:**
```json
{
    "success": true,
    "message": "Products retrieved successfully",
    "data": [
        {
            "id": 1,
            "name": "iPhone 14 Pro",
            "price": 999.00,
            "discountPercent": 10,
            "finalPrice": 899.10,
            "stockQuantity": 35,
            "status": "active",
            "category": {
                "id": 1,
                "name": "Smartphones"
            },
            "productImages": [...],
            "productDetails": [...]
        }
    ],
    "timestamp": "2024-01-15T10:30:00"
}
```

#### 1.2 GET /api/v1/products/{id}
**Mục đích:** Lấy chi tiết một sản phẩm

**Response:**
```json
{
    "success": true,
    "message": "Product found",
    "data": {
        "id": 1,
        "name": "iPhone 14 Pro",
        "description": "The iPhone 14 Pro delivers...",
        "price": 999.00,
        "productImages": [
            {
                "id": 1,
                "imageUrl": "/img/products/1-1.jpg",
                "isPrimary": true
            }
        ]
    }
}
```

#### 1.3 POST /api/v1/products
**Mục đích:** Tạo sản phẩm mới (Admin only)

**Request Body:**
```json
{
    "name": "Samsung Galaxy S24",
    "price": 899.00,
    "discountPercent": 5,
    "shortDescription": "Latest Samsung flagship",
    "description": "Full description...",
    "stockQuantity": 50,
    "categoryId": 1
}
```

#### 1.4 PUT /api/v1/products/{id}
**Mục đích:** Cập nhật sản phẩm

#### 1.5 DELETE /api/v1/products/{id}
**Mục đích:** Xóa sản phẩm

#### 1.6 GET /api/v1/products/category/{categoryId}
**Mục đích:** Lấy sản phẩm theo danh mục

---

### 2. Cart API

#### 2.1 GET /api/v1/cart/{userId}
**Mục đích:** Lấy giỏ hàng của user

**Response:**
```json
{
    "success": true,
    "message": "Cart retrieved successfully",
    "data": {
        "userId": 1,
        "items": [
            {
                "id": 1,
                "product": {
                    "id": 1,
                    "name": "iPhone 14 Pro",
                    "price": 999.00,
                    "finalPrice": 899.10
                },
                "quantity": 2,
                "subtotal": 1798.20
            }
        ],
        "totalItems": 2,
        "totalAmount": 1798.20
    }
}
```

#### 2.2 POST /api/v1/cart
**Mục đích:** Thêm sản phẩm vào giỏ

**Request Body:**
```json
{
    "userId": 1,
    "productId": 1,
    "quantity": 2
}
```

**Logic:**
- Kiểm tra sản phẩm có tồn tại không
- Kiểm tra số lượng tồn kho
- Nếu sản phẩm đã có trong giỏ → cập nhật số lượng
- Nếu chưa có → tạo mới cart item

#### 2.3 PUT /api/v1/cart/{cartId}
**Mục đích:** Cập nhật số lượng sản phẩm trong giỏ

**Request Body:**
```json
{
    "quantity": 3
}
```

#### 2.4 DELETE /api/v1/cart/{cartId}
**Mục đích:** Xóa sản phẩm khỏi giỏ

#### 2.5 DELETE /api/v1/cart/user/{userId}
**Mục đích:** Xóa toàn bộ giỏ hàng (sau khi đặt hàng)

---

### 3. Order API

#### 3.1 POST /api/v1/orders
**Mục đích:** Tạo đơn hàng từ giỏ hàng

**Request Body:**
```json
{
    "userId": 1,
    "shippingName": "Nguyễn Văn An",
    "shippingPhone": "0901234567",
    "shippingAddress": "123 Đường ABC, Quận 1, TP.HCM",
    "notes": "Giao hàng trong giờ hành chính",
    "paymentMethodId": 2
}
```

**Business Logic:**
1. Lấy tất cả items trong cart của user
2. Validate stock quantity cho từng product
3. Tính toán:
   - Total amount (tổng tiền gốc)
   - Discount amount (tổng giảm giá)
   - Shipping fee (phí ship - có thể cố định hoặc theo logic)
   - Final amount = Total - Discount + Shipping
4. Tạo order number (format: ORDYYYYMMDDxxx)
5. Tạo order record
6. Tạo order_items từ cart items
7. Xóa cart items
8. Tạo payment record với status PENDING
9. Cập nhật inventory (giảm stock)
10. Trả về order details

**Response:**
```json
{
    "success": true,
    "message": "Order created successfully",
    "data": {
        "id": 1,
        "orderNumber": "ORD20240115001",
        "userId": 1,
        "totalAmount": 1998.00,
        "discountAmount": 199.80,
        "shippingFee": 20.00,
        "finalAmount": 1818.20,
        "status": "PENDING",
        "orderItems": [...]
    }
}
```

#### 3.2 GET /api/v1/orders/user/{userId}
**Mục đích:** Lấy danh sách đơn hàng của user

**Response:**
```json
{
    "success": true,
    "message": "Orders retrieved successfully",
    "data": [
        {
            "id": 1,
            "orderNumber": "ORD20240115001",
            "finalAmount": 1818.20,
            "status": "CONFIRMED",
            "createdAt": "2024-01-15T11:00:00"
        }
    ]
}
```

#### 3.3 GET /api/v1/orders/{orderId}
**Mục đích:** Lấy chi tiết đơn hàng

**Response:**
```json
{
    "success": true,
    "message": "Order found",
    "data": {
        "id": 1,
        "orderNumber": "ORD20240115001",
        "status": "CONFIRMED",
        "shippingAddress": "123 Đường ABC...",
        "orderItems": [
            {
                "id": 1,
                "productName": "iPhone 14 Pro",
                "productPrice": 999.00,
                "quantity": 2,
                "subtotal": 1798.20
            }
        ],
        "payment": {
            "paymentMethod": "Momo",
            "amount": 1818.20,
            "status": "COMPLETED"
        }
    }
}
```

#### 3.4 PUT /api/v1/orders/{orderId}/status
**Mục đích:** Cập nhật trạng thái đơn hàng (Admin)

**Request Body:**
```json
{
    "status": "SHIPPED",
    "adminNotes": "Đơn hàng đã được giao cho đơn vị vận chuyển"
}
```

**Status Flow:**
```
PENDING → CONFIRMED → PROCESSING → SHIPPED → DELIVERED
                ↓
            CANCELLED
```

---

### 4. Review API

#### 4.1 POST /api/v1/reviews
**Mục đích:** Tạo đánh giá cho sản phẩm

**Request Body:**
```json
{
    "productId": 1,
    "userId": 1,
    "rating": 5,
    "comment": "Sản phẩm rất tốt, giao hàng nhanh!"
}
```

**Validation:**
- User phải mua sản phẩm này trước (check order history)
- Rating từ 1-5
- Mỗi user chỉ review 1 lần cho 1 sản phẩm

#### 4.2 GET /api/v1/reviews/product/{productId}
**Mục đích:** Lấy tất cả reviews của sản phẩm

**Response:**
```json
{
    "success": true,
    "data": [
        {
            "id": 1,
            "user": {
                "id": 1,
                "name": "Nguyễn Văn An"
            },
            "rating": 5,
            "comment": "Sản phẩm rất tốt...",
            "createdAt": "2024-01-20T10:00:00"
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

#### 4.3 PUT /api/v1/reviews/{reviewId}
**Mục đích:** Cập nhật review

#### 4.4 DELETE /api/v1/reviews/{reviewId}
**Mục đích:** Xóa review

---

## 🎨 Response Format Chuẩn

### Success Response
```json
{
    "success": true,
    "message": "Operation successful",
    "data": { ... },
    "timestamp": "2024-01-15T10:30:00"
}
```

### Error Response
```json
{
    "success": false,
    "message": "Error description",
    "error": {
        "code": "PRODUCT_NOT_FOUND",
        "details": "Product with id 999 does not exist"
    },
    "timestamp": "2024-01-15T10:30:00"
}
```

### Validation Error Response
```json
{
    "success": false,
    "message": "Validation failed",
    "errors": [
        {
            "field": "price",
            "message": "Price must be greater than 0"
        },
        {
            "field": "name",
            "message": "Product name is required"
        }
    ],
    "timestamp": "2024-01-15T10:30:00"
}
```

---

## 🔐 Error Codes

| Code | Description | HTTP Status |
|------|-------------|-------------|
| PRODUCT_NOT_FOUND | Sản phẩm không tồn tại | 404 |
| INSUFFICIENT_STOCK | Không đủ hàng trong kho | 400 |
| CART_ITEM_NOT_FOUND | Item không có trong giỏ | 404 |
| ORDER_NOT_FOUND | Đơn hàng không tồn tại | 404 |
| INVALID_ORDER_STATUS | Trạng thái đơn hàng không hợp lệ | 400 |
| REVIEW_ALREADY_EXISTS | Đã review sản phẩm này | 409 |
| UNAUTHORIZED | Không có quyền truy cập | 401 |

---

## 🚀 Cách chạy và kiểm thử

### 1. Setup Database

```bash
# Start MySQL with Docker Compose
docker-compose up -d db

# Verify database is running
docker ps
```

### 2. Run Application

```bash
# Build application
cd electro
./mvnw clean package

# Run application
./mvnw spring-boot:run

# Or with Docker Compose (full stack)
docker-compose up --build
```

### 3. Test với Postman

#### Import Collection
1. Mở Postman
2. Import file: `postman/ElectroMart-APIs.postman_collection.json`
3. Import environment: `postman/ElectroMart-Environment.postman_environment.json`

#### Test Flow

**Test Case 1: Product CRUD**
```
1. GET /api/v1/products → Lấy danh sách
2. GET /api/v1/products/1 → Lấy chi tiết
3. POST /api/v1/products → Tạo mới (Admin)
4. PUT /api/v1/products/1 → Cập nhật
5. DELETE /api/v1/products/1 → Xóa
```

**Test Case 2: Shopping Flow**
```
1. GET /api/v1/products/category/1 → Browse products
2. POST /api/v1/cart → Add to cart (productId=1, quantity=2)
3. POST /api/v1/cart → Add to cart (productId=11, quantity=1)
4. GET /api/v1/cart/1 → View cart
5. PUT /api/v1/cart/1 → Update quantity
6. POST /api/v1/orders → Checkout
7. GET /api/v1/orders/user/1 → View orders
8. GET /api/v1/orders/1 → View order details
```

**Test Case 3: Review Flow**
```
1. POST /api/v1/orders → Place order first
2. POST /api/v1/reviews → Add review
3. GET /api/v1/reviews/product/1 → View reviews
```

### 4. Verify API Consistency

**Checklist:**
- [ ] All responses follow standard format
- [ ] Proper HTTP status codes
- [ ] Error messages are clear and helpful
- [ ] Timestamps in ISO 8601 format
- [ ] Pagination for list endpoints (if needed)
- [ ] Field naming consistency (camelCase)

---

## 📝 Testing Checklist

### Product API
- [ ] List all products
- [ ] Get product by ID
- [ ] Get products by category
- [ ] Create new product
- [ ] Update product
- [ ] Delete product
- [ ] Handle product not found
- [ ] Validate required fields

### Cart API
- [ ] Add product to cart
- [ ] Add same product increases quantity
- [ ] Update cart item quantity
- [ ] Remove from cart
- [ ] Get user cart
- [ ] Handle insufficient stock
- [ ] Clear cart after order

### Order API
- [ ] Create order from cart
- [ ] Generate unique order number
- [ ] Calculate amounts correctly
- [ ] Create order items
- [ ] Update inventory
- [ ] Get user orders
- [ ] Get order details
- [ ] Update order status
- [ ] Handle insufficient stock during checkout

### Review API
- [ ] Add review
- [ ] Prevent duplicate reviews
- [ ] Update review
- [ ] Delete review
- [ ] Get product reviews
- [ ] Calculate average rating

---

## 📚 API Documentation

Chi tiết đầy đủ về API có trong file: `docs/API-Documentation.md`

Postman Collection: `postman/ElectroMart-APIs.postman_collection.json`

---

## 🔍 Monitoring & Logging

### Enable SQL Logging
```properties
# application.properties
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
logging.level.org.hibernate.type.descriptor.sql.BasicBinder=TRACE
```

### Check Application Logs
```bash
# View backend logs
docker logs -f backend

# View database logs  
docker logs -f mysql
```

---

## 🎯 Next Steps

1. **Authentication & Authorization**
   - Implement JWT authentication
   - Role-based access control (USER, ADMIN)
   - Secure endpoints

2. **Advanced Features**
   - Product search with filters
   - Pagination for large datasets
   - Product recommendations
   - Order tracking
   - Email notifications

3. **Performance Optimization**
   - Query optimization
   - Caching (Redis)
   - Database indexing
   - API rate limiting

4. **Testing**
   - Unit tests (JUnit)
   - Integration tests
   - API tests (Postman automation)

---

## 📞 Support

Nếu có vấn đề khi implement hoặc test API, vui lòng:
1. Check application logs
2. Verify database connection
3. Review API documentation
4. Test with Postman examples

**Happy Coding! 🚀**