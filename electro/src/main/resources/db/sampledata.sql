USE ElectroStore;

-- ============================================
-- ROLES DATA
-- ============================================
-- INSERT INTO roles (id, name, description, created_at) VALUES
-- (1, 'USER', 'Người dùng thông thường', '2024-01-01 00:00:00'),
-- (2, 'ADMIN', 'Quản trị viên hệ thống', '2024-01-01 00:00:00');

-- ============================================
-- USERS DATA
-- ============================================
INSERT INTO users (
    name, 
    email, 
    password, 
    phone, 
    address, 
    created_at
    ) 
VALUES
('Nguyễn Văn An', 'an.nguyen@example.com', 'password123', '0901234567', '123 Đường ABC, Quận 1, TP.HCM', '2024-01-10 10:00:00'),
('Trần Thị Bình', 'binh.tran@example.com', 'password123', '0902345678', '456 Đường XYZ, Quận 2, TP.HCM', '2024-01-11 10:00:00'),
('Lê Hoàng Cường', 'cuong.le@example.com', 'password123', '0903456789', '789 Đường DEF, Quận 3, TP.HCM', '2024-01-12 10:00:00'),
('Phạm Minh Dũng', 'dung.pham@example.com', 'password123', '0904567890', '321 Đường GHI, Quận 4, TP.HCM', '2024-01-13 10:00:00'),
('Võ Thị Hạnh', 'hanh.vo@example.com', 'password123', '0905678901', '654 Đường JKL, Quận 5, TP.HCM', '2024-01-14 10:00:00');

-- ============================================
-- CATEGORIES DATA
-- ============================================
INSERT INTO categories (
    name, 
    parent_id, 
    status, 
    created_at
    ) 
VALUES
('Smartphones', NULL, 'ACTIVE', '2024-01-10 10:00:00'),
('Laptops', NULL, 'ACTIVE', '2024-01-10 10:00:00'),
('Tablets', NULL, 'ACTIVE', '2024-01-10 10:00:00'),
('Audio & Headphones', NULL, 'ACTIVE', '2024-01-10 10:00:00'),
('Wearables', NULL, 'ACTIVE', '2024-01-10 10:00:00');

-- ============================================
-- PRODUCTS DATA
-- ============================================
INSERT INTO products (
    id,
    name,
    price,
    discount_percent,
    short_description,
    description,
    status,
    created_at,
    updated_at,
    category_id
)
VALUES
-- Smartphones (id 1-10)
(1, 'Apple iPhone 14 Pro', 999.00, 10,
 '6.1" Pro display · A16 Bionic · 48MP main camera',
 'The iPhone 14 Pro delivers fast performance with the A16 Bionic chip, a 6.1-inch Super Retina XDR display and a 48MP main camera for pro-grade photos and video.',
 'ACTIVE', '2023-09-01 09:00:00', '2023-12-01 12:00:00', 1),

(2, 'Samsung Galaxy S23', 849.00, 5,
 '6.1" Dynamic AMOLED · Snapdragon 8 Gen 2 · 50MP camera',
 'Samsung Galaxy S23 combines premium materials with flagship performance, offering a crisp Dynamic AMOLED display and pro-level camera features.',
 'ACTIVE', '2023-02-15 10:00:00', '2023-12-05 11:00:00', 1),

(3, 'Google Pixel 7', 599.00, 15,
 '6.3" OLED · Google Tensor G2 · 50MP camera',
 'Pixel 7 focuses on AI-powered features, clean Android experience and strong camera results even in low light.',
 'ACTIVE', '2022-10-13 09:00:00', '2023-11-15 14:00:00', 1),

(4, 'Xiaomi 13', 699.00, 10,
 '6.36" AMOLED · Snapdragon 8 Gen 2 · Leica optics',
 'Xiaomi 13 offers flagship hardware with Leica-tuned cameras, fast charging and a high-refresh AMOLED panel.',
 'ACTIVE', '2023-01-10 09:00:00', '2023-12-01 09:00:00', 1),

(5, 'OnePlus 11', 699.00, 8,
 '6.7" Fluid AMOLED · Snapdragon 8 Gen 2 · 100W charging',
 'OnePlus 11 delivers smooth performance with fast charging and a clean OxygenOS experience.',
 'ACTIVE', '2023-02-01 08:00:00', '2023-12-03 10:00:00', 1),

(6, 'Sony Xperia 1 IV', 1199.00, 12,
 '6.5" 4K HDR OLED · Cinematography-focused camera',
 'Sony Xperia 1 IV is tailored for creators, offering a 4K HDR display and pro camera controls for photo/video.',
 'ACTIVE', '2022-05-25 09:00:00', '2023-12-10 09:00:00', 1),

(7, 'OPPO Find X6 Pro', 1099.00, 10,
 '6.8" LTPO AMOLED · Snapdragon 8 Gen 2 · 80W charging',
 'Find X6 Pro brings flagship specs, long battery life and top-tier imaging performance.',
 'ACTIVE', '2023-04-15 09:00:00', '2023-12-08 09:00:00', 1),

(8, 'vivo X90 Pro', 999.00, 7,
 '6.78" AMOLED · MediaTek Dimensity 9200 · Zeiss optics',
 'vivo X90 Pro focuses on camera quality with Zeiss collaboration and high-performance chipset.',
 'ACTIVE', '2023-09-01 09:00:00', '2023-12-12 10:00:00', 1),

(9, 'Motorola Edge 40', 499.00, 10,
 '6.55" pOLED · Snapdragon 7 Gen 1 · 68W fast charge',
 'Motorola Edge 40 offers balanced performance, long battery life and a clean Android experience.',
 'ACTIVE', '2023-06-20 09:00:00', '2023-12-06 10:00:00', 1),

