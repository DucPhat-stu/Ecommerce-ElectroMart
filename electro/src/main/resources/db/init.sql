CREATE DATABASE IF NOT EXISTS ElectroStore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE ElectroStore;

-- Thêm dòng này để tắt kiểm tra khóa ngoại trong quá trình tạo bảng
SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE IF NOT EXISTS users (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    Age INT,
    Email VARCHAR(255) UNIQUE
);
