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
('John Smith', 'john.smith@example.com', 'password123', '0901234567', '123 Main Street, District 1, Ho Chi Minh City', '2024-01-10 10:00:00'),
('Sarah Johnson', 'sarah.johnson@example.com', 'password123', '0902345678', '456 Oak Avenue, District 2, Ho Chi Minh City', '2024-01-11 10:00:00'),
('Michael Brown', 'michael.brown@example.com', 'password123', '0903456789', '789 Pine Road, District 3, Ho Chi Minh City', '2024-01-12 10:00:00'),
('Emily Davis', 'emily.davis@example.com', 'password123', '0904567890', '321 Maple Lane, District 4, Ho Chi Minh City', '2024-01-13 10:00:00'),
('Jessica Wilson', 'jessica.wilson@example.com', 'password123', '0905678901', '654 Cedar Street, District 5, Ho Chi Minh City', '2024-01-14 10:00:00');

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
-- BRANDS DATA - Fixed: Brands now independent of categories
-- ============================================
INSERT INTO brands (
    id,
    name,
    logo_url
    )
VALUES
(1, 'Apple', NULL),
(2, 'Samsung', NULL),
(3, 'Google', NULL),
(4, 'OnePlus', NULL),
(5, 'Xiaomi', NULL),
(6, 'Sony', NULL),
(7, 'ASUS', NULL),
(8, 'Nothing', NULL),
(9, 'Microsoft', NULL),
(10, 'Dell', NULL),
(11, 'HP', NULL),
(12, 'Lenovo', NULL),
(13, 'Acer', NULL),
(14, 'Razer', NULL),
(15, 'MSI', NULL),
(16, 'Gigabyte', NULL),
(17, 'LG', NULL),
(18, 'Bose', NULL),
(19, 'Sennheiser', NULL),
(20, 'Bowers & Wilkins', NULL),
(21, 'Beats', NULL),
(22, 'Soundcore', NULL),
(23, 'Jabra', NULL),
(24, 'JBL', NULL),
(25, 'Shure', NULL),
(26, 'Sonos', NULL),
(27, 'Technics', NULL),
(28, 'Marshall', NULL),
(29, 'Garmin', NULL),
(30, 'Fitbit', NULL),
(31, 'Oura', NULL),
(32, 'Huawei', NULL),
(33, 'Amazfit', NULL),
(34, 'Suunto', NULL),
(35, 'Polar', NULL),
(36, 'WHOOP', NULL),
(37, 'Amazon', NULL);

-- ============================================
-- PRODUCTS DATA
-- ============================================
INSERT INTO products (
    id,
    name,
    short_description,
    description,
    status,
    created_at,
    updated_at,
    category_id,
    brand_id
)
VALUES
-- Smartphones (id 1-20)
(1, 'Apple iPhone 15 Pro',
 '6.1" LTPO Super Retina XDR - A17 Pro - Titanium',
 'iPhone 15 Pro features a titanium design, A17 Pro performance, ProRAW 48MP camera system, USB-C, and an adaptive 1-120Hz display.',
 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 1, 1),

(2, 'Apple iPhone 15',
 '6.1" Super Retina XDR - A16 Bionic - USB-C',
 'iPhone 15 brings Dynamic Island, a 48MP main camera, A16 Bionic performance, USB-C, and strong all-day battery life.',
 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 1, 1),

(3, 'Samsung Galaxy S24 Ultra',
 '6.8" QHD+ LTPO AMOLED - Snapdragon 8 Gen 3 - 200MP',
 'Galaxy S24 Ultra combines a titanium frame, 200MP camera, S Pen, and Galaxy AI features with flagship performance.',
 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 1, 2),

(4, 'Samsung Galaxy S24',
 '6.2" FHD+ AMOLED - Snapdragon 8 Gen 3/Exynos 2400',
 'Galaxy S24 delivers compact flagship power, a bright 120Hz display, versatile cameras, and Galaxy AI features.',
 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 1, 2),

(5, 'Google Pixel 8 Pro',
 '6.7" LTPO OLED - Tensor G3 - Pro AI camera',
 'Pixel 8 Pro adds advanced AI tools, a 120Hz LTPO display, pro camera controls, and long-term software support.',
 'ACTIVE', '2023-10-12 09:00:00', '2024-06-01 10:00:00', 1, 3),

(6, 'Google Pixel 8',
 '6.2" OLED 120Hz - Tensor G3 - 50MP camera',
 'Pixel 8 combines Tensor G3 performance, a smooth 120Hz display, and excellent computational photography.',
 'ACTIVE', '2023-10-12 09:00:00', '2024-06-01 10:00:00', 1, 3),

(7, 'OnePlus 12',
 '6.82" LTPO AMOLED - Snapdragon 8 Gen 3 - 100W',
 'OnePlus 12 offers a large bright display, strong battery life, fast charging, and Hasselblad-tuned cameras.',
 'ACTIVE', '2024-01-23 09:00:00', '2024-06-01 10:00:00', 1, 4),

(8, 'Xiaomi 14',
 '6.36" LTPO AMOLED - Snapdragon 8 Gen 3 - Leica',
 'Xiaomi 14 pairs compact flagship hardware with Leica optics, fast charging, and HyperOS refinements.',
 'ACTIVE', '2023-10-26 09:00:00', '2024-06-01 10:00:00', 1, 5),

(9, 'Sony Xperia 1 V',
 '6.5" 4K OLED 120Hz - Snapdragon 8 Gen 2',
 'Xperia 1 V targets creators with a 4K 21:9 OLED display, pro photo/video apps, and manual controls.',
 'ACTIVE', '2023-05-11 09:00:00', '2024-06-01 10:00:00', 1, 6),

(10, 'ASUS ROG Phone 8 Pro',
 '6.78" AMOLED 165Hz - Snapdragon 8 Gen 3 - Gaming',
 'ROG Phone 8 Pro focuses on gaming with a 165Hz display, advanced cooling, and a large battery.',
 'ACTIVE', '2024-01-08 09:00:00', '2024-06-01 10:00:00', 1, 7),

(11, 'Apple iPhone 15 Pro Max',
 '6.7" LTPO Super Retina XDR - A17 Pro - 5x zoom',
 'iPhone 15 Pro Max adds a 5x tetraprism camera, titanium build, USB-C, and top-tier performance.',
 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 1, 1),

(12, 'Apple iPhone 14 Pro',
 '6.1" LTPO Super Retina XDR - A16 Bionic',
 'iPhone 14 Pro introduced Dynamic Island, a 48MP main camera, and always-on display.',
 'ACTIVE', '2022-09-16 10:00:00', '2024-06-01 10:00:00', 1, 1),

(13, 'Samsung Galaxy Z Fold5',
 '7.6" foldable AMOLED - Snapdragon 8 Gen 2 - S Pen',
 'Galaxy Z Fold5 offers a large foldable display, multitasking features, and flagship cameras.',
 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 1, 2),

(14, 'Samsung Galaxy Z Flip5',
 '6.7" foldable AMOLED - Snapdragon 8 Gen 2 - Flex',
 'Galaxy Z Flip5 features a larger cover screen, compact foldable design, and versatile cameras.',
 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 1, 2),

(15, 'Samsung Galaxy S24+',
 '6.7" QHD+ AMOLED - Snapdragon 8 Gen 3/Exynos',
 'Galaxy S24+ delivers a larger QHD+ display, strong battery life, and Galaxy AI features.',
 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 1, 2),

(16, 'Google Pixel 8a',
 '6.1" OLED 120Hz - Tensor G3 - 64MP camera',
 'Pixel 8a brings Pixel AI features and flagship-quality photography at a more accessible price.',
 'ACTIVE', '2024-05-14 09:00:00', '2024-06-01 10:00:00', 1, 3),

(17, 'Xiaomi 14 Ultra',
 '6.73" LTPO AMOLED - Snapdragon 8 Gen 3 - Leica',
 'Xiaomi 14 Ultra delivers a 1-inch main sensor, pro zoom lenses, and fast wired charging.',
 'ACTIVE', '2024-02-22 09:00:00', '2024-06-01 10:00:00', 1, 5),

(18, 'OnePlus 12R',
 '6.78" LTPO AMOLED - Snapdragon 8 Gen 2 - 5500mAh',
 'OnePlus 12R focuses on value with a large LTPO display, strong performance, and long battery life.',
 'ACTIVE', '2024-02-06 09:00:00', '2024-06-01 10:00:00', 1, 4),

(19, 'Nothing Phone (2)',
 '6.7" LTPO OLED - Snapdragon 8+ Gen 1 - Glyph',
 'Nothing Phone (2) combines the Glyph interface with clean software, a bright display, and solid cameras.',
 'ACTIVE', '2023-07-17 09:00:00', '2024-06-01 10:00:00', 1, 8),

(20, 'Sony Xperia 5 V',
 '6.1" OLED 120Hz - Snapdragon 8 Gen 2 - 21:9',
 'Xperia 5 V offers a compact 21:9 OLED display, pro camera tools, and Sony imaging expertise.',
 'ACTIVE', '2023-09-01 09:00:00', '2024-06-01 10:00:00', 1, 6);

-- Tablets (id 21-40)
INSERT INTO products (
    id,
    name,
    short_description,
    description,
    status,
    created_at,
    updated_at,
    category_id,
    brand_id
)
VALUES
(21, 'Apple iPad Pro 11 (M4, 2024)',
 '11" Ultra Retina XDR OLED - Apple M4 - 120Hz',
 'iPad Pro 11-inch (M4) delivers an Ultra Retina XDR OLED display, M4 performance, Apple Pencil Pro support, and Thunderbolt/USB-C.',
 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 3, 1),

(22, 'Apple iPad Pro 13 (M4, 2024)',
 '13" Ultra Retina XDR OLED - Apple M4 - 120Hz',
 'iPad Pro 13-inch (M4) combines a large Ultra Retina XDR OLED screen with M4 power, pro apps, and Thunderbolt/USB-C.',
 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 3, 1),

(23, 'Apple iPad Air 11 (M2, 2024)',
 '11" Liquid Retina - Apple M2 - USB-C',
 'iPad Air 11-inch (M2) balances performance and portability with a Liquid Retina display, M2 chip, and Apple Pencil support.',
 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 3, 1),

(24, 'Apple iPad Air 13 (M2, 2024)',
 '13" Liquid Retina - Apple M2 - USB-C',
 'iPad Air 13-inch (M2) offers a larger Liquid Retina display, M2 performance, and a slim lightweight design.',
 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 3, 1),

(25, 'Apple iPad (10th generation)',
 '10.9" Liquid Retina - A14 Bionic - USB-C',
 'iPad (10th gen) features a 10.9-inch Liquid Retina display, A14 Bionic, USB-C, and a modern all-screen design.',
 'ACTIVE', '2022-10-26 10:00:00', '2024-06-01 10:00:00', 3, 1),

(26, 'Apple iPad mini (6th generation)',
 '8.3" Liquid Retina - A15 Bionic - USB-C',
 'iPad mini (6th gen) packs A15 Bionic power into a compact 8.3-inch Liquid Retina design with Apple Pencil support.',
 'ACTIVE', '2021-09-24 10:00:00', '2024-06-01 10:00:00', 3, 1),

(27, 'Samsung Galaxy Tab S9 Ultra',
 '14.6" AMOLED 120Hz - Snapdragon 8 Gen 2 - S Pen',
 'Galaxy Tab S9 Ultra delivers a massive AMOLED display, S Pen support, flagship performance, and premium audio.',
 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 3, 2),

(28, 'Samsung Galaxy Tab S9+',
 '12.4" AMOLED 120Hz - Snapdragon 8 Gen 2 - S Pen',
 'Galaxy Tab S9+ offers a vibrant 12.4-inch AMOLED display, S Pen, and powerful Snapdragon 8 Gen 2 performance.',
 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 3, 2),

(29, 'Samsung Galaxy Tab S9',
 '11" AMOLED 120Hz - Snapdragon 8 Gen 2 - S Pen',
 'Galaxy Tab S9 pairs a sharp AMOLED display with flagship Snapdragon performance and S Pen productivity.',
 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 3, 2),

(30, 'Samsung Galaxy Tab S9 FE',
 '10.9" LCD 90Hz - Exynos 1380 - S Pen',
 'Galaxy Tab S9 FE provides a smooth 90Hz display, S Pen support, and great battery life for everyday use.',
 'ACTIVE', '2023-10-20 10:00:00', '2024-06-01 10:00:00', 3, 2),

(31, 'Samsung Galaxy Tab S9 FE+',
 '12.4" LCD 90Hz - Exynos 1380 - S Pen',
 'Galaxy Tab S9 FE+ adds a larger 12.4-inch display with S Pen support and solid all-day battery life.',
 'ACTIVE', '2023-10-20 10:00:00', '2024-06-01 10:00:00', 3, 2),

(32, 'Microsoft Surface Pro 11',
 '13" OLED 120Hz - Snapdragon X Elite - 2-in-1',
 'Surface Pro 11 is a premium 2-in-1 with a 120Hz OLED display, Snapdragon X performance, and all-day mobility.',
 'ACTIVE', '2024-06-18 10:00:00', '2024-06-18 10:00:00', 3, 9),

(33, 'Microsoft Surface Go 4',
 '10.5" PixelSense - Intel N200 - 2-in-1',
 'Surface Go 4 delivers a compact 2-in-1 form factor with a crisp PixelSense display and improved performance.',
 'ACTIVE', '2023-10-03 10:00:00', '2024-06-01 10:00:00', 3, 9),

(34, 'Lenovo Tab P12',
 '12.7" 3K LCD - Dimensity 7050 - Pen support',
 'Tab P12 features a large 3K display, quad speakers, and optional pen support for media and productivity.',
 'ACTIVE', '2023-08-01 10:00:00', '2024-06-01 10:00:00', 3, 12),

(35, 'Lenovo Tab P11 Pro (2nd Gen)',
 '11.2" OLED 120Hz - Kompanio 1300T',
 'Tab P11 Pro (2nd Gen) offers a vivid OLED screen, premium audio, and smooth performance for entertainment.',
 'ACTIVE', '2022-09-01 10:00:00', '2024-06-01 10:00:00', 3, 12),

(36, 'Xiaomi Pad 6',
 '11" 144Hz - Snapdragon 870 - Quad speakers',
 'Xiaomi Pad 6 combines a 144Hz display with Snapdragon 870 performance and quad speakers for immersive media.',
 'ACTIVE', '2023-04-18 10:00:00', '2024-06-01 10:00:00', 3, 5),

(37, 'OnePlus Pad',
 '11.61" 144Hz - Dimensity 9000 - Quad speakers',
 'OnePlus Pad delivers a smooth 144Hz display, Dimensity 9000 power, and a slim aluminum design.',
 'ACTIVE', '2023-04-28 10:00:00', '2024-06-01 10:00:00', 3, 4),

(38, 'Huawei MatePad Pro 13.2',
 '13.2" OLED 144Hz - Kirin 9000S',
 'MatePad Pro 13.2 offers a large OLED display, premium build, and strong productivity features.',
 'ACTIVE', '2023-12-12 10:00:00', '2024-06-01 10:00:00', 3, 32),

(39, 'Amazon Fire Max 11',
 '11" 2K LCD - MT8188J - Alexa',
 'Fire Max 11 provides a large 2K display, Alexa integration, and solid battery life for entertainment.',
 'ACTIVE', '2023-06-14 10:00:00', '2024-06-01 10:00:00', 3, 37),

(40, 'Google Pixel Tablet',
 '10.95" LCD - Tensor G2 - Charging speaker dock',
 'Pixel Tablet combines a bright display with Tensor G2 power and a speaker dock for smart-home use.',
 'ACTIVE', '2023-06-20 10:00:00', '2024-06-01 10:00:00', 3, 3);

-- Laptops (id 41-60)
INSERT INTO products (
    id,
    name,
    short_description,
    description,
    status,
    created_at,
    updated_at,
    category_id,
    brand_id
)
VALUES
(41, 'Apple MacBook Pro 14 (M3 Pro, 2023)',
 '14.2" Liquid Retina XDR - M3 Pro - 120Hz ProMotion',
 'MacBook Pro 14 with M3 Pro delivers pro-class CPU/GPU performance, Liquid Retina XDR display, long battery life, and a wide port selection including HDMI and SDXC.',
 'ACTIVE', '2023-10-30 09:00:00', '2024-06-10 10:00:00', 2, 1),

(42, 'Apple MacBook Air 15 (M3, 2024)',
 '15.3" Liquid Retina display - M3 - Fanless design',
 'MacBook Air 15 with M3 offers a large, color-accurate display, silent fanless operation, all-day battery life, and a thin-and-light aluminum chassis.',
 'ACTIVE', '2024-03-08 09:00:00', '2024-06-05 10:00:00', 2, 1),

(43, 'Dell XPS 14 (9440, 2024)',
 '14.5" 3.2K OLED - Core Ultra - Premium build',
 'XPS 14 pairs Intel Core Ultra with a vivid OLED display, premium CNC aluminum chassis, and a clean minimal design for creators and professionals.',
 'ACTIVE', '2024-02-15 09:00:00', '2024-06-01 10:00:00', 2, 10),

(44, 'Dell XPS 13 (9340, 2024)',
 '13.4" FHD+/OLED - Core Ultra - Ultra-portable',
 'XPS 13 delivers ultra-portability with Intel Core Ultra performance, long battery life, and a compact chassis with a high-quality display.',
 'ACTIVE', '2024-02-10 09:00:00', '2024-05-20 10:00:00', 2, 10),

(45, 'HP Spectre x360 14 (2024)',
 '14" 2.8K OLED - Core Ultra - 2-in-1',
 'Spectre x360 14 is a premium convertible with OLED display, strong speakers, pen support, and flexible 360-degree hinge for tablet mode.',
 'ACTIVE', '2024-01-20 09:00:00', '2024-05-25 10:00:00', 2, 11),

(46, 'Lenovo ThinkPad X1 Carbon Gen 12 (2024)',
 '14" 2.8K OLED - Core Ultra - Carbon-fiber chassis',
 'ThinkPad X1 Carbon Gen 12 is a business flagship with robust security, legendary keyboard, lightweight carbon-fiber build, and Intel Core Ultra efficiency.',
 'ACTIVE', '2024-02-01 09:00:00', '2024-05-30 10:00:00', 2, 12),

(47, 'Lenovo ThinkPad X1 Yoga Gen 9 (2024)',
 '14" 2.8K OLED - Core Ultra - 2-in-1 business',
 'ThinkPad X1 Yoga Gen 9 combines a premium convertible design, pen support, enterprise security, and strong performance for professionals.',
 'ACTIVE', '2024-02-05 09:00:00', '2024-05-30 10:00:00', 2, 12),

(48, 'ASUS ROG Zephyrus G14 (2024)',
 '14" QHD+ 120Hz - Ryzen 9 - RTX graphics',
 'ROG Zephyrus G14 balances powerful gaming performance with a compact chassis, efficient thermals, and a high-refresh display.',
 'ACTIVE', '2024-03-01 09:00:00', '2024-06-15 10:00:00', 2, 7),

(49, 'ASUS ROG Zephyrus G16 (2024)',
 '16" OLED 240Hz - Core Ultra - RTX graphics',
 'ROG Zephyrus G16 delivers a stunning OLED display, strong gaming/creator performance, and a sleek aluminum design.',
 'ACTIVE', '2024-03-01 09:00:00', '2024-06-15 10:00:00', 2, 7),

(50, 'Acer Swift X 14 (2024)',
 '14.5" 2.8K OLED - Core Ultra - RTX 4050',
 'Swift X 14 targets creators with a color-accurate OLED screen, discrete RTX graphics, and a portable chassis.',
 'ACTIVE', '2024-02-20 09:00:00', '2024-05-10 10:00:00', 2, 13),

(51, 'Acer Swift Go 14 (2024)',
 '14" 2.8K OLED - Core Ultra - Lightweight',
 'Swift Go 14 offers a thin-and-light design with a sharp OLED display, modern ports, and solid battery life.',
 'ACTIVE', '2024-02-18 09:00:00', '2024-05-08 10:00:00', 2, 13),

(52, 'Microsoft Surface Laptop 6 (2024)',
 '13.5"/15" PixelSense - Core Ultra - Business',
 'Surface Laptop 6 for Business features a refined aluminum chassis, excellent keyboard, and Intel Core Ultra efficiency with enterprise security.',
 'ACTIVE', '2024-04-01 09:00:00', '2024-06-12 10:00:00', 2, 9),

(53, 'Microsoft Surface Laptop Studio 2 (2023)',
 '14.4" 120Hz PixelSense - H-series - RTX',
 'Surface Laptop Studio 2 combines a unique pull-forward display, powerful H-series CPU and RTX graphics for creative workflows.',
 'ACTIVE', '2023-10-03 09:00:00', '2024-05-20 10:00:00', 2, 9),

(54, 'Razer Blade 16 (2024)',
 '16" QHD+ Mini-LED 240Hz - i9 - RTX 4080/4090',
 'Razer Blade 16 delivers high-end gaming performance in a premium CNC aluminum chassis with a fast Mini-LED display.',
 'ACTIVE', '2024-01-15 09:00:00', '2024-05-18 10:00:00', 2, 14),

(55, 'Razer Blade 14 (2024)',
 '14" QHD+ 240Hz - Ryzen 9 - RTX 4070',
 'Razer Blade 14 pairs strong gaming performance with a compact and portable metal chassis.',
 'ACTIVE', '2024-01-15 09:00:00', '2024-05-18 10:00:00', 2, 14),

(56, 'MSI Stealth 16 Studio (2024)',
 '16" QHD+ 240Hz - Core i9 - RTX Studio',
 'Stealth 16 Studio blends creator-grade performance with a sleek chassis, high-refresh display, and strong connectivity.',
 'ACTIVE', '2024-02-08 09:00:00', '2024-05-22 10:00:00', 2, 15),

(57, 'MSI Raider GE78 HX (2024)',
 '17" QHD+ 240Hz - Core i9 HX - RTX 4090',
 'Raider GE78 HX is a desktop-replacement gaming powerhouse with high-wattage GPU and extensive cooling.',
 'ACTIVE', '2024-02-08 09:00:00', '2024-05-22 10:00:00', 2, 15),

(58, 'Gigabyte AORUS 16X (2024)',
 '16" QHD+ 165Hz - Core i7/Ultra - RTX 4070',
 'AORUS 16X offers a balanced gaming setup with a high-refresh display, strong thermals, and fast storage.',
 'ACTIVE', '2024-02-12 09:00:00', '2024-05-12 10:00:00', 2, 16),

(59, 'Samsung Galaxy Book4 Pro 14 (2024)',
 '14" 3K AMOLED - Core Ultra - Ultra-light',
 'Galaxy Book4 Pro 14 features a vibrant AMOLED display, long battery life, and a lightweight magnesium chassis.',
 'ACTIVE', '2024-02-26 09:00:00', '2024-05-15 10:00:00', 2, 2),

(60, 'LG Gram 16 (2024)',
 '16" WQXGA - Core Ultra - 1.2kg class',
 'LG Gram 16 prioritizes portability with a large, sharp display, long battery life, and ultralight design.',
 'ACTIVE', '2024-02-25 09:00:00', '2024-05-15 10:00:00', 2, 17);

-- Audio & Headphones (id 61-80)
INSERT INTO products (
    id,
    name,
    short_description,
    description,
    status,
    created_at,
    updated_at,
    category_id,
    brand_id
)
VALUES
(61, 'Sony WH-1000XM5',
 'Over-ear ANC - 30mm drivers - 30h battery',
 'WH-1000XM5 delivers top-tier active noise cancellation, warm balanced tuning, and long battery life with multipoint Bluetooth.',
 'ACTIVE', '2023-05-15 09:00:00', '2024-06-01 10:00:00', 4, 6),

(62, 'Bose QuietComfort Ultra Headphones',
 'Over-ear ANC - Immersive Audio - 24h battery',
 'QuietComfort Ultra Headphones offer powerful noise cancellation, spacious sound, and soft all-day comfort.',
 'ACTIVE', '2023-10-05 09:00:00', '2024-06-01 10:00:00', 4, 18),

(63, 'Apple AirPods Pro (2nd gen, USB-C)',
 'In-ear ANC - Adaptive Audio - MagSafe',
 'AirPods Pro (2nd gen) with USB-C provide strong ANC, Adaptive Transparency, spatial audio, and seamless Apple device pairing.',
 'ACTIVE', '2023-09-22 09:00:00', '2024-06-01 10:00:00', 4, 1),

(64, 'Sennheiser MOMENTUM 4 Wireless',
 'Over-ear ANC - 60h battery - aptX Adaptive',
 'Momentum 4 Wireless combines long battery life with punchy, detailed sound and adaptive noise cancellation.',
 'ACTIVE', '2022-08-23 09:00:00', '2024-06-01 10:00:00', 4, 19),

(65, 'Bowers & Wilkins Px7 S2e',
 'Over-ear ANC - 40mm drivers - 30h battery',
 'Px7 S2e delivers refined tuning, premium materials, and strong ANC for high-end wireless listening.',
 'ACTIVE', '2023-10-04 09:00:00', '2024-06-01 10:00:00', 4, 20),

(66, 'Bose QuietComfort Ultra Earbuds',
 'True wireless ANC - Immersive Audio - USB-C',
 'QC Ultra Earbuds feature class-leading noise cancellation, immersive audio, and a compact charging case.',
 'ACTIVE', '2023-10-05 09:00:00', '2024-06-01 10:00:00', 4, 18),

(67, 'Sony WF-1000XM5',
 'True wireless ANC - LDAC - 8h battery',
 'WF-1000XM5 offers flagship ANC, rich sound with LDAC, and improved comfort in a smaller shell.',
 'ACTIVE', '2023-07-24 09:00:00', '2024-06-01 10:00:00', 4, 6),

(68, 'Apple AirPods Max',
 'Over-ear ANC - Spatial Audio - Aluminum build',
 'AirPods Max delivers premium build quality, strong ANC, and spatial audio with dynamic head tracking.',
 'ACTIVE', '2020-12-15 09:00:00', '2024-06-01 10:00:00', 4, 1),

(69, 'Beats Studio Pro',
 'Over-ear ANC - USB-C lossless - 40h battery',
 'Beats Studio Pro adds USB-C lossless audio, improved ANC, and long battery life in a lightweight design.',
 'ACTIVE', '2023-07-19 09:00:00', '2024-06-01 10:00:00', 4, 21),

(70, 'Soundcore Liberty 4 NC',
 'True wireless ANC - Hi-Res Audio - 10h battery',
 'Liberty 4 NC offers strong ANC, solid sound, and long battery life at a competitive price.',
 'ACTIVE', '2023-06-29 09:00:00', '2024-06-01 10:00:00', 4, 22),

(71, 'Jabra Elite 10',
 'True wireless ANC - Dolby Atmos - 8h battery',
 'Elite 10 features all-day comfort, Dolby Atmos with head tracking, and improved call quality.',
 'ACTIVE', '2023-09-01 09:00:00', '2024-06-01 10:00:00', 4, 23),

(72, 'Samsung Galaxy Buds2 Pro',
 'True wireless ANC - 24-bit audio - IPX7',
 'Galaxy Buds2 Pro provides strong ANC, 24-bit audio on compatible Galaxy devices, and a compact fit.',
 'ACTIVE', '2022-08-26 09:00:00', '2024-06-01 10:00:00', 4, 2),

(73, 'Google Pixel Buds Pro',
 'True wireless ANC - Multipoint - 11h battery',
 'Pixel Buds Pro offers great noise cancellation, multipoint Bluetooth, and tight Google Assistant integration.',
 'ACTIVE', '2022-07-21 09:00:00', '2024-06-01 10:00:00', 4, 3),

(74, 'Nothing Ear (2024)',
 'True wireless ANC - Hi-Res Audio - 8.5h battery',
 'Nothing Ear (2024) delivers clear sound with LDAC, customizable EQ, and a transparent design.',
 'ACTIVE', '2024-04-18 09:00:00', '2024-06-01 10:00:00', 4, 8),

(75, 'JBL Tour One M2',
 'Over-ear ANC - 50h battery - Spatial Audio',
 'Tour One M2 combines strong ANC, deep bass, and very long battery life for travel.',
 'ACTIVE', '2023-01-05 09:00:00', '2024-06-01 10:00:00', 4, 24),

