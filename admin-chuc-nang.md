## Tổng quan

Tài liệu này mô tả **mapping giữa API backend** (thư mục `api_structure`) và **các tính năng UI** của `fe_admin_dashboard`, đồng thời giải thích **luồng dữ liệu từ Admin → FE (user)** sao cho:

- **Admin tự thêm/sửa dữ liệu** qua dashboard (không auto-generate).
- **Dữ liệu mới được rót ra FE** (trang `fe/index.html`) và **hiển thị đúng category**, ưu tiên xuất hiện ở các block sản phẩm mới/đầu trang.

---

## 1. ProductCreateAndUpdate.json ↔ Product Management & View Store

**API mẫu**: `ProductCreateAndUpdate.json`

```json
{
  "name": "",
  "shortDescription": "",
  "description": "",
  "status": "",
  "categoryId": null,
  "brandId": null,
  "productImages": [
    { "imageUrl": "", "primary": false }
  ],
  "productDetails": [
    { "attributeName": "", "attributeValue": "" }
  ],
  "productVariants": [
    {
      "basePrice": null,
      "discountPercent": null,
      "status": "",
      "options": [
        { "optionId": null, "value": "", "extraPrice": null }
      ]
    }
  ]
}
```

### 1.1. Mapping UI Admin

- **Màn hình**: `Product Management` trong `fe_admin_dashboard/index.html`
- **Module JS**: `js_admin_dashboard/modules/products.js`
- **Service gọi API**: `js_admin_dashboard/services/api.js`

**Trường API ↔ Form UI**

- `name` ↔ input `#productName`
- `shortDescription` ↔ input `#productShortDescription`
- `description` ↔ textarea `#productDescription`
- `status` (BACKEND enum `ACTIVE`/`INACTIVE`) ↔ select `#productStatus` (UI: `active`/`inactive`)  
  - Mapping đã được xử lý qua:
    - `__normalizeStatusToUi(status)` (backend → UI)
    - `__statusUiToBackend(uiStatus)` (UI → backend)
- `categoryId` ↔ select `#productCategory`  
  - Dữ liệu category được load bằng `API.getCategories()` trong `__loadProductsData()`.
- Giá/stock:
  - UI đang dùng payload đơn giản:
    - `price` ↔ input `#productPrice`
    - `discountPercent` ↔ input `#productDiscountPercent`
    - `stockQuantity` ↔ input `#productStock`
  - Khi backend dùng `productVariants`, FE admin có 2 hướng:
    - **Cách 1 (đơn giản, hiện tại)**: backend map `price/finalPrice/discountPercent/stockQuantity` ra level product (DTO tính sẵn từ variants).
    - **Cách 2 (nâng cấp)**: thêm UI quản lý `productVariants` chi tiết (không có trong UI hiện tại).
- `productImages`:
  - UI dùng **template ảnh** từ thư mục `fe/img` thay vì upload:
    - Select `#productImageKey` chứa `product01.png` → `product09.png`
    - `saveProduct()` build:
      - `productImages: [{ imageUrl: 'product0x.png', primary: true }]`
  - Backend nên:
    - Chấp nhận `imageUrl` là đường dẫn/tên file template.
    - Khi trả dữ liệu ra FE (admin & user), dùng lại trường này.

**Endpoint sử dụng trong admin**

- Tạo sản phẩm:
  - `API.createProduct(payload)` trong `products.js`
  - `api.js`:
    - Thử `POST /api/v1/product`, nếu lỗi thì fallback `POST /api/v1/products`.
- Cập nhật sản phẩm:
  - `API.updateProduct(id, payload)` → `PUT /api/v1/product/{id}` hoặc `/api/v1/products/{id}`.
- Lấy danh sách sản phẩm:
  - `API.getProducts()` → `GET /api/v1/products`
- Lấy chi tiết sản phẩm:
  - `API.getProduct(id)` → `GET /api/v1/product/{id}` hoặc `/api/v1/products/{id}`.