(10, 'ASUS ROG Phone 7', 899.00, 5,
 '6.78" AMOLED · Snapdragon 8 Gen 2 · Gaming features',
 'ROG Phone 7 is optimized for gaming with high refresh rate display, advanced cooling and gamer-centric accessories.',
 'ACTIVE', '2023-09-01 09:00:00', '2023-12-07 09:00:00', 1),

-- Laptops (id 11-20)
(11, 'Apple MacBook Air M2 (13-inch)', 1199.00, 0,
 'M2 chip · 8/16GB unified RAM · 256/512GB SSD',
 'MacBook Air with M2 chip provides great battery life and a fanless design ideal for everyday use and productivity.',
 'ACTIVE', '2022-06-05 09:00:00', '2023-11-20 12:00:00', 2),

(12, 'Apple MacBook Pro 14 (M2 Pro)', 1999.00, 5,
 'M2 Pro · 14-inch Liquid Retina · Pro performance',
 'MacBook Pro 14 offers high-end performance with M2 Pro for creative professionals and developers.',
 'ACTIVE', '2023-01-24 09:00:00', '2023-12-02 12:30:00', 2),

(13, 'Dell XPS 13 Plus', 1099.00, 7,
 '13.4" OLED option · 12th Gen Intel · compact',
 'XPS 13 Plus merges a sleek design with powerful internals, excellent display options and long battery life.',
 'ACTIVE', '2023-03-10 09:00:00', '2023-11-30 10:00:00', 2),

(14, 'HP Spectre x360 14', 1299.00, 10,
 'Convertible · 12th Gen Intel · OLED option',
 'Spectre x360 is a premium convertible offering touchscreen versatility, strong performance and an elegant design.',
 'ACTIVE', '2023-05-10 09:00:00', '2023-12-04 09:00:00', 2),

(15, 'Lenovo ThinkPad X1 Carbon Gen 11', 1499.00, 0,
 'Lightweight · Intel Evo · Business features',
 'ThinkPad X1 Carbon remains a top choice for business users with robust build, excellent keyboard and manageability features.',
 'ACTIVE', '2023-01-10 09:00:00', '2023-12-01 09:00:00', 2),

(16, 'ASUS ZenBook 14', 899.00, 12,
 '14" display · Ryzen 7 or Intel options · portable',
 'ZenBook 14 balances portability with solid performance and long battery life for mobile professionals.',
 'ACTIVE', '2023-06-15 09:00:00', '2023-12-07 09:00:00', 2),

(17, 'Acer Swift 3', 649.00, 15,
 'Thin & light · Ryzen/Intel options · value laptop',
 'Swift 3 provides great value with capable processors and good battery life for students and professionals.',
 'ACTIVE', '2023-03-20 09:00:00', '2023-12-08 09:00:00', 2),

(18, 'Razer Blade 15', 1799.00, 10,
 'Gaming laptop · RTX 40-series options · 240Hz',
 'Razer Blade 15 is a premium gaming laptop with thin chassis and high-refresh displays for esports-grade performance.',
 'ACTIVE', '2023-09-01 09:00:00', '2023-12-09 09:00:00', 2),

(19, 'MSI GS66 Stealth', 1599.00, 8,
 'Gaming · RTX 40-series · high-performance cooling',
 'GS66 Stealth focuses on delivering high frame rates and sustained performance in a portable chassis.',
 'ACTIVE', '2023-01-15 09:00:00', '2023-11-30 09:00:00', 2),

(20, 'Microsoft Surface Laptop 5', 1299.00, 0,
 'Touchscreen · Intel Core H-Series · premium build',
 'Surface Laptop 5 offers a clean Windows experience with a lightweight premium design, ideal for office productivity.',
 'ACTIVE', '2023-06-01 09:00:00', '2023-12-02 09:00:00', 2),

-- Tablets (id 21-30)
(21, 'Apple iPad Pro 11 (M2)', 799.00, 5,
 '11" Liquid Retina · M2 chip · pro performance',
 'iPad Pro brings desktop-class performance in a tablet form factor with support for Apple Pencil and Magic Keyboard.',
 'ACTIVE', '2022-10-18 09:00:00', '2023-12-01 09:00:00', 3),

(22, 'Apple iPad Air (5th gen)', 599.00, 10,
 '10.9" Liquid Retina · M1 chip · lightweight',
 'iPad Air balances performance and portability for content creation and everyday use.',
 'ACTIVE', '2022-03-08 09:00:00', '2023-12-10 09:00:00', 3),

(23, 'Samsung Galaxy Tab S8', 699.00, 7,
 '11" LCD · Snapdragon 8 Gen 1 · S Pen included',
 'Galaxy Tab S8 is optimized for productivity with S Pen support and a vivid display.',
 'ACTIVE', '2022-02-25 09:00:00', '2023-12-05 09:00:00', 3),

(24, 'Lenovo Tab P12 Pro', 649.00, 15,
 '12.6" AMOLED · Snapdragon 870 · premium display',
 'Tab P12 Pro offers a large AMOLED display and strong battery life, great for media consumption and multitasking.',
 'ACTIVE', '2022-12-01 09:00:00', '2023-11-28 09:00:00', 3),

(25, 'Huawei MatePad Pro', 599.00, 20,
 '12.6" display · Kirin/Qualcomm options · sleek',
 'MatePad Pro focuses on design and screen quality for creative users and professionals.',
 'ACTIVE', '2022-05-10 09:00:00', '2023-11-30 09:00:00', 3),

(26, 'Amazon Fire HD 10', 149.99, 25,
 '10.1" display · affordable tablet · media-first',
 'Fire HD 10 is an affordable tablet geared towards reading, streaming and light productivity.',
 'ACTIVE', '2023-01-05 09:00:00', '2023-12-01 09:00:00', 3),

(27, 'Samsung Galaxy Tab A8', 229.99, 10,
 '10.5" display · budget-friendly · long battery life',
 'Tab A8 is a value-oriented tablet suitable for family use and media consumption.',
 'ACTIVE', '2023-03-01 09:00:00', '2023-12-06 09:00:00', 3),

