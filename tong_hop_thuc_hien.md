# TỔNG HỢP THỰC HIỆN

Mục tiêu: Kết nối FE có sẵn với Backend đã chuẩn hoá (không chỉnh sửa entities/backend), bổ sung các trang còn thiếu theo concept giao diện, đảm bảo dữ liệu được validate và các chức năng e-commerce hoạt động logic.

1) Phân tích Backend (electro)
- Controllers đã có:
  - /api/v1/products, /api/v1/products/{id}, /api/v1/products/category/{categoryId}
  - /api/v1/cart (POST), /api/v1/cart/{cartId} (PUT, DELETE), /api/v1/cart/{userId} (GET), /api/v1/cart/user/{userId} (DELETE)
  - /api/v1/reviews (POST, PUT, DELETE), /api/v1/reviews/product/{productId} (GET)
  - /api/v1/users (GET)
  - /api/v1/orders (GET by id, POST tạo mẫu order)
  - /api/v1/category/{name}
- Product entity có các field: id, name, price, discountPercent, finalPrice (tính toán từ price/discount), shortDescription, description, stockQuantity, categoryName, productImages, productDetails...
- Lưu ý: Không chỉnh sửa backend; chỉ tương tác thông qua API.

2) Phân tích Frontend (fe)
- Có sẵn các trang: index.html, store.html, product.html, checkout.html và các asset (banner, footer, logo, CSS/JS). Chưa có logic gọi API thực tế, nội dung hiện tại là tĩnh mẫu template.
- Đã có js/api.js (client API) với các hàm ProductAPI, CartAPI, ReviewAPI, CategoryAPI, OrderAPI, UserAPI. Tuy nhiên chưa được nhúng vào các trang.

3) Thực thi tích hợp & xây dựng chức năng
- Thêm file mới: fe/js/app.js
  - Chức năng:
    - Trang chủ (index): gọi ProductAPI.getAll() để render danh sách sản phẩm vào slider (New Products, Top Selling) theo đúng slick layout sẵn có; giữ nguyên concept giao diện (banner, logo, footer).
    - Trang store: render danh sách sản phẩm dạng lưới từ API.
    - Trang product: đọc ?id=..., gọi ProductAPI.getById(id), bind ảnh, tên, giá (finalPrice), tồn kho, mô tả. Gắn sự kiện thêm vào giỏ hàng với số lượng nhập.
    - Reviews: gọi ReviewAPI.getProductReviews(productId), hiển thị danh sách review, rating trung bình; form gửi review validate (1-5) và comment đủ dài trước khi gọi ReviewAPI.create.
    - Header Cart: mỗi trang cập nhật dropdown giỏ hàng (số lượng, subtotal) qua CartAPI.getUserCart(userId). Liên kết View Cart -> cart.html, Checkout -> checkout.html.
    - Cart Page: thêm mới trang giỏ hàng (cart.html) để xem/sửa số lượng, xóa dòng, xóa toàn bộ, tính tổng tiền. Các thao tác gọi CartAPI.updateQuantity/removeFromCart/clearCart và cập nhật lại header.
    - Checkout: hiển thị tóm tắt đơn hàng từ giỏ; validate tick điều khoản và các trường bắt buộc (họ, tên, địa chỉ, điện thoại) trước khi gọi OrderAPI.create(). Sau khi tạo: clearCart và chuyển về index.
    - Format tiền sử dụng window.formatPrice từ js/api.js.
    - Xử lý ảnh: ưu tiên product.productImages[0].imageUrl; nếu thiếu thì fallback ảnh mẫu có sẵn trong template để đồng nhất giao diện.

- Thêm trang mới: fe/cart.html
  - Dựa trên concept sẵn có (header, banner, footer, logo) để đảm bảo đồng nhất.
  - Bảng hiển thị sản phẩm trong giỏ, thay đổi số lượng, xóa, tổng tiền, nút xóa toàn bộ, chuyển sang checkout.

