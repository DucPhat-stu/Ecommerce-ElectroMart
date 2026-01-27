# Hướng Dẫn Chạy Project ElectroStore

## 📋 Tổng Quan

ElectroStore là hệ thống E-Commerce được xây dựng với:
- **Backend**: Spring Boot (Java 17)
- **Database**: MySQL 8.0
- **Frontend**: HTML/CSS/JS (phục vụ qua Nginx)
- **Container**: Docker & Docker Compose

---

## 🚀 Cách 1: Chạy bằng Docker (Khuyến nghị)

### Yêu cầu:
- Docker Desktop đã cài đặt và đang chạy
- Hoặc Docker Engine + Docker Compose

### Bước 1: Kiểm tra Docker
```bash
docker --version
docker compose version
```

### Bước 2: Chạy toàn bộ hệ thống
```bash
# Di chuyển vào thư mục project (repo-clone)
cd <đường_dẫn_đến_thư_mục>/repo-clone

# Build và chạy tất cả services (database, backend, frontend)
docker compose up -d --build
```

Lưu ý:
- FE đã được bind-mount vào container Nginx (./fe và ./fe_admin_dashboard). Khi chỉnh sửa file FE, chỉ cần refresh trình duyệt (F5), không cần build lại image.
- Ảnh upload được phục vụ qua http://localhost/img/ và lưu tại thư mục ./uploads trên máy.
- API được truy cập qua http://localhost/api/v1/... (Nginx reverse proxy tới backend).

### Bước 3: Kiểm tra containers đang chạy
```bash
docker ps
```

Bạn sẽ thấy 3 containers:
- `mysql` - Database (port 3307)
- `backend` - Spring Boot API (port 8080)
- `nginx-service` - Frontend (port 80)

### Bước 4: Truy cập ứng dụng
- **Frontend**: http://localhost
- **Backend API**: http://localhost:8080/api/...
- **Database**: localhost:3307 (user: `user`, password: `123123`)

### Các lệnh hữu ích:

```bash
# Xem logs của backend
docker logs backend

# Xem logs của database
docker logs mysql

# Xem logs của nginx
docker logs nginx-service

# Truy cập vào MySQL để xem dữ liệu
docker exec -it mysql mysql -u user -p123123 ElectroStore

# Dừng toàn bộ hệ thống (giữ nguyên dữ liệu)
docker compose down

# Dừng và xóa toàn bộ dữ liệu (reset database)
docker compose down -v

# Build lại chỉ backend (khi sửa code Java backend)
docker compose build be && docker compose up -d be

# Xem tất cả containers
docker ps -a
```

### Live update Frontend (FE)
- FE được mount trực tiếp vào Nginx container. Sửa file trong `repo-clone/fe` hoặc `repo-clone/fe_admin_dashboard` → F5 trình duyệt để thấy thay đổi.
- Không cần rebuild image Nginx khi phát triển FE.
- Nếu không thấy cập nhật, kiểm tra trình duyệt có bị cache: dùng Ctrl+F5.

---

## 💻 Cách 2: Chạy Local (Không dùng Docker)

### Yêu cầu:
- Java 17 JDK
- Maven 3.6+
- MySQL 8.0 đã cài đặt và chạy
- IDE (IntelliJ IDEA, Eclipse, VS Code)

### Bước 1: Cài đặt MySQL

1. Cài đặt MySQL 8.0 từ https://dev.mysql.com/downloads/
2. Tạo database và user:
```sql
CREATE DATABASE ElectroStore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'user'@'localhost' IDENTIFIED BY '123123';
GRANT ALL PRIVILEGES ON ElectroStore.* TO 'user'@'localhost';
FLUSH PRIVILEGES;
```

### Bước 2: Import Database

Chạy các file SQL theo thứ tự:
```bash
# Kết nối MySQL
mysql -u user -p123123

# Trong MySQL console:
USE ElectroStore;
SOURCE D:/phan_mem/Ecommerce-ElectroMart/electro/src/main/resources/db/init.sql;
SOURCE D:/phan_mem/Ecommerce-ElectroMart/electro/src/main/resources/db/sampledata.sql;
```

Hoặc import trực tiếp:
```bash
mysql -u user -p123123 ElectroStore < D:/phan_mem/Ecommerce-ElectroMart/electro/src/main/resources/db/init.sql
mysql -u user -p123123 ElectroStore < D:/phan_mem/Ecommerce-ElectroMart/electro/src/main/resources/db/sampledata.sql
```

