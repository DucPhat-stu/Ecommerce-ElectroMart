# Tổng hợp Backend cho Admin Dashboard - ElectroMart

## Tổng quan

Tài liệu này mô tả cách hoạt động của backend API cho Admin Dashboard của hệ thống ElectroMart E-Commerce. Backend được xây dựng bằng Spring Boot và cung cấp các REST API endpoints để quản lý toàn bộ hệ thống.

## Cấu trúc Backend

### 1. Controllers

Backend có các controller chính sau:

#### 1.1. AdminDashboardController
**Path:** `/api/v1/admin`

Controller chuyên dụng cho Admin Dashboard, cung cấp các API endpoints để:
- Lấy thống kê tổng quan (dashboard summary)
- Lấy danh sách đơn hàng gần đây
- Lấy sản phẩm bán chạy nhất
- Lấy thống kê doanh thu, chi phí, lợi nhuận
- Lấy phân tích theo tháng

**Endpoints:**

| Method | Endpoint | Mô tả |
|--------|----------|-------|
| GET | `/api/v1/admin/dashboard/summary` | Lấy tổng quan: tổng users, products, orders, revenue |
| GET | `/api/v1/admin/dashboard/recent-orders?limit=5` | Lấy danh sách đơn hàng gần đây (mặc định 5) |
| GET | `/api/v1/admin/dashboard/top-products?limit=5` | Lấy sản phẩm bán chạy nhất (mặc định 5) |
| GET | `/api/v1/admin/statistics/summary` | Lấy thống kê: revenue, cost, profit, profit rate |
| GET | `/api/v1/admin/statistics/revenue-by-month` | Lấy doanh thu theo tháng (6 tháng gần nhất) |
| GET | `/api/v1/admin/statistics/order-status-distribution` | Lấy phân bố trạng thái đơn hàng |
| GET | `/api/v1/admin/statistics/profit-details` | Lấy chi tiết lợi nhuận theo tháng |

#### 1.2. UserController
**Path:** `/api/v1`

Quản lý người dùng trong hệ thống.

**Endpoints:**

| Method | Endpoint | Mô tả |
|--------|----------|-------|
| GET | `/api/v1/users` | Lấy danh sách tất cả users |
| GET | `/api/v1/user/{userId}` | Lấy thông tin user theo ID |
| POST | `/api/v1/user` | Tạo user mới |
| PUT | `/api/v1/user/{userId}` | Cập nhật thông tin user |
| DELETE | `/api/v1/user/{userId}` | Xóa user |

#### 1.3. ProductController
**Path:** `/api/v1`

Quản lý sản phẩm trong hệ thống.

**Endpoints:**

| Method | Endpoint | Mô tả |
|--------|----------|-------|
| GET | `/api/v1/products` | Lấy danh sách tất cả products |
| GET | `/api/v1/product/{productId}` | Lấy thông tin product theo ID |
| GET | `/api/v1/products/category/{categoryId}` | Lấy products theo category |
| POST | `/api/v1/product` | Tạo product mới |
| PUT | `/api/v1/product/{productId}` | Cập nhật product |
| DELETE | `/api/v1/product/{productId}` | Xóa product |

#### 1.4. CategoryController
**Path:** `/api/v1`

Quản lý danh mục sản phẩm.

**Endpoints:**

| Method | Endpoint | Mô tả |
|--------|----------|-------|
| GET | `/api/v1/categories` | Lấy danh sách tất cả categories |
| GET | `/api/v1/category/{categoryId}` | Lấy thông tin category theo ID |
| POST | `/api/v1/category` | Tạo category mới |
| PUT | `/api/v1/category/{categoryId}` | Cập nhật category |
| DELETE | `/api/v1/category/{categoryId}` | Xóa category |

#### 1.5. DiscountController
**Path:** `/api/v1`

Quản lý mã giảm giá/khuyến mãi.

**Endpoints:**

| Method | Endpoint | Mô tả |
|--------|----------|-------|
| GET | `/api/v1/discounts` | Lấy danh sách tất cả discounts |
| GET | `/api/v1/discount/{discountId}` | Lấy thông tin discount theo ID |
| GET | `/api/v1/discount/code/{code}` | Lấy discount theo mã code |
| POST | `/api/v1/discount` | Tạo discount mới |
| PUT | `/api/v1/discount/{discountId}` | Cập nhật discount |
| DELETE | `/api/v1/discount/{discountId}` | Xóa discount |

#### 1.6. OrderController
**Path:** `/api`

Quản lý đơn hàng.

**Endpoints:**

| Method | Endpoint | Mô tả |
|--------|----------|-------|
| GET | `/api/v1/orders?status={status}` | Lấy danh sách orders (có thể filter theo status) |
| GET | `/api/v1/orders/{id}` | Lấy thông tin order theo ID |
| PUT | `/api/v1/orders/{id}/status` | Cập nhật trạng thái order |
| DELETE | `/api/v1/orders/{id}` | Xóa order |
| POST | `/api/v1/orders` | Tạo order mới |