(28, 'Microsoft Surface Pro 9', 999.00, 5,
 '2-in-1 · Intel or ARM options · touchscreen',
 'Surface Pro 9 is a versatile 2-in-1 device offering laptop performance with tablet portability and detachable keyboard support.',
 'ACTIVE', '2023-02-10 09:00:00', '2023-12-09 09:00:00', 3),

(29, 'Xiaomi Pad 6', 399.00, 15,
 '11" IPS · Snapdragon 870 · great battery',
 'Xiaomi Pad 6 offers strong performance and a clean Android experience at a competitive price.',
 'ACTIVE', '2023-04-15 09:00:00', '2023-12-03 09:00:00', 3),

(30, 'OPPO Pad', 349.00, 20,
 '11.5" display · MediaTek chipset · lightweight',
 'OPPO Pad is an affordable tablet with solid display and battery life for media and productivity.',
 'ACTIVE', '2023-06-10 09:00:00', '2023-12-02 09:00:00', 3),

-- Audio & Headphones (id 31-40)
(31, 'Sony WH-1000XM5', 399.00, 10,
 'Over-ear · Industry-leading noise cancellation · long battery',
 'WH-1000XM5 features best-in-class ANC, excellent audio tuning and long battery life for travelers and commuters.',
 'ACTIVE', '2022-05-20 09:00:00', '2023-12-01 09:00:00', 4),

(32, 'Bose QuietComfort 45', 329.00, 5,
 'Over-ear · Balanced sound · comfort-focused',
 'QuietComfort 45 offers comfortable fit with reliable noise cancellation and a neutral sound profile.',
 'ACTIVE', '2022-09-10 09:00:00', '2023-12-02 09:00:00', 4),

(33, 'Sennheiser Momentum 4', 349.00, 8,
 'Over-ear · High-res audio · adaptive ANC',
 'Momentum 4 delivers detailed sound with adaptive noise cancellation and a comfortable design for long listening sessions.',
 'ACTIVE', '2022-11-15 09:00:00', '2023-12-03 09:00:00', 4),

(34, 'Apple AirPods Pro (2nd gen)', 249.00, 10,
 'In-ear · Active Noise Cancellation · Spatial Audio',
 'AirPods Pro 2 add improved ANC, better battery life and Spatial Audio for immersive listening.',
 'ACTIVE', '2022-09-23 09:00:00', '2023-12-05 09:00:00', 4),

(35, 'Bowers & Wilkins PX7 S2', 399.00, 12,
 'Over-ear · Premium sound · Adaptive ANC',
 'PX7 S2 aims for audiophiles with refined tuning, strong build and comfortable earcups.',
 'ACTIVE', '2023-03-01 09:00:00', '2023-12-06 09:00:00', 4),

(36, 'Jabra Elite 85t', 179.00, 15,
 'True wireless · customizable sound · ANC',
 'Jabra Elite 85t provides customizable EQ and reliable call performance in a compact case.',
 'ACTIVE', '2021-09-30 09:00:00', '2023-12-07 09:00:00', 4),

(37, 'Beats Studio3 Wireless', 299.00, 20,
 'Over-ear · Apple W1/H1 integration · bass-forward sound',
 'Studio3 offers seamless Apple device connectivity and robust low-end for bass lovers.',
 'ACTIVE', '2020-09-01 09:00:00', '2023-12-08 09:00:00', 4),

(38, 'Anker Soundcore Liberty Air 2 Pro', 129.99, 25,
 'True wireless · ANC · value performance',
 'Liberty Air 2 Pro gives strong value with good noise cancellation and customizable sound at a friendly price.',
 'ACTIVE', '2021-08-20 09:00:00', '2023-12-09 09:00:00', 4),

(39, 'Samsung Galaxy Buds2 Pro', 199.00, 10,
 'In-ear · Hi-Fi sound · ANC',
 'Buds2 Pro are tuned for clarity and fit well for extended listening with Samsung device integration.',
 'ACTIVE', '2022-08-10 09:00:00', '2023-12-01 09:00:00', 4),

(40, 'Sennheiser CX Plus True Wireless', 129.00, 20,
 'In-ear · great clarity · long battery',
 'CX Plus combines Sennheiser tuning with wireless convenience for clear audio and comfortable fit.',
 'ACTIVE', '2022-04-01 09:00:00', '2023-12-02 09:00:00', 4),

-- Wearables (id 41-50)
(41, 'Apple Watch Series 8', 399.00, 0,
 'Latest Apple watch · health & fitness features',
 'Series 8 includes advanced health sensors, robust fitness tracking and seamless iPhone integration.',
 'ACTIVE', '2022-09-07 09:00:00', '2023-12-01 09:00:00', 5),

(42, 'Samsung Galaxy Watch5', 279.00, 10,
 'Health tracking · wear OS · long battery',
 'Galaxy Watch5 blends solid hardware with Samsung health ecosystem and long battery life.',
 'ACTIVE', '2022-08-10 09:00:00', '2023-12-02 09:00:00', 5),

(43, 'Garmin Forerunner 955', 499.99, 5,
 'Sport watch · multisport tracking · long GPS battery',
 'Forerunner 955 is designed for serious athletes with detailed performance metrics and long battery life.',
 'ACTIVE', '2022-04-20 09:00:00', '2023-12-05 09:00:00', 5),

(44, 'Fitbit Sense 2', 299.95, 15,
 'Health-first smartwatch · stress & heart metrics',
 'Sense 2 focuses on health insights, stress management and advanced sleep tracking.',
 'ACTIVE', '2022-10-01 09:00:00', '2023-11-30 09:00:00', 5),

(45, 'Huawei Watch GT 3', 229.00, 20,
 'Long battery · health features · elegant design',
 'Watch GT 3 emphasizes long battery life with comprehensive health tracking.',
 'ACTIVE', '2022-06-10 09:00:00', '2023-12-01 09:00:00', 5),

