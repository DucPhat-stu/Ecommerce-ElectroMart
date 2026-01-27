# Trách nhiệm các nút trên giao diện Electro (repo-clone)

Phạm vi: chỉ áp dụng cho FE trong repo-clone, chạy qua Nginx, backend Spring Boot (api.prefix=/api/v1).

## Header (top)
- USD: dẫn tới checkout.html#payment để người dùng truy cập khu vực phương thức thanh toán (mô phỏng liên kết thẻ/tài khoản ngân hàng).
- My Account: dẫn tới account.html.

## Header (logo và cụm giỏ hàng / wishlist)
- Wishlist (biểu tượng tim + chữ Your Wishlist)
  - Hành vi: điều hướng tới wishlist.html.
  - Số lượng: hiển thị tổng số wishlist items (từ API /api/v1/wishlist/count?userId=...).
- Your Cart (dropdown)
  - Luôn hiển thị tổng số lượng item của toàn giỏ.
  - Dropdown hiển thị tối đa 7 item, trong đó item mới thêm xuất hiện trên cùng.
  - Subtotal hiển thị tổng tiền của toàn giỏ.
  - Nút View Cart → cart.html; Checkout → checkout.html.

## Header Search
- Tìm kiếm và lọc theo danh mục:
  - Gửi người dùng sang store.html với các query:
    - q: chuỗi tìm kiếm
    - category: tên danh mục được chọn
  - Ví dụ: store.html?q=laptop&category=Laptops.

## Navbar chính (Home/Hot Deals/Categories/Laptops/Smartphones/Cameras/Accessories)
- Home → index.html
- Hot Deals → store.html?hot=1 (lọc client-side: discountPercent>0)
- Categories → store.html (toàn bộ)
- Laptops → store.html?category=Laptops
- Smartphones → store.html?category=Smartphones
- Cameras → store.html?category=Cameras
- Accessories → store.html?category=Accessories

## Trang chủ (index)
- 3 ô Shop now (Laptop/Accessories/Cameras Collection):
  - Điều hướng đến store.html?category=... tương ứng.
- Khu vực New/Top: nạp sản phẩm qua API và hiển thị.
- Lưới 4x4 Featured (tự chèn bởi JS): hiển thị 16 sản phẩm đầu.

## Store (store.html)
- FE gọi ProductAPI.getAll(), lọc client-side theo:
  - q trong name/shortDescription/description (không phân biệt hoa thường).
  - category khớp tên danh mục.
  - hot → sản phẩm có discountPercent>0.
- Lưới hiển thị 4 cột (col-md-3) và nạp card bằng productCard().

## Product Card
- Quick View: liên kết tới quick-view.html?id={productId}.
- Add to Wishlist: gọi WishlistAPI.add(userId, productId), thông báo kết quả và cập nhật wishlist count trên header.
- Add to Cart: gọi CartAPI.addToCart(userId, productId, 1), cập nhật dropdown giỏ hàng.

## Product Detail (product.html)
- Nút Add to Cart: thêm theo số lượng nhập, cập nhật dropdown giỏ hàng.
- Khu vực ảnh: dùng slick, tự nạp ảnh từ product_images hoặc fallback.
- Reviews: nạp danh sách và gửi review (yêu cầu rating và comment hợp lệ).

## Quick View (quick-view.html)
- Tận dụng logic của Product Detail để hiển thị tóm tắt sản phẩm theo id.
- Có nút Add to Cart (số lượng), Add to Wishlist, và link View full details → product.html?id=...

## Footer
- Cột Service: My Account, View Cart, Wishlist, Help → điều hướng trang tương ứng.
- Cột Categories: Hot deals, Laptops, Smartphones, Cameras, Accessories → điều hướng store.html với query phù hợp.
- Dải liên kết pháp lý (tiêm vào bottom footer nếu thiếu): About | Contact | Privacy | Terms.

## Quy ước kỹ thuật
- Các liên kết được chuẩn hóa trong repo-clone/fe/js/app.js:
  - setNavbarLinks(): gán link Navbar.
  - setFooterLinks() + injectFooterLegalLinks(): chuẩn hóa footer và nhóm link pháp lý.
  - ensureHeaderLinks(): Wishlist, View Cart, Checkout, USD, My Account.
  - bindShopNowLinks(): gán link Shop now theo danh mục.
  - loadStorePage(): lọc sản phẩm theo q/category/hot và render grid 4 cột.
  - updateHeaderCart(): hiển thị tối đa 7 item mới nhất, tổng quantity, subtotal.

## Kiểm thử nhanh
1) Mở http://localhost
2) Click Wishlist (header) → wishlist.html
3) Gõ tìm kiếm, chọn danh mục → chuyển tới store.html và lọc kết quả.
4) Add to Cart từ card → dropdown giỏ hàng hiển thị item mới ở đầu, tối đa 7 item.
5) Add to Wishlist → tăng wishlist count.
6) Quick View → mở quick-view.html?id=..., xem, thêm vào giỏ/wishlist, hoặc đi tới product.html.
7) Footer → About/Contact/Privacy/Terms/Service/Categories điều hướng đúng.

Ghi chú: Không thay đổi entities/BE. Toàn bộ thay đổi thực hiện trên FE trong repo-clone.