### 2. Services

#### 2.1. DashboardService

Service xử lý logic cho Admin Dashboard.

**Các method chính:**

1. **getSummary()**: Tính toán tổng quan hệ thống
   - Tổng số users
   - Tổng số products
   - Tổng số orders
   - Tổng revenue

2. **getRecentOrders(int limit)**: Lấy danh sách đơn hàng gần đây
   - Sắp xếp theo thời gian tạo (mới nhất trước)
   - Giới hạn số lượng theo tham số limit

3. **getTopProducts(int limit)**: Lấy sản phẩm bán chạy nhất
   - Tính tổng số lượng đã bán và revenue cho mỗi sản phẩm
   - Sắp xếp theo số lượng bán (cao nhất trước)
   - Giới hạn số lượng theo tham số limit

4. **getStatisticsSummary()**: Tính toán thống kê tổng hợp
   - Total Revenue: Tổng doanh thu từ tất cả orders
   - Total Cost: Chi phí (giả định = 60% của revenue)
   - Total Profit: Lợi nhuận = Revenue - Cost
   - Profit Rate: Tỷ lệ lợi nhuận = (Profit / Revenue) * 100%

5. **getRevenueByMonth()**: Lấy doanh thu theo tháng
   - Tính toán doanh thu cho 6 tháng gần nhất
   - Nhóm orders theo tháng
   - Trả về danh sách {month, revenue}

6. **getOrderStatusDistribution()**: Phân bố trạng thái đơn hàng
   - Đếm số lượng orders theo từng trạng thái
   - Trả về map {status: count}

7. **getProfitDetailsByMonth()**: Chi tiết lợi nhuận theo tháng
   - Tính revenue, cost, profit cho mỗi tháng (6 tháng gần nhất)
   - Tính profit rate cho mỗi tháng
   - Trả về danh sách {month, revenue, cost, profit, rate}

### 3. Models/Entities

#### 3.1. User
- `id`: Long
- `fullName`: String
- `email`: String
- `role`: String (user/admin)
- `createdAt`: LocalDateTime

#### 3.2. Product
- `id`: Long
- `name`: String
- `shortDescription`: String
- `description`: String
- `status`: ProductStatus (ACTIVE/INACTIVE)
- `category`: Category (ManyToOne)
- `productVariants`: Set<ProductVariant>
- `createdAt`: LocalDateTime
- `updatedAt`: LocalDateTime

#### 3.3. Category
- `id`: Long
- `name`: String
- `parentId`: Long
- `status`: CategoryStatus
- `createdAt`: LocalDateTime

#### 3.4. Discount
- `id`: Long
- `code`: String (unique)
- `percent`: Integer
- `startDate`: LocalDate
- `endDate`: LocalDate
- `status`: String (ACTIVE/EXPIRED)
- `createdAt`: LocalDateTime
- `updatedAt`: LocalDateTime

#### 3.5. Order
- `id`: Long
- `user`: User (ManyToOne)
- `totalPrice`: BigDecimal
- `status`: OrderStatus (PENDING/CONFIRMED/SHIPPED/DELIVERED/CANCELLED)
- `shippingAddress`: String
- `shippingPhone`: String
- `shippingName`: String
- `orderDetails`: Set<OrderDetail>
- `createdAt`: LocalDateTime
- `updatedAt`: LocalDateTime

#### 3.6. OrderDetail
- `id`: Long
- `order`: Order (ManyToOne)
- `product`: ProductVariant (ManyToOne)
- `productName`: String
- `productPrice`: BigDecimal
- `quantity`: Integer
- `subtotal`: BigDecimal
- `createdAt`: LocalDateTime

### 4. Response Format

Tất cả API responses đều sử dụng format chuẩn `ApiResponse<T>`:

```json
{
  "success": true,
  "message": "Success message",
  "data": { ... }
}
```

**Ví dụ:**

```json
{
  "success": true,
  "message": "Dashboard summary retrieved successfully",
  "data": {
    "totalUsers": 150,
    "totalProducts": 500,
    "totalOrders": 1200,
    "totalRevenue": 500000000
  }
}
```

### 5. Cách hoạt động

#### 5.1. Dashboard Summary Flow

```
Frontend Request
    ↓
GET /api/v1/admin/dashboard/summary
    ↓
AdminDashboardController.getDashboardSummary()
    ↓
DashboardService.getSummary()
    ↓
- UserRepository.count() → totalUsers
- ProductRepository.count() → totalProducts
- OrderRepository.findAll() → allOrders
- Calculate totalOrders, totalRevenue
    ↓
Return Map<String, Object>
    ↓
ApiResponse wrapper
    ↓
JSON Response to Frontend
```

#### 5.2. Statistics Flow