(46, 'Amazfit GTR 3 Pro', 179.00, 25,
 'Value smartwatch · long battery · AMOLED',
 'GTR 3 Pro offers premium looks and long battery for users wanting smartwatch features at lower cost.',
 'ACTIVE', '2022-09-01 09:00:00', '2023-12-06 09:00:00', 5),

(47, 'Polar Vantage V2', 499.00, 10,
 'Pro sports watch · advanced metrics · lightweight',
 'Polar Vantage V2 provides pro-level training features in a sleek, lightweight package.',
 'ACTIVE', '2021-09-01 09:00:00', '2023-12-07 09:00:00', 5),

(48, 'Suunto 9 Peak', 449.00, 15,
 'Rugged sports watch · long battery life · accuracy',
 'Suunto 9 Peak is built for outdoor endurance sports and offers accurate GPS and long battery.',
 'ACTIVE', '2021-07-01 09:00:00', '2023-12-08 09:00:00', 5),

(49, 'TicWatch Pro 3', 299.00, 20,
 'Wear OS · dual-layer display · long battery',
 'TicWatch Pro 3 delivers Wear OS flexibility along with a battery-saving dual-display design.',
 'ACTIVE', '2021-11-01 09:00:00', '2023-12-09 09:00:00', 5),

(50, 'Fitbit Versa 4', 199.95, 15,
 'Fitness-first smartwatch · sleep & activity tracking',
 'Versa 4 is an approachable fitness smartwatch with simplified interface and good battery life.',
 'ACTIVE', '2022-09-20 09:00:00', '2023-12-10 09:00:00', 5);

-- Product Images (2 images per product, id 1-100)
INSERT INTO product_images (
    id, 
    product_id, 
    image_name,
    image_url, 
    position, 
    is_primary
    ) 