(76, 'Shure AONIC 50 Gen 2',
 'Over-ear ANC - Hi-Res Audio - 45h battery',
 'AONIC 50 Gen 2 delivers studio-grade tuning with powerful ANC and robust codec support.',
 'ACTIVE', '2023-11-15 09:00:00', '2024-06-01 10:00:00', 4, 25),

(77, 'Sonos Ace',
 'Over-ear ANC - Spatial Audio - 30h battery',
 'Sonos Ace offers cinematic spatial audio, excellent ANC, and seamless integration with Sonos systems.',
 'ACTIVE', '2024-06-05 09:00:00', '2024-06-15 10:00:00', 4, 26),

(78, 'Technics EAH-AZ80',
 'True wireless ANC - Hi-Res Audio - 7h battery',
 'EAH-AZ80 delivers rich sound with LDAC and excellent call quality with multipoint connectivity.',
 'ACTIVE', '2023-06-15 09:00:00', '2024-06-01 10:00:00', 4, 27),

(79, 'Bose SoundLink Flex',
 'Portable Bluetooth speaker - IP67 - 12h battery',
 'SoundLink Flex is a rugged portable speaker with balanced sound, strong bass, and IP67 durability.',
 'ACTIVE', '2022-05-12 09:00:00', '2024-06-01 10:00:00', 4, 18),

(80, 'Marshall Motif II ANC',
 'True wireless ANC - 30h total battery - IPX5',
 'Motif II ANC combines signature Marshall tuning with ANC and a compact case for all-day listening.',
 'ACTIVE', '2023-09-12 09:00:00', '2024-06-01 10:00:00', 4, 28);

-- Wearables (id 81-100)
INSERT INTO products (
    id,
    name,
    short_description,
    description,
    status,
    created_at,
    updated_at,
    category_id,
    brand_id
)
VALUES
(81, 'Apple Watch Series 9',
 '41/45mm OLED - S9 SiP - Double Tap',
 'Apple Watch Series 9 adds the S9 SiP, a brighter 2000-nit display, on-device Siri, and Double Tap gestures with carbon-neutral case options.',
 'ACTIVE', '2023-09-22 10:00:00', '2024-06-20 10:00:00', 5, 1),

(82, 'Apple Watch Ultra 2',
 '49mm titanium - S9 SiP - 100m water',
 'Apple Watch Ultra 2 delivers a rugged titanium build, 3000-nit display, precision dual-frequency GPS, and up to 36-hour battery life.',
 'ACTIVE', '2023-09-22 10:00:00', '2024-06-20 10:00:00', 5, 1),

(83, 'Samsung Galaxy Watch6',
 '40/44mm Super AMOLED - Wear OS',
 'Galaxy Watch6 brings a larger display, improved health tracking, advanced sleep coaching, and Wear OS apps in a slimmer design.',
 'ACTIVE', '2023-07-26 10:00:00', '2024-06-20 10:00:00', 5, 2),

(84, 'Samsung Galaxy Watch6 Classic',
 '43/47mm Super AMOLED - Rotating bezel',
 'Watch6 Classic combines stainless steel, a rotating bezel, and enhanced health sensors with the Wear OS ecosystem.',
 'ACTIVE', '2023-07-26 10:00:00', '2024-06-20 10:00:00', 5, 2),

(85, 'Google Pixel Watch 2',
 '41mm AMOLED - Snapdragon W5 - Fitbit',
 'Pixel Watch 2 integrates Fitbit health features, improved sensors, and all-day battery life with Wear OS performance.',
 'ACTIVE', '2023-10-12 09:00:00', '2024-06-20 10:00:00', 5, 3),

(86, 'Garmin fēnix 7 Pro',
 '47/51mm MIP - Multi-band GPS - Solar',
 'fēnix 7 Pro adds a brighter flashlight, upgraded heart-rate sensor, and exceptional battery life for outdoor training.',
 'ACTIVE', '2023-05-31 09:00:00', '2024-06-20 10:00:00', 5, 29),

(87, 'Garmin Forerunner 965',
 '47mm AMOLED - Multi-band GPS',
 'Forerunner 965 offers an AMOLED display, training readiness, and advanced running metrics with long battery life.',
 'ACTIVE', '2023-03-01 09:00:00', '2024-06-20 10:00:00', 5, 29),

(88, 'Garmin Venu 3',
 '45/41mm AMOLED - Health & sleep',
 'Venu 3 focuses on health metrics, sleep coaching, and voice calling in a modern AMOLED smartwatch.',
 'ACTIVE', '2023-08-31 09:00:00', '2024-06-20 10:00:00', 5, 29),

(89, 'Fitbit Sense 2',
 'EDA stress sensor - ECG - AMOLED',
 'Sense 2 delivers stress management with cEDA, ECG app support, and comprehensive health insights.',
 'ACTIVE', '2022-09-23 09:00:00', '2024-06-20 10:00:00', 5, 30),

(90, 'Fitbit Charge 6',
 'AMOLED band - Built-in GPS',
 'Charge 6 adds improved heart-rate accuracy, Google apps, and built-in GPS in a slim fitness tracker.',
 'ACTIVE', '2023-09-28 09:00:00', '2024-06-20 10:00:00', 5, 30),

(91, 'Oura Ring Gen 3',
 'Smart ring - Sleep & readiness',
 'Oura Ring Gen 3 tracks sleep, readiness, and recovery with a lightweight titanium ring and accurate sensors.',
 'ACTIVE', '2022-10-26 09:00:00', '2024-06-20 10:00:00', 5, 31),

(92, 'Xiaomi Watch 2 Pro',
 '46mm AMOLED - Wear OS - LTE',
 'Watch 2 Pro combines Wear OS, LTE option, and dual-band GNSS in a premium design.',
 'ACTIVE', '2023-10-26 09:00:00', '2024-06-20 10:00:00', 5, 5),

(93, 'Huawei Watch GT 4',
 '41/46mm AMOLED - 2-week battery',
 'Watch GT 4 offers long battery life, accurate GNSS, and health tracking in a stylish body.',
 'ACTIVE', '2023-09-14 09:00:00', '2024-06-20 10:00:00', 5, 32),

(94, 'Amazfit Balance',
 '46mm AMOLED - 14-day battery',
 'Amazfit Balance provides dual-band GPS, body composition metrics, and long battery life.',
 'ACTIVE', '2023-09-20 09:00:00', '2024-06-20 10:00:00', 5, 33),

(95, 'Suunto Vertical',
 'Rugged GPS - Solar options - Offline maps',
 'Suunto Vertical targets outdoor athletes with offline maps, solar charging options, and multi-band GNSS.',
 'ACTIVE', '2023-05-16 09:00:00', '2024-06-20 10:00:00', 5, 34),

(96, 'Polar Vantage V3',
 '47mm AMOLED - Dual-frequency GPS',
 'Vantage V3 includes AMOLED display, ECG/SpO2, and advanced training tools for endurance athletes.',
 'ACTIVE', '2023-10-11 09:00:00', '2024-06-20 10:00:00', 5, 35),

(97, 'Apple Watch SE (2nd gen)',
 '40/44mm Retina - S8 SiP',
 'Apple Watch SE (2nd gen) offers core Apple Watch features with S8 SiP, crash detection, and watchOS support.',
 'ACTIVE', '2022-09-16 10:00:00', '2024-06-20 10:00:00', 5, 1),

(98, 'Samsung Galaxy Watch5 Pro',
 '45mm sapphire - Long battery',
 'Watch5 Pro delivers rugged durability, sapphire crystal, and extended battery life for outdoor use.',
 'ACTIVE', '2022-08-26 09:00:00', '2024-06-20 10:00:00', 5, 2),

(99, 'WHOOP 4.0',
 'Screenless fitness band - Recovery',
 'WHOOP 4.0 provides continuous recovery, strain, and sleep coaching with a screenless wearable.',
 'ACTIVE', '2021-09-08 09:00:00', '2024-06-20 10:00:00', 5, 36),

(100, 'Samsung Galaxy Ring',
 'Titanium smart ring - Sleep & health',
 'Galaxy Ring tracks sleep, activity, and wellness in a lightweight titanium ring with long battery life.',
 'ACTIVE', '2024-07-10 09:00:00', '2024-07-10 09:00:00', 5, 2);

-- Product Images (2-3 images per product, id 1-200)
INSERT INTO product_images (
    id,
    product_id,
    image_name,
    image_url,
    position,
    is_primary
    )
VALUES
-- Placeholder paths /img/products/{productId}-{n}.jpg
(1, 1, 'Apple iPhone 15 Pro Front', '/img/products/1-1.jpg', 1, TRUE),
(2, 1, 'Apple iPhone 15 Pro Back', '/img/products/1-2.jpg', 2, FALSE),
(3, 2, 'Apple iPhone 15 Front', '/img/products/2-1.jpg', 1, TRUE),
(4, 2, 'Apple iPhone 15 Back', '/img/products/2-2.jpg', 2, FALSE),
(5, 3, 'Samsung Galaxy S24 Ultra Front', '/img/products/3-1.jpg', 1, TRUE),
(6, 3, 'Samsung Galaxy S24 Ultra Back', '/img/products/3-2.jpg', 2, FALSE),
(7, 4, 'Samsung Galaxy S24 Front', '/img/products/4-1.jpg', 1, TRUE),
(8, 4, 'Samsung Galaxy S24 Back', '/img/products/4-2.jpg', 2, FALSE),
(9, 5, 'Google Pixel 8 Pro Front', '/img/products/5-1.jpg', 1, TRUE),
(10, 5, 'Google Pixel 8 Pro Back', '/img/products/5-2.jpg', 2, FALSE),
(11, 6, 'Google Pixel 8 Front', '/img/products/6-1.jpg', 1, TRUE),
(12, 6, 'Google Pixel 8 Back', '/img/products/6-2.jpg', 2, FALSE),
(13, 7, 'OnePlus 12 Front', '/img/products/7-1.jpg', 1, TRUE),
(14, 7, 'OnePlus 12 Back', '/img/products/7-2.jpg', 2, FALSE),
(15, 8, 'Xiaomi 14 Front', '/img/products/8-1.jpg', 1, TRUE),
(16, 8, 'Xiaomi 14 Back', '/img/products/8-2.jpg', 2, FALSE),
(17, 9, 'Sony Xperia 1 V Front', '/img/products/9-1.jpg', 1, TRUE),
(18, 9, 'Sony Xperia 1 V Back', '/img/products/9-2.jpg', 2, FALSE),
(19, 10, 'ASUS ROG Phone 8 Pro Front', '/img/products/10-1.jpg', 1, TRUE),
(20, 10, 'ASUS ROG Phone 8 Pro Back', '/img/products/10-2.jpg', 2, FALSE),
(21, 11, 'Apple iPhone 15 Pro Max Front', '/img/products/11-1.jpg', 1, TRUE),
(22, 11, 'Apple iPhone 15 Pro Max Back', '/img/products/11-2.jpg', 2, FALSE),
(23, 12, 'Apple iPhone 14 Pro Front', '/img/products/12-1.jpg', 1, TRUE),
(24, 12, 'Apple iPhone 14 Pro Back', '/img/products/12-2.jpg', 2, FALSE),
(25, 13, 'Samsung Galaxy Z Fold5 Folded', '/img/products/13-1.jpg', 1, TRUE),
(26, 13, 'Samsung Galaxy Z Fold5 Unfolded', '/img/products/13-2.jpg', 2, FALSE),
(27, 14, 'Samsung Galaxy Z Flip5 Closed', '/img/products/14-1.jpg', 1, TRUE),
(28, 14, 'Samsung Galaxy Z Flip5 Open', '/img/products/14-2.jpg', 2, FALSE),
(29, 15, 'Samsung Galaxy S24+ Front', '/img/products/15-1.jpg', 1, TRUE),
(30, 15, 'Samsung Galaxy S24+ Back', '/img/products/15-2.jpg', 2, FALSE),
(31, 16, 'Google Pixel 8a Front', '/img/products/16-1.jpg', 1, TRUE),
(32, 16, 'Google Pixel 8a Back', '/img/products/16-2.jpg', 2, FALSE),
(33, 17, 'Xiaomi 14 Ultra Front', '/img/products/17-1.jpg', 1, TRUE),
(34, 17, 'Xiaomi 14 Ultra Back', '/img/products/17-2.jpg', 2, FALSE),
(35, 18, 'OnePlus 12R Front', '/img/products/18-1.jpg', 1, TRUE),
(36, 18, 'OnePlus 12R Back', '/img/products/18-2.jpg', 2, FALSE),
(37, 19, 'Nothing Phone (2) Front', '/img/products/19-1.jpg', 1, TRUE),
(38, 19, 'Nothing Phone (2) Back', '/img/products/19-2.jpg', 2, FALSE),
(39, 20, 'Sony Xperia 5 V Front', '/img/products/20-1.jpg', 1, TRUE),
(40, 20, 'Sony Xperia 5 V Back', '/img/products/20-2.jpg', 2, FALSE),
(41, 21, 'Apple iPad Pro 11 Front', '/img/products/21-1.jpg', 1, TRUE),
(42, 21, 'Apple iPad Pro 11 Back', '/img/products/21-2.jpg', 2, FALSE),
(43, 22, 'Apple iPad Pro 13 Front', '/img/products/22-1.jpg', 1, TRUE),
(44, 22, 'Apple iPad Pro 13 Back', '/img/products/22-2.jpg', 2, FALSE),
(45, 23, 'Apple iPad Air 11 Front', '/img/products/23-1.jpg', 1, TRUE),
(46, 23, 'Apple iPad Air 11 Back', '/img/products/23-2.jpg', 2, FALSE),
(47, 24, 'Apple iPad Air 13 Front', '/img/products/24-1.jpg', 1, TRUE),
(48, 24, 'Apple iPad Air 13 Back', '/img/products/24-2.jpg', 2, FALSE),
(49, 25, 'Apple iPad 10th Gen Front', '/img/products/25-1.jpg', 1, TRUE),
(50, 25, 'Apple iPad 10th Gen Back', '/img/products/25-2.jpg', 2, FALSE),
(51, 26, 'Apple iPad mini 6 Front', '/img/products/26-1.jpg', 1, TRUE),
(52, 26, 'Apple iPad mini 6 Back', '/img/products/26-2.jpg', 2, FALSE),
(53, 27, 'Samsung Galaxy Tab S9 Ultra Front', '/img/products/27-1.jpg', 1, TRUE),
(54, 27, 'Samsung Galaxy Tab S9 Ultra Back', '/img/products/27-2.jpg', 2, FALSE),
(55, 28, 'Samsung Galaxy Tab S9+ Front', '/img/products/28-1.jpg', 1, TRUE),
(56, 28, 'Samsung Galaxy Tab S9+ Back', '/img/products/28-2.jpg', 2, FALSE),
(57, 29, 'Samsung Galaxy Tab S9 Front', '/img/products/29-1.jpg', 1, TRUE),
(58, 29, 'Samsung Galaxy Tab S9 Back', '/img/products/29-2.jpg', 2, FALSE),
(59, 30, 'Samsung Galaxy Tab S9 FE Front', '/img/products/30-1.jpg', 1, TRUE),
(60, 30, 'Samsung Galaxy Tab S9 FE Back', '/img/products/30-2.jpg', 2, FALSE),
(61, 31, 'Samsung Galaxy Tab S9 FE+ Front', '/img/products/31-1.jpg', 1, TRUE),
(62, 31, 'Samsung Galaxy Tab S9 FE+ Back', '/img/products/31-2.jpg', 2, FALSE),
(63, 32, 'Microsoft Surface Pro 11 Front', '/img/products/32-1.jpg', 1, TRUE),
(64, 32, 'Microsoft Surface Pro 11 Back', '/img/products/32-2.jpg', 2, FALSE),
(65, 33, 'Microsoft Surface Go 4 Front', '/img/products/33-1.jpg', 1, TRUE),
(66, 33, 'Microsoft Surface Go 4 Back', '/img/products/33-2.jpg', 2, FALSE),
(67, 34, 'Lenovo Tab P12 Front', '/img/products/34-1.jpg', 1, TRUE),
(68, 34, 'Lenovo Tab P12 Back', '/img/products/34-2.jpg', 2, FALSE),
(69, 35, 'Lenovo Tab P11 Pro Front', '/img/products/35-1.jpg', 1, TRUE),
(70, 35, 'Lenovo Tab P11 Pro Back', '/img/products/35-2.jpg', 2, FALSE),
(71, 36, 'Xiaomi Pad 6 Front', '/img/products/36-1.jpg', 1, TRUE),
(72, 36, 'Xiaomi Pad 6 Back', '/img/products/36-2.jpg', 2, FALSE),
(73, 37, 'OnePlus Pad Front', '/img/products/37-1.jpg', 1, TRUE),
(74, 37, 'OnePlus Pad Back', '/img/products/37-2.jpg', 2, FALSE),
(75, 38, 'Huawei MatePad Pro 13.2 Front', '/img/products/38-1.jpg', 1, TRUE),
(76, 38, 'Huawei MatePad Pro 13.2 Back', '/img/products/38-2.jpg', 2, FALSE),
(77, 39, 'Amazon Fire Max 11 Front', '/img/products/39-1.jpg', 1, TRUE),
(78, 39, 'Amazon Fire Max 11 Back', '/img/products/39-2.jpg', 2, FALSE),
(79, 40, 'Google Pixel Tablet Front', '/img/products/40-1.jpg', 1, TRUE),
(80, 40, 'Google Pixel Tablet Back', '/img/products/40-2.jpg', 2, FALSE),
(81, 41, 'Apple MacBook Pro 14 Front', '/img/products/41-1.jpg', 1, TRUE),
(82, 41, 'Apple MacBook Pro 14 Back', '/img/products/41-2.jpg', 2, FALSE),
(83, 42, 'Apple MacBook Air 15 Front', '/img/products/42-1.jpg', 1, TRUE),
(84, 42, 'Apple MacBook Air 15 Back', '/img/products/42-2.jpg', 2, FALSE),
(85, 43, 'Dell XPS 14 Front', '/img/products/43-1.jpg', 1, TRUE),
(86, 43, 'Dell XPS 14 Back', '/img/products/43-2.jpg', 2, FALSE),
(87, 44, 'Dell XPS 13 Front', '/img/products/44-1.jpg', 1, TRUE),
(88, 44, 'Dell XPS 13 Back', '/img/products/44-2.jpg', 2, FALSE),
(89, 45, 'HP Spectre x360 14 Front', '/img/products/45-1.jpg', 1, TRUE),
(90, 45, 'HP Spectre x360 14 Back', '/img/products/45-2.jpg', 2, FALSE),
(91, 46, 'ThinkPad X1 Carbon Gen 12 Front', '/img/products/46-1.jpg', 1, TRUE),
(92, 46, 'ThinkPad X1 Carbon Gen 12 Back', '/img/products/46-2.jpg', 2, FALSE),
(93, 47, 'ThinkPad X1 Yoga Gen 9 Front', '/img/products/47-1.jpg', 1, TRUE),
(94, 47, 'ThinkPad X1 Yoga Gen 9 Back', '/img/products/47-2.jpg', 2, FALSE),
(95, 48, 'ROG Zephyrus G14 Front', '/img/products/48-1.jpg', 1, TRUE),
(96, 48, 'ROG Zephyrus G14 Back', '/img/products/48-2.jpg', 2, FALSE),
(97, 49, 'ROG Zephyrus G16 Front', '/img/products/49-1.jpg', 1, TRUE),
(98, 49, 'ROG Zephyrus G16 Back', '/img/products/49-2.jpg', 2, FALSE),
(99, 50, 'Acer Swift X 14 Front', '/img/products/50-1.jpg', 1, TRUE),
(100, 50, 'Acer Swift X 14 Back', '/img/products/50-2.jpg', 2, FALSE),
(101, 51, 'Acer Swift Go 14 Front', '/img/products/51-1.jpg', 1, TRUE),
(102, 51, 'Acer Swift Go 14 Back', '/img/products/51-2.jpg', 2, FALSE),
(103, 52, 'Surface Laptop 6 Front', '/img/products/52-1.jpg', 1, TRUE),
(104, 52, 'Surface Laptop 6 Back', '/img/products/52-2.jpg', 2, FALSE),
(105, 53, 'Surface Laptop Studio 2 Front', '/img/products/53-1.jpg', 1, TRUE),
(106, 53, 'Surface Laptop Studio 2 Back', '/img/products/53-2.jpg', 2, FALSE),
(107, 54, 'Razer Blade 16 Front', '/img/products/54-1.jpg', 1, TRUE),
(108, 54, 'Razer Blade 16 Back', '/img/products/54-2.jpg', 2, FALSE),
(109, 55, 'Razer Blade 14 Front', '/img/products/55-1.jpg', 1, TRUE),
(110, 55, 'Razer Blade 14 Back', '/img/products/55-2.jpg', 2, FALSE),
(111, 56, 'MSI Stealth 16 Studio Front', '/img/products/56-1.jpg', 1, TRUE),
(112, 56, 'MSI Stealth 16 Studio Back', '/img/products/56-2.jpg', 2, FALSE),
(113, 57, 'MSI Raider GE78 HX Front', '/img/products/57-1.jpg', 1, TRUE),
(114, 57, 'MSI Raider GE78 HX Back', '/img/products/57-2.jpg', 2, FALSE),
(115, 58, 'Gigabyte AORUS 16X Front', '/img/products/58-1.jpg', 1, TRUE),
(116, 58, 'Gigabyte AORUS 16X Back', '/img/products/58-2.jpg', 2, FALSE),
(117, 59, 'Samsung Galaxy Book4 Pro 14 Front', '/img/products/59-1.jpg', 1, TRUE),
(118, 59, 'Samsung Galaxy Book4 Pro 14 Back', '/img/products/59-2.jpg', 2, FALSE),
(119, 60, 'LG Gram 16 Front', '/img/products/60-1.jpg', 1, TRUE),
(120, 60, 'LG Gram 16 Back', '/img/products/60-2.jpg', 2, FALSE),
(121, 61, 'Sony WH-1000XM5 Front', '/img/products/61-1.jpg', 1, TRUE),
(122, 61, 'Sony WH-1000XM5 Side', '/img/products/61-2.jpg', 2, FALSE),
(123, 62, 'Bose QuietComfort Ultra Headphones Front', '/img/products/62-1.jpg', 1, TRUE),
(124, 62, 'Bose QuietComfort Ultra Headphones Side', '/img/products/62-2.jpg', 2, FALSE),
(125, 63, 'Apple AirPods Pro (2nd gen) Case', '/img/products/63-1.jpg', 1, TRUE),
(126, 63, 'Apple AirPods Pro (2nd gen) Earbuds', '/img/products/63-2.jpg', 2, FALSE),
(127, 64, 'Sennheiser MOMENTUM 4 Front', '/img/products/64-1.jpg', 1, TRUE),
(128, 64, 'Sennheiser MOMENTUM 4 Side', '/img/products/64-2.jpg', 2, FALSE),
(129, 65, 'Bowers & Wilkins Px7 S2e Front', '/img/products/65-1.jpg', 1, TRUE),
(130, 65, 'Bowers & Wilkins Px7 S2e Side', '/img/products/65-2.jpg', 2, FALSE),
(131, 66, 'Bose QuietComfort Ultra Earbuds Case', '/img/products/66-1.jpg', 1, TRUE),
(132, 66, 'Bose QuietComfort Ultra Earbuds Earbuds', '/img/products/66-2.jpg', 2, FALSE),
(133, 67, 'Sony WF-1000XM5 Case', '/img/products/67-1.jpg', 1, TRUE),
(134, 67, 'Sony WF-1000XM5 Earbuds', '/img/products/67-2.jpg', 2, FALSE),
(135, 68, 'Apple AirPods Max Front', '/img/products/68-1.jpg', 1, TRUE),
(136, 68, 'Apple AirPods Max Side', '/img/products/68-2.jpg', 2, FALSE),
(137, 69, 'Beats Studio Pro Front', '/img/products/69-1.jpg', 1, TRUE),
(138, 69, 'Beats Studio Pro Side', '/img/products/69-2.jpg', 2, FALSE),
(139, 70, 'Soundcore Liberty 4 NC Case', '/img/products/70-1.jpg', 1, TRUE),
(140, 70, 'Soundcore Liberty 4 NC Earbuds', '/img/products/70-2.jpg', 2, FALSE),
(141, 71, 'Jabra Elite 10 Case', '/img/products/71-1.jpg', 1, TRUE),
(142, 71, 'Jabra Elite 10 Earbuds', '/img/products/71-2.jpg', 2, FALSE),
(143, 72, 'Samsung Galaxy Buds2 Pro Case', '/img/products/72-1.jpg', 1, TRUE),
(144, 72, 'Samsung Galaxy Buds2 Pro Earbuds', '/img/products/72-2.jpg', 2, FALSE),
(145, 73, 'Google Pixel Buds Pro Case', '/img/products/73-1.jpg', 1, TRUE),
(146, 73, 'Google Pixel Buds Pro Earbuds', '/img/products/73-2.jpg', 2, FALSE),
(147, 74, 'Nothing Ear (2024) Case', '/img/products/74-1.jpg', 1, TRUE),
(148, 74, 'Nothing Ear (2024) Earbuds', '/img/products/74-2.jpg', 2, FALSE),
(149, 75, 'JBL Tour One M2 Front', '/img/products/75-1.jpg', 1, TRUE),
(150, 75, 'JBL Tour One M2 Side', '/img/products/75-2.jpg', 2, FALSE),
(151, 76, 'Shure AONIC 50 Gen 2 Front', '/img/products/76-1.jpg', 1, TRUE),
(152, 76, 'Shure AONIC 50 Gen 2 Side', '/img/products/76-2.jpg', 2, FALSE),
(153, 77, 'Sonos Ace Front', '/img/products/77-1.jpg', 1, TRUE),
(154, 77, 'Sonos Ace Side', '/img/products/77-2.jpg', 2, FALSE),
(155, 78, 'Technics EAH-AZ80 Case', '/img/products/78-1.jpg', 1, TRUE),
(156, 78, 'Technics EAH-AZ80 Earbuds', '/img/products/78-2.jpg', 2, FALSE),
(157, 79, 'Bose SoundLink Flex Front', '/img/products/79-1.jpg', 1, TRUE),
(158, 79, 'Bose SoundLink Flex Side', '/img/products/79-2.jpg', 2, FALSE),
(159, 80, 'Marshall Motif II ANC Case', '/img/products/80-1.jpg', 1, TRUE),
(160, 80, 'Marshall Motif II ANC Earbuds', '/img/products/80-2.jpg', 2, FALSE),
(161, 81, 'Apple Watch Series 9 Front', '/img/products/81-1.jpg', 1, TRUE),
(162, 81, 'Apple Watch Series 9 Side', '/img/products/81-2.jpg', 2, FALSE),
(163, 82, 'Apple Watch Ultra 2 Front', '/img/products/82-1.jpg', 1, TRUE),
(164, 82, 'Apple Watch Ultra 2 Side', '/img/products/82-2.jpg', 2, FALSE),
(165, 83, 'Galaxy Watch6 Front', '/img/products/83-1.jpg', 1, TRUE),
(166, 83, 'Galaxy Watch6 Side', '/img/products/83-2.jpg', 2, FALSE),
(167, 84, 'Galaxy Watch6 Classic Front', '/img/products/84-1.jpg', 1, TRUE),
(168, 84, 'Galaxy Watch6 Classic Side', '/img/products/84-2.jpg', 2, FALSE),
(169, 85, 'Pixel Watch 2 Front', '/img/products/85-1.jpg', 1, TRUE),
(170, 85, 'Pixel Watch 2 Side', '/img/products/85-2.jpg', 2, FALSE),
(171, 86, 'Garmin fēnix 7 Pro Front', '/img/products/86-1.jpg', 1, TRUE),
(172, 86, 'Garmin fēnix 7 Pro Side', '/img/products/86-2.jpg', 2, FALSE),
(173, 87, 'Garmin Forerunner 965 Front', '/img/products/87-1.jpg', 1, TRUE),
(174, 87, 'Garmin Forerunner 965 Side', '/img/products/87-2.jpg', 2, FALSE),
(175, 88, 'Garmin Venu 3 Front', '/img/products/88-1.jpg', 1, TRUE),
(176, 88, 'Garmin Venu 3 Side', '/img/products/88-2.jpg', 2, FALSE),
(177, 89, 'Fitbit Sense 2 Front', '/img/products/89-1.jpg', 1, TRUE),
(178, 89, 'Fitbit Sense 2 Side', '/img/products/89-2.jpg', 2, FALSE),
(179, 90, 'Fitbit Charge 6 Front', '/img/products/90-1.jpg', 1, TRUE),
(180, 90, 'Fitbit Charge 6 Side', '/img/products/90-2.jpg', 2, FALSE),
(181, 91, 'Oura Ring Gen 3 Top', '/img/products/91-1.jpg', 1, TRUE),
(182, 91, 'Oura Ring Gen 3 Side', '/img/products/91-2.jpg', 2, FALSE),
(183, 92, 'Xiaomi Watch 2 Pro Front', '/img/products/92-1.jpg', 1, TRUE),
(184, 92, 'Xiaomi Watch 2 Pro Side', '/img/products/92-2.jpg', 2, FALSE),
(185, 93, 'Huawei Watch GT 4 Front', '/img/products/93-1.jpg', 1, TRUE),
(186, 93, 'Huawei Watch GT 4 Side', '/img/products/93-2.jpg', 2, FALSE),
(187, 94, 'Amazfit Balance Front', '/img/products/94-1.jpg', 1, TRUE),
(188, 94, 'Amazfit Balance Side', '/img/products/94-2.jpg', 2, FALSE),
(189, 95, 'Suunto Vertical Front', '/img/products/95-1.jpg', 1, TRUE),
(190, 95, 'Suunto Vertical Side', '/img/products/95-2.jpg', 2, FALSE),
(191, 96, 'Polar Vantage V3 Front', '/img/products/96-1.jpg', 1, TRUE),
(192, 96, 'Polar Vantage V3 Side', '/img/products/96-2.jpg', 2, FALSE),
(193, 97, 'Apple Watch SE (2nd gen) Front', '/img/products/97-1.jpg', 1, TRUE),
(194, 97, 'Apple Watch SE (2nd gen) Side', '/img/products/97-2.jpg', 2, FALSE),
(195, 98, 'Galaxy Watch5 Pro Front', '/img/products/98-1.jpg', 1, TRUE),
(196, 98, 'Galaxy Watch5 Pro Side', '/img/products/98-2.jpg', 2, FALSE),
(197, 99, 'WHOOP 4.0 Band', '/img/products/99-1.jpg', 1, TRUE),
(198, 99, 'WHOOP 4.0 Sensor', '/img/products/99-2.jpg', 2, FALSE),
(199, 100, 'Samsung Galaxy Ring Top', '/img/products/100-1.jpg', 1, TRUE),
(200, 100, 'Samsung Galaxy Ring Side', '/img/products/100-2.jpg', 2, FALSE);

