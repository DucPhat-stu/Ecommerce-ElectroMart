# ElectroMart API Documentation

## Base URL
```
http://localhost:80/api/v1
```

When using Docker Compose, nginx reverse proxy routes `/api/*` to the backend service.

---

## Response Format

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
        "code": "ERROR_CODE",
        "details": "Detailed error message"
    },
    "timestamp": "2024-01-15T10:30:00"
}
```

---

## 1. Product APIs

### 1.1 Get All Products
```
GET /products
```

**Response:**
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
            "stockQuantity": 35,
            "status": "active",
            "productImages": [...],
            "productDetails": [...]
        }
    ]
}
```

### 1.2 Get Product by ID
```
GET /products/{id}
```

**Response:**
```json
{
    "success": true,
    "message": "Product found",
    "data": {
        "id": 1,
        "name": "iPhone 14 Pro",
        "price": 999.00,
        "discountPercent": 10,
        "description": "...",
        "productImages": [...],
        "productDetails": [...]
    }
}
```

### 1.3 Get Products by Category
```
GET /products/category/{categoryId}
```

### 1.4 Create Product
```
POST /products
```

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

### 1.5 Update Product
```
PUT /products/{id}
```

### 1.6 Delete Product
```
DELETE /products/{id}
```

---

## 2. Cart APIs

### 2.1 Get User Cart
```
GET /cart/{userId}
```

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
                    "finalPrice": 899.10,
                    "imageUrl": "/img/products/1-1.jpg"
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

### 2.2 Add to Cart
```
POST /cart
```

**Request Body:**
```json
{
    "userId": 1,
    "productId": 1,
    "quantity": 2
}
```

### 2.3 Update Cart Item
```
PUT /cart/{cartId}
```

**Request Body:**
```json
{
    "quantity": 3
}
```

### 2.4 Remove from Cart
```
DELETE /cart/{cartId}
```

### 2.5 Clear User Cart
```
DELETE /cart/user/{userId}
```

---

## 3. Order APIs

### 3.1 Create Order
```
POST /orders
```

**Request Body:**
```json
{
    "userId": 1,
    "shippingName": "Nguyễn Văn An",
    "shippingPhone": "0901234567",
    "shippingAddress": "123 Đường ABC, Quận 1, TP.HCM",
    "notes": "Giao hàng trong giờ hành chính"
}
```

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

### 3.2 Get User Orders
```
GET /orders/user/{userId}
```

### 3.3 Get Order Details
```
GET /orders/{orderId}
```

### 3.4 Update Order Status
```
PUT /orders/{orderId}/status
```

**Request Body:**
```json
{
    "status": "CONFIRMED",
    "adminNotes": "Đơn hàng đã được xác nhận"
}
```

**Valid Status Values:**
- PENDING
- CONFIRMED
- PROCESSING
- SHIPPED
- DELIVERED
- CANCELLED
- REFUNDED

---

## 4. Review APIs

### 4.1 Create Review
```
POST /reviews
```

**Request Body:**
```json
{
    "productId": 1,
    "userId": 1,
    "rating": 5,
    "comment": "Sản phẩm rất tốt!"
}
```

### 4.2 Get Product Reviews
```
GET /reviews/product/{productId}
```

**Response:**
```json
{
    "success": true,
    "message": "Reviews retrieved successfully",
    "data": {
        "reviews": [
            {
                "id": 1,
                "productId": 1,
                "userId": 1,
                "rating": 5,
                "comment": "Sản phẩm rất tốt!",
                "createdAt": "2024-01-20T10:00:00"
            }
        ],
        "summary": {
            "averageRating": 4.5,
            "totalReviews": 10,
            "ratingDistribution": {
                "1": 0,
                "2": 1,
                "3": 1,
                "4": 2,
                "5": 6
            }
        }
    }
}
```

### 4.3 Update Review
```
PUT /reviews/{reviewId}
```

### 4.4 Delete Review
```
DELETE /reviews/{reviewId}
```

---

## Error Codes

| Code | Description | HTTP Status |
|------|-------------|-------------|
| PRODUCT_NOT_FOUND | Sản phẩm không tồn tại | 404 |
| INSUFFICIENT_STOCK | Không đủ hàng trong kho | 400 |
| CART_ITEM_NOT_FOUND | Item không có trong giỏ | 404 |
| EMPTY_CART | Giỏ hàng trống | 400 |
| ORDER_NOT_FOUND | Đơn hàng không tồn tại | 404 |
| INVALID_STATUS | Trạng thái không hợp lệ | 400 |
| REVIEW_EXISTS | Đã review sản phẩm này | 409 |
| REVIEW_NOT_FOUND | Review không tồn tại | 404 |
| INVALID_RATING | Rating phải từ 1-5 | 400 |
| INTERNAL_ERROR | Lỗi hệ thống | 500 |

---

## Testing with Postman

### Environment Variables
```
BASE_URL: http://localhost:80/api/v1
USER_ID: 1
```

### Common Test Scenarios

#### Scenario 1: Browse and Add to Cart
1. GET /products → Get all products
2. GET /products/1 → View product details
3. POST /cart → Add product to cart
4. GET /cart/1 → View cart

#### Scenario 2: Complete Purchase Flow
1. POST /cart → Add multiple products
2. GET /cart/1 → Review cart
3. POST /orders → Create order
4. GET /orders/user/1 → View order history
5. GET /orders/1 → View order details

#### Scenario 3: Product Review
1. POST /orders → Place order first
2. POST /reviews → Add review
3. GET /reviews/product/1 → View all reviews

---

## Notes

- All timestamps are in ISO 8601 format
- Prices are in USD with 2 decimal places
- Stock quantities are checked before adding to cart and creating orders
- Cancelled orders automatically restore product stock
- Each user can only review a product once