VALUES
-- For brevity use placeholder image paths pointing to /img/products/{productId}-{n}.jpg
(1, 1, 'iPhone 14 Pro Front', '/img/products/1-1.jpg', 1, TRUE),(2, 1, 'iPhone 14 Pro Back', '/img/products/1-2.jpg', 2, FALSE),
(3, 2, 'Galaxy S23 Front', '/img/products/2-1.jpg', 1, TRUE),(4, 2, 'Galaxy S23 Back', '/img/products/2-2.jpg', 2, FALSE),
(5, 3, 'Pixel 7 Front', '/img/products/3-1.jpg', 1, TRUE),(6, 3, 'Pixel 7 Back', '/img/products/3-2.jpg', 2, FALSE),
(7, 4, 'Xiaomi 13 Front', '/img/products/4-1.jpg', 1, TRUE),(8, 4, 'Xiaomi 13 Back', '/img/products/4-2.jpg', 2, FALSE),
(9, 5, 'OnePlus 11 Front', '/img/products/5-1.jpg', 1, TRUE),(10, 5, 'OnePlus 11 Back', '/img/products/5-2.jpg', 2, FALSE),
(11, 6, 'Sony Xperia 1 IV Front', '/img/products/6-1.jpg', 1, TRUE),(12, 6, 'Sony Xperia 1 IV Back', '/img/products/6-2.jpg', 2, FALSE),
(13, 7, 'OPPO Find X6 Pro Front', '/img/products/7-1.jpg', 1, TRUE),(14, 7, 'OPPO Find X6 Pro Back', '/img/products/7-2.jpg', 2, FALSE),
(15, 8, 'vivo X90 Pro Front', '/img/products/8-1.jpg', 1, TRUE),(16, 8, 'vivo X90 Pro Back', '/img/products/8-2.jpg', 2, FALSE),
(17, 9, 'Motorola Edge 40 Front', '/img/products/9-1.jpg', 1, TRUE),(18, 9, 'Motorola Edge 40 Back', '/img/products/9-2.jpg', 2, FALSE),
(19, 10, 'ASUS ROG Phone 7 Front', '/img/products/10-1.jpg', 1, TRUE),(20, 10, 'ASUS ROG Phone 7 Back', '/img/products/10-2.jpg', 2, FALSE),
(21, 11, 'MacBook Air M2 Front', '/img/products/11-1.jpg', 1, TRUE),(22, 11, 'MacBook Air M2 Side', '/img/products/11-2.jpg', 2, FALSE),
(23, 12, 'MacBook Pro 14 M2 Pro Front', '/img/products/12-1.jpg', 1, TRUE),(24, 12, 'MacBook Pro 14 M2 Pro Side', '/img/products/12-2.jpg', 2, FALSE),
(25, 13, 'Dell XPS 13 Plus Front', '/img/products/13-1.jpg', 1, TRUE),(26, 13, 'Dell XPS 13 Plus Side', '/img/products/13-2.jpg', 2, FALSE),
(27, 14, 'HP Spectre x360 14 Front', '/img/products/14-1.jpg', 1, TRUE),(28, 14, 'HP Spectre x360 14 Folded', '/img/products/14-2.jpg', 2, FALSE),
(29, 15, 'ThinkPad X1 Carbon Gen 11 Front', '/img/products/15-1.jpg', 1, TRUE),(30, 15, 'ThinkPad X1 Carbon Gen 11 Side', '/img/products/15-2.jpg', 2, FALSE),
(31, 16, 'ASUS ZenBook 14 Front', '/img/products/16-1.jpg', 1, TRUE),(32, 16, 'ASUS ZenBook 14 Side', '/img/products/16-2.jpg', 2, FALSE),
(33, 17, 'Acer Swift 3 Front', '/img/products/17-1.jpg', 1, TRUE),(34, 17, 'Acer Swift 3 Side', '/img/products/17-2.jpg', 2, FALSE),
(35, 18, 'Razer Blade 15 Front', '/img/products/18-1.jpg', 1, TRUE),(36, 18, 'Razer Blade 15 Side', '/img/products/18-2.jpg', 2, FALSE),
(37, 19, 'MSI GS66 Stealth Front', '/img/products/19-1.jpg', 1, TRUE),(38, 19, 'MSI GS66 Stealth Side', '/img/products/19-2.jpg', 2, FALSE),
(39, 20, 'Surface Laptop 5 Front', '/img/products/20-1.jpg', 1, TRUE),(40, 20, 'Surface Laptop 5 Side', '/img/products/20-2.jpg', 2, FALSE),
(41, 21, 'iPad Pro 11 M2 Front', '/img/products/21-1.jpg', 1, TRUE),(42, 21, 'iPad Pro 11 M2 Back', '/img/products/21-2.jpg', 2, FALSE),
(43, 22, 'iPad Air 5th Gen Front', '/img/products/22-1.jpg', 1, TRUE),(44, 22, 'iPad Air 5th Gen Back', '/img/products/22-2.jpg', 2, FALSE),
(45, 23, 'Galaxy Tab S8 Front', '/img/products/23-1.jpg', 1, TRUE),(46, 23, 'Galaxy Tab S8 Back', '/img/products/23-2.jpg', 2, FALSE),
(47, 24, 'Tab P12 Pro Front', '/img/products/24-1.jpg', 1, TRUE),(48, 24, 'Tab P12 Pro Back', '/img/products/24-2.jpg', 2, FALSE),
(49, 25, 'MatePad Pro Front', '/img/products/25-1.jpg', 1, TRUE),(50, 25, 'MatePad Pro Back', '/img/products/25-2.jpg', 2, FALSE),
(51, 26, 'Fire HD 10 Front', '/img/products/26-1.jpg', 1, TRUE),(52, 26, 'Fire HD 10 Back', '/img/products/26-2.jpg', 2, FALSE),
(53, 27, 'Galaxy Tab A8 Front', '/img/products/27-1.jpg', 1, TRUE),(54, 27, 'Galaxy Tab A8 Back', '/img/products/27-2.jpg', 2, FALSE),
(55, 28, 'Surface Pro 9 Front', '/img/products/28-1.jpg', 1, TRUE),(56, 28, 'Surface Pro 9 With Keyboard', '/img/products/28-2.jpg', 2, FALSE),
(57, 29, 'Xiaomi Pad 6 Front', '/img/products/29-1.jpg', 1, TRUE),(58, 29, 'Xiaomi Pad 6 Back', '/img/products/29-2.jpg', 2, FALSE),
(59, 30, 'OPPO Pad Front', '/img/products/30-1.jpg', 1, TRUE),(60, 30, 'OPPO Pad Back', '/img/products/30-2.jpg', 2, FALSE),
(61, 31, 'Sony WH-1000XM5 Front', '/img/products/31-1.jpg', 1, TRUE),(62, 31, 'Sony WH-1000XM5 Side', '/img/products/31-2.jpg', 2, FALSE),
(63, 32, 'Bose QuietComfort 45 Front', '/img/products/32-1.jpg', 1, TRUE),(64, 32, 'Bose QuietComfort 45 Side', '/img/products/32-2.jpg', 2, FALSE),
(65, 33, 'Sennheiser Momentum 4 Front', '/img/products/33-1.jpg', 1, TRUE),(66, 33, 'Sennheiser Momentum 4 Side', '/img/products/33-2.jpg', 2, FALSE),
(67, 34, 'Apple AirPods Pro 2 Case', '/img/products/34-1.jpg', 1, TRUE),(68, 34, 'Apple AirPods Pro 2 Pod', '/img/products/34-2.jpg', 2, FALSE),
(69, 35, 'B&W PX7 S2 Front', '/img/products/35-1.jpg', 1, TRUE),(70, 35, 'B&W PX7 S2 Side', '/img/products/35-2.jpg', 2, FALSE),
(71, 36, 'Jabra Elite 85t Case', '/img/products/36-1.jpg', 1, TRUE),(72, 36, 'Jabra Elite 85t Pod', '/img/products/36-2.jpg', 2, FALSE),
(73, 37, 'Beats Studio3 Front', '/img/products/37-1.jpg', 1, TRUE),(74, 37, 'Beats Studio3 Side', '/img/products/37-2.jpg', 2, FALSE),
(75, 38, 'Anker Soundcore Liberty Case', '/img/products/38-1.jpg', 1, TRUE),(76, 38, 'Anker Soundcore Liberty Pod', '/img/products/38-2.jpg', 2, FALSE),
(77, 39, 'Samsung Galaxy Buds2 Pro Case', '/img/products/39-1.jpg', 1, TRUE),(78, 39, 'Samsung Galaxy Buds2 Pro Pod', '/img/products/39-2.jpg', 2, FALSE),
(79, 40, 'Sennheiser CX Plus Case', '/img/products/40-1.jpg', 1, TRUE),(80, 40, 'Sennheiser CX Plus Pod', '/img/products/40-2.jpg', 2, FALSE),
(81, 41, 'Apple Watch Series 8 Front', '/img/products/41-1.jpg', 1, TRUE),(82, 41, 'Apple Watch Series 8 Side', '/img/products/41-2.jpg', 2, FALSE),
(83, 42, 'Samsung Galaxy Watch5 Front', '/img/products/42-1.jpg', 1, TRUE),(84, 42, 'Samsung Galaxy Watch5 Side', '/img/products/42-2.jpg', 2, FALSE),
(85, 43, 'Garmin Forerunner 955 Front', '/img/products/43-1.jpg', 1, TRUE),(86, 43, 'Garmin Forerunner 955 Side', '/img/products/43-2.jpg', 2, FALSE),
(87, 44, 'Fitbit Sense 2 Front', '/img/products/44-1.jpg', 1, TRUE),(88, 44, 'Fitbit Sense 2 Side', '/img/products/44-2.jpg', 2, FALSE),
(89, 45, 'Huawei Watch GT 3 Front', '/img/products/45-1.jpg', 1, TRUE),(90, 45, 'Huawei Watch GT 3 Side', '/img/products/45-2.jpg', 2, FALSE),
(91, 46, 'Amazfit GTR 3 Pro Front', '/img/products/46-1.jpg', 1, TRUE),(92, 46, 'Amazfit GTR 3 Pro Side', '/img/products/46-2.jpg', 2, FALSE),
(93, 47, 'Polar Vantage V2 Front', '/img/products/47-1.jpg', 1, TRUE),(94, 47, 'Polar Vantage V2 Side', '/img/products/47-2.jpg', 2, FALSE),
(95, 48, 'Suunto 9 Peak Front', '/img/products/48-1.jpg', 1, TRUE),(96, 48, 'Suunto 9 Peak Side', '/img/products/48-2.jpg', 2, FALSE),
(97, 49, 'TicWatch Pro 3 Front', '/img/products/49-1.jpg', 1, TRUE),(98, 49, 'TicWatch Pro 3 Side', '/img/products/49-2.jpg', 2, FALSE),
(99, 50, 'Fitbit Versa 4 Front', '/img/products/50-1.jpg', 1, TRUE),(100, 50, 'Fitbit Versa 4 Side', '/img/products/50-2.jpg', 2, FALSE);

