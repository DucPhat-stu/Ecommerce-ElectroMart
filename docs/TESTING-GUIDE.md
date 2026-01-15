# ElectroMart Testing Guide

## 🚀 Quick Start

### Prerequisites
- Docker & Docker Compose installed
- Postman installed
- Port 80, 3307, 8080 available

### Start the Application

```bash
# From project root directory
docker-compose up --build
```

Wait for all services to start:
- ✅ MySQL database (port 3307)
- ✅ Spring Boot backend (port 8080)
- ✅ Nginx web server (port 80)

### Verify Setup

```bash
# Check running containers
docker ps

# Should see: mysql, backend, nginx-service
```

---

## 📋 Testing Checklist

### 1. Database Verification

```bash
# Connect to MySQL
docker exec -it mysql mysql -uuser -p123123 ElectroStore

# Check tables
SHOW TABLES;

# Verify sample data
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM categories;
```

Expected output:
- 50 products
- 6 users
- 5 categories

### 2. API Health Check

```bash
# Test backend directly
curl http://localhost:8080/api/v1/products

# Test through nginx
curl http://localhost/api/v1/products
```

Both should return product list.

---

## 🧪 API Testing with Postman

### Import Collection

1. Open Postman
2. Click "Import"
3. Select file: `postman/ElectroMart-API-Collection.json`
4. Collection will appear in left sidebar

### Test Scenarios

#### Test Case 1: Product CRUD Operations

**Steps:**
1. **Get All Products**
   - Request: `GET /products`
   - Expected: Status 200, list of 50 products
   
2. **Get Product Details**
   - Request: `GET /products/1`
   - Expected: Status 200, iPhone 14 Pro details
   
3. **Create New Product**
   - Request: `POST /products`
   - Body:
   ```json
   {
     "name": "Test Product",
     "price": 599.00,
     "discountPercent": 10,
     "shortDescription": "Test description",
     "description": "Full test description",
     "stockQuantity": 100,
     "categoryId": 1
   }
   ```
   - Expected: Status 201, product created
   
4. **Update Product**
   - Request: `PUT /products/{newProductId}`
   - Body:
   ```json
   {
     "price": 549.00,
     "stockQuantity": 90
   }
   ```
   - Expected: Status 200, product updated
   
5. **Delete Product**
   - Request: `DELETE /products/{newProductId}`
   - Expected: Status 200, product deleted

**✅ Pass Criteria:**
- All operations return correct status codes
- Data persists across requests
- Error handling works (404 for non-existent products)

#### Test Case 2: Shopping Cart Flow

**Steps:**
1. **View Empty Cart**
   - Request: `GET /cart/5`
   - Expected: Empty cart with totalAmount = 0

2. **Add Product to Cart**
   - Request: `POST /cart`
   - Body:
   ```json
   {
     "userId": 5,
     "productId": 1,
     "quantity": 2
   }
   ```
   - Expected: Status 201, cart item created

3. **Add Another Product**
   - Request: `POST /cart`
   - Body:
   ```json
   {
     "userId": 5,
     "productId": 11,
     "quantity": 1
   }
   ```
   - Expected: Status 201

4. **View Cart**
   - Request: `GET /cart/5`
   - Expected: 2 items, correct totals

5. **Update Quantity**
   - Request: `PUT /cart/{cartId}`
   - Body:
   ```json
   {
     "quantity": 3
   }
   ```
   - Expected: Status 200, quantity updated

6. **Remove Item**
   - Request: `DELETE /cart/{cartId}`
   - Expected: Status 200, item removed

**✅ Pass Criteria:**
- Cart calculations are correct
- Stock validation works
- Duplicate products update quantity
- Cart persists across sessions

#### Test Case 3: Order Creation Flow

**Prerequisites:** Cart must have items

**Steps:**
1. **Add Products to Cart**
   - Add 2-3 products with different quantities

2. **Create Order**
   - Request: `POST /orders`
   - Body:
   ```json
   {
     "userId": 5,
     "shippingName": "Test User",
     "shippingPhone": "0905678901",
     "shippingAddress": "Test Address, Test City",
     "notes": "Test order"
   }
   ```
   - Expected: Status 201, order created with order number

3. **Verify Order Created**
   - Request: `GET /orders/user/5`
   - Expected: New order appears in list

4. **View Order Details**
   - Request: `GET /orders/{orderId}`
   - Expected: Full order with items

5. **Update Order Status**
   - Request: `PUT /orders/{orderId}/status`
   - Body:
   ```json
   {
     "status": "CONFIRMED",
     "adminNotes": "Order confirmed"
   }
   ```
   - Expected: Status 200, status updated

6. **Verify Cart Cleared**
   - Request: `GET /cart/5`
   - Expected: Empty cart

**✅ Pass Criteria:**
- Order number generated correctly
- Amounts calculated correctly
- Stock reduced after order
- Cart cleared after order
- Order items saved with prices at time of order

#### Test Case 4: Order Cancellation

**Steps:**
1. Create an order (as in Test Case 3)
2. Note product stock before cancellation
3. Cancel order:
   - Request: `PUT /orders/{orderId}/status`
   - Body:
   ```json
   {
     "status": "CANCELLED",
     "adminNotes": "Customer requested cancellation"
   }
   ```
4. Verify stock restored:
   - Request: `GET /products/{productId}`
   - Compare stock quantity

**✅ Pass Criteria:**
- Stock restored correctly
- Order status updated
- Timestamps set correctly