### 1.2. Rót dữ liệu sang FE (User)

**FE user**: `repo-clone/fe`

- API client: `fe/js/api.js`
  - `ProductAPI.getAll()` → `GET /api/v1/products`
  - `ProductAPI.getById(id)` → `GET /api/v1/product/{id}` (fallback `/products/{id}`)
- Khi admin tạo/cập nhật sản phẩm:
  1. Admin gửi payload chuẩn `ProductCreateAndUpdate.json` (dạng đơn giản hóa qua `saveProduct()`).
  2. Backend lưu vào DB, build DTO trả ra trong `/products` với các field tối thiểu:
     - `id`
     - `name`
     - `finalPrice` hoặc `price`
     - `discountPercent`
     - `category`:
       - `categoryName` **hoặc** `category.name`
     - `productImages` (ít nhất 1 ảnh `primary=true` với `imageUrl` từ template).
  3. FE user (`app.js` – không trích ở đây) dùng `ProductAPI.getAll()` và render các block:
     - New products
     - Top selling
     - Sản phẩm theo category

**Đảm bảo sản phẩm mới nằm ở đầu trang và đúng category**

- Backend nên:
  - Trả danh sách `/products` đã **sort theo `createdAt` desc** hoặc có field `createdAt` để FE sort.
  - Gán `categoryId`/`categoryName` tương ứng với category mà admin chọn trong `#productCategory`.
- FE:
  - Ở admin-dashboard (`shop.js`), mỗi `product-card` gắn:
    - `data-category = product.categoryName || product.category.name || product.category`
  - Ở FE user, nên áp dụng quy ước tương tự:
    - Lấy đúng `categoryName` từ backend, KHÔNG hardcode text như "Laptops", "Smartphones" trong HTML.

---

## 2. Category APIs ↔ Category Management & Filter

**API thực tế dùng trong admin** (không có JSON trong `api_structure`, nhưng hiện diện trong `api.js`):

- `GET /api/v1/categories`
- `GET /api/v1/category/{id}`
- `POST /api/v1/category`
- `PUT /api/v1/category/{id}`
- `DELETE /api/v1/category/{id}`

### 2.1. Mapping UI Admin

- **Màn hình**: `Category Management`
- **UI**: section `#categories-section` trong `fe_admin_dashboard/index.html`
- **Module hiện tại**: `js_admin_dashboard/modules/categories.js`

Hiện tại module `categories.js` đang **dùng `mockData.categories`**, chưa gọi API. Để khớp với backend:

- Thay `mockData.categories` bằng dữ liệu lấy từ:
  - `API.getCategories()` trong `api.js`.
- CRUD category:
  - Tạo mới: `API.createCategory({ name, description, ... })`
  - Cập nhật: `API.updateCategory(id, { name, description, ... })`
  - Xoá: `API.deleteCategory(id)`

**Trường tối thiểu cần đồng bộ**

- `id`
- `name`
- `description`
- (tuỳ chọn) `productCount` – backend có thể trả thêm cho UI hiển thị.

### 2.2. Ảnh hưởng tới FE user

- FE user (`fe/js/api.js`):
  - `CategoryAPI.getAll()` → `GET /api/v1/categories`
  - `CategoryAPI.getById(id)` → `GET /api/v1/category/{id}`

Flow:

1. Admin tạo/sửa category bằng API `/category`.
2. Backend lưu DB, trả về category mới.
3. FE user dùng `CategoryAPI.getAll()` để hiển thị:
   - Menu categories (navigation, filter).
   - Các block "New Products", "Top selling" có thể lọc theo category thực.

Yêu cầu để **sản phẩm và category khớp**:

- Backend trả sản phẩm trong `/products` với:
  - `categoryId` và/hoặc `category.name` trùng với entity category.
- FE (user & admin) dùng cùng một nguồn category API thay vì text cứng.