-- Product Details (sample attributes per product)
INSERT INTO product_details (
    product_id, 
    attribute_name, 
    attribute_value
    ) 
VALUES
-- Smartphone attributes
(1, 'Display', '6.1" Super Retina XDR'),
(1, 'Processor', 'A16 Bionic'),
(1, 'Camera', '48MP main, 12MP ultrawide, 12MP telephoto'),
(1, 'Battery', '3125 mAh'),
(1, 'RAM', '6 GB'),

(2, 'Display', '6.1" Dynamic AMOLED'),
(2, 'Processor', 'Snapdragon 8 Gen 2'),
(2, 'Camera', '50MP main'),
(2, 'Battery', '3900 mAh'),
(2, 'RAM', '8 GB'),

(3, 'Display', '6.3" OLED'),
(3, 'Processor', 'Google Tensor G2'),
(3, 'Camera', '50MP main'),
(3, 'Battery', '4355 mAh'),
(3, 'RAM', '8 GB'),

(4, 'Display', '6.36" AMOLED'),
(4, 'Processor', 'Snapdragon 8 Gen 2'),
(4, 'Camera', '50MP main with Leica tuning'),
(4, 'Battery', '4600 mAh'),
(4, 'RAM', '8 GB'),

(5, 'Display', '6.7" Fluid AMOLED'),
(5, 'Processor', 'Snapdragon 8 Gen 2'),
(5, 'Camera', '50MP main'),
(5, 'Battery', '5000 mAh'),
(5, 'RAM', '8 GB'),

(6, 'Display', '6.5" 4K HDR OLED'),
(6, 'Processor', 'Snapdragon 8 Gen 1'),
(6, 'Camera', '12MP main with pro controls'),
(6, 'Battery', '5000 mAh'),
(6, 'RAM', '12 GB'),

(7, 'Display', '6.8" LTPO AMOLED'),
(7, 'Processor', 'Snapdragon 8 Gen 2'),
(7, 'Camera', '50MP main'),
(7, 'Battery', '5000 mAh'),
(7, 'RAM', '12 GB'),

(8, 'Display', '6.78" AMOLED'),
(8, 'Processor', 'Dimensity 9200'),
(8, 'Camera', '50MP main with Zeiss optics'),
(8, 'Battery', '4860 mAh'),
(8, 'RAM', '12 GB'),

(9, 'Display', '6.55" pOLED'),
(9, 'Processor', 'Snapdragon 7 Gen 1'),
(9, 'Camera', '50MP main'),
(9, 'Battery', '4500 mAh'),
(9, 'RAM', '8 GB'),

(10, 'Display', '6.78" AMOLED 165Hz'),
(10, 'Processor', 'Snapdragon 8 Gen 2'),
(10, 'Camera', '64MP main'),
(10, 'Battery', '6000 mAh'),
(10, 'RAM', '16 GB'),

-- Laptop attributes
(11, 'Display', '13.6" Liquid Retina'),
(11, 'Processor', 'Apple M2'),
(11, 'RAM', '8 GB'),
(11, 'Storage', '256 GB SSD'),
(11, 'Battery Life', 'Up to 18 hours'),

(12, 'Display', '14.2" Liquid Retina XDR'),
(12, 'Processor', 'Apple M2 Pro'),
(12, 'RAM', '16 GB'),
(12, 'Storage', '512 GB SSD'),
(12, 'Battery Life', 'Up to 20 hours'),

(13, 'Display', '13.4" Bright OLED option'),
(13, 'Processor', '12th Gen Intel Core i7'),
(13, 'RAM', '16 GB'),
(13, 'Storage', '512 GB SSD'),
(13, 'Weight', '1.3 kg'),

(14, 'Display', '13.5" OLED option'),
(14, 'Processor', '12th Gen Intel Core i7'),
(14, 'RAM', '16 GB'),
(14, 'Storage', '512 GB SSD'),
(14, 'Convertible', 'Yes'),

(15, 'Display', '14" IPS'),
(15, 'Processor', 'Intel Core i7'),
(15, 'RAM', '16 GB'),
(15, 'Storage', '512 GB SSD'),
(15, 'Business Grade', 'Yes'),

(16, 'Display', '14" FHD'),
(16, 'Processor', 'AMD Ryzen 7'),
(16, 'RAM', '16 GB'),
(16, 'Storage', '512 GB SSD'),
(16, 'Weight', '1.1 kg'),