#### Test Case 5: Review System

**Prerequisites:** User must have ordered the product

**Steps:**
1. **Create Order First** (user 5, product 1)

2. **Add Review**
   - Request: `POST /reviews`
   - Body:
   ```json
   {
     "productId": 1,
     "userId": 5,
     "rating": 5,
     "comment": "Excellent product! Highly recommended."
   }
   ```
   - Expected: Status 201, review created

3. **Try Duplicate Review**
   - Request: Same as step 2
   - Expected: Status 409, error "already reviewed"

4. **View Product Reviews**
   - Request: `GET /reviews/product/1`
   - Expected: Reviews list with summary

5. **Update Review**
   - Request: `PUT /reviews/{reviewId}`
   - Body:
   ```json
   {
     "rating": 4,
     "comment": "Good product but pricey"
   }
   ```
   - Expected: Status 200, review updated

6. **Delete Review**
   - Request: `DELETE /reviews/{reviewId}`
   - Expected: Status 200, review deleted

**✅ Pass Criteria:**
- Rating validation (1-5)
- One review per user per product
- Average rating calculated correctly
- Rating distribution accurate

#### Test Case 6: Stock Validation

**Steps:**
1. **Check Product Stock**
   - Request: `GET /products/9`
   - Note: Motorola Edge 40 has 60 in stock

2. **Try Adding More Than Stock**
   - Request: `POST /cart`
   - Body:
   ```json
   {
     "userId": 5,
     "productId": 9,
     "quantity": 100
   }
   ```
   - Expected: Status 400, "Insufficient stock"

3. **Add Valid Quantity**
   - Request: `POST /cart`
   - Body:
   ```json
   {
     "userId": 5,
     "productId": 9,
     "quantity": 50
   }
   ```
   - Expected: Status 201

4. **Try Ordering More Than Available**
   - Add another product to exceed stock
   - Try creating order
   - Expected: Status 400, "Insufficient stock"

**✅ Pass Criteria:**
- Stock validation on add to cart
- Stock validation on order creation
- Clear error messages

#### Test Case 7: Error Handling

**Test Invalid Product ID:**
```
GET /products/999
Expected: 404, "Product not found"
```

**Test Invalid Cart ID:**
```
DELETE /cart/999
Expected: 404, "Cart item not found"
```

**Test Invalid Order ID:**
```
GET /orders/999
Expected: 404, "Order not found"
```

**Test Invalid Rating:**
```json
POST /reviews
{
  "productId": 1,
  "userId": 5,
  "rating": 6
}
Expected: 400, "Rating must be between 1 and 5"
```

**✅ Pass Criteria:**
- Appropriate HTTP status codes
- Clear error messages
- Consistent error response format

---

## 📊 Database State Verification

After testing, verify database state:

```sql
-- Check cart items
SELECT * FROM cart WHERE user_id = 5;

-- Check orders
SELECT * FROM orders WHERE user_id = 5;

-- Check order items
SELECT oi.*, o.order_number 
FROM order_items oi 
JOIN orders o ON oi.order_id = o.id 
WHERE o.user_id = 5;

-- Check product stock changes
SELECT id, name, stock_quantity 
FROM products 
WHERE id IN (1, 9, 11);

-- Check reviews
SELECT * FROM reviews WHERE user_id = 5;
```

---

## 🐛 Troubleshooting

### Backend Not Starting

```bash
# Check logs
docker logs backend

# Common issues:
# - Database not ready: Wait 30 seconds and retry
# - Port conflict: Stop other services on port 8080
```

### Database Connection Failed

```bash
# Check MySQL status
docker logs mysql

# Verify credentials in application.properties
# spring.datasource.username=user
# spring.datasource.password=123123
```

### API Returns 404

```bash
# Check nginx routing
docker logs nginx-service

# Verify URL path: /api/v1/... (not /api/...)
```

### Changes Not Reflecting

```bash
# Rebuild containers
docker-compose down
docker-compose up --build

# Clear volumes if needed
docker-compose down -v
```

---

## 📈 Performance Testing

### Load Testing with curl

```bash
# Test concurrent requests
for i in {1..100}; do
  curl -X GET http://localhost/api/v1/products &
done
wait

# Measure response time
time curl http://localhost/api/v1/products
```

### Expected Performance

- Product listing: < 500ms
- Product details: < 300ms
- Add to cart: < 200ms
- Create order: < 1s

---

## ✅ Testing Completion Checklist

- [ ] All product CRUD operations work
- [ ] Cart operations function correctly
- [ ] Order creation successful
- [ ] Order cancellation restores stock
- [ ] Review system works
- [ ] Stock validation prevents overselling
- [ ] Error handling returns proper codes
- [ ] Database state consistent
- [ ] All 50 products accessible
- [ ] Sample data intact

---

## 📝 Test Report Template

```
# Test Report

**Date:** [Date]
**Tester:** [Name]
**Environment:** Docker Compose

## Test Results

| Test Case | Status | Notes |
|-----------|--------|-------|
| Product CRUD | ✅ PASS | All operations working |
| Shopping Cart | ✅ PASS | Calculations correct |
| Order Creation | ✅ PASS | Order number generated |
| Order Cancellation | ✅ PASS | Stock restored |
| Review System | ✅ PASS | Validation working |
| Stock Validation | ✅ PASS | Prevents overselling |
| Error Handling | ✅ PASS | Proper status codes |

## Issues Found

None

## Recommendations

- All APIs functioning as expected
- Ready for integration with frontend
```