### Bước 3: Cấu hình application.properties

Tạo hoặc cập nhật file `electro/src/main/resources/application.properties`:

```properties
spring.application.name=electro

# Database Configuration
spring.datasource.url=jdbc:mysql://localhost:3306/ElectroStore?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
spring.datasource.username=user
spring.datasource.password=123123
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# Hibernate JPA
spring.jpa.database-platform=org.hibernate.dialect.MySQLDialect
spring.jpa.hibernate.ddl-auto=none
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# Server Port
server.port=8080
```

### Bước 4: Build và chạy Backend

**Cách 1: Dùng Maven command line**
```bash
cd D:\phan_mem\Ecommerce-ElectroMart\electro

# Build project
mvn clean install

# Chạy ứng dụng
mvn spring-boot:run
```

**Cách 2: Dùng IDE (IntelliJ IDEA)**
1. Mở project trong IntelliJ IDEA
2. File → Open → Chọn folder `electro`
3. Đợi Maven sync dependencies
4. Tìm file `ElectroApplication.java`
5. Click chuột phải → Run 'ElectroApplication'

**Cách 3: Dùng Maven Wrapper (Windows)**
```bash
cd D:\phan_mem\Ecommerce-ElectroMart\electro
.\mvnw.cmd spring-boot:run
```

### Bước 5: Chạy Frontend

**Cách 1: Dùng Python HTTP Server**
```bash
cd D:\phan_mem\Ecommerce-ElectroMart\fe

# Python 3
python -m http.server 8000

# Hoặc Python 2
python -m SimpleHTTPServer 8000
```

**Cách 2: Dùng Node.js http-server**
```bash
# Cài đặt http-server (nếu chưa có)
npm install -g http-server

# Chạy
cd D:\phan_mem\Ecommerce-ElectroMart\fe
http-server -p 8000
```

**Cách 3: Dùng Live Server trong VS Code**
1. Cài extension "Live Server" trong VS Code
2. Mở file `fe/index.html`
3. Click chuột phải → "Open with Live Server"

### Bước 6: Truy cập ứng dụng
- **Frontend**: http://localhost:8000
- **Backend API**: http://localhost:8080/api/...

---

## 🔧 Troubleshooting

### Lỗi: Port đã được sử dụng
```bash
# Windows: Tìm process đang dùng port
netstat -ano | findstr :8080
netstat -ano | findstr :3306

# Kill process (thay PID bằng số thực tế)
taskkill /PID <PID> /F
```

### Lỗi: Database connection failed
- Kiểm tra MySQL đã chạy chưa
- Kiểm tra username/password trong `application.properties`
- Kiểm tra database `ElectroStore` đã được tạo chưa

### Lỗi: Docker không chạy được
- Đảm bảo Docker Desktop đang chạy
- Kiểm tra port 80, 8080, 3307 không bị chiếm dụng
- Thử restart Docker Desktop

### Reset Database (Docker)
```bash
docker compose down -v
docker compose up -d --build
```

---

## 📝 Thông tin Database

- **Database Name**: ElectroStore
- **Username**: user
- **Password**: 123123
- **Port**: 3307 (Docker) hoặc 3306 (Local)

### Tài khoản mẫu:
- **Admin**: 
  - Username: `admin`
  - Password: `password123`
  - Email: `admin@electrostore.com`

- **User thường**:
  - Username: `an.nguyen`
  - Password: `password123`
  - Email: `an.nguyen@example.com`

---

## 🎯 API Endpoints (Ví dụ)

Sau khi chạy thành công, bạn có thể test các API:
- `GET http://localhost:8080/api/products` - Lấy danh sách sản phẩm
- `GET http://localhost:8080/api/categories` - Lấy danh sách danh mục
- `GET http://localhost:8080/api/products/{id}` - Lấy chi tiết sản phẩm

---

## 📚 Tài liệu tham khảo

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Docker Documentation](https://docs.docker.com/)
- [MySQL Documentation](https://dev.mysql.com/doc/)

---

## ✅ Checklist khi chạy lần đầu

- [ ] Đã cài đặt Docker hoặc MySQL
- [ ] Đã clone/download project về máy
- [ ] Đã chạy lệnh `docker compose up -d --build` hoặc setup MySQL local
- [ ] Đã kiểm tra containers/services đang chạy
- [ ] Đã truy cập được http://localhost (hoặc http://localhost:8000)
- [ ] Đã test API backend tại http://localhost:8080/api/...

---

**Chúc bạn chạy thành công! 🎉**