```
Frontend Request
    ↓
GET /api/v1/admin/statistics/summary
    ↓
AdminDashboardController.getStatisticsSummary()
    ↓
DashboardService.getStatisticsSummary()
    ↓
- OrderRepository.findAll() → allOrders
- Calculate totalRevenue (sum of all order.totalPrice)
- Calculate totalCost (60% of revenue)
- Calculate totalProfit (revenue - cost)
- Calculate profitRate ((profit / revenue) * 100)
    ↓
Return Map<String, Object>
    ↓
ApiResponse wrapper
    ↓
JSON Response to Frontend
```

#### 5.3. Revenue by Month Flow

```
Frontend Request
    ↓
GET /api/v1/admin/statistics/revenue-by-month
    ↓
AdminDashboardController.getRevenueByMonth()
    ↓
DashboardService.getRevenueByMonth()
    ↓
- OrderRepository.findAll() → allOrders
- Group orders by YearMonth (from createdAt)
- Calculate revenue for each month
- Return last 6 months (initialize missing months with 0)
    ↓
Return List<Map<String, Object>>
    ↓
ApiResponse wrapper
    ↓
JSON Response to Frontend
```

#### 5.4. Top Products Flow

```
Frontend Request
    ↓
GET /api/v1/admin/dashboard/top-products?limit=5
    ↓
AdminDashboardController.getTopProducts(limit)
    ↓
DashboardService.getTopProducts(limit)
    ↓
- OrderRepository.findAll() → allOrders
- Iterate through all orders and orderDetails
- Group by productName
- Calculate total sold quantity and revenue per product
- Sort by quantity (descending)
- Limit to top N products
    ↓
Return List<Map<String, Object>>
    ↓
ApiResponse wrapper
    ↓
JSON Response to Frontend
```

### 6. Database Schema

Backend sử dụng MySQL database với các bảng chính:

- `users`: Lưu thông tin người dùng
- `products`: Lưu thông tin sản phẩm
- `categories`: Lưu danh mục sản phẩm
- `product_variants`: Lưu các biến thể của sản phẩm (màu sắc, dung lượng, giá...)
- `discounts`: Lưu mã giảm giá
- `orders`: Lưu đơn hàng
- `order_details`: Lưu chi tiết từng sản phẩm trong đơn hàng

### 7. Tính toán Cost và Profit

Hiện tại, hệ thống sử dụng công thức đơn giản:
- **Cost = 60% của Revenue** (giả định)
- **Profit = Revenue - Cost**
- **Profit Rate = (Profit / Revenue) * 100%**

Đây là công thức mặc định. Trong tương lai có thể mở rộng để tính toán chi phí thực tế từ:
- Giá vốn hàng bán (COGS)
- Chi phí vận chuyển
- Chi phí marketing
- Chi phí quản lý
- v.v.

### 8. Lưu ý quan trọng

1. **Authentication & Authorization**: Hiện tại backend chưa có authentication middleware. Cần thêm JWT authentication và role-based access control (RBAC) để bảo mật các API endpoints của admin.

2. **Error Handling**: Tất cả exceptions được xử lý bởi `GlobalExceptionHandler` và trả về format chuẩn.

3. **Validation**: Sử dụng Jakarta Validation (`@Valid`) cho các request DTOs.

4. **Pagination**: Hiện tại các API list không có pagination. Có thể cần thêm pagination cho các danh sách lớn.

5. **Caching**: Chưa có caching. Có thể thêm caching cho các thống kê để tăng hiệu suất.

### 9. Kết nối Frontend

Frontend Admin Dashboard cần gọi các API endpoints này để:
- Hiển thị dashboard với các thống kê tổng quan
- Quản lý users, products, categories, discounts, orders
- Xem thống kê doanh thu và lợi nhuận
- Xem biểu đồ và báo cáo

**Base URL**: `http://localhost:8080`

**Ví dụ kết nối từ Frontend:**

```javascript
// Dashboard Summary
fetch('http://localhost:8080/api/v1/admin/dashboard/summary')
  .then(res => res.json())
  .then(data => {
    // data.data contains: {totalUsers, totalProducts, totalOrders, totalRevenue}
  });

// Statistics
fetch('http://localhost:8080/api/v1/admin/statistics/summary')
  .then(res => res.json())
  .then(data => {
    // data.data contains: {totalRevenue, totalCost, totalProfit, profitRate}
  });
```

### 10. Tổng kết

Backend cho Admin Dashboard đã được xây dựng với đầy đủ các chức năng:
- ✅ Dashboard summary (users, products, orders, revenue)
- ✅ Recent orders
- ✅ Top products
- ✅ Statistics (revenue, cost, profit, profit rate)
- ✅ Revenue by month
- ✅ Order status distribution
- ✅ Profit details by month
- ✅ CRUD operations cho Users, Products, Categories, Discounts, Orders

Tất cả các endpoints đều trả về format chuẩn `ApiResponse<T>` và sẵn sàng để frontend Admin Dashboard tích hợp.