- Cập nhật các trang để nhúng script:
  - Nhúng axios CDN, js/api.js và js/app.js vào: fe/index.html, fe/store.html, fe/product.html, fe/checkout.html.
  - Không thay đổi layout/giao diện và nội dung đã có, chỉ bổ sung script ở cuối để kích hoạt logic.

4) Đảm bảo không thay đổi backend chuẩn hoá
- Không chỉnh sửa bất kỳ file Java backend hoặc entities. Ch��� đọc API để mapping dữ liệu lên FE.

5) Đảm bảo validate dữ liệu
- Form review: kiểm tra rating [1..5], độ dài comment.
- Trang product: số lượng thêm vào giỏ tối thiểu 1.
- Trang checkout: bắt buộc nhập họ, tên, địa chỉ, điện thoại; bắt buộc đồng ý điều khoản trước khi đặt hàng.
- Các thao tác API có xử lý lỗi hiển thị alert thông báo.

6) Liên kết chức năng logic e-commerce
- Danh sách sản phẩm -> Chi tiết -> Thêm vào giỏ -> Xem giỏ -> Cập nhật/xóa -> Checkout -> Tạo đơn -> Xóa giỏ và chuyển về trang chủ.
- Header Cart luôn đồng bộ số lượng và subtotal với trạng thái hiện tại của giỏ.

7) Danh sách file thay đổi/tạo mới
- Tạo mới:
  - fe/js/app.js
  - fe/cart.html
- Chỉnh sửa (chỉ bổ sung scripts):
  - fe/index.html
  - fe/store.html
  - fe/product.html
  - fe/checkout.html

8) Hướng dẫn chạy thử tránh lỗi
- Backend:
  - Chạy theo HUONG_DAN_CHAY*.md hoặc run-project.bat có sẵn (mặc định Spring Boot port 8080). Đảm bảo cơ sở dữ liệu đã init theo hướng dẫn trong resources/db.
- Frontend:
  - Dùng nginx cấu hình sẵn (docker-compose) hoặc mở trực tiếp fe/index.html từ server tĩnh. Khi chạy qua file:// có th�� bị CORS; khuyến nghị chạy nginx theo thư mục nginx/ hoặc phục vụ fe qua một HTTP server (ví dụ: npx http-server fe -p 8081) và đằng sau reverse proxy tới backend nếu cần.
  - Các trang sử dụng axios và gọi API dựa trên window.location.origin. Nếu FE và BE khác origin, chỉnh API_BASE_URL trong fe/js/api.js cho phù hợp (ví dụ: const API_BASE_URL = 'http://localhost:8080').

9) Ghi chú tương thích API
- CategoryAPI trong js/api.js gọi /api/v1/category/{name}. Backend hiện mapping ở /api/v1/category/{name} (CategoryController đặt @RequestMapping("/api") + @GetMapping("/v1/category/{categoryName}") => hợp lệ với client đã viết).
- OrderAPI.create: backend hiện tại trả thực thể Order trực tiếp (không bọc ApiResponse). app.js có xử lý trường hợp success === false; nếu backend trả trực tiếp thì coi như thành công.
- CartResponse schema có thể khác nhau, app.js có fallback lấy items từ các key phổ biến: items | cartItems | products.

10) Kiểm thử nhanh
- Mở index.html -> thấy sản phẩm từ API, nút add to cart hoạt động, Header Cart cập nhật.
- Mở store.html -> lưới sản phẩm render từ API, add to cart hoạt động.
- Mở product.html?id=1 -> thông tin, ảnh, giá, review hiển thị; gửi review với rating và comment hợp lệ sẽ thành công.
- Mở cart.html -> danh sách giỏ, đổi số lượng, xóa item, xóa giỏ, tổng tiền cập nhật.
- Mở checkout.html -> tóm tắt giỏ, nhập thông tin hợp lệ + chấp nhận điều khoản -> đặt hàng -> clear giỏ -> về index.

Hoàn tất.