---

## 3. createOrderAPI.json ↔ OrderAPI.create & FE Checkout

**API mẫu**: `createOrderAPI.json`

```json
{
  "userId": null,
  "shippingName": "",
  "shippingPhone": "",
  "shippingAddress": "",
  "notes": ""
}
```

### 3.1. Mapping ở FE user (khách hàng đặt hàng)

- **File**: `fe/js/api.js`
- **Module**: `OrderAPI.create(orderData)`
  - Endpoint: `POST /api/v1/orders`
  - Hàm tự đảm bảo:
    - Nếu `payload.userId == null` → set `getCurrentUserId()` (demo, sau này thay bằng JWT).

**Trường API ↔ Form checkout (FE – không trong admin)**

- Khi user đặt hàng, form checkout cần map:
  - `shippingName` ↔ tên người nhận.
  - `shippingPhone` ↔ số điện thoại.
  - `shippingAddress` ↔ địa chỉ giao hàng.
  - `notes` ↔ ghi chú đơn hàng.
- `userId`:
  - Lấy từ JWT hoặc localStorage (`getCurrentUserId()` trong demo).

Giỏ hàng/chi tiết sản phẩm sẽ được backend build `orderDetails` dựa trên:

- Cart hiện tại của user (`CartAPI` & `getCartAPI.json` – xem phần dưới).

### 3.2. Mapping ở Admin (quản lý đơn)

- **Admin UI**: `Order Management` trong `fe_admin_dashboard/index.html`
- **Module hiện tại**: `js_admin_dashboard/modules/orders.js`
- Hiện tại dùng `mockData.orders`, cần nâng cấp để dùng API:
  - Danh sách đơn:
    - Dùng `API.getOrders(status)` trong `js_admin_dashboard/services/api.js`
      - `GET /api/v1/orders?status=...`
  - Xem chi tiết 1 đơn:
    - `API.getOrder(id)` → `GET /api/v1/orders/{id}`
  - Cập nhật trạng thái:
    - `API.updateOrderStatus(id, status)` → `PUT /api/v1/orders/{id}/status`
  - Xoá đơn:
    - `API.deleteOrder(id)` → `DELETE /api/v1/orders/{id}`

---

## 4. getOrderAPI.json ↔ Order Detail DTO cho Admin/FE

**API mẫu**: `getOrderAPI.json`

```json
{
  "id": null,
  "userId": null,
  "totalPrice": null,
  "status": "",
  "shippingAddress": "",
  "shippingPhone": "",
  "shippingName": "",
  "orderDetails": [
    {
      "id": null,
      "productId": null,
      "productName": "",
      "productPrice": null,
      "discountPercent": null,
      "quantity": null,
      "subtotal": null,
      "options": [
        {
          "optionName": "",
          "optionValue": "",
          "extraPrice": null
        }
      ],
      "createdAt": ""
    }
  ],
  "createdAt": "",
  "updatedAt": ""
}
```

### 4.1. Sử dụng ở Admin

Khi admin xem/chỉnh một đơn hàng, UI nên hiển thị:

- Thông tin chung:
  - `id`, `userId`, `status`, `shippingName`, `shippingPhone`, `shippingAddress`, `createdAt`, `updatedAt`, `totalPrice`.
- Bảng chi tiết:
  - `productName`, `quantity`, `productPrice`, `discountPercent`, `subtotal`, options.

Đề xuất:

- Nâng cấp `modules/orders.js`:
  - `renderOrdersTable()` dùng:
    - `API.getOrders()` để hiển thị hàng gọn (id, customer, total, status, createdAt).
  - `editOrder(orderId)`:
    - Gọi `API.getOrder(orderId)` để mở modal chi tiết, dùng schema `getOrderAPI.json`.

### 4.2. Sử dụng ở FE user