(17, 'Display', '14" FHD'),
(17, 'Processor', 'Intel Core i5/i7 options'),
(17, 'RAM', '8/16 GB'),
(17, 'Storage', '256/512 GB SSD'),
(17, 'Value', 'Yes'),

(18, 'Display', '15.6" 240Hz option'),
(18, 'Processor', 'Intel Core i9 options'),
(18, 'RAM', '32 GB'),
(18, 'GPU', 'NVIDIA RTX 40 series'),
(18, 'Cooling', 'Advanced vapor chamber'),

(19, 'Display', '15.6" 240Hz option'),
(19, 'Processor', 'Intel Core i9 options'),
(19, 'RAM', '32 GB'),
(19, 'GPU', 'NVIDIA RTX 40 series'),
(19, 'RGB Keyboard', 'Yes'),

(20, 'Display', '13.5" PixelSense Touch'),
(20, 'Processor', 'Intel Core i7'),
(20, 'RAM', '16 GB'),
(20, 'Storage', '512 GB SSD'),
(20, 'Pen Support', 'Optional'),

-- Tablet attributes
(21, 'Display', '11" Liquid Retina'),
(21, 'Processor', 'Apple M2'),
(21, 'Storage', '128/256 GB'),
(21, 'Pencil Support', 'Yes'),
(21, 'Cellular', 'Optional'),

(22, 'Display', '10.9" Liquid Retina'),
(22, 'Processor', 'Apple M1'),
(22, 'Storage', '64/256 GB'),
(22, 'Lightweight', 'Yes'),
(22, 'Pencil Support', 'Yes'),

(23, 'Display', '11" LCD'),
(23, 'Processor', 'Snapdragon 8 Gen 1'),
(23, 'RAM', '8 GB'),
(23, 'S Pen', 'Included'),
(23, 'Cellular', 'Optional'),

(24, 'Display', '12.6" AMOLED'),
(24, 'Processor', 'Snapdragon 870'),
(24, 'RAM', '8 GB'),
(24, 'Storage', '128/256 GB'),
(24, 'Keyboard', 'Optional'),

(25, 'Display', '12.6" LCD'),
(25, 'Processor', 'Kirin/Qualcomm variants'),
(25, 'Storage', '128 GB'),
(25, 'Battery', 'Large capacity'),
(25, 'HarmonyOS', 'Yes'),

(26, 'Display', '10.1" Full HD'),
(26, 'Processor', 'MediaTek Helio G95'),
(26, 'Storage', '32/64 GB'),
(26, 'Family Mode', 'Optimized'),
(26, 'Affordable', 'Yes'),

(27, 'Display', '10.5" Full HD'),
(27, 'Processor', 'Unisoc/Mediatek'),
(27, 'Storage', '32/64 GB'),
(27, 'Long Battery', 'Yes'),
(27, 'Value', 'Yes'),

(28, 'Display', '13" PixelSense'),
(28, 'Processor', 'Intel Core i7/ARM options'),
(28, 'RAM', '8/16 GB'),
(28, 'Detachable Keyboard', 'Yes'),
(28, 'Pen Support', 'Yes'),

(29, 'Display', '11" 144Hz option'),
(29, 'Processor', 'Snapdragon 870'),
(29, 'RAM', '6/8 GB'),
(29, 'Storage', '128/256 GB'),
(29, 'Battery', 'Strong endurance'),

(30, 'Display', '11.5" LCD'),
(30, 'Processor', 'MediaTek chipset'),
(30, 'RAM', '6 GB'),
(30, 'Storage', '128 GB'),
(30, 'Portable', 'Yes'),

-- Audio attributes
(31, 'Type', 'Over-ear'),
(31, 'ANC', 'Industry-leading'),
(31, 'Battery', 'Up to 30 hours'),
(31, 'Wireless', 'Bluetooth 5.2'),

(32, 'Type', 'Over-ear'),
(32, 'ANC', 'Balanced QC'),
(32, 'Comfort', 'High'),
(32, 'Battery', 'Up to 24 hours'),

(33, 'Type', 'Over-ear'),
(33, 'Audio', 'High-res tuned'),
(33, 'ANC', 'Adaptive'),
(33, 'Battery', 'Up to 60 hours'),

(34, 'Type', 'In-ear'),
(34, 'ANC', 'Yes'),
(34, 'Spatial Audio', 'Yes'),
(34, 'Battery', 'Up to 6 hours earbuds + extra from case'),

(35, 'Type', 'Over-ear'),
(35, 'Audio', 'Premium'),
(35, 'ANC', 'Adaptive'),
(35, 'Battery', 'Up to 25 hours'),

(36, 'Type', 'True wireless'),
(36, 'Customization', 'App EQ'),
(36, 'ANC', 'Yes'),
(36, 'Battery', 'Up to 7 hours'),

(37, 'Type', 'Over-ear'),
(37, 'Integration', 'Apple ecosystem'),
(37, 'Battery', 'Up to 22 hours'),
(37, 'Style', 'Bass-forward'),

(38, 'Type', 'True wireless'),
(38, 'ANC', 'Yes'),
(38, 'Battery', 'Up to 7 hours'),
(38, 'Value', 'High'),

(39, 'Type', 'In-ear'),
(39, 'Audio', 'Hi-Fi'),
(39, 'ANC', 'Yes'),
(39, 'Battery', 'Up to 5 hours earbuds + case'),

(40, 'Type', 'In-ear'),
(40, 'Audio', 'Clear tuning'),
(40, 'Battery', 'Up to 8 hours'),
(40, 'Value', 'High'),

-- Wearables attributes
(41, 'Compatibility', 'iPhone (best)'),
(41, 'Health', 'ECG, HR, Temperature'),
(41, 'Battery', 'Up to 18 hours'),
(41, 'Water Resistance', '50m'),

(42, 'Compatibility', 'Android/Smartphones'),
(42, 'Health', 'HR, Sleep, BioActive sensors'),
(42, 'Battery', 'Up to 40 hours'),

