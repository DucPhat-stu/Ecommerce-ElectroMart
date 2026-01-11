# ElectroStore – Dockerized System Guide

ElectroStore là một hệ thống web E-Commerce mẫu được xây dựng theo kiến trúc Client – Server, sử dụng Docker để chuẩn hóa môi trường chạy và triển khai.  
Hệ thống gồm Spring Boot cho backend, MySQL cho cơ sở dữ liệu và Nginx làm reverse proxy đồng thời phục vụ frontend tĩnh.

Mục tiêu của tài liệu này là hướng dẫn chạy project từ đầu đến cuối, giải thích rõ từng câu lệnh Docker/Docker Compose và đảm bảo tất cả thành viên trong nhóm có môi trường giống nhau.

---

## Architecture

Client (Browser)  
→ Nginx (port 80)  
→ Spring Boot Backend (port 8080)  
→ MySQL Database (port 3306 – internal)

Expose ra host:
- Frontend (Nginx): 80  
- Backend API: 8080  
- MySQL: 3307  

---

## Services

- db: MySQL 8.0, lưu trữ dữ liệu
- be: Spring Boot backend, xử lý nghiệp vụ
- nginx: Reverse proxy + frontend tĩnh

---

## Requirements

- Docker
- Docker Compose hoặc Docker Desktop

Kiểm tra môi trường:

```bash
docker --version
docker compose version
```

---

## Access URLs
Nếu chạy container thành công thì truy cập vào các url sau:
### Frontend: http://localhost
### Backend API: http://localhost/api/........ (api path)

---

## Commands
```bash
# Chạy web
docker compose up -d --build : Chạy build lần đầu

docker compose up -d --build tên_container : build riêng lại container
(Nếu chỉ sửa đổi backend thì chỉ cần build lại mỗi backend)

# Dừng app
docker compose down : Dừng toàn bộ hệ thống (giữ nguyên dữ liệu)

docker compose down -v : Dừng toàn bộ hệ thống (reset dữ liệu)

# Truy cập vào container
docker exec -it tên_container : Truy cập vào container

docker exec -it mysql mysql -u user -p ElectroStore : Truy cập vào db để xem dữ liệu (nhập pass 123123)

# Xem container, image, volume, logs
docker ps -a : Xem toàn bộ container

docker images : Xem toàn bộ image

docker volume ls : Xem toàn bộ volume

docker logs tên_container : Xem log container

# Xóa thủ công
docker rm id_container id_container : Xóa container (có thể xóa nhiều)

docker rmi id_image id_image  : Xóa images (có thể xóa nhiều)

docker volume remove tên_volume : Xóa volume
```