-- Product Details
INSERT INTO product_details (
    product_id,
    attribute_name,
    attribute_value
    )
VALUES
-- ==============================================
-- SMARTPHONES TEMPLATE (Products 1-20)
-- Attributes: Display Size, Display Type, Refresh Rate, Processor, RAM, Storage Options,
-- Main Camera, Front Camera, Battery Capacity, Fast Charging, Operating System, 5G Support, Weight
-- ==============================================

-- iPhone 15 Pro (1)
(1, 'Display Size', '6.1 inches'),
(1, 'Display Type', 'LTPO Super Retina XDR OLED'),
(1, 'Refresh Rate', '1-120Hz ProMotion'),
(1, 'Processor', 'Apple A17 Pro (3nm)'),
(1, 'RAM', '8GB'),
(1, 'Storage Options', '128GB / 256GB / 512GB / 1TB'),
(1, 'Main Camera', '48MP f/1.78 main + 12MP f/2.2 ultra-wide + 12MP f/2.8 3x telephoto'),
(1, 'Front Camera', '12MP TrueDepth f/1.9'),
(1, 'Battery Capacity', '3274 mAh'),
(1, 'Fast Charging', '20W wired, 15W MagSafe wireless'),
(1, 'Operating System', 'iOS 17 (upgradable to iOS 18)'),
(1, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(1, 'Weight', '187g'),

-- iPhone 15 (2)
(2, 'Display Size', '6.1 inches'),
(2, 'Display Type', 'Super Retina XDR OLED'),
(2, 'Refresh Rate', '60Hz'),
(2, 'Processor', 'Apple A16 Bionic (5nm)'),
(2, 'RAM', '6GB'),
(2, 'Storage Options', '128GB / 256GB / 512GB'),
(2, 'Main Camera', '48MP f/1.6 main + 12MP f/2.4 ultra-wide'),
(2, 'Front Camera', '12MP TrueDepth f/1.9'),
(2, 'Battery Capacity', '3349 mAh'),
(2, 'Fast Charging', '20W wired, 15W MagSafe wireless'),
(2, 'Operating System', 'iOS 17 (upgradable to iOS 18)'),
(2, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(2, 'Weight', '171g'),

-- Galaxy S24 Ultra (3)
(3, 'Display Size', '6.8 inches'),
(3, 'Display Type', 'QHD+ LTPO AMOLED'),
(3, 'Refresh Rate', '1-120Hz (LTPO)'),
(3, 'Processor', 'Snapdragon 8 Gen 3 for Galaxy'),
(3, 'RAM', '12GB'),
(3, 'Storage Options', '256GB / 512GB / 1TB'),
(3, 'Main Camera', '200MP f/1.7 main + 50MP f/3.4 5x + 10MP f/2.4 3x + 12MP f/2.2 ultra-wide'),
(3, 'Front Camera', '12MP f/2.2'),
(3, 'Battery Capacity', '5000 mAh'),
(3, 'Fast Charging', '45W wired, 15W wireless'),
(3, 'Operating System', 'Android 14 (One UI 6.1)'),
(3, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(3, 'Weight', '232g'),

-- Galaxy S24 (4)
(4, 'Display Size', '6.2 inches'),
(4, 'Display Type', 'FHD+ LTPO AMOLED'),
(4, 'Refresh Rate', '1-120Hz (LTPO)'),
(4, 'Processor', 'Snapdragon 8 Gen 3 / Exynos 2400'),
(4, 'RAM', '8GB'),
(4, 'Storage Options', '128GB / 256GB / 512GB'),
(4, 'Main Camera', '50MP f/1.8 main + 10MP f/2.4 3x + 12MP f/2.2 ultra-wide'),
(4, 'Front Camera', '12MP f/2.2'),
(4, 'Battery Capacity', '4000 mAh'),
(4, 'Fast Charging', '25W wired, 15W wireless'),
(4, 'Operating System', 'Android 14 (One UI 6.1)'),
(4, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(4, 'Weight', '167g'),

-- Pixel 8 Pro (5)
(5, 'Display Size', '6.7 inches'),
(5, 'Display Type', 'LTPO OLED'),
(5, 'Refresh Rate', '1-120Hz (LTPO)'),
(5, 'Processor', 'Google Tensor G3'),
(5, 'RAM', '12GB'),
(5, 'Storage Options', '128GB / 256GB / 512GB'),
(5, 'Main Camera', '50MP f/1.68 main + 48MP f/3.5 5x + 48MP f/2.8 ultra-wide'),
(5, 'Front Camera', '10.5MP f/2.2'),
(5, 'Battery Capacity', '5050 mAh'),
(5, 'Fast Charging', '30W wired, 23W wireless'),
(5, 'Operating System', 'Android 14'),
(5, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(5, 'Weight', '221g'),

-- Pixel 8 (6)
(6, 'Display Size', '6.2 inches'),
(6, 'Display Type', 'OLED'),
(6, 'Refresh Rate', '120Hz'),
(6, 'Processor', 'Google Tensor G3'),
(6, 'RAM', '8GB'),
(6, 'Storage Options', '128GB / 256GB'),
(6, 'Main Camera', '50MP f/1.7 main + 12MP f/2.2 ultra-wide'),
(6, 'Front Camera', '10.5MP f/2.2'),
(6, 'Battery Capacity', '4575 mAh'),
(6, 'Fast Charging', '20W wired, 20W wireless'),
(6, 'Operating System', 'Android 14'),
(6, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(6, 'Weight', '187g'),

-- OnePlus 12 (7)
(7, 'Display Size', '6.82 inches'),
(7, 'Display Type', 'LTPO AMOLED'),
(7, 'Refresh Rate', '1-120Hz (LTPO)'),
(7, 'Processor', 'Snapdragon 8 Gen 3'),
(7, 'RAM', '12GB'),
(7, 'Storage Options', '256GB / 512GB'),
(7, 'Main Camera', '50MP f/1.6 main + 64MP f/2.6 3x periscope + 48MP f/2.2 ultra-wide'),
(7, 'Front Camera', '32MP f/2.4'),
(7, 'Battery Capacity', '5400 mAh'),
(7, 'Fast Charging', '100W wired SUPERVOOC'),
(7, 'Operating System', 'Android 14 (OxygenOS 14)'),
(7, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(7, 'Weight', '220g'),

-- Xiaomi 14 (8)
(8, 'Display Size', '6.36 inches'),
(8, 'Display Type', 'LTPO AMOLED'),
(8, 'Refresh Rate', '1-120Hz (LTPO)'),
(8, 'Processor', 'Snapdragon 8 Gen 3'),
(8, 'RAM', '12GB'),
(8, 'Storage Options', '256GB / 512GB'),
(8, 'Main Camera', '50MP f/1.7 main + 50MP f/2.0 3.2x + 50MP f/2.2 ultra-wide (Leica)'),
(8, 'Front Camera', '32MP f/2.0'),
(8, 'Battery Capacity', '4610 mAh'),
(8, 'Fast Charging', '90W HyperCharge wired, 80W wireless'),
(8, 'Operating System', 'Android 14 (HyperOS)'),
(8, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(8, 'Weight', '199g'),

-- Sony Xperia 1 V (9)
(9, 'Display Size', '6.5 inches'),
(9, 'Display Type', '4K OLED 21:9'),
(9, 'Refresh Rate', '120Hz'),
(9, 'Processor', 'Snapdragon 8 Gen 2'),
(9, 'RAM', '12GB'),
(9, 'Storage Options', '256GB / 512GB'),
(9, 'Main Camera', '48MP f/2.0 main + 12MP f/2.6 85-125mm tele + 12MP f/2.2 ultra-wide'),
(9, 'Front Camera', '12MP f/2.0'),
(9, 'Battery Capacity', '5000 mAh'),
(9, 'Fast Charging', '30W wired, no wireless'),
(9, 'Operating System', 'Android 14'),
(9, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(9, 'Weight', '187g'),

-- ASUS ROG Phone 8 Pro (10)
(10, 'Display Size', '6.78 inches'),
(10, 'Display Type', 'AMOLED'),
(10, 'Refresh Rate', '165Hz'),
(10, 'Processor', 'Snapdragon 8 Gen 3'),
(10, 'RAM', '16GB'),
(10, 'Storage Options', '256GB / 512GB'),
(10, 'Main Camera', '50MP f/1.9 main + 32MP f/2.0 3x + 13MP f/2.2 ultra-wide'),
(10, 'Front Camera', '32MP f/2.45'),
(10, 'Battery Capacity', '5500 mAh'),
(10, 'Fast Charging', '65W wired ASUS HyperCharge'),
(10, 'Operating System', 'Android 14 (ROG UI)'),
(10, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(10, 'Weight', '246g'),

-- iPhone 15 Pro Max (11)
(11, 'Display Size', '6.7 inches'),
(11, 'Display Type', 'LTPO Super Retina XDR OLED'),
(11, 'Refresh Rate', '1-120Hz ProMotion'),
(11, 'Processor', 'Apple A17 Pro (3nm)'),
(11, 'RAM', '8GB'),
(11, 'Storage Options', '256GB / 512GB / 1TB'),
(11, 'Main Camera', '48MP f/1.78 main + 12MP f/2.2 ultra-wide + 12MP f/2.8 5x tetraprism'),
(11, 'Front Camera', '12MP TrueDepth f/1.9'),
(11, 'Battery Capacity', '4422 mAh'),
(11, 'Fast Charging', '20W wired, 15W MagSafe wireless'),
(11, 'Operating System', 'iOS 17 (upgradable to iOS 18)'),
(11, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(11, 'Weight', '221g'),

-- iPhone 14 Pro (12)
(12, 'Display Size', '6.1 inches'),
(12, 'Display Type', 'LTPO Super Retina XDR OLED'),
(12, 'Refresh Rate', '1-120Hz ProMotion'),
(12, 'Processor', 'Apple A16 Bionic (5nm)'),
(12, 'RAM', '6GB'),
(12, 'Storage Options', '128GB / 256GB / 512GB / 1TB'),
(12, 'Main Camera', '48MP f/1.78 main + 12MP f/2.2 ultra-wide + 12MP f/2.8 3x telephoto'),
(12, 'Front Camera', '12MP TrueDepth f/1.9'),
(12, 'Battery Capacity', '3200 mAh'),
(12, 'Fast Charging', '20W wired, 15W MagSafe wireless'),
(12, 'Operating System', 'iOS 16 (upgradable to iOS 18)'),
(12, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(12, 'Weight', '203g'),

-- Galaxy Z Fold5 (13)
(13, 'Display Size', '7.6" foldable (6.2" cover)'),
(13, 'Display Type', 'QXGA+ LTPO AMOLED (main) / AMOLED (cover)'),
(13, 'Refresh Rate', '1-120Hz (LTPO main)'),
(13, 'Processor', 'Snapdragon 8 Gen 2 for Galaxy'),
(13, 'RAM', '12GB'),
(13, 'Storage Options', '256GB / 512GB / 1TB'),
(13, 'Main Camera', '50MP f/1.8 main + 12MP f/2.2 ultra-wide + 10MP f/2.4 3x telephoto'),
(13, 'Front Camera', '10MP f/2.2 cover + 4MP f/1.8 under-display'),
(13, 'Battery Capacity', '4400 mAh'),
(13, 'Fast Charging', '25W wired, 10W wireless'),
(13, 'Operating System', 'Android 14 (One UI 6.1)'),
(13, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(13, 'Weight', '253g'),

-- Galaxy Z Flip5 (14)
(14, 'Display Size', '6.7" foldable (3.4" cover)'),
(14, 'Display Type', 'FHD+ AMOLED (main) / Super AMOLED (cover)'),
(14, 'Refresh Rate', '1-120Hz (main)'),
(14, 'Processor', 'Snapdragon 8 Gen 2 for Galaxy'),
(14, 'RAM', '8GB'),
(14, 'Storage Options', '256GB / 512GB'),
(14, 'Main Camera', '12MP f/1.8 main + 12MP f/2.2 ultra-wide'),
(14, 'Front Camera', '10MP f/2.2'),
(14, 'Battery Capacity', '3700 mAh'),
(14, 'Fast Charging', '25W wired, 10W wireless'),
(14, 'Operating System', 'Android 14 (One UI 6.1)'),
(14, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(14, 'Weight', '187g'),

-- Galaxy S24+ (15)
(15, 'Display Size', '6.7 inches'),
(15, 'Display Type', 'QHD+ AMOLED'),
(15, 'Refresh Rate', '1-120Hz (LTPO)'),
(15, 'Processor', 'Snapdragon 8 Gen 3 / Exynos 2400'),
(15, 'RAM', '12GB'),
(15, 'Storage Options', '256GB / 512GB'),
(15, 'Main Camera', '50MP f/1.8 main + 10MP f/2.4 3x + 12MP f/2.2 ultra-wide'),
(15, 'Front Camera', '12MP f/2.2'),
(15, 'Battery Capacity', '4900 mAh'),
(15, 'Fast Charging', '25W wired, 15W wireless'),
(15, 'Operating System', 'Android 14 (One UI 6.1)'),
(15, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(15, 'Weight', '196g'),

-- Pixel 8a (16)
(16, 'Display Size', '6.1 inches'),
(16, 'Display Type', 'OLED'),
(16, 'Refresh Rate', '120Hz'),
(16, 'Processor', 'Google Tensor G3'),
(16, 'RAM', '8GB'),
(16, 'Storage Options', '128GB / 256GB'),
(16, 'Main Camera', '64MP f/1.89 main + 13MP f/2.2 ultra-wide'),
(16, 'Front Camera', '13MP f/2.2'),
(16, 'Battery Capacity', '4492 mAh'),
(16, 'Fast Charging', '18W wired, 7.5W wireless'),
(16, 'Operating System', 'Android 14'),
(16, '5G Support', 'Yes (Sub-6GHz only)'),
(16, 'Weight', '187g'),

-- Xiaomi 14 Ultra (17)
(17, 'Display Size', '6.73 inches'),
(17, 'Display Type', 'LTPO AMOLED'),
(17, 'Refresh Rate', '1-120Hz (LTPO)'),
(17, 'Processor', 'Snapdragon 8 Gen 3'),
(17, 'RAM', '16GB'),
(17, 'Storage Options', '512GB / 1TB'),
(17, 'Main Camera', '50MP f/1.63 1-inch main + 50MP f/2.0 3.2x + 50MP f/2.6 5x + 50MP f/2.2 ultra-wide'),
(17, 'Front Camera', '32MP f/2.0'),
(17, 'Battery Capacity', '5000 mAh'),
(17, 'Fast Charging', '90W HyperCharge wired, 80W wireless'),
(17, 'Operating System', 'Android 14 (HyperOS)'),
(17, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(17, 'Weight', '224g'),

-- OnePlus 12R (18)
(18, 'Display Size', '6.78 inches'),
(18, 'Display Type', 'LTPO AMOLED'),
(18, 'Refresh Rate', '1-120Hz (LTPO)'),
(18, 'Processor', 'Snapdragon 8 Gen 2'),
(18, 'RAM', '8GB'),
(18, 'Storage Options', '128GB / 256GB'),
(18, 'Main Camera', '50MP f/1.6 main + 8MP f/2.2 ultra-wide + 2MP f/2.4 macro'),
(18, 'Front Camera', '16MP f/2.4'),
(18, 'Battery Capacity', '5500 mAh'),
(18, 'Fast Charging', '100W SUPERVOOC wired'),
(18, 'Operating System', 'Android 14 (OxygenOS 14)'),
(18, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(18, 'Weight', '207g'),

-- Nothing Phone (2) (19)
(19, 'Display Size', '6.7 inches'),
(19, 'Display Type', 'LTPO OLED'),
(19, 'Refresh Rate', '1-120Hz (LTPO)'),
(19, 'Processor', 'Snapdragon 8+ Gen 1'),
(19, 'RAM', '12GB'),
(19, 'Storage Options', '256GB / 512GB'),
(19, 'Main Camera', '50MP f/1.88 main + 50MP f/2.2 ultra-wide'),
(19, 'Front Camera', '32MP f/2.2'),
(19, 'Battery Capacity', '4700 mAh'),
(19, 'Fast Charging', '45W wired, no wireless'),
(19, 'Operating System', 'Android 14 (Nothing OS 2)'),
(19, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(19, 'Weight', '201.3g'),

-- Xperia 5 V (20)
(20, 'Display Size', '6.1 inches'),
(20, 'Display Type', 'FHD+ OLED 21:9'),
(20, 'Refresh Rate', '120Hz'),
(20, 'Processor', 'Snapdragon 8 Gen 2'),
(20, 'RAM', '8GB'),
(20, 'Storage Options', '128GB / 256GB'),
(20, 'Main Camera', '48MP f/2.0 main + 12MP f/2.2 ultra-wide'),
(20, 'Front Camera', '12MP f/2.0'),
(20, 'Battery Capacity', '5000 mAh'),
(20, 'Fast Charging', '30W wired, no wireless'),
(20, 'Operating System', 'Android 14'),
(20, '5G Support', 'Yes (Sub-6GHz and mmWave)'),
(20, 'Weight', '159g'),

-- ==============================================
-- TABLETS TEMPLATE (Products 21-40)
-- Attributes: Display Size, Display Type, Refresh Rate, Processor, RAM, Storage Options,
-- Rear Camera, Front Camera, Battery Capacity, Stylus Support, Operating System, Connectivity, Weight
-- ==============================================

-- iPad Pro 11-inch (M4, 2024) (21)
(21, 'Display Size', '11 inches'),
(21, 'Display Type', 'Ultra Retina XDR OLED'),
(21, 'Refresh Rate', '120Hz'),
(21, 'Processor', 'Apple M4 (3nm)'),
(21, 'RAM', '8GB / 16GB'),
(21, 'Storage Options', '256GB / 512GB / 1TB / 2TB'),
(21, 'Rear Camera', '12MP f/1.8 wide + LiDAR scanner'),
(21, 'Front Camera', '12MP f/2.4 ultra-wide landscape'),
(21, 'Battery Capacity', '28.65 Wh'),
(21, 'Stylus Support', 'Yes (Apple Pencil Pro)'),
(21, 'Operating System', 'iPadOS 17'),
(21, 'Connectivity', 'Wi-Fi 6E, Bluetooth 5.3, Thunderbolt/USB-C'),
(21, 'Weight', '438g'),

-- iPad Pro 13-inch (M4, 2024) (22)
(22, 'Display Size', '13 inches'),
(22, 'Display Type', 'Ultra Retina XDR OLED'),
(22, 'Refresh Rate', '120Hz'),
(22, 'Processor', 'Apple M4 (3nm)'),
(22, 'RAM', '8GB / 16GB'),
(22, 'Storage Options', '256GB / 512GB / 1TB / 2TB'),
(22, 'Rear Camera', '12MP f/1.8 wide + LiDAR scanner'),
(22, 'Front Camera', '12MP f/2.4 ultra-wide landscape'),
(22, 'Battery Capacity', '38.99 Wh'),
(22, 'Stylus Support', 'Yes (Apple Pencil Pro)'),
(22, 'Operating System', 'iPadOS 17'),
(22, 'Connectivity', 'Wi-Fi 6E, Bluetooth 5.3, Thunderbolt/USB-C'),
(22, 'Weight', '579g'),

-- iPad Air 11-inch (M2, 2024) (23)
(23, 'Display Size', '11 inches'),
(23, 'Display Type', 'Liquid Retina'),
(23, 'Refresh Rate', '60Hz'),
(23, 'Processor', 'Apple M2 (5nm)'),
(23, 'RAM', '8GB'),
(23, 'Storage Options', '128GB / 256GB / 512GB / 1TB'),
(23, 'Rear Camera', '12MP f/1.8 wide'),
(23, 'Front Camera', '12MP f/2.4 ultra-wide landscape'),
(23, 'Battery Capacity', '28.93 Wh'),
(23, 'Stylus Support', 'Yes (Apple Pencil 2nd gen)'),
(23, 'Operating System', 'iPadOS 17'),
(23, 'Connectivity', 'Wi-Fi 6E, Bluetooth 5.3, USB-C'),
(23, 'Weight', '458g'),

-- iPad Air 13-inch (M2, 2024) (24)
(24, 'Display Size', '13 inches'),
(24, 'Display Type', 'Liquid Retina'),
(24, 'Refresh Rate', '60Hz'),
(24, 'Processor', 'Apple M2 (5nm)'),
(24, 'RAM', '8GB'),
(24, 'Storage Options', '128GB / 256GB / 512GB / 1TB'),
(24, 'Rear Camera', '12MP f/1.8 wide'),
(24, 'Front Camera', '12MP f/2.4 ultra-wide landscape'),
(24, 'Battery Capacity', '36.59 Wh'),
(24, 'Stylus Support', 'Yes (Apple Pencil 2nd gen)'),
(24, 'Operating System', 'iPadOS 17'),
(24, 'Connectivity', 'Wi-Fi 6E, Bluetooth 5.3, USB-C'),
(24, 'Weight', '617g'),

-- iPad (10th generation) (25)
(25, 'Display Size', '10.9 inches'),
(25, 'Display Type', 'Liquid Retina'),
(25, 'Refresh Rate', '60Hz'),
(25, 'Processor', 'Apple A14 Bionic'),
(25, 'RAM', '4GB'),
(25, 'Storage Options', '64GB / 256GB'),
(25, 'Rear Camera', '12MP f/1.8 wide'),
(25, 'Front Camera', '12MP f/2.4 ultra-wide landscape'),
(25, 'Battery Capacity', '28.6 Wh'),
(25, 'Stylus Support', 'Yes (Apple Pencil 1st/2nd gen)'),
(25, 'Operating System', 'iPadOS 17'),
(25, 'Connectivity', 'Wi-Fi 6, Bluetooth 5.2, USB-C'),
(25, 'Weight', '477g'),

-- iPad mini (6th generation) (26)
(26, 'Display Size', '8.3 inches'),
(26, 'Display Type', 'Liquid Retina'),
(26, 'Refresh Rate', '60Hz'),
(26, 'Processor', 'Apple A15 Bionic'),
(26, 'RAM', '4GB / 8GB'),
(26, 'Storage Options', '64GB / 256GB'),
(26, 'Rear Camera', '12MP f/2.0 wide'),
(26, 'Front Camera', '12MP f/2.4 ultra-wide'),
(26, 'Battery Capacity', '19.3 Wh'),
(26, 'Stylus Support', 'Yes (Apple Pencil 1st/2nd gen)'),
(26, 'Operating System', 'iPadOS 17'),
(26, 'Connectivity', 'Wi-Fi 6, Bluetooth 5.0, USB-C'),
(26, 'Weight', '293g'),

-- Galaxy Tab S9 Ultra (27)
(27, 'Display Size', '14.6 inches'),
(27, 'Display Type', 'Dynamic AMOLED 2X'),
(27, 'Refresh Rate', '120Hz'),
(27, 'Processor', 'Snapdragon 8 Gen 2 for Galaxy'),
(27, 'RAM', '12GB / 16GB'),
(27, 'Storage Options', '256GB / 512GB'),
(27, 'Rear Camera', '13MP f/1.8 + 8MP f/2.2 ultra-wide'),
(27, 'Front Camera', '12MP f/2.2 ultra-wide'),
(27, 'Battery Capacity', '11200 mAh'),
(27, 'Stylus Support', 'Yes (S Pen included)'),
(27, 'Operating System', 'Android 14 (One UI 6.1)'),
(27, 'Connectivity', 'Wi-Fi 6E, Bluetooth 5.3, USB-C, optional LTE'),
(27, 'Weight', '732g'),

-- Galaxy Tab S9+ (28)
(28, 'Display Size', '12.4 inches'),
(28, 'Display Type', 'Dynamic AMOLED 2X'),
(28, 'Refresh Rate', '120Hz'),
(28, 'Processor', 'Snapdragon 8 Gen 2 for Galaxy'),
(28, 'RAM', '12GB / 16GB'),
(28, 'Storage Options', '256GB / 512GB'),
(28, 'Rear Camera', '13MP f/1.8 + 8MP f/2.2 ultra-wide'),
(28, 'Front Camera', '12MP f/2.2 ultra-wide'),
(28, 'Battery Capacity', '10090 mAh'),
(28, 'Stylus Support', 'Yes (S Pen included)'),
(28, 'Operating System', 'Android 14 (One UI 6.1)'),
(28, 'Connectivity', 'Wi-Fi 6E, Bluetooth 5.3, USB-C, optional LTE'),
(28, 'Weight', '582g'),

-- Galaxy Tab S9 (29)
(29, 'Display Size', '11 inches'),
(29, 'Display Type', 'Dynamic AMOLED 2X'),
(29, 'Refresh Rate', '120Hz'),
(29, 'Processor', 'Snapdragon 8 Gen 2 for Galaxy'),
(29, 'RAM', '8GB / 12GB'),
(29, 'Storage Options', '128GB / 256GB'),
(29, 'Rear Camera', '13MP f/1.8'),
(29, 'Front Camera', '12MP f/2.2 ultra-wide'),
(29, 'Battery Capacity', '8400 mAh'),
(29, 'Stylus Support', 'Yes (S Pen sold separately)'),
(29, 'Operating System', 'Android 14 (One UI 6.1)'),
(29, 'Connectivity', 'Wi-Fi 6E, Bluetooth 5.3, USB-C, optional LTE'),
(29, 'Weight', '503g'),

-- Galaxy Tab S9 FE (30)
(30, 'Display Size', '10.9 inches'),
(30, 'Display Type', 'LCD'),
(30, 'Refresh Rate', '90Hz'),
(30, 'Processor', 'Exynos 1380'),
(30, 'RAM', '4GB / 6GB'),
(30, 'Storage Options', '64GB / 128GB'),
(30, 'Rear Camera', '8MP f/2.0'),
(30, 'Front Camera', '12MP f/2.2 ultra-wide'),
(30, 'Battery Capacity', '8000 mAh'),
(30, 'Stylus Support', 'No'),
(30, 'Operating System', 'Android 14 (One UI 6.1)'),
(30, 'Connectivity', 'Wi-Fi 6, Bluetooth 5.3, USB-C'),
(30, 'Weight', '510g'),

-- Galaxy Tab S9 FE+ (31)
(31, 'Display Size', '12.4 inches'),
(31, 'Display Type', 'LCD'),
(31, 'Refresh Rate', '90Hz'),
(31, 'Processor', 'Exynos 1380'),
(31, 'RAM', '4GB / 6GB'),
(31, 'Storage Options', '64GB / 128GB'),
(31, 'Rear Camera', '8MP f/2.0'),
(31, 'Front Camera', '12MP f/2.2 ultra-wide'),
(31, 'Battery Capacity', '10090 mAh'),
(31, 'Stylus Support', 'No'),
(31, 'Operating System', 'Android 14 (One UI 6.1)'),
(31, 'Connectivity', 'Wi-Fi 6, Bluetooth 5.3, USB-C'),
(31, 'Weight', '668g'),

-- Surface Pro 11 (32)
(32, 'Display Size', '13 inches'),
(32, 'Display Type', 'OLED PixelSense (3:2)'),
(32, 'Refresh Rate', '120Hz'),
(32, 'Processor', 'Snapdragon X Elite / X Plus'),
(32, 'RAM', '16GB / 32GB'),
(32, 'Storage Options', '256GB / 512GB / 1TB'),
(32, 'Rear Camera', '10MP f/2.0'),
(32, 'Front Camera', '1440p f/2.0'),
(32, 'Battery Capacity', '48 Wh'),
(32, 'Stylus Support', 'Yes (Slim Pen 2)'),
(32, 'Operating System', 'Windows 11 Pro'),
(32, 'Connectivity', 'Wi-Fi 7, Bluetooth 5.4, USB4, optional 5G'),
(32, 'Weight', '890g'),

-- Surface Go 4 (33)
(33, 'Display Size', '10.5 inches'),
(33, 'Display Type', 'IPS PixelSense (3:2)'),
(33, 'Refresh Rate', '60Hz'),
(33, 'Processor', 'Intel Processor N200'),
(33, 'RAM', '8GB'),
(33, 'Storage Options', '128GB / 256GB'),
(33, 'Rear Camera', '8MP f/2.0'),
(33, 'Front Camera', '5MP f/2.4'),
(33, 'Battery Capacity', '28 Wh'),
(33, 'Stylus Support', 'Yes (Slim Pen 2)'),
(33, 'Operating System', 'Windows 11 Home/Pro'),
(33, 'Connectivity', 'Wi-Fi 6, Bluetooth 5.1, USB-C'),
(33, 'Weight', '598g'),

-- Lenovo Tab P12 (34)
(34, 'Display Size', '12.7 inches'),
(34, 'Display Type', '3K LCD'),
(34, 'Refresh Rate', '90Hz'),
(34, 'Processor', 'MediaTek Dimensity 7050'),
(34, 'RAM', '8GB'),
(34, 'Storage Options', '128GB / 256GB'),
(34, 'Rear Camera', '8MP f/2.0'),
(34, 'Front Camera', '13MP f/2.0'),
(34, 'Battery Capacity', '10200 mAh'),
(34, 'Stylus Support', 'Yes (optional pen)'),
(34, 'Operating System', 'Android 13'),
(34, 'Connectivity', 'Wi-Fi 6, Bluetooth 5.1, USB-C'),
(34, 'Weight', '615g'),

-- Lenovo Tab P11 Pro (2nd Gen) (35)
(35, 'Display Size', '11.2 inches'),
(35, 'Display Type', 'OLED (2.5K)'),
(35, 'Refresh Rate', '120Hz'),
(35, 'Processor', 'MediaTek Kompanio 1300T'),
(35, 'RAM', '8GB / 12GB'),
(35, 'Storage Options', '128GB / 256GB'),
(35, 'Rear Camera', '13MP f/2.0 + 8MP f/2.2 ultra-wide'),
(35, 'Front Camera', '8MP f/2.2'),
(35, 'Battery Capacity', '8200 mAh'),
(35, 'Stylus Support', 'Yes (optional Lenovo Pen)'),
(35, 'Operating System', 'Android 13'),
(35, 'Connectivity', 'Wi-Fi 6, Bluetooth 5.1, USB-C'),
(35, 'Weight', '485g'),

-- Xiaomi Pad 6 (36)
(36, 'Display Size', '11 inches'),
(36, 'Display Type', 'IPS LCD'),
(36, 'Refresh Rate', '144Hz'),
(36, 'Processor', 'Snapdragon 870'),
(36, 'RAM', '6GB / 8GB'),
(36, 'Storage Options', '128GB / 256GB'),
(36, 'Rear Camera', '13MP f/2.0'),
(36, 'Front Camera', '8MP f/2.2'),
(36, 'Battery Capacity', '8840 mAh'),
(36, 'Stylus Support', 'Yes (Xiaomi Stylus)'),
(36, 'Operating System', 'Android 13 (HyperOS)'),
(36, 'Connectivity', 'Wi-Fi 6, Bluetooth 5.2, USB-C'),
(36, 'Weight', '490g'),

-- OnePlus Pad (37)
(37, 'Display Size', '11.61 inches'),
(37, 'Display Type', 'IPS LCD'),
(37, 'Refresh Rate', '144Hz'),
(37, 'Processor', 'MediaTek Dimensity 9000'),
(37, 'RAM', '8GB / 12GB'),
(37, 'Storage Options', '128GB / 256GB'),
(37, 'Rear Camera', '13MP f/2.0'),
(37, 'Front Camera', '8MP f/2.2'),
(37, 'Battery Capacity', '9510 mAh'),
(37, 'Stylus Support', 'Yes (OnePlus Stylus 2)'),
(37, 'Operating System', 'Android 14 (OxygenOS)'),
(37, 'Connectivity', 'Wi-Fi 6, Bluetooth 5.3, USB-C'),
(37, 'Weight', '551g'),

-- Huawei MatePad Pro 13.2 (38)
(38, 'Display Size', '13.2 inches'),
(38, 'Display Type', 'OLED'),
(38, 'Refresh Rate', '144Hz'),
(38, 'Processor', 'Kirin 9000S'),
(38, 'RAM', '12GB'),
(38, 'Storage Options', '256GB / 512GB'),
(38, 'Rear Camera', '13MP f/1.8 + 8MP f/2.2 ultra-wide'),
(38, 'Front Camera', '16MP f/2.0'),
(38, 'Battery Capacity', '10100 mAh'),
(38, 'Stylus Support', 'Yes (M-Pencil)'),
(38, 'Operating System', 'HarmonyOS 4'),
(38, 'Connectivity', 'Wi-Fi 6, Bluetooth 5.2, USB-C, optional 5G'),
(38, 'Weight', '679g'),

-- Amazon Fire Max 11 (39)
(39, 'Display Size', '11 inches'),
(39, 'Display Type', 'LCD (2000x1200)'),
(39, 'Refresh Rate', '90Hz'),
(39, 'Processor', 'MediaTek MT8188J'),
(39, 'RAM', '4GB'),
(39, 'Storage Options', '32GB / 64GB / 128GB'),
(39, 'Rear Camera', '8MP f/2.0'),
(39, 'Front Camera', '8MP f/2.0'),
(39, 'Battery Capacity', '7500 mAh'),
(39, 'Stylus Support', 'No'),
(39, 'Operating System', 'Fire OS (Android-based)'),
(39, 'Connectivity', 'Wi-Fi 6, Bluetooth 5.2, USB-C'),
(39, 'Weight', '500g'),

-- Google Pixel Tablet (40)
(40, 'Display Size', '10.95 inches'),
(40, 'Display Type', 'LCD'),
(40, 'Refresh Rate', '60Hz'),
(40, 'Processor', 'Google Tensor G2'),
(40, 'RAM', '8GB'),
(40, 'Storage Options', '128GB / 256GB'),
(40, 'Rear Camera', '8MP f/2.0'),
(40, 'Front Camera', '8MP f/2.0'),
(40, 'Battery Capacity', '27 Wh'),
(40, 'Stylus Support', 'No'),
(40, 'Operating System', 'Android 14'),
(40, 'Connectivity', 'Wi-Fi 6, Bluetooth 5.2, USB-C'),
(40, 'Weight', '493g'),

-- ==============================================
-- LAPTOPS TEMPLATE (Products 41-60)
-- Attributes: Display Size, Display Type, Resolution, Processor, GPU, RAM Options, Storage Options,
-- Battery Life, Weight, Operating System, Ports, Special Features
-- ==============================================

-- MacBook Pro 14 (M3 Pro) (41)
(41, 'Display Size', '14.2 inches'),
(41, 'Display Type', 'Liquid Retina XDR (3:2)'),
(41, 'Resolution', '3024 x 1964 @ 120Hz ProMotion'),
(41, 'Processor', 'Apple M3 Pro (8-core CPU)'),
(41, 'GPU', 'Apple M3 Pro (18-core GPU)'),
(41, 'RAM Options', '18GB / 36GB'),
(41, 'Storage Options', '512GB / 1TB / 2TB SSD'),
(41, 'Battery Life', 'Up to 18 hours'),
(41, 'Weight', '1.61kg'),
(41, 'Operating System', 'macOS'),
(41, 'Ports', '3x Thunderbolt 4, HDMI 2.1, SDXC, MagSafe 3, 3.5mm'),
(41, 'Special Features', 'Notch design, ProMotion, Backlit keyboard'),

-- MacBook Air 15 (M3) (42)
(42, 'Display Size', '15.3 inches'),
(42, 'Display Type', 'Liquid Retina (16:10)'),
(42, 'Resolution', '2880 x 1864 @ 60Hz'),
(42, 'Processor', 'Apple M3 (8-core CPU)'),
(42, 'GPU', 'Apple M3 (10-core GPU)'),
(42, 'RAM Options', '8GB / 16GB / 24GB'),
(42, 'Storage Options', '256GB / 512GB / 1TB SSD'),
(42, 'Battery Life', 'Up to 18 hours'),
(42, 'Weight', '1.51kg'),
(42, 'Operating System', 'macOS'),
(42, 'Ports', '2x Thunderbolt/USB 4, MagSafe 3, 3.5mm'),
(42, 'Special Features', 'All-day battery, Backlit keyboard, Thin design'),

-- Dell XPS 14 (9440) (43)
(43, 'Display Size', '14.5 inches'),
(43, 'Display Type', '3.2K OLED (16:10)'),
(43, 'Resolution', '3456 x 2160 @ 120Hz'),
(43, 'Processor', 'Intel Core Ultra 7'),
(43, 'GPU', 'NVIDIA GeForce RTX 4050 Laptop GPU'),
(43, 'RAM Options', '16GB / 32GB LPDDR5x'),
(43, 'Storage Options', '512GB / 1TB PCIe 4.0 SSD'),
(43, 'Battery Life', 'Up to 13 hours'),
(43, 'Weight', '1.68kg'),
(43, 'Operating System', 'Windows 11'),
(43, 'Ports', '3x Thunderbolt 4 (USB-C), SD Card, 3.5mm'),
(43, 'Special Features', 'OLED display, Premium build, InfinityEdge design'),

-- Dell XPS 13 (9340) (44)
(44, 'Display Size', '13.4 inches'),
(44, 'Display Type', '2.8K OLED (16:10)'),
(44, 'Resolution', '2880 x 1800 @ 120Hz'),
(44, 'Processor', 'Intel Core Ultra 7'),
(44, 'GPU', 'Intel Arc Graphics'),
(44, 'RAM Options', '16GB / 32GB LPDDR5x'),
(44, 'Storage Options', '512GB / 1TB PCIe 4.0 SSD'),
(44, 'Battery Life', 'Up to 12 hours'),
(44, 'Weight', '1.19kg'),
(44, 'Operating System', 'Windows 11'),
(44, 'Ports', '2x Thunderbolt 4 (USB-C), 3.5mm'),
(44, 'Special Features', 'Ultra-portable, InfinityEdge, Premium design'),

-- HP Spectre x360 14 (45)
(45, 'Display Size', '14 inches'),
(45, 'Display Type', '2.8K OLED Touchscreen (16:10)'),
(45, 'Resolution', '2880 x 1800 @ 120Hz'),
(45, 'Processor', 'Intel Core Ultra 7'),
(45, 'GPU', 'Intel Arc Graphics'),
(45, 'RAM Options', '16GB / 32GB LPDDR5x'),
(45, 'Storage Options', '512GB / 1TB PCIe SSD'),
(45, 'Battery Life', 'Up to 13 hours'),
(45, 'Weight', '1.44kg'),
(45, 'Operating System', 'Windows 11'),
(45, 'Ports', '2x Thunderbolt 4, 2x USB-A, HDMI, 3.5mm'),
(45, 'Special Features', '2-in-1 convertible, OLED touchscreen, Stylus support'),

-- ThinkPad X1 Carbon Gen 12 (46)
(46, 'Display Size', '14 inches'),
(46, 'Display Type', '2.8K OLED (16:10)'),
(46, 'Resolution', '2880 x 1800 @ 120Hz'),
(46, 'Processor', 'Intel Core Ultra 7'),
(46, 'GPU', 'Intel Arc Graphics'),
(46, 'RAM Options', '16GB / 32GB LPDDR5x'),
(46, 'Storage Options', '512GB / 1TB PCIe SSD'),
(46, 'Battery Life', 'Up to 15 hours'),
(46, 'Weight', '1.12kg'),
(46, 'Operating System', 'Windows 11 Pro'),
(46, 'Ports', '2x Thunderbolt 4, 2x USB-A, HDMI, 3.5mm'),
(46, 'Special Features', 'Premium business laptop, Lightweight, TrackPoint'),

-- ThinkPad X1 Yoga Gen 9 (47)
(47, 'Display Size', '14 inches'),
(47, 'Display Type', '2.8K OLED Touchscreen (16:10)'),
(47, 'Resolution', '2880 x 1800 @ 120Hz'),
(47, 'Processor', 'Intel Core Ultra 7'),
(47, 'GPU', 'Intel Arc Graphics'),
(47, 'RAM Options', '16GB / 32GB LPDDR5x'),
(47, 'Storage Options', '512GB / 1TB PCIe SSD'),
(47, 'Battery Life', 'Up to 14 hours'),
(47, 'Weight', '1.39kg'),
(47, 'Operating System', 'Windows 11 Pro'),
(47, 'Ports', '2x Thunderbolt 4, 2x USB-A, HDMI, 3.5mm'),
(47, 'Special Features', '2-in-1 convertible, OLED touchscreen, 360° hinge'),

-- ROG Zephyrus G14 (2024) (48)
(48, 'Display Size', '14 inches'),
(48, 'Display Type', 'QHD+ IPS (16:10)'),
(48, 'Resolution', '2560 x 1600 @ 120Hz'),
(48, 'Processor', 'AMD Ryzen 9 9950X / 7900HX3D'),
(48, 'GPU', 'NVIDIA GeForce RTX 4060 / 4070 Laptop'),
(48, 'RAM Options', '16GB / 32GB LPDDR5x'),
(48, 'Storage Options', '1TB / 2TB PCIe SSD'),
(48, 'Battery Life', '10+ hours'),
(48, 'Weight', '1.50kg'),
(48, 'Operating System', 'Windows 11'),
(48, 'Ports', 'USB4, 2x USB-A, HDMI 2.1, 3.5mm'),
(48, 'Special Features', 'Gaming-focused, RGB keyboard, Vapor cooling'),

-- ROG Zephyrus G16 (2024) (49)
(49, 'Display Size', '16 inches'),
(49, 'Display Type', 'OLED (16:10)'),
(49, 'Resolution', '2560 x 1600 @ 240Hz'),
(49, 'Processor', 'Intel Core Ultra 9 / i9-14900HX'),
(49, 'GPU', 'NVIDIA GeForce RTX 4070 / 4080 Laptop'),
(49, 'RAM Options', '16GB / 32GB'),
(49, 'Storage Options', '1TB / 2TB PCIe SSD'),
(49, 'Battery Life', '10+ hours'),
(49, 'Weight', '1.85kg'),
(49, 'Operating System', 'Windows 11'),
(49, 'Ports', 'Thunderbolt 4, 2x USB-A, HDMI 2.1, 3.5mm'),
(49, 'Special Features', 'High-refresh OLED, Gaming beast, Vapor cooling'),

-- Acer Swift X 14 (2024) (50)
(50, 'Display Size', '14.5 inches'),
(50, 'Display Type', '2.8K OLED (16:10)'),
(50, 'Resolution', '2880 x 1800 @ 120Hz'),
(50, 'Processor', 'Intel Core Ultra 7'),
(50, 'GPU', 'NVIDIA GeForce RTX 4050 Laptop GPU'),
(50, 'RAM Options', '16GB / 32GB'),
(50, 'Storage Options', '512GB / 1TB PCIe SSD'),
(50, 'Battery Life', 'Up to 14 hours'),
(50, 'Weight', '1.55kg'),
(50, 'Operating System', 'Windows 11'),
(50, 'Ports', '2x USB-C (Thunderbolt), 2x USB-A, HDMI 2.1'),
(50, 'Special Features', 'Excellent value, OLED display, Balanced performance'),

-- Acer Swift Go 14 (2024) (51)
(51, 'Display Size', '14 inches'),
(51, 'Display Type', '2.8K OLED (16:10)'),
(51, 'Resolution', '2880 x 1800 @ 90Hz'),
(51, 'Processor', 'Intel Core Ultra 5 / 7'),
(51, 'GPU', 'Intel Arc Graphics'),
(51, 'RAM Options', '8GB / 16GB'),
(51, 'Storage Options', '256GB / 512GB PCIe SSD'),
(51, 'Battery Life', 'Up to 13 hours'),
(51, 'Weight', '1.25kg'),
(51, 'Operating System', 'Windows 11'),
(51, 'Ports', '2x USB-C, 2x USB-A, HDMI 2.1'),
(51, 'Special Features', 'Ultraportable, OLED, Good battery life'),

-- Surface Laptop 6 (52)
(52, 'Display Size', '13.5 / 15 inches'),
(52, 'Display Type', 'PixelSense (3:2)'),
(52, 'Resolution', '2880 x 1920 @ 60Hz'),
(52, 'Processor', 'Intel Core Ultra 7 / 9'),
(52, 'GPU', 'Intel Arc Graphics'),
(52, 'RAM Options', '16GB / 32GB'),
(52, 'Storage Options', '512GB / 1TB SSD'),
(52, 'Battery Life', 'Up to 18 hours'),
(52, 'Weight', '1.38kg / 1.77kg'),
(52, 'Operating System', 'Windows 11 Pro'),
(52, 'Ports', '2x Thunderbolt 4, USB-A, 3.5mm'),
(52, 'Special Features', 'Premium build, All-day battery, Sleek design'),

-- Surface Laptop Studio 2 (53)
(53, 'Display Size', '14.4 inches'),
(53, 'Display Type', 'PixelSense Flow (3:2) Touchscreen'),
(53, 'Resolution', '2400 x 1600 @ 120Hz'),
(53, 'Processor', 'Intel Core i7 / i9 H-series'),
(53, 'GPU', 'NVIDIA GeForce RTX 4050 / 4060 Laptop'),
(53, 'RAM Options', '16GB / 32GB'),
(53, 'Storage Options', '512GB / 1TB SSD'),
(53, 'Battery Life', 'Up to 19 hours'),
(53, 'Weight', '1.98kg'),
(53, 'Operating System', 'Windows 11'),
(53, 'Ports', '2x Thunderbolt 4, USB-A, microSDXC'),
(53, 'Special Features', 'Creator laptop, Touchscreen, Vapor cooling'),

-- Razer Blade 16 (54)
(54, 'Display Size', '16 inches'),
(54, 'Display Type', 'QHD+ Mini-LED (16:10)'),
(54, 'Resolution', '2560 x 1600 @ 240Hz'),
(54, 'Processor', 'Intel Core i9-14900HX'),
(54, 'GPU', 'NVIDIA GeForce RTX 4080 / 4090 Laptop'),
(54, 'RAM Options', '16GB / 32GB'),
(54, 'Storage Options', '1TB / 2TB PCIe SSD'),
(54, 'Battery Life', '6-8 hours'),
(54, 'Weight', '2.45kg'),
(54, 'Operating System', 'Windows 11'),
(54, 'Ports', 'Thunderbolt 4, 3x USB-A, HDMI 2.1, SD, 3.5mm'),
(54, 'Special Features', 'Ultimate gaming, 240Hz display, Premium build'),

-- Razer Blade 14 (55)
(55, 'Display Size', '14 inches'),
(55, 'Display Type', 'QHD+ IPS (16:10)'),
(55, 'Resolution', '2560 x 1600 @ 240Hz'),
(55, 'Processor', 'AMD Ryzen 9'),
(55, 'GPU', 'NVIDIA GeForce RTX 4070 Laptop'),
(55, 'RAM Options', '16GB / 32GB'),
(55, 'Storage Options', '1TB SSD'),
(55, 'Battery Life', '7-9 hours'),
(55, 'Weight', '1.84kg'),
(55, 'Operating System', 'Windows 11'),
(55, 'Ports', 'USB4, 2x USB-A, HDMI 2.1, 3.5mm'),
(55, 'Special Features', 'Compact gaming, High refresh, Magnesium chassis'),

-- MSI Stealth 16 Studio (56)
(56, 'Display Size', '16 inches'),
(56, 'Display Type', 'QHD+ IPS (16:10)'),
(56, 'Resolution', '2560 x 1600 @ 240Hz'),
(56, 'Processor', 'Intel Core i9'),
(56, 'GPU', 'NVIDIA GeForce RTX 4070 / 4080 Laptop'),
(56, 'RAM Options', '16GB / 32GB'),
(56, 'Storage Options', '1TB / 2TB SSD'),
(56, 'Battery Life', '8-10 hours'),
(56, 'Weight', '2.10kg'),
(56, 'Operating System', 'Windows 11'),
(56, 'Ports', 'Thunderbolt 4, 2x USB-A, HDMI 2.1, microSD'),
(56, 'Special Features', 'Studio-focused, Thin bezel, Premium keyboard'),

-- MSI Raider GE78 HX (57)
(57, 'Display Size', '17 inches'),
(57, 'Display Type', 'QHD+ IPS (16:10)'),
(57, 'Resolution', '2560 x 1600 @ 240Hz'),
(57, 'Processor', 'Intel Core i9-14900HX'),
(57, 'GPU', 'NVIDIA GeForce RTX 4090 Laptop'),
(57, 'RAM Options', '32GB / 64GB'),
(57, 'Storage Options', '1TB / 2TB SSD'),
(57, 'Battery Life', '5-6 hours'),
(57, 'Weight', '2.98kg'),
(57, 'Operating System', 'Windows 11'),
(57, 'Ports', 'Thunderbolt 4, 2x USB-A, HDMI 2.1, SD'),
(57, 'Special Features', 'Desktop replacement, RTX 4090, Cooling tech'),

-- Gigabyte AORUS 16X (58)
(58, 'Display Size', '16 inches'),
(58, 'Display Type', 'QHD+ IPS (16:10)'),
(58, 'Resolution', '2560 x 1600 @ 165Hz'),
(58, 'Processor', 'Intel Core i7 / i9 / Ultra'),
(58, 'GPU', 'NVIDIA GeForce RTX 4070 Laptop'),
(58, 'RAM Options', '16GB / 32GB'),
(58, 'Storage Options', '1TB PCIe SSD'),
(58, 'Battery Life', '8-10 hours'),
(58, 'Weight', '2.30kg'),
(58, 'Operating System', 'Windows 11'),
(58, 'Ports', 'Thunderbolt 4, 2x USB-A, HDMI 2.1, RJ-45'),
(58, 'Special Features', 'Professional gaming, RGB keyboard, Cooling'),

-- Galaxy Book4 Pro 14 (59)
(59, 'Display Size', '14 inches'),
(59, 'Display Type', '3K AMOLED (16:10)'),
(59, 'Resolution', '3072 x 1920 @ 120Hz'),
(59, 'Processor', 'Intel Core Ultra 7'),
(59, 'GPU', 'Intel Arc Graphics'),
(59, 'RAM Options', '16GB / 32GB'),
(59, 'Storage Options', '512GB / 1TB SSD'),
(59, 'Battery Life', 'Up to 12 hours'),
(59, 'Weight', '1.23kg'),
(59, 'Operating System', 'Windows 11'),
(59, 'Ports', '2x Thunderbolt 4, USB-A, HDMI 2.0, microSD'),
(59, 'Special Features', 'Samsung AMOLED, Lightweight, Samsung ecosystem'),

-- LG Gram 16 (60)
(60, 'Display Size', '16 inches'),
(60, 'Display Type', 'WQXGA IPS (16:10)'),
(60, 'Resolution', '2560 x 1600 @ 60Hz'),
(60, 'Processor', 'Intel Core Ultra 7'),
(60, 'GPU', 'Intel Arc Graphics'),
(60, 'RAM Options', '16GB / 32GB'),
(60, 'Storage Options', '512GB / 1TB SSD'),
(60, 'Battery Life', 'Up to 14 hours'),
(60, 'Weight', '1.19kg'),
(60, 'Operating System', 'Windows 11'),
(60, 'Ports', '2x Thunderbolt 4, 2x USB-A, HDMI, microSD'),
(60, 'Special Features', 'Super lightweight, Long battery, Magnesium'),

-- ==============================================
-- AUDIO & HEADPHONES TEMPLATE (Products 61-80)
-- Attributes: Type, Driver Size, Noise Cancellation, Battery Life, Charging Port, Bluetooth Version,
-- Audio Codecs, Water Resistance, Weight, Special Features
-- ==============================================

-- Sony WH-1000XM5 (61)
(61, 'Type', 'Over-ear wireless'),
(61, 'Driver Size', '30mm dynamic'),
(61, 'Noise Cancellation', 'Dual processors with adaptive ANC'),
(61, 'Battery Life', 'Up to 30 hours (ANC on), 40 hours (ANC off)'),
(61, 'Charging Port', 'USB-C'),
(61, 'Bluetooth Version', 'Bluetooth 5.2'),
(61, 'Audio Codecs', 'SBC, AAC, LDAC, LDAC HQ'),
(61, 'Water Resistance', 'No rating (not splash-proof)'),
(61, 'Weight', '250g'),
(61, 'Special Features', 'Multipoint connection, Ambient mode, Touch controls'),

-- Bose QuietComfort Ultra Headphones (62)
(62, 'Type', 'Over-ear wireless'),
(62, 'Driver Size', 'Custom Bose drivers'),
(62, 'Noise Cancellation', 'Advanced ANC with Aware mode'),
(62, 'Battery Life', 'Up to 24 hours (ANC on)'),
(62, 'Charging Port', 'USB-C'),
(62, 'Bluetooth Version', 'Bluetooth 5.3'),
(62, 'Audio Codecs', 'SBC, AAC, aptX, aptX Adaptive'),
(62, 'Water Resistance', 'No rating (not splash-proof)'),
(62, 'Weight', '250g'),
(62, 'Special Features', 'Multipoint connection, Comfort fit, Premium build'),

-- AirPods Pro (2nd gen, USB-C) (63)
(63, 'Type', 'True wireless in-ear'),
(63, 'Driver Size', 'Custom Apple dynamic driver'),
(63, 'Noise Cancellation', 'Active ANC, Adaptive Transparency'),
(63, 'Battery Life', 'Up to 6 hours (earbuds), 30 hours (with case)'),
(63, 'Charging Port', 'USB-C with MagSafe'),
(63, 'Bluetooth Version', 'Bluetooth 5.3'),
(63, 'Audio Codecs', 'AAC (Apple proprietary)'),
(63, 'Water Resistance', 'IPX4 (earbuds and case)'),
(63, 'Weight', '4.3g (per earbud)'),
(63, 'Special Features', 'Spatial Audio, H2 chip, Conversation Awareness'),

-- Sennheiser MOMENTUM 4 Wireless (64)
(64, 'Type', 'Over-ear wireless'),
(64, 'Driver Size', '42mm dynamic'),
(64, 'Noise Cancellation', 'Adaptive ANC'),
(64, 'Battery Life', 'Up to 60 hours (ANC on), 80 hours (ANC off)'),
(64, 'Charging Port', 'USB-C'),
(64, 'Bluetooth Version', 'Bluetooth 5.2'),
(64, 'Audio Codecs', 'SBC, AAC, aptX, aptX Adaptive'),
(64, 'Water Resistance', 'No rating'),
(64, 'Weight', '293g'),
(64, 'Special Features', 'Exceptional battery life, Comfortable fit, Premium sound'),

-- Bowers & Wilkins Px7 S2e (65)
(65, 'Type', 'Over-ear wireless'),
(65, 'Driver Size', '40mm biocellulose'),
(65, 'Noise Cancellation', 'Adaptive ANC'),
(65, 'Battery Life', 'Up to 30 hours (ANC on)'),
(65, 'Charging Port', 'USB-C'),
(65, 'Bluetooth Version', 'Bluetooth 5.2'),
(65, 'Audio Codecs', 'SBC, AAC, aptX, aptX Adaptive, aptX HD'),
(65, 'Water Resistance', 'No rating'),
(65, 'Weight', '307g'),
(65, 'Special Features', 'Premium sound, Multipoint, Intuitive controls'),

-- Bose QuietComfort Ultra Earbuds (66)
(66, 'Type', 'True wireless in-ear'),
(66, 'Driver Size', 'Bose balanced armature'),
(66, 'Noise Cancellation', 'Advanced ANC with Immersive Audio'),
(66, 'Battery Life', 'Up to 6 hours (earbuds), 24 hours (with case)'),
(66, 'Charging Port', 'USB-C with wireless charging case'),
(66, 'Bluetooth Version', 'Bluetooth 5.3'),
(66, 'Audio Codecs', 'SBC, AAC'),
(66, 'Water Resistance', 'IPX4'),
(66, 'Weight', '6.24g (per earbud)'),
(66, 'Special Features', 'Multipoint connection, Aware mode, Signature Bose ANC'),

-- Sony WF-1000XM5 (67)
(67, 'Type', 'True wireless in-ear'),
(67, 'Driver Size', '8.4mm dynamic'),
(67, 'Noise Cancellation', 'Dual proprietary processors with ANC'),
(67, 'Battery Life', 'Up to 8 hours (ANC on), 12 hours (ANC off)'),
(67, 'Charging Port', 'USB-C with Qi wireless'),
(67, 'Bluetooth Version', 'Bluetooth 5.3'),
(67, 'Audio Codecs', 'SBC, AAC, LDAC, LDAC HQ'),
(67, 'Water Resistance', 'IPX4'),
(67, 'Weight', '5.9g (per earbud)'),
(67, 'Special Features', 'Multipoint connection, Ambient mode, Stellar ANC'),

-- AirPods Max (68)
(68, 'Type', 'Over-ear wireless'),
(68, 'Driver Size', 'Custom Apple dynamic driver'),
(68, 'Noise Cancellation', 'Active ANC, Transparency mode'),
(68, 'Battery Life', 'Up to 20 hours'),
(68, 'Charging Port', 'Lightning connector'),
(68, 'Bluetooth Version', 'Bluetooth 5.0'),
(68, 'Audio Codecs', 'AAC (Apple proprietary)'),
(68, 'Water Resistance', 'No rating'),
(68, 'Weight', '384.8g'),
(68, 'Special Features', 'Spatial Audio, Digital Crown, Premium build'),

-- Beats Studio Pro (69)
(69, 'Type', 'Over-ear wireless'),
(69, 'Driver Size', '40mm driver'),
(69, 'Noise Cancellation', 'ANC and Transparency mode'),
(69, 'Battery Life', 'Up to 40 hours'),
(69, 'Charging Port', 'USB-C'),
(69, 'Bluetooth Version', 'Bluetooth 5.3'),
(69, 'Audio Codecs', 'SBC, AAC'),
(69, 'Water Resistance', 'No rating'),
(69, 'Weight', '260g'),
(69, 'Special Features', 'Fast charging (10min = 4hrs), Premium sound, Iconic design'),

-- Soundcore Liberty 4 NC (70)
(70, 'Type', 'True wireless in-ear'),
(70, 'Driver Size', '10.2mm driver'),
(70, 'Noise Cancellation', 'Adaptive ANC 2.0'),
(70, 'Battery Life', 'Up to 10 hours (ANC on), 14 hours (ANC off)'),
(70, 'Charging Port', 'USB-C'),
(70, 'Bluetooth Version', 'Bluetooth 5.3'),
(70, 'Audio Codecs', 'SBC, AAC, LDAC'),
(70, 'Water Resistance', 'IPX4'),
(70, 'Weight', '4.2g (per earbud)'),
(70, 'Special Features', 'Multipoint connection, LDAC support, 50H case battery'),

-- Jabra Elite 10 (71)
(71, 'Type', 'True wireless in-ear'),
(71, 'Driver Size', '8.8mm driver'),
(71, 'Noise Cancellation', 'Advanced ANC'),
(71, 'Battery Life', 'Up to 8 hours (ANC on), 12 hours (ANC off)'),
(71, 'Charging Port', 'USB-C with wireless charging'),
(71, 'Bluetooth Version', 'Bluetooth 5.3'),
(71, 'Audio Codecs', 'SBC, AAC, aptX, aptX Adaptive'),
(71, 'Water Resistance', 'IP57'),
(71, 'Weight', '5.4g (per earbud)'),
(71, 'Special Features', 'Multipoint connection, Call quality, Fast pairing'),

-- Samsung Galaxy Buds2 Pro (72)
(72, 'Type', 'True wireless in-ear'),
(72, 'Driver Size', '5.4mm woofer + 6.5mm tweeter (dual driver)'),
(72, 'Noise Cancellation', 'Intelligent ANC'),
(72, 'Battery Life', 'Up to 5 hours (ANC on), 8 hours (ANC off)'),
(72, 'Charging Port', 'USB-C with wireless charging'),
(72, 'Bluetooth Version', 'Bluetooth 5.3'),
(72, 'Audio Codecs', 'SSC (Samsung proprietary), AAC, SBC'),
(72, 'Water Resistance', 'IPX7'),
(72, 'Weight', '6.4g (per earbud)'),
(72, 'Special Features', 'Seamless Samsung integration, 360-degree sound'),

-- Google Pixel Buds Pro (73)
(73, 'Type', 'True wireless in-ear'),
(73, 'Driver Size', 'Custom-tuned dynamic speaker'),
(73, 'Noise Cancellation', 'Active Noise Cancellation'),
(73, 'Battery Life', 'Up to 11 hours (earbuds), 31 hours (with case)'),
(73, 'Charging Port', 'USB-C with wireless charging'),
(73, 'Bluetooth Version', 'Bluetooth 5.0'),
(73, 'Audio Codecs', 'SBC, AAC'),
(73, 'Water Resistance', 'IPX4'),
(73, 'Weight', '6.2g (per earbud)'),
(73, 'Special Features', 'Google Assistant integration, Real-time translate, Fast Pair'),

-- Nothing Ear (2024) (74)
(74, 'Type', 'True wireless in-ear'),
(74, 'Driver Size', '10.9mm driver'),
(74, 'Noise Cancellation', 'Smart ANC up to 45 dB reduction'),
(74, 'Battery Life', 'Up to 8.5 hours (ANC on), 10.5 hours (ANC off)'),
(74, 'Charging Port', 'USB-C with wireless charging'),
(74, 'Bluetooth Version', 'Bluetooth 5.3'),
(74, 'Audio Codecs', 'SBC, AAC, LDAC'),
(74, 'Water Resistance', 'IP54'),
(74, 'Weight', '4.3g (per earbud)'),
(74, 'Special Features', 'Unique design, Excellent ANC, Multipoint'),

-- JBL Tour One M2 (75)
(75, 'Type', 'Over-ear wireless'),
(75, 'Driver Size', '40mm dynamic'),
(75, 'Noise Cancellation', 'True Adaptive ANC'),
(75, 'Battery Life', 'Up to 50 hours (ANC off), 35 hours (ANC on)'),
(75, 'Charging Port', 'USB-C'),
(75, 'Bluetooth Version', 'Bluetooth 5.3'),
(75, 'Audio Codecs', 'SBC, AAC'),
(75, 'Water Resistance', 'No rating'),
(75, 'Weight', '278g'),
(75, 'Special Features', 'Exceptional battery, Multipoint connection, Signature JBL sound'),

-- Shure AONIC 50 Gen 2 (76)
(76, 'Type', 'Over-ear wireless'),
(76, 'Driver Size', '40mm driver'),
(76, 'Noise Cancellation', 'Adjustable ANC'),
(76, 'Battery Life', 'Up to 45 hours'),
(76, 'Charging Port', 'USB-C'),
(76, 'Bluetooth Version', 'Bluetooth 5.0'),
(76, 'Audio Codecs', 'SBC, AAC, aptX, aptX HD, aptX Adaptive'),
(76, 'Water Resistance', 'No rating'),
(76, 'Weight', '334g'),
(76, 'Special Features', 'Professional-grade, Adjustable ANC, Excellent connectivity'),

-- Sonos Ace (77)
(77, 'Type', 'Over-ear wireless'),
(77, 'Driver Size', 'Custom drivers'),
(77, 'Noise Cancellation', 'Active ANC with Aware mode'),
(77, 'Battery Life', 'Up to 30 hours'),
(77, 'Charging Port', 'USB-C'),
(77, 'Bluetooth Version', 'Bluetooth 5.4'),
(77, 'Audio Codecs', 'SBC, AAC'),
(77, 'Water Resistance', 'No rating'),
(77, 'Weight', '312g'),
(77, 'Special Features', 'Spatial Audio, Sonos ecosystem, Premium construction'),

-- Technics EAH-AZ80 (78)
(78, 'Type', 'True wireless in-ear'),
(78, 'Driver Size', '6.4mm dynamic driver'),
(78, 'Noise Cancellation', 'Dual hybrid ANC'),
(78, 'Battery Life', 'Up to 7 hours (ANC on), 10 hours (ANC off)'),
(78, 'Charging Port', 'USB-C with wireless charging'),
(78, 'Bluetooth Version', 'Bluetooth 5.3'),
(78, 'Audio Codecs', 'SBC, AAC, LDAC, LDAC HQ'),
(78, 'Water Resistance', 'IPX4'),
(78, 'Weight', '5.4g (per earbud)'),
(78, 'Special Features', 'Audiophile sound, LDAC support, Multipoint'),

-- Bose SoundLink Flex (79)
(79, 'Type', 'Portable Bluetooth speaker'),
(79, 'Driver Size', 'Custom full-range drivers'),
(79, 'Noise Cancellation', 'Not applicable'),
(79, 'Battery Life', 'Up to 12 hours'),
(79, 'Charging Port', 'USB-C'),
(79, 'Bluetooth Version', 'Bluetooth 4.2'),
(79, 'Audio Codecs', 'SBC'),
(79, 'Water Resistance', 'IP67 (waterproof)'),
(79, 'Weight', '600g'),
(79, 'Special Features', 'Waterproof, 360° sound, Flexible design'),

-- Marshall Motif II ANC (80)
(80, 'Type', 'True wireless in-ear'),
(80, 'Driver Size', '8.8mm dynamic driver'),
(80, 'Noise Cancellation', 'Active Noise Cancellation'),
(80, 'Battery Life', 'Up to 6 hours (ANC on), 9 hours (ANC off)'),
(80, 'Charging Port', 'USB-C with wireless charging'),
(80, 'Bluetooth Version', 'Bluetooth 5.3'),
(80, 'Audio Codecs', 'SBC, AAC'),
(80, 'Water Resistance', 'IPX5'),
(80, 'Weight', '6.3g (per earbud)'),
(80, 'Special Features', 'Iconic Marshall design, Great sound, Signature style'),

-- ==============================================
-- WEARABLES TEMPLATE (Products 81-100)
-- Attributes: Type, Display Type, Display Size, Case Size, Processor, Sensors, Battery Life,
-- Water Resistance, Operating System, Connectivity, Special Features
-- ==============================================

-- Apple Watch Series 9 (81)
(81, 'Type', 'Smartwatch'),
(81, 'Display Type', 'LTPO OLED Retina'),
(81, 'Display Size', '1.69" / 1.84" (41mm / 45mm)'),
(81, 'Case Size', '41mm / 45mm'),
(81, 'Processor', 'Apple S9 SiP'),
(81, 'Sensors', 'ECG, PPG, Blood oxygen, Temperature, Compass, Altimeter, Accelerometer'),
(81, 'Battery Life', 'Up to 18 hours (low power up to 36 hours)'),
(81, 'Water Resistance', '50m (WR50)'),
(81, 'Operating System', 'watchOS 10'),
(81, 'Connectivity', 'GPS, Wi-Fi, Bluetooth 5.3, NFC, optional LTE'),
(81, 'Special Features', 'Double tap gesture, Always-on Retina, Fitness tracking'),

-- Apple Watch Ultra 2 (82)
(82, 'Type', 'Rugged smartwatch'),
(82, 'Display Type', 'LTPO OLED Retina'),
(82, 'Display Size', '1.92" (49mm)'),
(82, 'Case Size', '49mm titanium'),
(82, 'Processor', 'Apple S9 SiP'),
(82, 'Sensors', 'ECG, PPG, Blood oxygen, Temperature, Depth gauge, Compass, Altimeter'),
(82, 'Battery Life', 'Up to 36 hours (low power up to 72 hours)'),
(82, 'Water Resistance', '100m (EN13319) + diving'),
(82, 'Operating System', 'watchOS 10'),
(82, 'Connectivity', 'Dual-frequency GPS, Wi-Fi, Bluetooth 5.3, LTE'),
(82, 'Special Features', 'Rugged titanium, Action button, Emergency SOS, Depth tracking'),

-- Galaxy Watch6 (83)
(83, 'Type', 'Smartwatch'),
(83, 'Display Type', 'Super AMOLED'),
(83, 'Display Size', '1.3" / 1.4" (40mm / 44mm)'),
(83, 'Case Size', '40mm / 44mm'),
(83, 'Processor', 'Exynos W930'),
(83, 'Sensors', 'BioActive (HR, ECG, BIA), Temperature, Accelerometer, Barometer, Gyroscope'),
(83, 'Battery Life', 'Up to 40 hours'),
(83, 'Water Resistance', '5ATM + IP68, MIL-STD-810H'),
(83, 'Operating System', 'Wear OS (One UI Watch)'),
(83, 'Connectivity', 'GPS, Bluetooth 5.3, Wi-Fi, NFC'),
(83, 'Special Features', 'BioActive sensors, Always-on display, Samsung Health integration'),

-- Galaxy Watch6 Classic (84)
(84, 'Type', 'Smartwatch with rotating bezel'),
(84, 'Display Type', 'Super AMOLED'),
(84, 'Display Size', '1.3" / 1.4" (43mm / 47mm)'),
(84, 'Case Size', '43mm / 47mm'),
(84, 'Processor', 'Exynos W930'),
(84, 'Sensors', 'BioActive (HR, ECG, BIA), Temperature, Accelerometer, Barometer, Gyroscope'),
(84, 'Battery Life', 'Up to 40 hours'),
(84, 'Water Resistance', '5ATM + IP68, MIL-STD-810H'),
(84, 'Operating System', 'Wear OS (One UI Watch)'),
(84, 'Connectivity', 'GPS, Bluetooth 5.3, Wi-Fi, NFC'),
(84, 'Special Features', 'Rotating bezel, Classic design, BioActive sensors'),

-- Pixel Watch 2 (85)
(85, 'Type', 'Smartwatch'),
(85, 'Display Type', 'AMOLED'),
(85, 'Display Size', '1.2 inches (34mm)'),
(85, 'Case Size', '41mm'),
(85, 'Processor', 'Qualcomm Snapdragon W5 Gen 1'),
(85, 'Sensors', 'Multi-path HR, ECG, SpO2, Skin temperature, Accelerometer'),
(85, 'Battery Life', 'Up to 24 hours'),
(85, 'Water Resistance', '5ATM'),
(85, 'Operating System', 'Wear OS 4'),
(85, 'Connectivity', 'GPS, Bluetooth 5.0, Wi-Fi, NFC, optional LTE'),
(85, 'Special Features', 'Google Assistant, Fitbit integration, Temperature sensor'),

-- Garmin fēnix 7 Pro (86)
(86, 'Type', 'Outdoor multisport watch'),
(86, 'Display Type', 'MIP sunlight-visible'),
(86, 'Display Size', '1.3 inches (32mm / 43mm)'),
(86, 'Case Size', '47mm / 51mm'),
(86, 'Processor', 'Garmin-proprietary'),
(86, 'Sensors', 'Multi-band GPS, Altimeter, Compass, Pulse Ox, HR, Temperature, Pressure'),
(86, 'Battery Life', 'Up to 18 days (47mm), up to 37 days (51mm), solar extends'),
(86, 'Water Resistance', '10 ATM'),
(86, 'Operating System', 'Garmin OS'),
(86, 'Connectivity', 'Bluetooth, Wi-Fi, ANT+'),
(86, 'Special Features', 'Solar charging, Multi-band GPS, Maps, Sport tracking'),

-- Garmin Forerunner 965 (87)
(87, 'Type', 'Performance running watch'),
(87, 'Display Type', 'AMOLED'),
(87, 'Display Size', '1.4 inches (47mm)'),
(87, 'Case Size', '47mm'),
(87, 'Processor', 'Garmin-proprietary'),
(87, 'Sensors', 'Multi-band GPS, HR, Pulse Ox, Barometer, Accelerometer, Compass'),
(87, 'Battery Life', 'Up to 23 days (smartwatch mode), 11 hours (GPS mode)'),
(87, 'Water Resistance', '5 ATM'),
(87, 'Operating System', 'Garmin OS'),
(87, 'Connectivity', 'Bluetooth, Wi-Fi, ANT+'),
(87, 'Special Features', 'AMOLED display, Running metrics, TrainingPeaks integration'),

-- Garmin Venu 3 (88)
(88, 'Type', 'Health & fitness smartwatch'),
(88, 'Display Type', 'AMOLED'),
(88, 'Display Size', '1.4" / 1.2" (45mm / 41mm)'),
(88, 'Case Size', '45mm / 41mm (Venu 3S)'),
(88, 'Processor', 'Garmin-proprietary'),
(88, 'Sensors', 'HR, Pulse Ox, Barometer, Accelerometer, Gyroscope, Compass'),
(88, 'Battery Life', 'Up to 14 days (45mm), up to 10 days (41mm)'),
(88, 'Water Resistance', '5 ATM'),
(88, 'Operating System', 'Garmin OS'),
(88, 'Connectivity', 'Bluetooth, Wi-Fi, ANT+'),
(88, 'Special Features', 'AMOLED display, Health tracking, Music storage'),

-- Fitbit Sense 2 (89)
(89, 'Type', 'Health smartwatch'),
(89, 'Display Type', 'AMOLED'),
(89, 'Display Size', '1.58 inches'),
(89, 'Case Size', 'Standard'),
(89, 'Processor', 'Fitbit-proprietary'),
(89, 'Sensors', 'cEDA (stress), ECG, SpO2, Skin temperature, Accelerometer, Gyroscope'),
(89, 'Battery Life', 'Up to 6 days'),
(89, 'Water Resistance', '50m'),
(89, 'Operating System', 'Fitbit OS'),
(89, 'Connectivity', 'Bluetooth 5.0, NFC, GPS'),
(89, 'Special Features', 'Stress detection, Google Fit integration, Health Metrics'),

-- Fitbit Charge 6 (90)
(90, 'Type', 'Fitness tracker'),
(90, 'Display Type', 'AMOLED'),
(90, 'Display Size', '1.56 inches'),
(90, 'Case Size', 'Standard'),
(90, 'Processor', 'Fitbit-proprietary'),
(90, 'Sensors', 'HR, SpO2, ECG, Skin temperature, Accelerometer'),
(90, 'Battery Life', 'Up to 7 days'),
(90, 'Water Resistance', '50m'),
(90, 'Operating System', 'Fitbit OS'),
(90, 'Connectivity', 'Bluetooth 5.0, NFC, Built-in GPS'),
(90, 'Special Features', 'Built-in GPS, NFC payment, Health data tracking'),

-- Oura Ring Gen 3 (91)
(91, 'Type', 'Smart ring'),
(91, 'Display Type', 'None (no display)'),
(91, 'Display Size', 'N/A'),
(91, 'Case Size', 'US sizes 6-13'),
(91, 'Processor', 'Oura-proprietary'),
(91, 'Sensors', 'Infrared LEDs, Temperature, Accelerometer, Gyroscope'),
(91, 'Battery Life', 'Up to 7 days'),
(91, 'Water Resistance', '100m'),
(91, 'Operating System', 'Oura app (iOS/Android)'),
(91, 'Connectivity', 'Bluetooth Low Energy'),
(91, 'Special Features', 'Sleep tracking, Readiness score, Temperature sensing'),

-- Xiaomi Watch 2 Pro (92)
(92, 'Type', 'Smartwatch'),
(92, 'Display Type', 'AMOLED'),
(92, 'Display Size', '1.43 inches (466x466)'),
(92, 'Case Size', '46mm'),
(92, 'Processor', 'Snapdragon W5+ Gen 1'),
(92, 'Sensors', 'HR, SpO2, Temperature, Accelerometer, Barometer, Compass'),
(92, 'Battery Life', 'Up to 65 hours (Bluetooth), 27 hours (LTE)'),
(92, 'Water Resistance', '5 ATM'),
(92, 'Operating System', 'Wear OS 4'),
(92, 'Connectivity', 'Bluetooth 5.2, Wi-Fi, NFC, optional LTE, GNSS'),
(92, 'Special Features', 'Long battery life, Dual GNSS, LTE option'),

-- Huawei Watch GT 4 (93)
(93, 'Type', 'Smartwatch'),
(93, 'Display Type', 'AMOLED'),
(93, 'Display Size', '1.43" / 1.2" (46mm / 41mm)'),
(93, 'Case Size', '46mm / 41mm'),
(93, 'Processor', 'Huawei-proprietary'),
(93, 'Sensors', 'HR, SpO2, Temperature, Accelerometer, Compass, Gyroscope'),
(93, 'Battery Life', 'Up to 7 days (46mm) / 14 days (41mm)'),
(93, 'Water Resistance', '5 ATM'),
(93, 'Operating System', 'HarmonyOS'),
(93, 'Connectivity', 'Bluetooth 5.2, GNSS'),
(93, 'Special Features', 'Long battery life, Music storage, GNSS'),

-- Amazfit Balance (94)
(94, 'Type', 'Smartwatch'),
(94, 'Display Type', 'AMOLED'),
(94, 'Display Size', '1.5 inches (46mm)'),
(94, 'Case Size', '46mm'),
(94, 'Processor', 'Amazfit-proprietary'),
(94, 'Sensors', 'HR, SpO2, Stress, Sleep, Accelerometer, Barometer, Compass'),
(94, 'Battery Life', 'Up to 14 days'),
(94, 'Water Resistance', '5 ATM'),
(94, 'Operating System', 'Zepp OS'),
(94, 'Connectivity', 'Bluetooth 5.0, Dual-band GPS, NFC (select)'),
(94, 'Special Features', 'Stress monitoring, Long battery, Music storage'),

-- Suunto Vertical (95)
(95, 'Type', 'Outdoor GPS watch'),
(95, 'Display Type', 'MIP (sunlight-visible)'),
(95, 'Display Size', '1.4 inches (49mm)'),
(95, 'Case Size', '49mm'),
(95, 'Processor', 'Suunto-proprietary'),
(95, 'Sensors', 'Multi-band GNSS, Altimeter, Compass, Temperature, Accelerometer'),
(95, 'Battery Life', 'Up to 60 days (varies by mode, solar extends)'),
(95, 'Water Resistance', '100m'),
(95, 'Operating System', 'Suunto OS'),
(95, 'Connectivity', 'Bluetooth, Multi-band GNSS, Offline maps'),
(95, 'Special Features', 'Solar charging, Rugged design, Offline navigation'),

-- Polar Vantage V3 (96)
(96, 'Type', 'Multisport watch'),
(96, 'Display Type', 'AMOLED'),
(96, 'Display Size', '1.39 inches (47mm)'),
(96, 'Case Size', '47mm'),
(96, 'Processor', 'Polar-proprietary'),
(96, 'Sensors', 'ECG, SpO2, Skin temperature, Dual-band GPS, HR, Barometer'),
(96, 'Battery Life', 'Up to 8 days (smartwatch), 40 hours (GPS)'),
(96, 'Water Resistance', '50m'),
(96, 'Operating System', 'Polar OS'),
(96, 'Connectivity', 'Bluetooth, Dual-band GPS'),
(96, 'Special Features', 'ECG & SpO2, Training load tracking, Running metrics'),

-- Apple Watch SE (2nd gen) (97)
(97, 'Type', 'Smartwatch'),
(97, 'Display Type', 'Retina OLED'),
(97, 'Display Size', '1.57" / 1.70" (40mm / 44mm)'),
(97, 'Case Size', '40mm / 44mm'),
(97, 'Processor', 'Apple S8 SiP'),
(97, 'Sensors', 'HR, Accelerometer, Gyroscope, Compass, Altimeter'),
(97, 'Battery Life', 'Up to 18 hours'),
(97, 'Water Resistance', '50m (WR50)'),
(97, 'Operating System', 'watchOS 10'),
(97, 'Connectivity', 'GPS, Wi-Fi, Bluetooth 5.3, NFC, optional LTE'),
(97, 'Special Features', 'Fitness tracking, Fall detection, Emergency SOS'),

-- Galaxy Watch5 Pro (98)
(98, 'Type', 'Rugged smartwatch'),
(98, 'Display Type', 'Super AMOLED'),
(98, 'Display Size', '1.4 inches (45mm)'),
(98, 'Case Size', '45mm titanium'),
(98, 'Processor', 'Exynos W920'),
(98, 'Sensors', 'BioActive (HR, ECG, BIA), Temperature, Barometer, Compass, Accelerometer'),
(98, 'Battery Life', 'Up to 80 hours'),
(98, 'Water Resistance', '5ATM + IP68, MIL-STD-810H'),
(98, 'Operating System', 'Wear OS (One UI Watch)'),
(98, 'Connectivity', 'GPS, Bluetooth 5.2, Wi-Fi, NFC'),
(98, 'Special Features', 'Titanium case, Sapphire crystal, Extended battery'),

-- WHOOP 4.0 (99)
(99, 'Type', 'Screenless fitness band'),
(99, 'Display Type', 'None (no display)'),
(99, 'Display Size', 'N/A'),
(99, 'Case Size', 'One size fits all'),
(99, 'Processor', 'WHOOP-proprietary'),
(99, 'Sensors', 'PPG (photoplethysmography), Temperature, Accelerometer'),
(99, 'Battery Life', 'Up to 5 days'),
(99, 'Water Resistance', '5 ATM'),
(99, 'Operating System', 'WHOOP app (iOS/Android)'),
(99, 'Connectivity', 'Bluetooth LE'),
(99, 'Special Features', 'Strain, recovery, sleep tracking, Subscription-based'),

-- Samsung Galaxy Ring (100)
(100, 'Type', 'Smart ring'),
(100, 'Display Type', 'None (no display)'),
(100, 'Display Size', 'N/A'),
(100, 'Case Size', 'US sizes 5-13 (titanium)'),
(100, 'Processor', 'Samsung-proprietary'),
(100, 'Sensors', 'PPG, Skin temperature, Accelerometer'),
(100, 'Battery Life', 'Up to 7 days'),
(100, 'Water Resistance', '10 ATM'),
(100, 'Operating System', 'Samsung Health app (Android)'),
(100, 'Connectivity', 'Bluetooth LE'),
(100, 'Special Features', 'Health tracking, Samsung integration, Premium design');

-- Ensure option codes exist (ids fixed for reference)
INSERT INTO product_options (id, code) VALUES
    (1, 'COLOR'),
    (2, 'STORAGE'),
    (3, 'RAM'),
    (4, 'CPU'),
    (5, 'GPU')
ON DUPLICATE KEY UPDATE code = VALUES(code);

-- Product variants for Smartphones (base price = min price per product)
INSERT INTO product_variants (
    id,
    product_id,
    price,
    discount_percent,
    status,
    created_at,
    updated_at,
    version
) VALUES
    -- Apple iPhone 15 Pro (id=1)
    (1, 1, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (2, 1, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (3, 1, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (4, 1, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (5, 1, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (6, 1, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (7, 1, 999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (8, 1, 999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (9, 1, 999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple iPhone 15 (id=2)
    (10, 2, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (11, 2, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (12, 2, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (13, 2, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (14, 2, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (15, 2, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (16, 2, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (17, 2, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (18, 2, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy S24 Ultra (id=3)
    (19, 3, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (20, 3, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (21, 3, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (22, 3, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (23, 3, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (24, 3, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (25, 3, 1299.00, 8, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (26, 3, 1299.00, 8, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (27, 3, 1299.00, 8, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy S24 (id=4)
    (28, 4, 899.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (29, 4, 899.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (30, 4, 899.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (31, 4, 899.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (32, 4, 899.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (33, 4, 899.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (34, 4, 899.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (35, 4, 899.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (36, 4, 899.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Google Pixel 8 Pro (id=5)
    (37, 5, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (38, 5, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (39, 5, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (40, 5, 999.00, 10, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (41, 5, 999.00, 10, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (42, 5, 999.00, 10, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (43, 5, 999.00, 10, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (44, 5, 999.00, 10, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (45, 5, 999.00, 10, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Google Pixel 8 (id=6)
    (46, 6, 699.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (47, 6, 699.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (48, 6, 699.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (49, 6, 699.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (50, 6, 699.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (51, 6, 699.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- OnePlus 12 (id=7)
    (52, 7, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (53, 7, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (54, 7, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (55, 7, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Xiaomi 14 (id=8)
    (56, 8, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (57, 8, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (58, 8, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (59, 8, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (60, 8, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (61, 8, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Sony Xperia 1 V (id=9)
    (62, 9, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (63, 9, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (64, 9, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (65, 9, 1199.00, 10, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (66, 9, 1199.00, 10, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (67, 9, 1199.00, 10, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- ASUS ROG Phone 8 Pro (id=10)
    (68, 10, 1099.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (69, 10, 1099.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (70, 10, 1099.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (71, 10, 1099.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple iPhone 15 Pro Max (id=11)
    (72, 11, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (73, 11, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (74, 11, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (75, 11, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (76, 11, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (77, 11, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (78, 11, 1199.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (79, 11, 1199.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (80, 11, 1199.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple iPhone 14 Pro (id=12)
    (81, 12, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (82, 12, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (83, 12, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (84, 12, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Z Fold5 (id=13)
    (85, 13, 1799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (86, 13, 1799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (87, 13, 1799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (88, 13, 1799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (89, 13, 1799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (90, 13, 1799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (91, 13, 1799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (92, 13, 1799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (93, 13, 1799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Z Flip5 (id=14)
    (94, 14, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (95, 14, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (96, 14, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (97, 14, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy S24+ (id=15)
    (98, 15, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (99, 15, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (100, 15, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (101, 15, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Google Pixel 8a (id=16)
    (102, 16, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (103, 16, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (104, 16, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (105, 16, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Xiaomi 14 Ultra (id=17)
    (106, 17, 1499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (107, 17, 1499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (108, 17, 1499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (109, 17, 1499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- OnePlus 12R (id=18)
    (110, 18, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (111, 18, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (112, 18, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (113, 18, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Nothing Phone (2) (id=19)
    (114, 19, 649.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (115, 19, 649.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (116, 19, 649.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (117, 19, 649.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Sony Xperia 5 V (id=20)
    (118, 20, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (119, 20, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (120, 20, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (121, 20, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0);

-- Variant options for Smartphones (COLOR + STORAGE with extra_price)
INSERT INTO variant_options (
    variant_id,
    option_id,
    value,
    extra_price
) VALUES
    -- iPhone 15 Pro (1-9) base 999, color extras: limited none, storage extras: 128=0, 256=100, 512=300
    (1, 2, '128GB', 0.00), (1, 1, 'Natural Titanium', 0.00),
    (2, 2, '128GB', 0.00), (2, 1, 'Blue Titanium', 0.00),
    (3, 2, '128GB', 0.00), (3, 1, 'Black Titanium', 0.00),

    (4, 2, '256GB', 100.00), (4, 1, 'Natural Titanium', 0.00),
    (5, 2, '256GB', 100.00), (5, 1, 'Blue Titanium', 0.00),
    (6, 2, '256GB', 100.00), (6, 1, 'Black Titanium', 0.00),

    (7, 2, '512GB', 300.00), (7, 1, 'Natural Titanium', 0.00),
    (8, 2, '512GB', 300.00), (8, 1, 'Blue Titanium', 0.00),
    (9, 2, '512GB', 300.00), (9, 1, 'Black Titanium', 0.00),

    -- iPhone 15 (10-18) base 799, color extras: Pink=+20 (limited), storage extras: 128=0, 256=100, 512=300
    (10, 2, '128GB', 0.00), (10, 1, 'Blue', 0.00),
    (11, 2, '128GB', 0.00), (11, 1, 'Pink', 20.00),
    (12, 2, '128GB', 0.00), (12, 1, 'Black', 0.00),

    (13, 2, '256GB', 100.00), (13, 1, 'Blue', 0.00),
    (14, 2, '256GB', 100.00), (14, 1, 'Pink', 20.00),
    (15, 2, '256GB', 100.00), (15, 1, 'Black', 0.00),

    (16, 2, '512GB', 300.00), (16, 1, 'Blue', 0.00),
    (17, 2, '512GB', 300.00), (17, 1, 'Pink', 20.00),
    (18, 2, '512GB', 300.00), (18, 1, 'Black', 0.00),

    -- Galaxy S24 Ultra (19-27) base 1299, color extras: Violet=+20 (limited), storage extras: 256=0, 512=100, 1TB=300
    (19, 2, '256GB', 0.00), (19, 1, 'Phantom Black', 0.00),
    (20, 2, '256GB', 0.00), (20, 1, 'Titanium Gray', 0.00),
    (21, 2, '256GB', 0.00), (21, 1, 'Violet', 20.00),
    (22, 2, '512GB', 100.00), (22, 1, 'Phantom Black', 0.00),
    (23, 2, '512GB', 100.00), (23, 1, 'Titanium Gray', 0.00),
    (24, 2, '512GB', 100.00), (24, 1, 'Violet', 20.00),
    (25, 2, '1TB', 300.00), (25, 1, 'Phantom Black', 0.00),
    (26, 2, '1TB', 300.00), (26, 1, 'Titanium Gray', 0.00),
    (27, 2, '1TB', 300.00), (27, 1, 'Violet', 20.00),

    -- Galaxy S24 (28-36) base 899, color extras: Cobalt Violet=+20 (limited), Amber Yellow=+15 (limited), storage extras: 128=0, 256=100, 512=200
    (28, 2, '128GB', 0.00), (28, 1, 'Cobalt Violet', 20.00),
    (29, 2, '128GB', 0.00), (29, 1, 'Marble Gray', 0.00),
    (30, 2, '128GB', 0.00), (30, 1, 'Amber Yellow', 15.00),
    (31, 2, '256GB', 100.00), (31, 1, 'Cobalt Violet', 20.00),
    (32, 2, '256GB', 100.00), (32, 1, 'Marble Gray', 0.00),
    (33, 2, '256GB', 100.00), (33, 1, 'Amber Yellow', 15.00),
    (34, 2, '512GB', 200.00), (34, 1, 'Cobalt Violet', 20.00),
    (35, 2, '512GB', 200.00), (35, 1, 'Marble Gray', 0.00),
    (36, 2, '512GB', 200.00), (36, 1, 'Amber Yellow', 15.00),

    -- Pixel 8 Pro (37-45) base 999, storage extras: 128=0, 256=100, 512=200
    (37, 2, '128GB', 0.00), (37, 1, 'Obsidian', 0.00),
    (38, 2, '128GB', 0.00), (38, 1, 'Bay', 0.00),
    (39, 2, '128GB', 0.00), (39, 1, 'Porcelain', 0.00),
    (40, 2, '256GB', 100.00), (40, 1, 'Obsidian', 0.00),
    (41, 2, '256GB', 100.00), (41, 1, 'Bay', 0.00),
    (42, 2, '256GB', 100.00), (42, 1, 'Porcelain', 0.00),
    (43, 2, '512GB', 200.00), (43, 1, 'Obsidian', 0.00),
    (44, 2, '512GB', 200.00), (44, 1, 'Bay', 0.00),
    (45, 2, '512GB', 200.00), (45, 1, 'Porcelain', 0.00),

    -- Pixel 8 (46-51) base 699, storage extras: 128=0, 256=60
    (46, 2, '128GB', 0.00), (46, 1, 'Obsidian', 0.00),
    (47, 2, '128GB', 0.00), (47, 1, 'Hazel', 0.00),
    (48, 2, '128GB', 0.00), (48, 1, 'Rose', 0.00),
    (49, 2, '256GB', 60.00), (49, 1, 'Obsidian', 0.00),
    (50, 2, '256GB', 60.00), (50, 1, 'Hazel', 0.00),
    (51, 2, '256GB', 60.00), (51, 1, 'Rose', 0.00),

    -- OnePlus 12 (52-55) base 799, storage extras: 256=0, 512=100
    (52, 2, '256GB', 0.00), (52, 1, 'Silky Black', 0.00),
    (53, 2, '256GB', 0.00), (53, 1, 'Flowy Emerald', 0.00),
    (54, 2, '512GB', 100.00), (54, 1, 'Silky Black', 0.00),
    (55, 2, '512GB', 100.00), (55, 1, 'Flowy Emerald', 0.00),

    -- Xiaomi 14 (56-61) base 799, storage extras: 256=0, 512=100
    (56, 2, '256GB', 0.00), (56, 1, 'Black', 0.00),
    (57, 2, '256GB', 0.00), (57, 1, 'Green', 0.00),
    (58, 2, '256GB', 0.00), (58, 1, 'White', 0.00),
    (59, 2, '512GB', 100.00), (59, 1, 'Black', 0.00),
    (60, 2, '512GB', 100.00), (60, 1, 'Green', 0.00),
    (61, 2, '512GB', 100.00), (61, 1, 'White', 0.00),

    -- Xperia 1 V (62-67) base 1199, storage extras: 256=0, 512=100
    (62, 2, '256GB', 0.00), (62, 1, 'Black', 0.00),
    (63, 2, '256GB', 0.00), (63, 1, 'Khaki Green', 0.00),
    (64, 2, '256GB', 0.00), (64, 1, 'Platinum Silver', 0.00),
    (65, 2, '512GB', 100.00), (65, 1, 'Black', 0.00),
    (66, 2, '512GB', 100.00), (66, 1, 'Khaki Green', 0.00),
    (67, 2, '512GB', 100.00), (67, 1, 'Platinum Silver', 0.00),

    -- ROG Phone 8 Pro (68-71) base 1099, storage extras: 256=0, 512=200
    (68, 2, '256GB', 0.00), (68, 1, 'Phantom Black', 0.00),
    (69, 2, '256GB', 0.00), (69, 1, 'Gray', 0.00),
    (70, 2, '512GB', 200.00), (70, 1, 'Phantom Black', 0.00),
    (71, 2, '512GB', 200.00), (71, 1, 'Gray', 0.00),

    -- iPhone 15 Pro Max (72-80) base 1199, color extras: limited none, storage extras: 256=0, 512=200, 1TB=400
    (72, 2, '256GB', 0.00), (72, 1, 'Natural Titanium', 0.00),
    (73, 2, '256GB', 0.00), (73, 1, 'Blue Titanium', 0.00),
    (74, 2, '256GB', 0.00), (74, 1, 'Black Titanium', 0.00),
    (75, 2, '512GB', 200.00), (75, 1, 'Natural Titanium', 0.00),
    (76, 2, '512GB', 200.00), (76, 1, 'Blue Titanium', 0.00),
    (77, 2, '512GB', 200.00), (77, 1, 'Black Titanium', 0.00),
    (78, 2, '1TB', 400.00), (78, 1, 'Natural Titanium', 0.00),
    (79, 2, '1TB', 400.00), (79, 1, 'Blue Titanium', 0.00),
    (80, 2, '1TB', 400.00), (80, 1, 'Black Titanium', 0.00),

    -- iPhone 14 Pro (81-84) base 999, color extras: Deep Purple=+25 (limited), storage extras: 128=0, 256=100
    (81, 2, '128GB', 0.00), (81, 1, 'Space Black', 0.00),
    (82, 2, '128GB', 0.00), (82, 1, 'Deep Purple', 25.00),
    (83, 2, '256GB', 100.00), (83, 1, 'Space Black', 0.00),
    (84, 2, '256GB', 100.00), (84, 1, 'Deep Purple', 25.00),

    -- Galaxy Z Fold5 (85-93) base 1799, storage extras: 256=0, 512=120, 1TB=360
    (85, 2, '256GB', 0.00), (85, 1, 'Icy Blue', 0.00),
    (86, 2, '256GB', 0.00), (86, 1, 'Phantom Black', 0.00),
    (87, 2, '256GB', 0.00), (87, 1, 'Cream', 0.00),
    (88, 2, '512GB', 120.00), (88, 1, 'Icy Blue', 0.00),
    (89, 2, '512GB', 120.00), (89, 1, 'Phantom Black', 0.00),
    (90, 2, '512GB', 120.00), (90, 1, 'Cream', 0.00),
    (91, 2, '1TB', 360.00), (91, 1, 'Icy Blue', 0.00),
    (92, 2, '1TB', 360.00), (92, 1, 'Phantom Black', 0.00),
    (93, 2, '1TB', 360.00), (93, 1, 'Cream', 0.00),

    -- Galaxy Z Flip5 (94-97) base 999, storage extras: 256=0, 512=120
    (94, 2, '256GB', 0.00), (94, 1, 'Mint', 0.00),
    (95, 2, '256GB', 0.00), (95, 1, 'Graphite', 0.00),
    (96, 2, '512GB', 120.00), (96, 1, 'Mint', 0.00),
    (97, 2, '512GB', 120.00), (97, 1, 'Graphite', 0.00),

    -- Galaxy S24+ (98-101) base 999, storage extras: 256=0, 512=120
    (98, 2, '256GB', 0.00), (98, 1, 'Onyx Black', 0.00),
    (99, 2, '256GB', 0.00), (99, 1, 'Marble Gray', 0.00),
    (100, 2, '512GB', 120.00), (100, 1, 'Onyx Black', 0.00),
    (101, 2, '512GB', 120.00), (101, 1, 'Marble Gray', 0.00),

    -- Pixel 8a (102-105) base 499, storage extras: 128=0, 256=60
    (102, 2, '128GB', 0.00), (102, 1, 'Obsidian', 0.00),
    (103, 2, '128GB', 0.00), (103, 1, 'Aloe', 0.00),
    (104, 2, '256GB', 60.00), (104, 1, 'Obsidian', 0.00),
    (105, 2, '256GB', 60.00), (105, 1, 'Aloe', 0.00),

    -- Xiaomi 14 Ultra (106-109) base 1499, storage extras: 512=0, 1TB=200
    (106, 2, '512GB', 0.00), (106, 1, 'Black', 0.00),
    (107, 2, '512GB', 0.00), (107, 1, 'White', 0.00),
    (108, 2, '1TB', 200.00), (108, 1, 'Black', 0.00),
    (109, 2, '1TB', 200.00), (109, 1, 'White', 0.00),

    -- OnePlus 12R (110-113) base 499, storage extras: 128=0, 256=100
    (110, 2, '128GB', 0.00), (110, 1, 'Cool Blue', 0.00),
    (111, 2, '128GB', 0.00), (111, 1, 'Iron Gray', 0.00),
    (112, 2, '256GB', 100.00), (112, 1, 'Cool Blue', 0.00),
    (113, 2, '256GB', 100.00), (113, 1, 'Iron Gray', 0.00),

    -- Nothing Phone (2) (114-117) base 649, storage extras: 256=0, 512=100
    (114, 2, '256GB', 0.00), (114, 1, 'White', 0.00),
    (115, 2, '256GB', 0.00), (115, 1, 'Dark Gray', 0.00),
    (116, 2, '512GB', 100.00), (116, 1, 'White', 0.00),
    (117, 2, '512GB', 100.00), (117, 1, 'Dark Gray', 0.00),

    -- Xperia 5 V (118-121) base 999, storage extras: 128=0, 256=50
    (118, 2, '128GB', 0.00), (118, 1, 'Black', 0.00),
    (119, 2, '128GB', 0.00), (119, 1, 'Blue', 0.00),
    (120, 2, '256GB', 50.00), (120, 1, 'Black', 0.00),
    (121, 2, '256GB', 50.00), (121, 1, 'Blue', 0.00);

    -- ========== LAPTOPS SECTION ==========
INSERT INTO product_variants (
    id,
    product_id,
    price,
    discount_percent,
    status,
    created_at,
    updated_at,
    version
) VALUES
    -- Apple MacBook Pro 14 (M3 Pro) (id=21) - 2 colors x 2 RAM x 2 SSD = 8 variants
    (122, 21, 1999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (123, 21, 1999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (124, 21, 1999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (125, 21, 1999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (126, 21, 1999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (127, 21, 1999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (128, 21, 1999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (129, 21, 1999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple MacBook Air 15 (M3) (id=22) - 2 colors x 3 RAM x 3 SSD = 18 variants
    (130, 22, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (131, 22, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (132, 22, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (133, 22, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (134, 22, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (135, 22, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (136, 22, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (137, 22, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (138, 22, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (139, 22, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (140, 22, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (141, 22, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (142, 22, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (143, 22, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (144, 22, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (145, 22, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (146, 22, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (147, 22, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Dell XPS 14 (9440) (id=23) - 2 colors x 2 RAM x 2 SSD = 8 variants
    (148, 23, 1799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (149, 23, 1799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (150, 23, 1799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (151, 23, 1799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (152, 23, 1799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (153, 23, 1799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (154, 23, 1799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (155, 23, 1799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Dell XPS 13 (9340) (id=24) - 2 colors x 2 RAM x 2 SSD = 8 variants
    (156, 24, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (157, 24, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (158, 24, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (159, 24, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (160, 24, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (161, 24, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (162, 24, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (163, 24, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- HP Spectre x360 14 (id=25) - 2 colors x 2 RAM x 2 SSD = 8 variants
    (164, 25, 1599.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (165, 25, 1599.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (166, 25, 1599.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (167, 25, 1599.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (168, 25, 1599.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (169, 25, 1599.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (170, 25, 1599.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (171, 25, 1599.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Lenovo ThinkPad X1 Carbon Gen 12 (id=26) - 1 color x 2 RAM x 2 SSD = 4 variants
    (172, 26, 1699.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (173, 26, 1699.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (174, 26, 1699.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (175, 26, 1699.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Lenovo ThinkPad X1 Yoga Gen 9 (id=27) - 1 color x 2 RAM x 2 SSD = 4 variants
    (176, 27, 1799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (177, 27, 1799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (178, 27, 1799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (179, 27, 1799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- ASUS ROG Zephyrus G14 (2024) (id=28) - 2 colors x 2 RAM x 2 SSD = 8 variants
    (180, 28, 1899.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (181, 28, 1899.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (182, 28, 1899.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (183, 28, 1899.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (184, 28, 1899.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (185, 28, 1899.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (186, 28, 1899.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (187, 28, 1899.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- ASUS ROG Zephyrus G16 (2024) (id=29) - 2 colors x 2 RAM x 2 SSD = 8 variants
    (188, 29, 2099.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (189, 29, 2099.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (190, 29, 2099.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (191, 29, 2099.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (192, 29, 2099.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (193, 29, 2099.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (194, 29, 2099.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (195, 29, 2099.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Acer Swift X 14 (id=30) - 1 color x 2 RAM x 2 SSD = 4 variants
    (196, 30, 1099.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (197, 30, 1099.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (198, 30, 1099.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (199, 30, 1099.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Acer Swift Go 14 (id=31) - 1 color x 2 RAM x 2 SSD = 4 variants
    (200, 31, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (201, 31, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (202, 31, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (203, 31, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Microsoft Surface Laptop 6 (id=32) - 2 colors x 2 RAM x 2 SSD = 8 variants
    (204, 32, 1499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (205, 32, 1499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (206, 32, 1499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (207, 32, 1499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (208, 32, 1499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (209, 32, 1499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (210, 32, 1499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (211, 32, 1499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Microsoft Surface Laptop Studio 2 (id=33) - 2 colors x 2 RAM x 2 SSD = 8 variants
    (212, 33, 1999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (213, 33, 1999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (214, 33, 1999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (215, 33, 1999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (216, 33, 1999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (217, 33, 1999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (218, 33, 1999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (219, 33, 1999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Razer Blade 16 (id=34) - 1 color x 1 RAM x 2 SSD = 2 variants
    (220, 34, 2999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (221, 34, 2999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Razer Blade 14 (id=35) - 2 colors x 2 RAM x 1 SSD = 4 variants
    (222, 35, 2199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (223, 35, 2199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (224, 35, 2199.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (225, 35, 2199.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- MSI Stealth 16 Studio (id=36) - 1 color x 2 RAM x 2 SSD = 4 variants
    (226, 36, 2299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (227, 36, 2299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (228, 36, 2299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (229, 36, 2299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- MSI Raider GE78 HX (id=37) - 1 color x 2 RAM x 2 SSD = 4 variants
    (230, 37, 2799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (231, 37, 2799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (232, 37, 2799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (233, 37, 2799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Gigabyte AORUS 16X (id=38) - 1 color x 2 RAM x 1 SSD = 2 variants
    (234, 38, 2499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (235, 38, 2499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Book4 Pro 14 (id=39) - 1 color x 2 RAM x 2 SSD = 4 variants
    (236, 39, 1399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (237, 39, 1399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (238, 39, 1399.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (239, 39, 1399.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- LG Gram 16 (id=40) - 1 color x 2 RAM x 2 SSD = 4 variants
    (240, 40, 1399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (241, 40, 1399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (242, 40, 1399.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (243, 40, 1399.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0);

-- Variant options for Laptops (COLOR + RAM + SSD with extra_price)
INSERT INTO variant_options (
    variant_id,
    option_id,
    value,
    extra_price
) VALUES
    -- MacBook Pro 14 M3 Pro (122-129) - 2 colors x 2 RAM x 2 SSD
    (122, 1, 'Space Black', 0.00), (122, 3, '18GB', 0.00), (122, 2, '512GB', 0.00),
    (123, 1, 'Silver', 0.00), (123, 3, '18GB', 0.00), (123, 2, '512GB', 0.00),
    (124, 1, 'Space Black', 0.00), (124, 3, '18GB', 0.00), (124, 2, '1TB', 200.00),
    (125, 1, 'Silver', 0.00), (125, 3, '18GB', 0.00), (125, 2, '1TB', 200.00),
    (126, 1, 'Space Black', 0.00), (126, 3, '36GB', 400.00), (126, 2, '512GB', 0.00),
    (127, 1, 'Silver', 0.00), (127, 3, '36GB', 400.00), (127, 2, '512GB', 0.00),
    (128, 1, 'Space Black', 0.00), (128, 3, '36GB', 400.00), (128, 2, '1TB', 200.00),
    (129, 1, 'Silver', 0.00), (129, 3, '36GB', 400.00), (129, 2, '1TB', 200.00),

    -- MacBook Air 15 M3 (130-147) - 2 colors x 3 RAM x 3 SSD
    (130, 1, 'Midnight', 0.00), (130, 3, '8GB', 0.00), (130, 2, '256GB', 0.00),
    (131, 1, 'Starlight', 0.00), (131, 3, '8GB', 0.00), (131, 2, '256GB', 0.00),
    (132, 1, 'Midnight', 0.00), (132, 3, '8GB', 0.00), (132, 2, '512GB', 100.00),
    (133, 1, 'Starlight', 0.00), (133, 3, '8GB', 0.00), (133, 2, '512GB', 100.00),
    (134, 1, 'Midnight', 0.00), (134, 3, '8GB', 0.00), (134, 2, '1TB', 300.00),
    (135, 1, 'Starlight', 0.00), (135, 3, '8GB', 0.00), (135, 2, '1TB', 300.00),
    (136, 1, 'Midnight', 0.00), (136, 3, '16GB', 200.00), (136, 2, '256GB', 0.00),
    (137, 1, 'Starlight', 0.00), (137, 3, '16GB', 200.00), (137, 2, '256GB', 0.00),
    (138, 1, 'Midnight', 0.00), (138, 3, '16GB', 200.00), (138, 2, '512GB', 100.00),
    (139, 1, 'Starlight', 0.00), (139, 3, '16GB', 200.00), (139, 2, '512GB', 100.00),
    (140, 1, 'Midnight', 0.00), (140, 3, '16GB', 200.00), (140, 2, '1TB', 300.00),
    (141, 1, 'Starlight', 0.00), (141, 3, '16GB', 200.00), (141, 2, '1TB', 300.00),
    (142, 1, 'Midnight', 0.00), (142, 3, '24GB', 400.00), (142, 2, '256GB', 0.00),
    (143, 1, 'Starlight', 0.00), (143, 3, '24GB', 400.00), (143, 2, '256GB', 0.00),
    (144, 1, 'Midnight', 0.00), (144, 3, '24GB', 400.00), (144, 2, '512GB', 100.00),
    (145, 1, 'Starlight', 0.00), (145, 3, '24GB', 400.00), (145, 2, '512GB', 100.00),
    (146, 1, 'Midnight', 0.00), (146, 3, '24GB', 400.00), (146, 2, '1TB', 300.00),
    (147, 1, 'Starlight', 0.00), (147, 3, '24GB', 400.00), (147, 2, '1TB', 300.00),

    -- Dell XPS 14 (148-155) - 2 colors x 2 RAM x 2 SSD
    (148, 1, 'Platinum', 0.00), (148, 3, '16GB', 0.00), (148, 2, '512GB', 0.00),
    (149, 1, 'Graphite', 0.00), (149, 3, '16GB', 0.00), (149, 2, '512GB', 0.00),
    (150, 1, 'Platinum', 0.00), (150, 3, '16GB', 0.00), (150, 2, '1TB', 200.00),
    (151, 1, 'Graphite', 0.00), (151, 3, '16GB', 0.00), (151, 2, '1TB', 200.00),
    (152, 1, 'Platinum', 0.00), (152, 3, '32GB', 300.00), (152, 2, '512GB', 0.00),
    (153, 1, 'Graphite', 0.00), (153, 3, '32GB', 300.00), (153, 2, '512GB', 0.00),
    (154, 1, 'Platinum', 0.00), (154, 3, '32GB', 300.00), (154, 2, '1TB', 200.00),
    (155, 1, 'Graphite', 0.00), (155, 3, '32GB', 300.00), (155, 2, '1TB', 200.00),

    -- Dell XPS 13 (156-163) - 2 colors x 2 RAM x 2 SSD
    (156, 1, 'Platinum', 0.00), (156, 3, '16GB', 0.00), (156, 2, '512GB', 0.00),
    (157, 1, 'Graphite', 0.00), (157, 3, '16GB', 0.00), (157, 2, '512GB', 0.00),
    (158, 1, 'Platinum', 0.00), (158, 3, '16GB', 0.00), (158, 2, '1TB', 200.00),
    (159, 1, 'Graphite', 0.00), (159, 3, '16GB', 0.00), (159, 2, '1TB', 200.00),
    (160, 1, 'Platinum', 0.00), (160, 3, '32GB', 300.00), (160, 2, '512GB', 0.00),
    (161, 1, 'Graphite', 0.00), (161, 3, '32GB', 300.00), (161, 2, '512GB', 0.00),
    (162, 1, 'Platinum', 0.00), (162, 3, '32GB', 300.00), (162, 2, '1TB', 200.00),
    (163, 1, 'Graphite', 0.00), (163, 3, '32GB', 300.00), (163, 2, '1TB', 200.00),

    -- HP Spectre x360 14 (164-171) - 2 colors x 2 RAM x 2 SSD
    (164, 1, 'Nightfall Black', 0.00), (164, 3, '16GB', 0.00), (164, 2, '512GB', 0.00),
    (165, 1, 'Slate Blue', 0.00), (165, 3, '16GB', 0.00), (165, 2, '512GB', 0.00),
    (166, 1, 'Nightfall Black', 0.00), (166, 3, '16GB', 0.00), (166, 2, '1TB', 200.00),
    (167, 1, 'Slate Blue', 0.00), (167, 3, '16GB', 0.00), (167, 2, '1TB', 200.00),
    (168, 1, 'Nightfall Black', 0.00), (168, 3, '32GB', 300.00), (168, 2, '512GB', 0.00),
    (169, 1, 'Slate Blue', 0.00), (169, 3, '32GB', 300.00), (169, 2, '512GB', 0.00),
    (170, 1, 'Nightfall Black', 0.00), (170, 3, '32GB', 300.00), (170, 2, '1TB', 200.00),
    (171, 1, 'Slate Blue', 0.00), (171, 3, '32GB', 300.00), (171, 2, '1TB', 200.00),

    -- ThinkPad X1 Carbon Gen 12 (172-175) - 1 color x 2 RAM x 2 SSD
    (172, 1, 'Black', 0.00), (172, 3, '16GB', 0.00), (172, 2, '512GB', 0.00),
    (173, 1, 'Black', 0.00), (173, 3, '16GB', 0.00), (173, 2, '1TB', 200.00),
    (174, 1, 'Black', 0.00), (174, 3, '32GB', 300.00), (174, 2, '512GB', 0.00),
    (175, 1, 'Black', 0.00), (175, 3, '32GB', 300.00), (175, 2, '1TB', 200.00),

    -- ThinkPad X1 Yoga Gen 9 (176-179) - 1 color x 2 RAM x 2 SSD
    (176, 1, 'Storm Gray', 0.00), (176, 3, '16GB', 0.00), (176, 2, '512GB', 0.00),
    (177, 1, 'Storm Gray', 0.00), (177, 3, '16GB', 0.00), (177, 2, '1TB', 200.00),
    (178, 1, 'Storm Gray', 0.00), (178, 3, '32GB', 300.00), (178, 2, '512GB', 0.00),
    (179, 1, 'Storm Gray', 0.00), (179, 3, '32GB', 300.00), (179, 2, '1TB', 200.00),

    -- ASUS ROG Zephyrus G14 (180-187) - 2 colors x 2 RAM x 2 SSD
    (180, 1, 'Eclipse Gray', 0.00), (180, 3, '16GB', 0.00), (180, 2, '1TB', 0.00),
    (181, 1, 'Moonlight White', 0.00), (181, 3, '16GB', 0.00), (181, 2, '1TB', 0.00),
    (182, 1, 'Eclipse Gray', 0.00), (182, 3, '16GB', 0.00), (182, 2, '2TB', 300.00),
    (183, 1, 'Moonlight White', 0.00), (183, 3, '16GB', 0.00), (183, 2, '2TB', 300.00),
    (184, 1, 'Eclipse Gray', 0.00), (184, 3, '32GB', 300.00), (184, 2, '1TB', 0.00),
    (185, 1, 'Moonlight White', 0.00), (185, 3, '32GB', 300.00), (185, 2, '1TB', 0.00),
    (186, 1, 'Eclipse Gray', 0.00), (186, 3, '32GB', 300.00), (186, 2, '2TB', 300.00),
    (187, 1, 'Moonlight White', 0.00), (187, 3, '32GB', 300.00), (187, 2, '2TB', 300.00),
    (180, 4, 'AMD Ryzen 9 7900HX3D', 0.00), (180, 5, 'NVIDIA GeForce RTX 4060 Laptop', 0.00),
    (181, 4, 'AMD Ryzen 9 7900HX3D', 0.00), (181, 5, 'NVIDIA GeForce RTX 4060 Laptop', 0.00),
    (182, 4, 'AMD Ryzen 9 7900HX3D', 0.00), (182, 5, 'NVIDIA GeForce RTX 4060 Laptop', 0.00),
    (183, 4, 'AMD Ryzen 9 7900HX3D', 0.00), (183, 5, 'NVIDIA GeForce RTX 4060 Laptop', 0.00),
    (184, 4, 'AMD Ryzen 9 9950X', 200.00), (184, 5, 'NVIDIA GeForce RTX 4070 Laptop', 200.00),
    (185, 4, 'AMD Ryzen 9 9950X', 200.00), (185, 5, 'NVIDIA GeForce RTX 4070 Laptop', 200.00),
    (186, 4, 'AMD Ryzen 9 9950X', 200.00), (186, 5, 'NVIDIA GeForce RTX 4070 Laptop', 200.00),
    (187, 4, 'AMD Ryzen 9 9950X', 200.00), (187, 5, 'NVIDIA GeForce RTX 4070 Laptop', 200.00),

    -- ASUS ROG Zephyrus G16 (188-195) - 2 colors x 2 RAM x 2 SSD
    (188, 1, 'Eclipse Gray', 0.00), (188, 3, '16GB', 0.00), (188, 2, '1TB', 0.00),
    (189, 1, 'Platinum', 0.00), (189, 3, '16GB', 0.00), (189, 2, '1TB', 0.00),
    (190, 1, 'Eclipse Gray', 0.00), (190, 3, '16GB', 0.00), (190, 2, '2TB', 300.00),
    (191, 1, 'Platinum', 0.00), (191, 3, '16GB', 0.00), (191, 2, '2TB', 300.00),
    (192, 1, 'Eclipse Gray', 0.00), (192, 3, '32GB', 300.00), (192, 2, '1TB', 0.00),
    (193, 1, 'Platinum', 0.00), (193, 3, '32GB', 300.00), (193, 2, '1TB', 0.00),
    (194, 1, 'Eclipse Gray', 0.00), (194, 3, '32GB', 300.00), (194, 2, '2TB', 300.00),
    (195, 1, 'Platinum', 0.00), (195, 3, '32GB', 300.00), (195, 2, '2TB', 300.00),
    (188, 4, 'Intel Core Ultra 9', 0.00), (188, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (189, 4, 'Intel Core Ultra 9', 0.00), (189, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (190, 4, 'Intel Core Ultra 9', 0.00), (190, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (191, 4, 'Intel Core Ultra 9', 0.00), (191, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (192, 4, 'Intel Core i9-14900HX', 200.00), (192, 5, 'NVIDIA GeForce RTX 4080 Laptop', 250.00),
    (193, 4, 'Intel Core i9-14900HX', 200.00), (193, 5, 'NVIDIA GeForce RTX 4080 Laptop', 250.00),
    (194, 4, 'Intel Core i9-14900HX', 200.00), (194, 5, 'NVIDIA GeForce RTX 4080 Laptop', 250.00),
    (195, 4, 'Intel Core i9-14900HX', 200.00), (195, 5, 'NVIDIA GeForce RTX 4080 Laptop', 250.00),

    -- Acer Swift X 14 (196-199) - 1 color x 2 RAM x 2 SSD
    (196, 1, 'Steel Gray', 0.00), (196, 3, '16GB', 0.00), (196, 2, '512GB', 0.00),
    (197, 1, 'Steel Gray', 0.00), (197, 3, '16GB', 0.00), (197, 2, '1TB', 200.00),
    (198, 1, 'Steel Gray', 0.00), (198, 3, '32GB', 300.00), (198, 2, '512GB', 0.00),
    (199, 1, 'Steel Gray', 0.00), (199, 3, '32GB', 300.00), (199, 2, '1TB', 200.00),

    -- Acer Swift Go 14 (200-203) - 1 color x 2 RAM x 2 SSD
    (200, 1, 'Silver', 0.00), (200, 3, '8GB', 0.00), (200, 2, '256GB', 0.00),
    (201, 1, 'Silver', 0.00), (201, 3, '8GB', 0.00), (201, 2, '512GB', 100.00),
    (202, 1, 'Silver', 0.00), (202, 3, '16GB', 200.00), (202, 2, '256GB', 0.00),
    (203, 1, 'Silver', 0.00), (203, 3, '16GB', 200.00), (203, 2, '512GB', 100.00),
    (200, 4, 'Intel Core Ultra 5', 0.00),
    (201, 4, 'Intel Core Ultra 5', 0.00),
    (202, 4, 'Intel Core Ultra 7', 100.00),
    (203, 4, 'Intel Core Ultra 7', 100.00),

    -- Microsoft Surface Laptop 6 (204-211) - 2 colors x 2 RAM x 2 SSD
    (204, 1, 'Platinum', 0.00), (204, 3, '16GB', 0.00), (204, 2, '512GB', 0.00),
    (205, 1, 'Black', 0.00), (205, 3, '16GB', 0.00), (205, 2, '512GB', 0.00),
    (206, 1, 'Platinum', 0.00), (206, 3, '16GB', 0.00), (206, 2, '1TB', 200.00),
    (207, 1, 'Black', 0.00), (207, 3, '16GB', 0.00), (207, 2, '1TB', 200.00),
    (208, 1, 'Platinum', 0.00), (208, 3, '32GB', 300.00), (208, 2, '512GB', 0.00),
    (209, 1, 'Black', 0.00), (209, 3, '32GB', 300.00), (209, 2, '512GB', 0.00),
    (210, 1, 'Platinum', 0.00), (210, 3, '32GB', 300.00), (210, 2, '1TB', 200.00),
    (211, 1, 'Black', 0.00), (211, 3, '32GB', 300.00), (211, 2, '1TB', 200.00),
    (204, 4, 'Intel Core Ultra 7', 0.00),
    (205, 4, 'Intel Core Ultra 7', 0.00),
    (206, 4, 'Intel Core Ultra 7', 0.00),
    (207, 4, 'Intel Core Ultra 7', 0.00),
    (208, 4, 'Intel Core Ultra 9', 150.00),
    (209, 4, 'Intel Core Ultra 9', 150.00),
    (210, 4, 'Intel Core Ultra 9', 150.00),
    (211, 4, 'Intel Core Ultra 9', 150.00),

    -- Microsoft Surface Laptop Studio 2 (212-219) - 2 colors x 2 RAM x 2 SSD
    (212, 1, 'Platinum', 0.00), (212, 3, '16GB', 0.00), (212, 2, '512GB', 0.00),
    (213, 1, 'Graphite', 0.00), (213, 3, '16GB', 0.00), (213, 2, '512GB', 0.00),
    (214, 1, 'Platinum', 0.00), (214, 3, '16GB', 0.00), (214, 2, '1TB', 200.00),
    (215, 1, 'Graphite', 0.00), (215, 3, '16GB', 0.00), (215, 2, '1TB', 200.00),
    (216, 1, 'Platinum', 0.00), (216, 3, '32GB', 300.00), (216, 2, '512GB', 0.00),
    (217, 1, 'Graphite', 0.00), (217, 3, '32GB', 300.00), (217, 2, '512GB', 0.00),
    (218, 1, 'Platinum', 0.00), (218, 3, '32GB', 300.00), (218, 2, '1TB', 200.00),
    (219, 1, 'Graphite', 0.00), (219, 3, '32GB', 300.00), (219, 2, '1TB', 200.00),
    (212, 4, 'Intel Core i7 H-series', 0.00), (212, 5, 'NVIDIA GeForce RTX 4050 Laptop', 0.00),
    (213, 4, 'Intel Core i7 H-series', 0.00), (213, 5, 'NVIDIA GeForce RTX 4050 Laptop', 0.00),
    (214, 4, 'Intel Core i7 H-series', 0.00), (214, 5, 'NVIDIA GeForce RTX 4060 Laptop', 200.00),
    (215, 4, 'Intel Core i7 H-series', 0.00), (215, 5, 'NVIDIA GeForce RTX 4060 Laptop', 200.00),
    (216, 4, 'Intel Core i9 H-series', 200.00), (216, 5, 'NVIDIA GeForce RTX 4050 Laptop', 0.00),
    (217, 4, 'Intel Core i9 H-series', 200.00), (217, 5, 'NVIDIA GeForce RTX 4050 Laptop', 0.00),
    (218, 4, 'Intel Core i9 H-series', 200.00), (218, 5, 'NVIDIA GeForce RTX 4060 Laptop', 200.00),
    (219, 4, 'Intel Core i9 H-series', 200.00), (219, 5, 'NVIDIA GeForce RTX 4060 Laptop', 200.00),

    -- Razer Blade 16 (220-221) - 1 color x 1 RAM x 2 SSD
    (220, 1, 'Black', 0.00), (220, 3, '32GB', 0.00), (220, 2, '1TB', 0.00),
    (221, 1, 'Black', 0.00), (221, 3, '32GB', 0.00), (221, 2, '2TB', 400.00),
    (220, 5, 'NVIDIA GeForce RTX 4080 Laptop', 0.00),
    (221, 5, 'NVIDIA GeForce RTX 4090 Laptop', 400.00),

    -- Razer Blade 14 (222-225) - 2 colors x 2 RAM x 1 SSD
    (222, 1, 'Black', 0.00), (222, 3, '16GB', 0.00), (222, 2, '1TB', 0.00),
    (223, 1, 'Mercury', 0.00), (223, 3, '16GB', 0.00), (223, 2, '1TB', 0.00),
    (224, 1, 'Black', 0.00), (224, 3, '32GB', 400.00), (224, 2, '1TB', 0.00),
    (225, 1, 'Mercury', 0.00), (225, 3, '32GB', 400.00), (225, 2, '1TB', 0.00),

    -- MSI Stealth 16 Studio (226-229) - 1 color x 2 RAM x 2 SSD
    (226, 1, 'Core Black', 0.00), (226, 3, '16GB', 0.00), (226, 2, '1TB', 0.00),
    (227, 1, 'Core Black', 0.00), (227, 3, '16GB', 0.00), (227, 2, '2TB', 400.00),
    (228, 1, 'Core Black', 0.00), (228, 3, '32GB', 400.00), (228, 2, '1TB', 0.00),
    (229, 1, 'Core Black', 0.00), (229, 3, '32GB', 400.00), (229, 2, '2TB', 400.00),
    (226, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (227, 5, 'NVIDIA GeForce RTX 4080 Laptop', 300.00),
    (228, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (229, 5, 'NVIDIA GeForce RTX 4080 Laptop', 300.00),

    -- MSI Raider GE78 HX (230-233) - 1 color x 2 RAM x 2 SSD
    (230, 1, 'Black', 0.00), (230, 3, '32GB', 0.00), (230, 2, '1TB', 0.00),
    (231, 1, 'Black', 0.00), (231, 3, '32GB', 0.00), (231, 2, '2TB', 400.00),
    (232, 1, 'Black', 0.00), (232, 3, '64GB', 500.00), (232, 2, '1TB', 0.00),
    (233, 1, 'Black', 0.00), (233, 3, '64GB', 500.00), (233, 2, '2TB', 400.00),

    -- Gigabyte AORUS 16X (234-235) - 1 color x 2 RAM x 1 SSD
    (234, 1, 'Black', 0.00), (234, 3, '16GB', 0.00), (234, 2, '1TB', 0.00),
    (235, 1, 'Black', 0.00), (235, 3, '32GB', 400.00), (235, 2, '1TB', 0.00),
    (234, 4, 'Intel Core i7', 0.00),
    (235, 4, 'Intel Core i9', 200.00),

    -- Samsung Galaxy Book4 Pro 14 (236-239) - 1 color x 2 RAM x 2 SSD
    (236, 1, 'Moonstone Gray', 0.00), (236, 3, '16GB', 0.00), (236, 2, '512GB', 0.00),
    (237, 1, 'Moonstone Gray', 0.00), (237, 3, '16GB', 0.00), (237, 2, '1TB', 200.00),
    (238, 1, 'Moonstone Gray', 0.00), (238, 3, '32GB', 300.00), (238, 2, '512GB', 0.00),
    (239, 1, 'Moonstone Gray', 0.00), (239, 3, '32GB', 300.00), (239, 2, '1TB', 200.00),

    -- LG Gram 16 (240-243) - 1 color x 2 RAM x 2 SSD
    (240, 1, 'Black', 0.00), (240, 3, '16GB', 0.00), (240, 2, '512GB', 0.00),
    (241, 1, 'Black', 0.00), (241, 3, '16GB', 0.00), (241, 2, '1TB', 200.00),
    (242, 1, 'Black', 0.00), (242, 3, '32GB', 300.00), (242, 2, '512GB', 0.00),
    (243, 1, 'Black', 0.00), (243, 3, '32GB', 300.00), (243, 2, '1TB', 200.00),

    -- CPU/GPU options for ROG Zephyrus G14 (180-187)
    (180, 4, 'AMD Ryzen 9 7900HX3D', 0.00), (180, 5, 'NVIDIA GeForce RTX 4060 Laptop', 0.00),
    (181, 4, 'AMD Ryzen 9 7900HX3D', 0.00), (181, 5, 'NVIDIA GeForce RTX 4060 Laptop', 0.00),
    (182, 4, 'AMD Ryzen 9 7900HX3D', 0.00), (182, 5, 'NVIDIA GeForce RTX 4060 Laptop', 0.00),
    (183, 4, 'AMD Ryzen 9 7900HX3D', 0.00), (183, 5, 'NVIDIA GeForce RTX 4060 Laptop', 0.00),
    (184, 4, 'AMD Ryzen 9 9950X', 0.00), (184, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (185, 4, 'AMD Ryzen 9 9950X', 0.00), (185, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (186, 4, 'AMD Ryzen 9 9950X', 0.00), (186, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (187, 4, 'AMD Ryzen 9 9950X', 0.00), (187, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),

    -- CPU/GPU options for ROG Zephyrus G16 (188-195)
    (188, 4, 'Intel Core Ultra 9', 0.00), (188, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (189, 4, 'Intel Core Ultra 9', 0.00), (189, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (190, 4, 'Intel Core Ultra 9', 0.00), (190, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (191, 4, 'Intel Core Ultra 9', 0.00), (191, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (192, 4, 'Intel Core i9-14900HX', 0.00), (192, 5, 'NVIDIA GeForce RTX 4080 Laptop', 0.00),
    (193, 4, 'Intel Core i9-14900HX', 0.00), (193, 5, 'NVIDIA GeForce RTX 4080 Laptop', 0.00),
    (194, 4, 'Intel Core i9-14900HX', 0.00), (194, 5, 'NVIDIA GeForce RTX 4080 Laptop', 0.00),
    (195, 4, 'Intel Core i9-14900HX', 0.00), (195, 5, 'NVIDIA GeForce RTX 4080 Laptop', 0.00),

    -- CPU options for Acer Swift Go 14 (200-203)
    (200, 4, 'Intel Core Ultra 5', 0.00),
    (201, 4, 'Intel Core Ultra 5', 0.00),
    (202, 4, 'Intel Core Ultra 7', 0.00),
    (203, 4, 'Intel Core Ultra 7', 0.00),

    -- CPU options for Surface Laptop 6 (204-211)
    (204, 4, 'Intel Core Ultra 7', 0.00),
    (205, 4, 'Intel Core Ultra 7', 0.00),
    (206, 4, 'Intel Core Ultra 7', 0.00),
    (207, 4, 'Intel Core Ultra 7', 0.00),
    (208, 4, 'Intel Core Ultra 9', 0.00),
    (209, 4, 'Intel Core Ultra 9', 0.00),
    (210, 4, 'Intel Core Ultra 9', 0.00),
    (211, 4, 'Intel Core Ultra 9', 0.00),

    -- CPU/GPU options for Surface Laptop Studio 2 (212-219)
    (212, 4, 'Intel Core i7 H-series', 0.00), (212, 5, 'NVIDIA GeForce RTX 4050 Laptop', 0.00),
    (213, 4, 'Intel Core i7 H-series', 0.00), (213, 5, 'NVIDIA GeForce RTX 4050 Laptop', 0.00),
    (214, 4, 'Intel Core i7 H-series', 0.00), (214, 5, 'NVIDIA GeForce RTX 4060 Laptop', 0.00),
    (215, 4, 'Intel Core i7 H-series', 0.00), (215, 5, 'NVIDIA GeForce RTX 4060 Laptop', 0.00),
    (216, 4, 'Intel Core i9 H-series', 0.00), (216, 5, 'NVIDIA GeForce RTX 4050 Laptop', 0.00),
    (217, 4, 'Intel Core i9 H-series', 0.00), (217, 5, 'NVIDIA GeForce RTX 4050 Laptop', 0.00),
    (218, 4, 'Intel Core i9 H-series', 0.00), (218, 5, 'NVIDIA GeForce RTX 4060 Laptop', 0.00),
    (219, 4, 'Intel Core i9 H-series', 0.00), (219, 5, 'NVIDIA GeForce RTX 4060 Laptop', 0.00),

    -- GPU options for Razer Blade 16 (220-221)
    (220, 5, 'NVIDIA GeForce RTX 4080 Laptop', 0.00),
    (221, 5, 'NVIDIA GeForce RTX 4090 Laptop', 0.00),

    -- GPU options for MSI Stealth 16 Studio (226-229)
    (226, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (227, 5, 'NVIDIA GeForce RTX 4080 Laptop', 0.00),
    (228, 5, 'NVIDIA GeForce RTX 4070 Laptop', 0.00),
    (229, 5, 'NVIDIA GeForce RTX 4080 Laptop', 0.00),

    -- CPU options for Gigabyte AORUS 16X (234-235)
    (234, 4, 'Intel Core i7', 0.00),
    (235, 4, 'Intel Core i9', 0.00);

-- ========== TABLETS SECTION ==========

-- Product variants for Tablets (base price = min price per product)
INSERT INTO product_variants (
    id,
    product_id,
    price,
    discount_percent,
    status,
    created_at,
    updated_at,
    version
) VALUES
    -- Apple iPad Pro 11 (M4) (id=41)
    (244, 41, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (245, 41, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (246, 41, 999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (247, 41, 999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple iPad Pro 13 (M4) (id=42)
    (248, 42, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (249, 42, 1299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (250, 42, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (251, 42, 1299.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple iPad Air 11 (M2) (id=43)
    (252, 43, 599.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (253, 43, 599.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (254, 43, 599.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (255, 43, 599.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple iPad Air 13 (M2) (id=44)
    (256, 44, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (257, 44, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (258, 44, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (259, 44, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple iPad (10th generation) (id=45)
    (260, 45, 349.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (261, 45, 349.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (262, 45, 349.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (263, 45, 349.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple iPad mini (6th generation) (id=46)
    (264, 46, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (265, 46, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (266, 46, 499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (267, 46, 499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Tab S9 Ultra (id=47)
    (268, 47, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (269, 47, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (270, 47, 1199.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (271, 47, 1199.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Tab S9+ (id=48)
    (272, 48, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (273, 48, 999.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (274, 48, 999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (275, 48, 999.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Tab S9 (id=49)
    (276, 49, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (277, 49, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (278, 49, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (279, 49, 799.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Tab S9 FE (id=50)
    (280, 50, 449.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (281, 50, 449.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (282, 50, 449.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (283, 50, 449.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Tab S9 FE+ (id=51)
    (284, 51, 599.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (285, 51, 599.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (286, 51, 599.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (287, 51, 599.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Microsoft Surface Pro 11 (id=52)
    (288, 52, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (289, 52, 1199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (290, 52, 1199.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (291, 52, 1199.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Microsoft Surface Go 4 (id=53)
    (292, 53, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (293, 53, 499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Lenovo Tab P12 (id=54)
    (294, 54, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (295, 54, 399.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Lenovo Tab P11 Pro (2nd Gen) (id=55)
    (296, 55, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (297, 55, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (298, 55, 499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (299, 55, 499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Xiaomi Pad 6 (id=56)
    (300, 56, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (301, 56, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (302, 56, 399.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (303, 56, 399.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- OnePlus Pad (id=57)
    (304, 57, 479.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (305, 57, 479.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Huawei MatePad Pro 13.2 (id=58)
    (306, 58, 899.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (307, 58, 899.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (308, 58, 899.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (309, 58, 899.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Amazon Fire Max 11 (id=59)
    (310, 59, 229.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (311, 59, 229.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Google Pixel Tablet (id=60)
    (312, 60, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (313, 60, 499.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (314, 60, 499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (315, 60, 499.00, 5, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0);

-- Variant options for Tablets (COLOR + STORAGE with extra_price)
INSERT INTO variant_options (
    variant_id,
    option_id,
    value,
    extra_price
) VALUES
    -- iPad Pro 11 (244-247)
    (244, 2, '256GB', 0.00), (244, 1, 'Space Black', 0.00),
    (245, 2, '256GB', 0.00), (245, 1, 'Silver', 0.00),
    (246, 2, '512GB', 200.00), (246, 1, 'Space Black', 0.00),
    (247, 2, '512GB', 200.00), (247, 1, 'Silver', 0.00),

    -- iPad Pro 13 (248-251)
    (248, 2, '256GB', 0.00), (248, 1, 'Space Black', 0.00),
    (249, 2, '256GB', 0.00), (249, 1, 'Silver', 0.00),
    (250, 2, '512GB', 200.00), (250, 1, 'Space Black', 0.00),
    (251, 2, '512GB', 200.00), (251, 1, 'Silver', 0.00),

    -- iPad Air 11 (252-255)
    (252, 2, '128GB', 0.00), (252, 1, 'Blue', 0.00),
    (253, 2, '128GB', 0.00), (253, 1, 'Starlight', 0.00),
    (254, 2, '256GB', 150.00), (254, 1, 'Blue', 0.00),
    (255, 2, '256GB', 150.00), (255, 1, 'Starlight', 0.00),

    -- iPad Air 13 (256-259)
    (256, 2, '128GB', 0.00), (256, 1, 'Blue', 0.00),
    (257, 2, '128GB', 0.00), (257, 1, 'Starlight', 0.00),
    (258, 2, '256GB', 150.00), (258, 1, 'Blue', 0.00),
    (259, 2, '256GB', 150.00), (259, 1, 'Starlight', 0.00),

    -- iPad (10th generation) (260-263)
    (260, 2, '64GB', 0.00), (260, 1, 'Blue', 0.00),
    (261, 2, '64GB', 0.00), (261, 1, 'Silver', 0.00),
    (262, 2, '256GB', 150.00), (262, 1, 'Blue', 0.00),
    (263, 2, '256GB', 150.00), (263, 1, 'Silver', 0.00),

    -- iPad mini 6 (264-267)
    (264, 2, '64GB', 0.00), (264, 1, 'Purple', 0.00),
    (265, 2, '64GB', 0.00), (265, 1, 'Space Gray', 0.00),
    (266, 2, '256GB', 150.00), (266, 1, 'Purple', 0.00),
    (267, 2, '256GB', 150.00), (267, 1, 'Space Gray', 0.00),

    -- Galaxy Tab S9 Ultra (268-271)
    (268, 2, '256GB', 0.00), (268, 1, 'Graphite', 0.00),
    (269, 2, '256GB', 0.00), (269, 1, 'Beige', 0.00),
    (270, 2, '512GB', 200.00), (270, 1, 'Graphite', 0.00),
    (271, 2, '512GB', 200.00), (271, 1, 'Beige', 0.00),

    -- Galaxy Tab S9+ (272-275)
    (272, 2, '256GB', 0.00), (272, 1, 'Graphite', 0.00),
    (273, 2, '256GB', 0.00), (273, 1, 'Beige', 0.00),
    (274, 2, '512GB', 180.00), (274, 1, 'Graphite', 0.00),
    (275, 2, '512GB', 180.00), (275, 1, 'Beige', 0.00),

    -- Galaxy Tab S9 (276-279)
    (276, 2, '128GB', 0.00), (276, 1, 'Graphite', 0.00),
    (277, 2, '128GB', 0.00), (277, 1, 'Beige', 0.00),
    (278, 2, '256GB', 150.00), (278, 1, 'Graphite', 0.00),
    (279, 2, '256GB', 150.00), (279, 1, 'Beige', 0.00),

    -- Galaxy Tab S9 FE (280-283)
    (280, 2, '128GB', 0.00), (280, 1, 'Gray', 0.00),
    (281, 2, '128GB', 0.00), (281, 1, 'Mint', 0.00),
    (282, 2, '256GB', 120.00), (282, 1, 'Gray', 0.00),
    (283, 2, '256GB', 120.00), (283, 1, 'Mint', 0.00),

    -- Galaxy Tab S9 FE+ (284-287)
    (284, 2, '128GB', 0.00), (284, 1, 'Gray', 0.00),
    (285, 2, '128GB', 0.00), (285, 1, 'Lavender', 0.00),
    (286, 2, '256GB', 150.00), (286, 1, 'Gray', 0.00),
    (287, 2, '256GB', 150.00), (287, 1, 'Lavender', 0.00),

    -- Surface Pro 11 (288-291)
    (288, 2, '256GB', 0.00), (288, 1, 'Platinum', 0.00),
    (289, 2, '256GB', 0.00), (289, 1, 'Black', 0.00),
    (290, 2, '512GB', 200.00), (290, 1, 'Platinum', 0.00),
    (291, 2, '512GB', 200.00), (291, 1, 'Black', 0.00),

    -- Surface Go 4 (292-293)
    (292, 2, '128GB', 0.00), (292, 1, 'Platinum', 0.00),
    (293, 2, '256GB', 120.00), (293, 1, 'Platinum', 0.00),

    -- Lenovo Tab P12 (294-295)
    (294, 2, '128GB', 0.00), (294, 1, 'Storm Grey', 0.00),
    (295, 2, '256GB', 100.00), (295, 1, 'Storm Grey', 0.00),

    -- Lenovo Tab P11 Pro 2nd Gen (296-299)
    (296, 2, '128GB', 0.00), (296, 1, 'Storm Grey', 0.00),
    (297, 2, '128GB', 0.00), (297, 1, 'Oat', 0.00),
    (298, 2, '256GB', 120.00), (298, 1, 'Storm Grey', 0.00),
    (299, 2, '256GB', 120.00), (299, 1, 'Oat', 0.00),

    -- Xiaomi Pad 6 (300-303)
    (300, 2, '128GB', 0.00), (300, 1, 'Gravity Gray', 0.00),
    (301, 2, '128GB', 0.00), (301, 1, 'Champagne', 0.00),
    (302, 2, '256GB', 100.00), (302, 1, 'Gravity Gray', 0.00),
    (303, 2, '256GB', 100.00), (303, 1, 'Champagne', 0.00),

    -- OnePlus Pad (304-305)
    (304, 2, '128GB', 0.00), (304, 1, 'Halo Green', 0.00),
    (305, 2, '256GB', 120.00), (305, 1, 'Halo Green', 0.00),

    -- Huawei MatePad Pro 13.2 (306-309)
    (306, 2, '256GB', 0.00), (306, 1, 'Black', 0.00),
    (307, 2, '256GB', 0.00), (307, 1, 'Gold', 0.00),
    (308, 2, '512GB', 180.00), (308, 1, 'Black', 0.00),
    (309, 2, '512GB', 180.00), (309, 1, 'Gold', 0.00),

    -- Amazon Fire Max 11 (310-311)
    (310, 2, '64GB', 0.00), (310, 1, 'Gray', 0.00),
    (311, 2, '128GB', 80.00), (311, 1, 'Gray', 0.00),

    -- Google Pixel Tablet (312-315)
    (312, 2, '128GB', 0.00), (312, 1, 'Porcelain', 0.00),
    (313, 2, '128GB', 0.00), (313, 1, 'Hazel', 0.00),
    (314, 2, '256GB', 100.00), (314, 1, 'Porcelain', 0.00),
    (315, 2, '256GB', 100.00), (315, 1, 'Hazel', 0.00);

-- ========== AUDIO & HEADPHONES SECTION ==========

-- Product variants for Audio & Headphones (1 variant per color - NO DUPLICATION)
INSERT INTO product_variants (
    id,
    product_id,
    price,
    discount_percent,
    status,
    created_at,
    updated_at,
    version
) VALUES
    -- Sony WH-1000XM5 (id=61) - 2 colors
    (316, 61, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (317, 61, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Bose QuietComfort Ultra Headphones (id=62) - 2 colors
    (318, 62, 429.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (319, 62, 429.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple AirPods Pro (2nd gen, USB-C) (id=63) - 1 color
    (320, 63, 249.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Sennheiser MOMENTUM 4 Wireless (id=64) - 2 colors
    (321, 64, 379.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (322, 64, 379.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Bowers & Wilkins Px7 S2e (id=65) - 2 colors
    (323, 65, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (324, 65, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Bose QuietComfort Ultra Earbuds (id=66) - 2 colors
    (325, 66, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (326, 66, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Sony WF-1000XM5 (id=67) - 2 colors
    (327, 67, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (328, 67, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple AirPods Max (id=68) - 2 colors
    (329, 68, 549.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (330, 68, 549.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Beats Studio Pro (id=69) - 2 colors
    (331, 69, 349.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (332, 69, 349.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Soundcore Liberty 4 NC (id=70) - 2 colors
    (333, 70, 129.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (334, 70, 129.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Jabra Elite 10 (id=71) - 2 colors
    (335, 71, 249.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (336, 71, 249.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Buds2 Pro (id=72) - 2 colors
    (337, 72, 229.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (338, 72, 229.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Google Pixel Buds Pro (id=73) - 2 colors
    (339, 73, 199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (340, 73, 199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Nothing Ear (2024) (id=74) - 2 colors
    (341, 74, 149.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (342, 74, 149.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- JBL Tour One M2 (id=75) - 2 colors
    (343, 75, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (344, 75, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Shure AONIC 50 Gen 2 (id=76) - 2 colors
    (345, 76, 349.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (346, 76, 349.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Sonos Ace (id=77) - 2 colors
    (347, 77, 449.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (348, 77, 449.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Technics EAH-AZ80 (id=78) - 2 colors
    (349, 78, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (350, 78, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Bose SoundLink Flex (id=79) - 2 colors
    (351, 79, 149.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (352, 79, 149.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Marshall Motif II ANC (id=80) - 2 colors
    (353, 80, 199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (354, 80, 199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0);

-- Variant options for Audio & Headphones (COLOR only - minimal 1 option per variant)
INSERT INTO variant_options (
    variant_id,
    option_id,
    value,
    extra_price
) VALUES
    -- Sony WH-1000XM5 (316-317)
    (316, 1, 'Black', 0.00),
    (317, 1, 'Silver', 0.00),

    -- Bose QC Ultra Headphones (318-319)
    (318, 1, 'Black', 0.00),
    (319, 1, 'Sandstone', 0.00),

    -- AirPods Pro (320)
    (320, 1, 'White', 0.00),

    -- MOMENTUM 4 (321-322)
    (321, 1, 'Black', 0.00),
    (322, 1, 'White', 0.00),

    -- B&W Px7 S2e (323-324)
    (323, 1, 'Anthracite Black', 0.00),
    (324, 1, 'Cloud Grey', 0.00),

    -- Bose QC Ultra Earbuds (325-326)
    (325, 1, 'Black', 0.00),
    (326, 1, 'White Smoke', 0.00),

    -- Sony WF-1000XM5 (327-328)
    (327, 1, 'Black', 0.00),
    (328, 1, 'Silver', 0.00),

    -- AirPods Max (329-330)
    (329, 1, 'Space Gray', 0.00),
    (330, 1, 'Silver', 0.00),

    -- Beats Studio Pro (331-332)
    (331, 1, 'Black', 0.00),
    (332, 1, 'Sandstone', 0.00),

    -- Soundcore Liberty 4 NC (333-334)
    (333, 1, 'Black', 0.00),
    (334, 1, 'White', 0.00),

    -- Jabra Elite 10 (335-336)
    (335, 1, 'Titanium Black', 0.00),
    (336, 1, 'Cream', 0.00),

    -- Galaxy Buds2 Pro (337-338)
    (337, 1, 'Graphite', 0.00),
    (338, 1, 'White', 0.00),

    -- Pixel Buds Pro (339-340)
    (339, 1, 'Charcoal', 0.00),
    (340, 1, 'Fog', 0.00),

    -- Nothing Ear (2024) (341-342)
    (341, 1, 'White', 0.00),
    (342, 1, 'Black', 0.00),

    -- JBL Tour One M2 (343-344)
    (343, 1, 'Black', 0.00),
    (344, 1, 'Champagne', 0.00),

    -- Shure AONIC 50 Gen 2 (345-346)
    (345, 1, 'Black', 0.00),
    (346, 1, 'Brown', 0.00),

    -- Sonos Ace (347-348)
    (347, 1, 'Black', 0.00),
    (348, 1, 'Soft White', 0.00),

    -- Technics EAH-AZ80 (349-350)
    (349, 1, 'Black', 0.00),
    (350, 1, 'Silver', 0.00),

    -- Bose SoundLink Flex (351-352)
    (351, 1, 'Black', 0.00),
    (352, 1, 'Stone Blue', 0.00),

    -- Marshall Motif II ANC (353-354)
    (353, 1, 'Black', 0.00),
    (354, 1, 'Cream', 0.00);

-- ========== WEARABLES SECTION ==========

-- Product variants for Wearables (1 variant per color - NO DUPLICATION)
INSERT INTO product_variants (
    id,
    product_id,
    price,
    discount_percent,
    status,
    created_at,
    updated_at,
    version
) VALUES
    -- Apple Watch Series 9 (id=81) - 2 colors
    (355, 81, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (356, 81, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple Watch Ultra 2 (id=82) - 2 colors
    (357, 82, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (358, 82, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Watch6 (id=83) - 2 colors
    (359, 83, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (360, 83, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Watch6 Classic (id=84) - 2 colors
    (361, 84, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (362, 84, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Google Pixel Watch 2 (id=85) - 2 colors
    (363, 85, 349.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (364, 85, 349.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Garmin fenix 7 Pro (id=86) - 2 colors
    (365, 86, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (366, 86, 799.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Garmin Forerunner 965 (id=87) - 2 colors
    (367, 87, 599.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (368, 87, 599.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Garmin Venu 3 (id=88) - 2 colors
    (369, 88, 449.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (370, 88, 449.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Fitbit Sense 2 (id=89) - 2 colors
    (371, 89, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (372, 89, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Fitbit Charge 6 (id=90) - 2 colors
    (373, 90, 159.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (374, 90, 159.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Oura Ring Gen 3 (id=91) - 2 colors
    (375, 91, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (376, 91, 299.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Xiaomi Watch 2 Pro (id=92) - 2 colors
    (377, 92, 249.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (378, 92, 249.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Huawei Watch GT 4 (id=93) - 2 colors
    (379, 93, 279.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (380, 93, 279.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Amazfit Balance (id=94) - 2 colors
    (381, 94, 199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (382, 94, 199.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Suunto Vertical (id=95) - 2 colors
    (383, 95, 649.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (384, 95, 649.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Polar Vantage V3 (id=96) - 2 colors
    (385, 96, 599.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (386, 96, 599.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Apple Watch SE (2nd gen) (id=97) - 2 colors
    (387, 97, 249.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (388, 97, 249.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Watch5 Pro (id=98) - 2 colors
    (389, 98, 449.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (390, 98, 449.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- WHOOP 4.0 (id=99) - 2 colors
    (391, 99, 239.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (392, 99, 239.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),

    -- Samsung Galaxy Ring (id=100) - 2 colors
    (393, 100, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0),
    (394, 100, 399.00, 0, 'ACTIVE', '2024-06-01 10:00:00', '2024-06-01 10:00:00', 0);

-- Variant options for Wearables (COLOR only - minimal 1 option per variant)
INSERT INTO variant_options (
    variant_id,
    option_id,
    value,
    extra_price
) VALUES
    -- Apple Watch Series 9 (355-356)
    (355, 1, 'Midnight', 0.00),
    (356, 1, 'Starlight', 0.00),

    -- Apple Watch Ultra 2 (357-358)
    (357, 1, 'Natural Titanium', 0.00),
    (358, 1, 'Titanium Blue Trail', 0.00),

    -- Galaxy Watch6 (359-360)
    (359, 1, 'Graphite', 0.00),
    (360, 1, 'Silver', 0.00),

    -- Galaxy Watch6 Classic (361-362)
    (361, 1, 'Black', 0.00),
    (362, 1, 'Silver', 0.00),

    -- Pixel Watch 2 (363-364)
    (363, 1, 'Black', 0.00),
    (364, 1, 'Polished Silver', 0.00),

    -- Garmin fenix 7 Pro (365-366)
    (365, 1, 'Slate Gray', 0.00),
    (366, 1, 'Carbon Gray', 0.00),

    -- Garmin Forerunner 965 (367-368)
    (367, 1, 'Black', 0.00),
    (368, 1, 'Amp Yellow', 0.00),

    -- Garmin Venu 3 (369-370)
    (369, 1, 'Black', 0.00),
    (370, 1, 'Cream Gold', 0.00),

    -- Fitbit Sense 2 (371-372)
    (371, 1, 'Lunar White', 0.00),
    (372, 1, 'Shadow Grey', 0.00),

    -- Fitbit Charge 6 (373-374)
    (373, 1, 'Obsidian', 0.00),
    (374, 1, 'Porcelain', 0.00),

    -- Oura Ring Gen 3 (375-376)
    (375, 1, 'Silver', 0.00),
    (376, 1, 'Black', 0.00),

    -- Xiaomi Watch 2 Pro (377-378)
    (377, 1, 'Black', 0.00),
    (378, 1, 'Silver', 0.00),

    -- Huawei Watch GT 4 (379-380)
    (379, 1, 'Green', 0.00),
    (380, 1, 'White', 0.00),

    -- Amazfit Balance (381-382)
    (381, 1, 'Midnight', 0.00),
    (382, 1, 'Sunset Gray', 0.00),

    -- Suunto Vertical (383-384)
    (383, 1, 'Black', 0.00),
    (384, 1, 'Sand', 0.00),

    -- Polar Vantage V3 (385-386)
    (385, 1, 'Night Black', 0.00),
    (386, 1, 'Sky Blue', 0.00),

    -- Apple Watch SE 2nd gen (387-388)
    (387, 1, 'Midnight', 0.00),
    (388, 1, 'Silver', 0.00),

    -- Galaxy Watch5 Pro (389-390)
    (389, 1, 'Black Titanium', 0.00),
    (390, 1, 'Gray Titanium', 0.00),

    -- WHOOP 4.0 (391-392)
    (391, 1, 'Black', 0.00),
    (392, 1, 'Onyx', 0.00),

    -- Samsung Galaxy Ring (393-394)
    (393, 1, 'Titanium Black', 0.00),
    (394, 1, 'Titanium Silver', 0.00);

-- Inventories per variant (394 variants total - each variant has independent inventory)
INSERT INTO inventories (
    variant_id,
    total_quantity,
    reserved_quantity
) VALUES
-- Smartphones variants (1-121)
(1, 15, 0),(2, 15, 0),(3, 15, 0),(4, 12, 0),(5, 12, 0),(6, 12, 0),(7, 18, 0),(8, 18, 0),(9, 18, 0),
(10, 15, 0),(11, 15, 0),(12, 15, 0),(13, 12, 0),(14, 12, 0),(15, 12, 0),(16, 18, 0),(17, 18, 0),(18, 18, 0),
(19, 10, 0),(20, 10, 0),(21, 10, 0),(22, 15, 0),(23, 15, 0),(24, 15, 0),(25, 20, 0),(26, 20, 0),(27, 20, 0),
(28, 12, 0),(29, 12, 0),(30, 12, 0),(31, 12, 0),(32, 12, 0),(33, 12, 0),(34, 15, 0),(35, 15, 0),(36, 15, 0),
(37, 12, 0),(38, 12, 0),(39, 12, 0),(40, 18, 0),(41, 18, 0),(42, 18, 0),(43, 18, 0),(44, 18, 0),(45, 18, 0),
(46, 15, 0),(47, 15, 0),(48, 15, 0),(49, 12, 0),(50, 12, 0),(51, 12, 0),
(52, 12, 0),(53, 12, 0),(54, 12, 0),(55, 15, 0),(56, 15, 0),(57, 15, 0),
(58, 12, 0),(59, 12, 0),(60, 12, 0),(61, 15, 0),(62, 15, 0),(63, 15, 0),
(64, 10, 0),(65, 10, 0),(66, 10, 0),(67, 15, 0),(68, 15, 0),(69, 15, 0),
(70, 12, 0),(71, 12, 0),(72, 12, 0),(73, 12, 0),
(74, 15, 0),(75, 15, 0),(76, 15, 0),(77, 12, 0),(78, 12, 0),(79, 12, 0),(80, 18, 0),(81, 18, 0),(82, 18, 0),
(83, 10, 0),(84, 10, 0),(85, 10, 0),(86, 10, 0),
(87, 12, 0),(88, 12, 0),(89, 12, 0),(90, 12, 0),(91, 12, 0),(92, 12, 0),(93, 15, 0),(94, 15, 0),(95, 15, 0),
(96, 12, 0),(97, 12, 0),(98, 12, 0),(99, 12, 0),
(100, 15, 0),(101, 15, 0),(102, 15, 0),(103, 15, 0),
(104, 12, 0),(105, 12, 0),(106, 12, 0),(107, 12, 0),
(108, 18, 0),(109, 18, 0),(110, 12, 0),(111, 12, 0),
(112, 12, 0),(113, 12, 0),(114, 12, 0),(115, 12, 0),
(116, 12, 0),(117, 12, 0),(118, 12, 0),(119, 12, 0),(120, 12, 0),(121, 12, 0),

-- Tablets variants (244-315) = 72 variants
(244, 12, 0),(245, 12, 0),(246, 15, 0),(247, 15, 0),
(248, 15, 0),(249, 15, 0),(250, 18, 0),(251, 18, 0),
(252, 12, 0),(253, 12, 0),(254, 15, 0),(255, 15, 0),
(256, 12, 0),(257, 12, 0),(258, 15, 0),(259, 15, 0),
(260, 12, 0),(261, 12, 0),(262, 15, 0),(263, 15, 0),
(264, 12, 0),(265, 12, 0),(266, 15, 0),(267, 15, 0),
(268, 15, 0),(269, 15, 0),(270, 18, 0),(271, 18, 0),
(272, 12, 0),(273, 12, 0),(274, 15, 0),(275, 15, 0),
(276, 12, 0),(277, 12, 0),(278, 15, 0),(279, 15, 0),
(280, 12, 0),(281, 12, 0),(282, 15, 0),(283, 15, 0),
(284, 12, 0),(285, 12, 0),(286, 15, 0),(287, 15, 0),
(288, 15, 0),(289, 15, 0),(290, 18, 0),(291, 18, 0),
(292, 12, 0),(293, 15, 0),
(294, 12, 0),(295, 15, 0),
(296, 12, 0),(297, 12, 0),(298, 15, 0),(299, 15, 0),
(300, 12, 0),(301, 12, 0),(302, 15, 0),(303, 15, 0),
(304, 12, 0),(305, 15, 0),
(306, 15, 0),(307, 15, 0),(308, 18, 0),(309, 18, 0),
(310, 12, 0),(311, 15, 0),
(312, 12, 0),(313, 12, 0),(314, 15, 0),(315, 15, 0),

-- Laptops variants (122-243) = 122 variants
(122, 20, 0),(123, 20, 0),(124, 20, 0),(125, 20, 0),(126, 25, 0),(127, 25, 0),(128, 25, 0),(129, 25, 0),
(130, 15, 0),(131, 15, 0),(132, 15, 0),(133, 15, 0),(134, 15, 0),(135, 15, 0),(136, 18, 0),(137, 18, 0),
(138, 18, 0),(139, 18, 0),(140, 20, 0),(141, 20, 0),(142, 20, 0),(143, 20, 0),(144, 22, 0),(145, 22, 0),
(146, 22, 0),(147, 22, 0),
(148, 18, 0),(149, 18, 0),(150, 20, 0),(151, 20, 0),(152, 22, 0),(153, 22, 0),(154, 25, 0),(155, 25, 0),
(156, 18, 0),(157, 18, 0),(158, 20, 0),(159, 20, 0),(160, 22, 0),(161, 22, 0),(162, 25, 0),(163, 25, 0),
(164, 18, 0),(165, 18, 0),(166, 20, 0),(167, 20, 0),(168, 22, 0),(169, 22, 0),(170, 25, 0),(171, 25, 0),
(172, 20, 0),(173, 20, 0),(174, 22, 0),(175, 22, 0),
(176, 20, 0),(177, 20, 0),(178, 22, 0),(179, 22, 0),
(180, 18, 0),(181, 18, 0),(182, 20, 0),(183, 20, 0),(184, 22, 0),(185, 22, 0),(186, 25, 0),(187, 25, 0),
(188, 18, 0),(189, 18, 0),(190, 20, 0),(191, 20, 0),(192, 22, 0),(193, 22, 0),(194, 25, 0),(195, 25, 0),
(196, 18, 0),(197, 20, 0),(198, 22, 0),(199, 25, 0),
(200, 15, 0),(201, 18, 0),(202, 20, 0),(203, 22, 0),
(204, 18, 0),(205, 18, 0),(206, 20, 0),(207, 20, 0),(208, 22, 0),(209, 22, 0),(210, 25, 0),(211, 25, 0),
(212, 18, 0),(213, 18, 0),(214, 20, 0),(215, 20, 0),(216, 22, 0),(217, 22, 0),(218, 25, 0),(219, 25, 0),
(220, 25, 0),(221, 30, 0),
(222, 20, 0),(223, 20, 0),(224, 25, 0),(225, 25, 0),
(226, 20, 0),(227, 25, 0),(228, 25, 0),(229, 30, 0),
(230, 25, 0),(231, 30, 0),(232, 30, 0),(233, 35, 0),
(234, 20, 0),(235, 25, 0),
(236, 18, 0),(237, 20, 0),(238, 22, 0),(239, 25, 0),
(240, 18, 0),(241, 20, 0),(242, 22, 0),(243, 25, 0),

-- Audio & Headphones variants (316-354) = 39 variants
(316, 18, 0),(317, 18, 0),
(318, 18, 0),(319, 18, 0),
(320, 20, 0),
(321, 18, 0),(322, 18, 0),
(323, 18, 0),(324, 18, 0),
(325, 18, 0),(326, 18, 0),
(327, 18, 0),(328, 18, 0),
(329, 20, 0),(330, 20, 0),
(331, 18, 0),(332, 18, 0),
(333, 20, 0),(334, 20, 0),
(335, 18, 0),(336, 18, 0),
(337, 18, 0),(338, 18, 0),
(339, 18, 0),(340, 18, 0),
(341, 18, 0),(342, 18, 0),
(343, 18, 0),(344, 18, 0),
(345, 18, 0),(346, 18, 0),
(347, 20, 0),(348, 20, 0),
(349, 18, 0),(350, 18, 0),
(351, 18, 0),(352, 18, 0),
(353, 18, 0),(354, 18, 0),

-- Wearables variants (355-394) = 40 variants
(355, 15, 0),(356, 15, 0),
(357, 12, 0),(358, 12, 0),
(359, 15, 0),(360, 15, 0),
(361, 15, 0),(362, 15, 0),
(363, 15, 0),(364, 15, 0),
(365, 12, 0),(366, 12, 0),
(367, 12, 0),(368, 12, 0),
(369, 15, 0),(370, 15, 0),
(371, 15, 0),(372, 15, 0),
(373, 18, 0),(374, 18, 0),
(375, 10, 0),(376, 10, 0),
(377, 15, 0),(378, 15, 0),
(379, 15, 0),(380, 15, 0),
(381, 18, 0),(382, 18, 0),
(383, 12, 0),(384, 12, 0),
(385, 12, 0),(386, 12, 0),
(387, 18, 0),(388, 18, 0),
(389, 12, 0),(390, 12, 0),
(391, 15, 0),(392, 15, 0),
(393, 10, 0),(394, 10, 0);


-- Initial orders (6), each with 3–4 product variants
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
(1, 1, 3497.00, 'PENDING', '123 Elm Street, District 1, Ho Chi Minh City', '0901234567', 'Van An Nguyen', '2024-02-10 11:00:00', '2024-02-10 11:30:00'),
(2, 2, 4046.00, 'CONFIRMED', '456 Pine Avenue, District 2, Ho Chi Minh City', '0902345678', 'Thi Binh Tran', '2024-02-15 15:00:00', '2024-02-15 15:15:00'),
(3, 3, 4897.00, 'SHIPPED', '789 Oak Road, District 3, Ho Chi Minh City', '0903456789', 'Hoang Cuong Le', '2024-03-05 09:20:00', '2024-03-06 10:00:00'),
(4, 4, 2477.00, 'DELIVERED', '321 Maple Street, District 4, Ho Chi Minh City', '0904567890', 'Minh Dung Pham', '2024-03-18 14:10:00', '2024-03-20 16:30:00'),
(5, 5, 6446.00, 'CONFIRMED', '654 Cedar Lane, District 5, Ho Chi Minh City', '0905678901', 'Thi Hanh Vo', '2024-04-02 08:45:00', '2024-04-02 09:10:00'),
(6, 1, 3696.00, 'PENDING', '123 Elm Street, District 1, Ho Chi Minh City', '0901234567', 'Van An Nguyen', '2024-04-15 10:30:00', '2024-04-15 10:45:00');

INSERT INTO order_details (
    order_id,
    variant_id,
    product_name,
    product_price,
    quantity,
    subtotal,
    created_at
    )
VALUES
-- Order 1 items (uses variant_id from product_variants table)
(1, 5, 'Apple iPhone 15 Pro 256GB Blue Titanium', 1099.00, 1, 1099.00, '2024-02-10 11:05:00'),
(1, 163, 'Dell XPS 13 32GB/1TB Graphite', 1699.00, 1, 1699.00, '2024-02-10 11:06:00'),
(1, 203, 'Acer Swift Go 14 16GB/512GB Silver', 699.00, 1, 699.00, '2024-02-10 11:07:00'),
-- Order 2 items
(2, 98, 'Samsung Galaxy S24+ 256GB Onyx Black', 999.00, 1, 999.00, '2024-02-15 15:05:00'),
(2, 251, 'Apple iPad Pro 13 512GB Silver', 1499.00, 1, 1499.00, '2024-02-15 15:06:00'),
(2, 336, 'Jabra Elite 10 Cream', 249.00, 1, 249.00, '2024-02-15 15:07:00'),
(2, 201, 'Acer Swift Go 14 16GB/256GB Silver', 1299.00, 1, 1299.00, '2024-02-15 15:08:00'),
-- Order 3 items
(3, 72, 'Apple iPhone 15 Pro Max 256GB Natural Titanium', 1199.00, 1, 1199.00, '2024-03-05 09:25:00'),
(3, 130, 'MacBook Air 15 8GB/256GB Midnight', 1799.00, 1, 1799.00, '2024-03-05 09:26:00'),
(3, 238, 'Samsung Galaxy Book4 Pro 14 32GB/512GB Gray', 1899.00, 1, 1899.00, '2024-03-05 09:27:00'),
-- Order 4 items
(4, 274, 'Samsung Galaxy Tab S9+ 512GB Graphite', 1179.00, 1, 1179.00, '2024-03-18 14:15:00'),
(4, 328, 'Sony WF-1000XM5 Silver', 299.00, 1, 299.00, '2024-03-18 14:16:00'),
(4, 241, 'LG Gram 16 16GB/1TB Black', 999.00, 1, 999.00, '2024-03-18 14:17:00'),
-- Order 5 items
(5, 108, 'Xiaomi 14 Ultra 512GB Black', 1499.00, 1, 1499.00, '2024-04-02 08:50:00'),
(5, 220, 'Razer Blade 16 32GB/1TB Black', 2799.00, 1, 2799.00, '2024-04-02 08:51:00'),
(5, 348, 'Sonos Ace Soft White', 449.00, 1, 449.00, '2024-04-02 08:52:00'),
(5, 137, 'MacBook Air 15 16GB/256GB Starlight', 1699.00, 1, 1699.00, '2024-04-02 08:53:00'),
-- Order 6 items
(6, 40, 'Google Pixel 8 Pro 256GB Obsidian', 1099.00, 1, 1099.00, '2024-04-15 10:35:00'),
(6, 277, 'Samsung Galaxy Tab S9 128GB Graphite', 799.00, 1, 799.00, '2024-04-15 10:36:00'),
(6, 242, 'LG Gram 16 32GB/512GB Black', 1599.00, 1, 1599.00, '2024-04-15 10:37:00'),
(6, 354, 'Marshall Motif II ANC Cream', 199.00, 1, 199.00, '2024-04-15 10:38:00');