(43, 'Sport Focus', 'Multisport & triathlon'),
(43, 'Battery', 'Up to 2 weeks in smartwatch mode'),
(43, 'GPS', 'Multi-band GPS'),
(43, 'Training Tools', 'Advanced'),

(44, 'Health', 'Stress & HRV tracking'),
(44, 'Battery', 'Up to 6+ days'),
(44, 'Sleep', 'Advanced'),

(45, 'Battery', 'Up to 14 days'),
(45, 'Health', 'HR & SpO2'),
(45, 'Design', 'Elegant'),

(46, 'Display', 'AMOLED'),
(46, 'Battery', 'Up to 12 days'),
(46, 'Health', 'Comprehensive sensors'),
(46, 'Value', 'High'),

(47, 'Sport Focus', 'Pro athletes'),
(47, 'Metrics', 'Running Power, Recovery'),
(47, 'Battery', 'Up to 7 days'),
(47, 'Weight', 'Lightweight'),

(48, 'Rugged', 'Yes'),
(48, 'Battery', 'Up to 7 days'),
(48, 'GPS', 'Accurate'),
(48, 'Design', 'Sturdy'),

(49, 'Display', 'Dual-layer'),
(49, 'Battery', 'Long-life modes'),
(49, 'OS', 'Wear OS'),
(49, 'Value', 'Yes'),

(50, 'Fitness', 'Activity & Sleep'),
(50, 'Battery', 'Up to 6+ days'),
(50, 'Compatibility', 'Android/iOS');

INSERT INTO cart (
    user_id, 
    product_id, 
    quantity, 
    created_at
    ) 
VALUES
(1, 1, 2, '2024-01-15 10:00:00'),
(1, 11, 1, '2024-01-15 10:05:00'),
(2, 3, 1, '2024-01-16 14:30:00'),
(2, 21, 1, '2024-01-16 14:35:00'),
(3, 31, 1, '2024-01-17 09:15:00'),
(3, 34, 2, '2024-01-17 09:20:00'),
(4, 41, 1, '2024-01-18 16:00:00');

INSERT INTO orders (
    id, 
    user_id, 
    total_price, 
    status, 
    shipping_address, 
    shipping_phone, 
    shipping_name, 
    created_at, 
    updated_at
    ) 
VALUES
(1, 1, 1998.00, 'PROCESSING', '123 Đường ABC, Quận 1, TP.HCM', '0901234567', 'Nguyễn Văn An', '2024-01-15 11:00:00', '2024-01-15 11:30:00'),
(2, 2, 599.00, 'PROCESSING', '456 Đường XYZ, Quận 2, TP.HCM', '0902345678', 'Trần Thị Bình', '2024-01-16 15:00:00', '2024-01-16 15:15:00'),
(3, 3, 897.00, 'SHIPPED', '789 Đường DEF, Quận 3, TP.HCM', '0903456789', 'Lê Hoàng Cường', '2024-01-17 10:00:00', '2024-01-17 10:30:00'),
(4, 4, 399.00, 'DELIVERED', '321 Đường GHI, Quận 4, TP.HCM', '0904567890', 'Phạm Minh Dũng', '2024-01-18 17:00:00', '2024-01-18 17:30:00');

INSERT INTO order_details (
    order_id, 
    product_id, 
    product_name, 
    product_price, 
    quantity, 
    subtotal, 
    created_at
    ) 
VALUES
-- Order 1: iPhone 14 Pro x2
(1, 1, 'Apple iPhone 14 Pro', 999.00, 2, 1798.20, '2024-01-15 11:05:00'),
-- Order 2: Google Pixel 7
(2, 3, 'Google Pixel 7', 599.00, 1, 509.15, '2024-01-16 15:05:00'),
-- Order 3: Sony WH-1000XM5 + AirPods Pro x2
(3, 31, 'Sony WH-1000XM5', 399.00, 1, 359.10, '2024-01-17 10:05:00'),
(3, 34, 'Apple AirPods Pro (2nd gen)', 249.00, 2, 448.20, '2024-01-17 10:06:00'),
-- Order 4: Apple Watch Series 8
(4, 41, 'Apple Watch Series 8', 399.00, 1, 399.00, '2024-01-18 17:05:00');

-- ============================================
-- INVENTORIES DATA
-- ============================================
INSERT INTO inventories (
    product_id,
    total_quantity,
    reserved_quantity
)
VALUES
-- Smartphones (id 1-10)
(1, 35, 0),
(2, 42, 0),
(3, 28, 0),
(4, 50, 0),
(5, 22, 0),
(6, 8, 0),
(7, 18, 0),
(8, 14, 0),
(9, 60, 0),
(10, 12, 0),
-- Laptops (id 11-20)
(11, 25, 0),
(12, 10, 0),
(13, 20, 0),
(14, 15, 0),
(15, 18, 0),
(16, 30, 0),
(17, 40, 0),
(18, 6, 0),
(19, 9, 0),
(20, 22, 0),
-- Tablets (id 21-30)
(21, 16, 0),
(22, 28, 0),
(23, 20, 0),
(24, 10, 0),
(25, 5, 0),
(26, 75, 0),
(27, 60, 0),
(28, 12, 0),
(29, 30, 0),
(30, 20, 0),
-- Audio & Headphones (id 31-40)
(31, 40, 0),
(32, 35, 0),
(33, 18, 0),
(34, 55, 0),
(35, 9, 0),
(36, 45, 0),
(37, 22, 0),
(38, 100, 0),
(39, 30, 0),
(40, 48, 0),
-- Wearables (id 41-50)
(41, 60, 0),
(42, 40, 0),
(43, 12, 0),
(44, 25, 0),
(45, 30, 0),
(46, 50, 0),
(47, 8, 0),
(48, 7, 0),
(49, 20, 0),
(50, 65, 0);

