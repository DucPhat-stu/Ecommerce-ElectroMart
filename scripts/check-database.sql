-- ============================================
-- Script để kiểm tra Database
-- Chạy script này sau khi import để kiểm tra
-- ============================================

USE ElectroStore;

-- Kiểm tra tables
SELECT 'Tables in database:' as info;
SHOW TABLES;

-- Đếm số lượng records trong các bảng chính
SELECT 'Record counts:' as info;
SELECT 'users' as table_name, COUNT(*) as count FROM users
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_details', COUNT(*) FROM order_details
UNION ALL
SELECT 'discounts', COUNT(*) FROM discounts
UNION ALL
SELECT 'product_variants', COUNT(*) FROM product_variants;

-- Xem sample data
SELECT 'Sample Users:' as info;
SELECT id, full_name, email, role FROM users LIMIT 5;

SELECT 'Sample Products:' as info;
SELECT p.id, p.name, p.status, c.name as category_name 
FROM products p 
LEFT JOIN categories c ON p.category_id = c.id 
LIMIT 5;

SELECT 'Sample Categories:' as info;
SELECT * FROM categories;

SELECT 'Sample Orders:' as info;
SELECT o.id, o.total_price, o.status, u.full_name as customer
FROM orders o
LEFT JOIN users u ON o.user_id = u.id
LIMIT 5;