- `OrderAPI.getById(id)` trong `fe/js/api.js` đã tồn tại:
  - `GET /api/v1/orders/{id}`
- FE có thể dùng DTO `getOrderAPI.json` để:
  - Trang `orders.html` / `track-order.html` hiển thị chi tiết đơn.

---

## 5. getCartAPI.json ↔ CartAPI & Luồng tạo đơn

**API mẫu**: `getCartAPI.json`

```json
{
  "success": true,
  "message": "",
  "data": {
    "userId": null,
    "items": [
      {
        "id": null,
        "product": {
          "discountPercent": null,
          "finalPrice": null,
          "id": null,
          "imageUrl": "",
          "name": "",
          "options": [
            {
              "optionCode": "",
              "value": "",
              "extraPrice": null
            }
          ],
          "price": null
        },
        "quantity": null,
        "subtotal": null
      }
    ],
    "totalItems": null,
    "totalAmount": null
  },
  "timestamp": ""
}
```

### 5.1. Mapping ở FE user

- **Module**: `CartAPI` trong `fe/js/api.js`
  - `getUserCart(userId)` → `GET /api/v1/cart/{userId}`
  - `addToCart(userId, productId, quantity)` → `POST /api/v1/cart`
  - `updateQuantity(cartId, quantity)` → `PUT /api/v1/cart/{cartId}`
  - `removeFromCart(cartId)` → `DELETE /api/v1/cart/{cartId}`
  - `clearCart(userId)` → `DELETE /api/v1/cart/user/{userId}`

**Yêu cầu DTO cho `/cart/{userId}`**

- Response cần khớp với `getCartAPI.json`:
  - Bọc trong object có `success`, `message`, `data`.
  - `data` chứa:
    - `items[]` với:
      - `product.id`, `product.name`, `product.imageUrl`, `product.price`, `product.finalPrice`, `discountPercent`.
      - `options[]` (tuỳ chọn).
    - `totalItems`, `totalAmount`.

### 5.2. Luồng tạo đơn từ Cart

1. FE user gọi `CartAPI.getUserCart(userId)` và hiển thị giỏ.
2. Người dùng nhấn "Checkout" → FE gửi `OrderAPI.create(payload)` theo `createOrderAPI.json`.
3. Backend:
   - Đọc cart hiện tại của user.
   - Build order theo `getOrderAPI.json`.
   - Trả lại entity order hoặc ApiResponse.
4. FE có thể clear cart bằng `CartAPI.clearCart(userId)` sau khi đặt thành công.

Admin sau đó xem đơn trong `Order Management` (mục 3 & 4 ở trên).

---

## 6. Các module admin khác & API liên quan

### 6.1. Dashboard

- **Module**: `js_admin_dashboard/modules/dashboard.js`
- **API**:
  - `API.getDashboardSummary()` → `GET /admin/dashboard/summary`
    - Trả về: `totalUsers`, `totalProducts`, `totalOrders`, `totalRevenue`.
  - `API.getRecentOrders(limit)` → `GET /admin/dashboard/recent-orders?limit=5`
    - DTO nên tương thích với `getOrderAPI.json` (tối thiểu: `id`, `customer`, `total`, `status`).
  - `API.getTopProducts(limit)` → `GET /admin/dashboard/top-products?limit=5`
    - Thiết kế DTO:
      - `productName`, `sold`, `revenue`.

### 6.2. Statistics

- **Module**: `js_admin_dashboard/modules/statistics.js`
- Hiện tại dùng dữ liệu random từ `mockData`.
- Trong `api.js` đã có:
  - `getStatisticsSummary()` → `/admin/statistics/summary`
  - `getRevenueByMonth()` → `/admin/statistics/revenue-by-month`
  - `getOrderStatusDistribution()` → `/admin/statistics/order-status-distribution`
  - `getProfitDetails()` → `/admin/statistics/profit-details`

Để khớp API:

- `renderStatistics()` nên gọi `getStatisticsSummary()` để lấy:
  - `totalRevenue`, `totalCost`, `totalProfit`, `profitRate`.
- `renderProfitDetail()` nên dùng `getProfitDetails()` thay vì random.

### 6.3. Users

- **Module**: `js_admin_dashboard/modules/users.js` (hiện tại mock).
- **API** trong `api.js`:
  - `getUsers()` → `GET /users`
  - `getUser(id)` → `GET /user/{id}`
  - `createUser(userData)` → `POST /user`
  - `updateUser(id, userData)` → `PUT /user/{id}`
  - `deleteUser(id)` → `DELETE /user/{id}`

DTO user nên chứa:

- `id`, `name`, `email`, `role`, `createdAt`.

### 6.4. Discounts

- **Module**: `js_admin_dashboard/modules/discounts.js` (hiện tại mock).
- **API**:
  - `getDiscounts()` → `/discounts`
  - `getDiscount(id)` → `/discount/{id}`
  - `createDiscount(data)` → `/discount` (POST)
  - `updateDiscount(id, data)` → `/discount/{id}` (PUT)
  - `deleteDiscount(id)` → `/discount/{id}` (DELETE)

DTO discount tối thiểu:

- `id`, `code` hoặc `discountCode`, `percent`, `startDate`, `endDate`, `status` (`active`/`expired`).

### 6.5. Wishlist (admin view)

- **Module**: `js_admin_dashboard/modules/wishlist.js` (hiện tại mock).
- Mục tiêu nếu cần đồng bộ với backend:
  - Expose API admin để:
    - Xem top sản phẩm được wishlist nhiều.
    - Hoặc thống kê wishlist của user (`/wishlist/admin/...`).
- Trên FE user, đã có `WishlistAPI` trong `fe/js/api.js`:
  - `getUserWishlist`, `getWishlistCount`, `add`, `remove`.

---

## 7. Kết luận & checklist đồng bộ

Để đảm bảo **UI admin rót dữ liệu đầy đủ sang FE user**, cần:

- **Backend**
  - Triển khai chuẩn DTO theo các file:
    - `ProductCreateAndUpdate.json`
    - `getCartAPI.json`
    - `getOrderAPI.json`
  - Đảm bảo:
    - `/products` trả đủ: `id`, `name`, `finalPrice/price`, `discountPercent`, `category{ id, name }`, `productImages`.
    - `/categories` trả: `id`, `name`, `description`, `productCount` (nếu có).
    - `/cart/{userId}` và `/orders` tuân thủ các schema trên.
  - Sort hợp lý (mới nhất trước) để sản phẩm mới admin thêm xuất hiện ở **đầu các block sản phẩm** trên FE.

- **FE Admin (`fe_admin_dashboard`)**
  - Đã **gọi API products & categories** trong `products.js`.
  - Cần nâng cấp:
    - `categories.js`, `orders.js`, `users.js`, `discounts.js`, `statistics.js`, `wishlist.js` để sử dụng API thay vì `mockData`.

- **FE User (`fe`)**
  - Đã bọc API trong `fe/js/api.js` cho:
    - Product, Category, Cart, Order, Wishlist, User, Auth.
  - Cần đồng bộ:
    - Navigation/category filter, các slider "New products", "Top selling" sử dụng dữ liệu thật từ `ProductAPI` & `CategoryAPI` thay vì HTML tĩnh.

Khi các phần trên được hoàn thiện, **luồng chuẩn sẽ là**:

1. Admin tạo/sửa **Category** và **Product** trên `fe_admin_dashboard`.
2. Backend lưu DB, cập nhật DTO cho `/categories` và `/products`.
3. FE (user) gọi `ProductAPI.getAll()` + `CategoryAPI.getAll()` để render **home/index**:
   - Sản phẩm mới nhất nằm đầu.
   - Mỗi sản phẩm hiển thị đúng category mà admin đã gán.

