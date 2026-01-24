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
-- BRANDS DATA
-- ============================================
INSERT INTO brands (
    id,
    name,
    logo_url,
    category_id
    )
VALUES
-- Smartphones
(1, 'Apple', NULL, 1),
(2, 'Samsung', NULL, 1),
(3, 'Google', NULL, 1),
(4, 'OnePlus', NULL, 1),
(5, 'Xiaomi', NULL, 1),
(6, 'Sony', NULL, 1),
(7, 'ASUS', NULL, 1),
(8, 'Nothing', NULL, 1),

-- Tablets
(9, 'Apple', NULL, 3),
(10, 'Samsung', NULL, 3),
(11, 'Microsoft', NULL, 3),
(12, 'Lenovo', NULL, 3),
(13, 'Xiaomi', NULL, 3),
(14, 'OnePlus', NULL, 3),
(15, 'Huawei', NULL, 3),
(16, 'Amazon', NULL, 3),
(17, 'Google', NULL, 3),

-- Laptops
(18, 'Apple', NULL, 2),
(19, 'Dell', NULL, 2),
(20, 'HP', NULL, 2),
(21, 'Lenovo', NULL, 2),
(22, 'ASUS', NULL, 2),
(23, 'Acer', NULL, 2),
(24, 'Microsoft', NULL, 2),
(25, 'Razer', NULL, 2),
(26, 'MSI', NULL, 2),
(27, 'Gigabyte', NULL, 2),
(28, 'Samsung', NULL, 2),
(29, 'LG', NULL, 2),

-- Audio & Headphones
(30, 'Sony', NULL, 4),
(31, 'Bose', NULL, 4),
(32, 'Apple', NULL, 4),
(33, 'Sennheiser', NULL, 4),
(34, 'Bowers & Wilkins', NULL, 4),
(35, 'Beats', NULL, 4),
(36, 'Soundcore', NULL, 4),
(37, 'Jabra', NULL, 4),
(38, 'Samsung', NULL, 4),
(39, 'Google', NULL, 4),
(40, 'Nothing', NULL, 4),
(41, 'JBL', NULL, 4),
(42, 'Shure', NULL, 4),
(43, 'Sonos', NULL, 4),
(44, 'Technics', NULL, 4),
(45, 'Marshall', NULL, 4),

-- Wearables
(46, 'Apple', NULL, 5),
(47, 'Samsung', NULL, 5),
(48, 'Google', NULL, 5),
(49, 'Garmin', NULL, 5),
(50, 'Fitbit', NULL, 5),
(51, 'Oura', NULL, 5),
(52, 'Xiaomi', NULL, 5),
(53, 'Huawei', NULL, 5),
(54, 'Amazfit', NULL, 5),
(55, 'Suunto', NULL, 5),
(56, 'Polar', NULL, 5),
(57, 'WHOOP', NULL, 5);

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
 '6.1" LTPO Super Retina XDR · A17 Pro · Titanium',
 'iPhone 15 Pro features a titanium design, A17 Pro performance, ProRAW 48MP camera system, USB‑C, and an adaptive 1-120Hz display.',
 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 1, 1),

(2, 'Apple iPhone 15',
 '6.1" Super Retina XDR · A16 Bionic · USB‑C',
 'iPhone 15 brings Dynamic Island, a 48MP main camera, A16 Bionic performance, USB‑C, and strong all‑day battery life.',
 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 1, 1),

(3, 'Samsung Galaxy S24 Ultra',
 '6.8" QHD+ LTPO AMOLED · Snapdragon 8 Gen 3 · 200MP',
 'Galaxy S24 Ultra combines a titanium frame, 200MP camera, S Pen, and Galaxy AI features with flagship performance.',
 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 1, 2),

(4, 'Samsung Galaxy S24',
 '6.2" FHD+ AMOLED · Snapdragon 8 Gen 3/Exynos 2400',
 'Galaxy S24 delivers compact flagship power, a bright 120Hz display, versatile cameras, and Galaxy AI features.',
 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 1, 2),

(5, 'Google Pixel 8 Pro',
 '6.7" LTPO OLED · Tensor G3 · Pro AI camera',
 'Pixel 8 Pro adds advanced AI tools, a 120Hz LTPO display, pro camera controls, and long-term software support.',
 'ACTIVE', '2023-10-12 09:00:00', '2024-06-01 10:00:00', 1, 3),

(6, 'Google Pixel 8',
 '6.2" OLED 120Hz · Tensor G3 · 50MP camera',
 'Pixel 8 combines Tensor G3 performance, a smooth 120Hz display, and excellent computational photography.',
 'ACTIVE', '2023-10-12 09:00:00', '2024-06-01 10:00:00', 1, 3),

(7, 'OnePlus 12',
 '6.82" LTPO AMOLED · Snapdragon 8 Gen 3 · 100W',
 'OnePlus 12 offers a large bright display, strong battery life, fast charging, and Hasselblad-tuned cameras.',
 'ACTIVE', '2024-01-23 09:00:00', '2024-06-01 10:00:00', 1, 4),

(8, 'Xiaomi 14',
 '6.36" LTPO AMOLED · Snapdragon 8 Gen 3 · Leica',
 'Xiaomi 14 pairs compact flagship hardware with Leica optics, fast charging, and HyperOS refinements.',
 'ACTIVE', '2023-10-26 09:00:00', '2024-06-01 10:00:00', 1, 5),

(9, 'Sony Xperia 1 V',
 '6.5" 4K OLED 120Hz · Snapdragon 8 Gen 2',
 'Xperia 1 V targets creators with a 4K 21:9 OLED display, pro photo/video apps, and manual controls.',
 'ACTIVE', '2023-05-11 09:00:00', '2024-06-01 10:00:00', 1, 6),

(10, 'ASUS ROG Phone 8 Pro',
 '6.78" AMOLED 165Hz · Snapdragon 8 Gen 3 · Gaming',
 'ROG Phone 8 Pro focuses on gaming with a 165Hz display, advanced cooling, and a large battery.',
 'ACTIVE', '2024-01-08 09:00:00', '2024-06-01 10:00:00', 1, 7),

(11, 'Apple iPhone 15 Pro Max',
 '6.7" LTPO Super Retina XDR · A17 Pro · 5x zoom',
 'iPhone 15 Pro Max adds a 5x tetraprism camera, titanium build, USB‑C, and top-tier performance.',
 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 1, 1),

(12, 'Apple iPhone 14 Pro',
 '6.1" LTPO Super Retina XDR · A16 Bionic',
 'iPhone 14 Pro introduced Dynamic Island, a 48MP main camera, and always‑on display.',
 'ACTIVE', '2022-09-16 10:00:00', '2024-06-01 10:00:00', 1, 1),

(13, 'Samsung Galaxy Z Fold5',
 '7.6" foldable AMOLED · Snapdragon 8 Gen 2 · S Pen',
 'Galaxy Z Fold5 offers a large foldable display, multitasking features, and flagship cameras.',
 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 1, 2),

(14, 'Samsung Galaxy Z Flip5',
 '6.7" foldable AMOLED · Snapdragon 8 Gen 2 · Flex',
 'Galaxy Z Flip5 features a larger cover screen, compact foldable design, and versatile cameras.',
 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 1, 2),

(15, 'Samsung Galaxy S24+',
 '6.7" QHD+ AMOLED · Snapdragon 8 Gen 3/Exynos',
 'Galaxy S24+ delivers a larger QHD+ display, strong battery life, and Galaxy AI features.',
 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 1, 2),

(16, 'Google Pixel 8a',
 '6.1" OLED 120Hz · Tensor G3 · 64MP camera',
 'Pixel 8a brings Pixel AI features and flagship-quality photography at a more accessible price.',
 'ACTIVE', '2024-05-14 09:00:00', '2024-06-01 10:00:00', 1, 3),

(17, 'Xiaomi 14 Ultra',
 '6.73" LTPO AMOLED · Snapdragon 8 Gen 3 · Leica',
 'Xiaomi 14 Ultra delivers a 1-inch main sensor, pro zoom lenses, and fast wired charging.',
 'ACTIVE', '2024-02-22 09:00:00', '2024-06-01 10:00:00', 1, 5),

(18, 'OnePlus 12R',
 '6.78" LTPO AMOLED · Snapdragon 8 Gen 2 · 5500mAh',
 'OnePlus 12R focuses on value with a large LTPO display, strong performance, and long battery life.',
 'ACTIVE', '2024-02-06 09:00:00', '2024-06-01 10:00:00', 1, 4),

(19, 'Nothing Phone (2)',
 '6.7" LTPO OLED · Snapdragon 8+ Gen 1 · Glyph',
 'Nothing Phone (2) combines the Glyph interface with clean software, a bright display, and solid cameras.',
 'ACTIVE', '2023-07-17 09:00:00', '2024-06-01 10:00:00', 1, 8),

(20, 'Sony Xperia 5 V',
 '6.1" OLED 120Hz · Snapdragon 8 Gen 2 · 21:9',
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
 '11" Ultra Retina XDR OLED · Apple M4 · 120Hz',
 'iPad Pro 11-inch (M4) delivers an Ultra Retina XDR OLED display, M4 performance, Apple Pencil Pro support, and Thunderbolt/USB‑C.',
 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 3, 9),

(22, 'Apple iPad Pro 13 (M4, 2024)',
 '13" Ultra Retina XDR OLED · Apple M4 · 120Hz',
 'iPad Pro 13-inch (M4) combines a large Ultra Retina XDR OLED screen with M4 power, pro apps, and Thunderbolt/USB‑C.',
 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 3, 9),

(23, 'Apple iPad Air 11 (M2, 2024)',
 '11" Liquid Retina · Apple M2 · USB‑C',
 'iPad Air 11-inch (M2) balances performance and portability with a Liquid Retina display, M2 chip, and Apple Pencil support.',
 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 3, 9),

(24, 'Apple iPad Air 13 (M2, 2024)',
 '13" Liquid Retina · Apple M2 · USB‑C',
 'iPad Air 13-inch (M2) offers a larger Liquid Retina display, M2 performance, and a slim lightweight design.',
 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 3, 9),

(25, 'Apple iPad (10th generation)',
 '10.9" Liquid Retina · A14 Bionic · USB‑C',
 'iPad (10th gen) features a 10.9-inch Liquid Retina display, A14 Bionic, USB‑C, and a modern all‑screen design.',
 'ACTIVE', '2022-10-26 10:00:00', '2024-06-01 10:00:00', 3, 9),

(26, 'Apple iPad mini (6th generation)',
 '8.3" Liquid Retina · A15 Bionic · USB‑C',
 'iPad mini (6th gen) packs A15 Bionic power into a compact 8.3-inch Liquid Retina design with Apple Pencil support.',
 'ACTIVE', '2021-09-24 10:00:00', '2024-06-01 10:00:00', 3, 9),

(27, 'Samsung Galaxy Tab S9 Ultra',
 '14.6" AMOLED 120Hz · Snapdragon 8 Gen 2 · S Pen',
 'Galaxy Tab S9 Ultra delivers a massive AMOLED display, S Pen support, flagship performance, and premium audio.',
 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 3, 10),

(28, 'Samsung Galaxy Tab S9+',
 '12.4" AMOLED 120Hz · Snapdragon 8 Gen 2 · S Pen',
 'Galaxy Tab S9+ offers a vibrant 12.4-inch AMOLED display, S Pen, and powerful Snapdragon 8 Gen 2 performance.',
 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 3, 10),

(29, 'Samsung Galaxy Tab S9',
 '11" AMOLED 120Hz · Snapdragon 8 Gen 2 · S Pen',
 'Galaxy Tab S9 pairs a sharp AMOLED display with flagship Snapdragon performance and S Pen productivity.',
 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 3, 10),

(30, 'Samsung Galaxy Tab S9 FE',
 '10.9" LCD 90Hz · Exynos 1380 · S Pen',
 'Galaxy Tab S9 FE provides a smooth 90Hz display, S Pen support, and great battery life for everyday use.',
 'ACTIVE', '2023-10-20 10:00:00', '2024-06-01 10:00:00', 3, 10),

(31, 'Samsung Galaxy Tab S9 FE+',
 '12.4" LCD 90Hz · Exynos 1380 · S Pen',
 'Galaxy Tab S9 FE+ adds a larger 12.4-inch display with S Pen support and solid all‑day battery life.',
 'ACTIVE', '2023-10-20 10:00:00', '2024-06-01 10:00:00', 3, 10),

(32, 'Microsoft Surface Pro 11',
 '13" OLED 120Hz · Snapdragon X Elite · 2‑in‑1',
 'Surface Pro 11 is a premium 2‑in‑1 with a 120Hz OLED display, Snapdragon X performance, and all‑day mobility.',
 'ACTIVE', '2024-06-18 10:00:00', '2024-06-18 10:00:00', 3, 11),

(33, 'Microsoft Surface Go 4',
 '10.5" PixelSense · Intel N200 · 2‑in‑1',
 'Surface Go 4 delivers a compact 2‑in‑1 form factor with a crisp PixelSense display and improved performance.',
 'ACTIVE', '2023-10-03 10:00:00', '2024-06-01 10:00:00', 3, 11),

(34, 'Lenovo Tab P12',
 '12.7" 3K LCD · Dimensity 7050 · Pen support',
 'Tab P12 features a large 3K display, quad speakers, and optional pen support for media and productivity.',
 'ACTIVE', '2023-08-01 10:00:00', '2024-06-01 10:00:00', 3, 12),

(35, 'Lenovo Tab P11 Pro (2nd Gen)',
 '11.2" OLED 120Hz · Kompanio 1300T',
 'Tab P11 Pro (2nd Gen) offers a vivid OLED screen, premium audio, and smooth performance for entertainment.',
 'ACTIVE', '2022-09-01 10:00:00', '2024-06-01 10:00:00', 3, 12),

(36, 'Xiaomi Pad 6',
 '11" 144Hz · Snapdragon 870 · Quad speakers',
 'Xiaomi Pad 6 combines a 144Hz display with Snapdragon 870 performance and quad speakers for immersive media.',
 'ACTIVE', '2023-04-18 10:00:00', '2024-06-01 10:00:00', 3, 13),

(37, 'OnePlus Pad',
 '11.61" 144Hz · Dimensity 9000 · Quad speakers',
 'OnePlus Pad delivers a smooth 144Hz display, Dimensity 9000 power, and a slim aluminum design.',
 'ACTIVE', '2023-04-28 10:00:00', '2024-06-01 10:00:00', 3, 14),

(38, 'Huawei MatePad Pro 13.2',
 '13.2" OLED 144Hz · Kirin 9000S',
 'MatePad Pro 13.2 offers a large OLED display, premium build, and strong productivity features.',
 'ACTIVE', '2023-12-12 10:00:00', '2024-06-01 10:00:00', 3, 15),

(39, 'Amazon Fire Max 11',
 '11" 2K LCD · MT8188J · Alexa',
 'Fire Max 11 provides a large 2K display, Alexa integration, and solid battery life for entertainment.',
 'ACTIVE', '2023-06-14 10:00:00', '2024-06-01 10:00:00', 3, 16),

(40, 'Google Pixel Tablet',
 '10.95" LCD · Tensor G2 · Charging speaker dock',
 'Pixel Tablet combines a bright display with Tensor G2 power and a speaker dock for smart‑home use.',
 'ACTIVE', '2023-06-20 10:00:00', '2024-06-01 10:00:00', 3, 17);

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
 '14.2" Liquid Retina XDR · M3 Pro · 120Hz ProMotion',
 'MacBook Pro 14 with M3 Pro delivers pro-class CPU/GPU performance, Liquid Retina XDR display, long battery life, and a wide port selection including HDMI and SDXC.',
 'ACTIVE', '2023-10-30 09:00:00', '2024-06-10 10:00:00', 2, 18),

(42, 'Apple MacBook Air 15 (M3, 2024)',
 '15.3" Liquid Retina · M3 · Fanless design',
 'MacBook Air 15 with M3 offers a large, color-accurate display, silent fanless operation, all-day battery life, and a thin-and-light aluminum chassis.',
 'ACTIVE', '2024-03-08 09:00:00', '2024-06-05 10:00:00', 2, 18),

(43, 'Dell XPS 14 (9440, 2024)',
 '14.5" 3.2K OLED · Core Ultra · Premium build',
 'XPS 14 pairs Intel Core Ultra with a vivid OLED display, premium CNC aluminum chassis, and a clean minimal design for creators and professionals.',
 'ACTIVE', '2024-02-15 09:00:00', '2024-06-01 10:00:00', 2, 19),

(44, 'Dell XPS 13 (9340, 2024)',
 '13.4" FHD+/OLED · Core Ultra · Ultra-portable',
 'XPS 13 delivers ultra-portability with Intel Core Ultra performance, long battery life, and a compact chassis with a high-quality display.',
 'ACTIVE', '2024-02-10 09:00:00', '2024-05-20 10:00:00', 2, 19),

(45, 'HP Spectre x360 14 (2024)',
 '14" 2.8K OLED · Core Ultra · 2-in-1',
 'Spectre x360 14 is a premium convertible with OLED display, strong speakers, pen support, and flexible 360° hinge for tablet mode.',
 'ACTIVE', '2024-01-20 09:00:00', '2024-05-25 10:00:00', 2, 20),

(46, 'Lenovo ThinkPad X1 Carbon Gen 12 (2024)',
 '14" 2.8K OLED · Core Ultra · Carbon-fiber chassis',
 'ThinkPad X1 Carbon Gen 12 is a business flagship with robust security, legendary keyboard, lightweight carbon-fiber build, and Intel Core Ultra efficiency.',
 'ACTIVE', '2024-02-01 09:00:00', '2024-05-30 10:00:00', 2, 21),

(47, 'Lenovo ThinkPad X1 Yoga Gen 9 (2024)',
 '14" 2.8K OLED · Core Ultra · 2-in-1 business',
 'ThinkPad X1 Yoga Gen 9 combines a premium convertible design, pen support, enterprise security, and strong performance for professionals.',
 'ACTIVE', '2024-02-05 09:00:00', '2024-05-30 10:00:00', 2, 21),

(48, 'ASUS ROG Zephyrus G14 (2024)',
 '14" QHD+ 120Hz · Ryzen 9 · RTX graphics',
 'ROG Zephyrus G14 balances powerful gaming performance with a compact chassis, efficient thermals, and a high-refresh display.',
 'ACTIVE', '2024-03-01 09:00:00', '2024-06-15 10:00:00', 2, 22),

(49, 'ASUS ROG Zephyrus G16 (2024)',
 '16" OLED 240Hz · Core Ultra · RTX graphics',
 'ROG Zephyrus G16 delivers a stunning OLED display, strong gaming/creator performance, and a sleek aluminum design.',
 'ACTIVE', '2024-03-01 09:00:00', '2024-06-15 10:00:00', 2, 22),

(50, 'Acer Swift X 14 (2024)',
 '14.5" 2.8K OLED · Core Ultra · RTX 4050',
 'Swift X 14 targets creators with a color-accurate OLED screen, discrete RTX graphics, and a portable chassis.',
 'ACTIVE', '2024-02-20 09:00:00', '2024-05-10 10:00:00', 2, 23),

(51, 'Acer Swift Go 14 (2024)',
 '14" 2.8K OLED · Core Ultra · Lightweight',
 'Swift Go 14 offers a thin-and-light design with a sharp OLED display, modern ports, and solid battery life.',
 'ACTIVE', '2024-02-18 09:00:00', '2024-05-08 10:00:00', 2, 23),

(52, 'Microsoft Surface Laptop 6 (2024)',
 '13.5"/15" PixelSense · Core Ultra · Business',
 'Surface Laptop 6 for Business features a refined aluminum chassis, excellent keyboard, and Intel Core Ultra efficiency with enterprise security.',
 'ACTIVE', '2024-04-01 09:00:00', '2024-06-12 10:00:00', 2, 24),

(53, 'Microsoft Surface Laptop Studio 2 (2023)',
 '14.4" 120Hz PixelSense · H-series · RTX',
 'Surface Laptop Studio 2 combines a unique pull-forward display, powerful H-series CPU and RTX graphics for creative workflows.',
 'ACTIVE', '2023-10-03 09:00:00', '2024-05-20 10:00:00', 2, 24),

(54, 'Razer Blade 16 (2024)',
 '16" QHD+ Mini-LED 240Hz · i9 · RTX 4080/4090',
 'Razer Blade 16 delivers high-end gaming performance in a premium CNC aluminum chassis with a fast Mini-LED display.',
 'ACTIVE', '2024-01-15 09:00:00', '2024-05-18 10:00:00', 2, 25),

(55, 'Razer Blade 14 (2024)',
 '14" QHD+ 240Hz · Ryzen 9 · RTX 4070',
 'Razer Blade 14 pairs strong gaming performance with a compact and portable metal chassis.',
 'ACTIVE', '2024-01-15 09:00:00', '2024-05-18 10:00:00', 2, 25),

(56, 'MSI Stealth 16 Studio (2024)',
 '16" QHD+ 240Hz · Core i9 · RTX Studio',
 'Stealth 16 Studio blends creator-grade performance with a sleek chassis, high-refresh display, and strong connectivity.',
 'ACTIVE', '2024-02-08 09:00:00', '2024-05-22 10:00:00', 2, 26),

(57, 'MSI Raider GE78 HX (2024)',
 '17" QHD+ 240Hz · Core i9 HX · RTX 4090',
 'Raider GE78 HX is a desktop-replacement gaming powerhouse with high-wattage GPU and extensive cooling.',
 'ACTIVE', '2024-02-08 09:00:00', '2024-05-22 10:00:00', 2, 26),

(58, 'Gigabyte AORUS 16X (2024)',
 '16" QHD+ 165Hz · Core i7/Ultra · RTX 4070',
 'AORUS 16X offers a balanced gaming setup with a high-refresh display, strong thermals, and fast storage.',
 'ACTIVE', '2024-02-12 09:00:00', '2024-05-12 10:00:00', 2, 27),

(59, 'Samsung Galaxy Book4 Pro 14 (2024)',
 '14" 3K AMOLED · Core Ultra · Ultra-light',
 'Galaxy Book4 Pro 14 features a vibrant AMOLED display, long battery life, and a lightweight magnesium chassis.',
 'ACTIVE', '2024-02-26 09:00:00', '2024-05-15 10:00:00', 2, 28),

(60, 'LG Gram 16 (2024)',
 '16" WQXGA · Core Ultra · 1.2kg class',
 'LG Gram 16 prioritizes portability with a large, sharp display, long battery life, and ultralight design.',
 'ACTIVE', '2024-02-25 09:00:00', '2024-05-15 10:00:00', 2, 29);

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
 'Over‑ear ANC · 30mm drivers · 30h battery',
 'WH‑1000XM5 delivers top-tier active noise cancellation, warm balanced tuning, and long battery life with multipoint Bluetooth.',
 'ACTIVE', '2023-05-15 09:00:00', '2024-06-01 10:00:00', 4, 30),

(62, 'Bose QuietComfort Ultra Headphones',
 'Over‑ear ANC · Immersive Audio · 24h battery',
 'QuietComfort Ultra Headphones offer powerful noise cancellation, spacious sound, and soft all‑day comfort.',
 'ACTIVE', '2023-10-05 09:00:00', '2024-06-01 10:00:00', 4, 31),

(63, 'Apple AirPods Pro (2nd gen, USB‑C)',
 'In‑ear ANC · Adaptive Audio · MagSafe',
 'AirPods Pro (2nd gen) with USB‑C provide strong ANC, Adaptive Transparency, spatial audio, and seamless Apple device pairing.',
 'ACTIVE', '2023-09-22 09:00:00', '2024-06-01 10:00:00', 4, 32),

(64, 'Sennheiser MOMENTUM 4 Wireless',
 'Over‑ear ANC · 60h battery · aptX Adaptive',
 'Momentum 4 Wireless combines long battery life with punchy, detailed sound and adaptive noise cancellation.',
 'ACTIVE', '2022-08-23 09:00:00', '2024-06-01 10:00:00', 4, 33),

(65, 'Bowers & Wilkins Px7 S2e',
 'Over‑ear ANC · 40mm drivers · 30h battery',
 'Px7 S2e delivers refined tuning, premium materials, and strong ANC for high‑end wireless listening.',
 'ACTIVE', '2023-10-04 09:00:00', '2024-06-01 10:00:00', 4, 34),

(66, 'Bose QuietComfort Ultra Earbuds',
 'True wireless ANC · Immersive Audio · USB‑C',
 'QC Ultra Earbuds feature class‑leading noise cancellation, immersive audio, and a compact charging case.',
 'ACTIVE', '2023-10-05 09:00:00', '2024-06-01 10:00:00', 4, 31),

(67, 'Sony WF-1000XM5',
 'True wireless ANC · LDAC · 8h battery',
 'WF‑1000XM5 offers flagship ANC, rich sound with LDAC, and improved comfort in a smaller shell.',
 'ACTIVE', '2023-07-24 09:00:00', '2024-06-01 10:00:00', 4, 30),

(68, 'Apple AirPods Max',
 'Over‑ear ANC · Spatial Audio · Aluminum build',
 'AirPods Max delivers premium build quality, strong ANC, and spatial audio with dynamic head tracking.',
 'ACTIVE', '2020-12-15 09:00:00', '2024-06-01 10:00:00', 4, 32),

(69, 'Beats Studio Pro',
 'Over‑ear ANC · USB‑C lossless · 40h battery',
 'Beats Studio Pro adds USB‑C lossless audio, improved ANC, and long battery life in a lightweight design.',
 'ACTIVE', '2023-07-19 09:00:00', '2024-06-01 10:00:00', 4, 35),

(70, 'Soundcore Liberty 4 NC',
 'True wireless ANC · Hi‑Res Audio · 10h battery',
 'Liberty 4 NC offers strong ANC, solid sound, and long battery life at a competitive price.',
 'ACTIVE', '2023-06-29 09:00:00', '2024-06-01 10:00:00', 4, 36),

(71, 'Jabra Elite 10',
 'True wireless ANC · Dolby Atmos · 8h battery',
 'Elite 10 features all‑day comfort, Dolby Atmos with head tracking, and improved call quality.',
 'ACTIVE', '2023-09-01 09:00:00', '2024-06-01 10:00:00', 4, 37),

(72, 'Samsung Galaxy Buds2 Pro',
 'True wireless ANC · 24‑bit audio · IPX7',
 'Galaxy Buds2 Pro provides strong ANC, 24‑bit audio on compatible Galaxy devices, and a compact fit.',
 'ACTIVE', '2022-08-26 09:00:00', '2024-06-01 10:00:00', 4, 38),

(73, 'Google Pixel Buds Pro',
 'True wireless ANC · Multipoint · 11h battery',
 'Pixel Buds Pro offers great noise cancellation, multipoint Bluetooth, and tight Google Assistant integration.',
 'ACTIVE', '2022-07-21 09:00:00', '2024-06-01 10:00:00', 4, 39),

(74, 'Nothing Ear (2024)',
 'True wireless ANC · Hi‑Res Audio · 8.5h battery',
 'Nothing Ear (2024) delivers clear sound with LDAC, customizable EQ, and a transparent design.',
 'ACTIVE', '2024-04-18 09:00:00', '2024-06-01 10:00:00', 4, 40),

(75, 'JBL Tour One M2',
 'Over‑ear ANC · 50h battery · Spatial Audio',
 'Tour One M2 combines strong ANC, deep bass, and very long battery life for travel.',
 'ACTIVE', '2023-01-05 09:00:00', '2024-06-01 10:00:00', 4, 41),

(76, 'Shure AONIC 50 Gen 2',
 'Over‑ear ANC · Hi‑Res Audio · 45h battery',
 'AONIC 50 Gen 2 delivers studio‑grade tuning with powerful ANC and robust codec support.',
 'ACTIVE', '2023-11-15 09:00:00', '2024-06-01 10:00:00', 4, 42),

(77, 'Sonos Ace',
 'Over‑ear ANC · Spatial Audio · 30h battery',
 'Sonos Ace offers cinematic spatial audio, excellent ANC, and seamless integration with Sonos systems.',
 'ACTIVE', '2024-06-05 09:00:00', '2024-06-15 10:00:00', 4, 43),

(78, 'Technics EAH-AZ80',
 'True wireless ANC · Hi‑Res Audio · 7h battery',
 'EAH‑AZ80 delivers rich sound with LDAC and excellent call quality with multipoint connectivity.',
 'ACTIVE', '2023-06-15 09:00:00', '2024-06-01 10:00:00', 4, 44),

(79, 'Bose SoundLink Flex',
 'Portable Bluetooth speaker · IP67 · 12h battery',
 'SoundLink Flex is a rugged portable speaker with balanced sound, strong bass, and IP67 durability.',
 'ACTIVE', '2022-05-12 09:00:00', '2024-06-01 10:00:00', 4, 31),

(80, 'Marshall Motif II ANC',
 'True wireless ANC · 30h total battery · IPX5',
 'Motif II ANC combines signature Marshall tuning with ANC and a compact case for all‑day listening.',
 'ACTIVE', '2023-09-12 09:00:00', '2024-06-01 10:00:00', 4, 45);

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
 '41/45mm OLED · S9 SiP · Double Tap',
 'Apple Watch Series 9 adds the S9 SiP, a brighter 2000‑nit display, on‑device Siri, and Double Tap gestures with carbon‑neutral case options.',
 'ACTIVE', '2023-09-22 10:00:00', '2024-06-20 10:00:00', 5, 46),

(82, 'Apple Watch Ultra 2',
 '49mm titanium · S9 SiP · 100m water',
 'Apple Watch Ultra 2 delivers a rugged titanium build, 3000‑nit display, precision dual‑frequency GPS, and up to 36‑hour battery life.',
 'ACTIVE', '2023-09-22 10:00:00', '2024-06-20 10:00:00', 5, 46),

(83, 'Samsung Galaxy Watch6',
 '40/44mm Super AMOLED · Wear OS',
 'Galaxy Watch6 brings a larger display, improved health tracking, advanced sleep coaching, and Wear OS apps in a slimmer design.',
 'ACTIVE', '2023-07-26 10:00:00', '2024-06-20 10:00:00', 5, 47),

(84, 'Samsung Galaxy Watch6 Classic',
 '43/47mm Super AMOLED · Rotating bezel',
 'Watch6 Classic combines stainless steel, a rotating bezel, and enhanced health sensors with the Wear OS ecosystem.',
 'ACTIVE', '2023-07-26 10:00:00', '2024-06-20 10:00:00', 5, 47),

(85, 'Google Pixel Watch 2',
 '41mm AMOLED · Snapdragon W5 · Fitbit',
 'Pixel Watch 2 integrates Fitbit health features, improved sensors, and all‑day battery life with Wear OS performance.',
 'ACTIVE', '2023-10-12 09:00:00', '2024-06-20 10:00:00', 5, 48),

(86, 'Garmin fēnix 7 Pro',
 '47/51mm MIP · Multi‑band GPS · Solar',
 'fēnix 7 Pro adds a brighter flashlight, upgraded heart‑rate sensor, and exceptional battery life for outdoor training.',
 'ACTIVE', '2023-05-31 09:00:00', '2024-06-20 10:00:00', 5, 49),

(87, 'Garmin Forerunner 965',
 '47mm AMOLED · Multi‑band GPS',
 'Forerunner 965 offers an AMOLED display, training readiness, and advanced running metrics with long battery life.',
 'ACTIVE', '2023-03-01 09:00:00', '2024-06-20 10:00:00', 5, 49),

(88, 'Garmin Venu 3',
 '45/41mm AMOLED · Health & sleep',
 'Venu 3 focuses on health metrics, sleep coaching, and voice calling in a modern AMOLED smartwatch.',
 'ACTIVE', '2023-08-31 09:00:00', '2024-06-20 10:00:00', 5, 49),

(89, 'Fitbit Sense 2',
 'EDA stress sensor · ECG · AMOLED',
 'Sense 2 delivers stress management with cEDA, ECG app support, and comprehensive health insights.',
 'ACTIVE', '2022-09-23 09:00:00', '2024-06-20 10:00:00', 5, 50),

(90, 'Fitbit Charge 6',
 'AMOLED band · Built‑in GPS',
 'Charge 6 adds improved heart‑rate accuracy, Google apps, and built‑in GPS in a slim fitness tracker.',
 'ACTIVE', '2023-09-28 09:00:00', '2024-06-20 10:00:00', 5, 50),

(91, 'Oura Ring Gen 3',
 'Smart ring · Sleep & readiness',
 'Oura Ring Gen 3 tracks sleep, readiness, and recovery with a lightweight titanium ring and accurate sensors.',
 'ACTIVE', '2022-10-26 09:00:00', '2024-06-20 10:00:00', 5, 51),

(92, 'Xiaomi Watch 2 Pro',
 '46mm AMOLED · Wear OS · LTE',
 'Watch 2 Pro combines Wear OS, LTE option, and dual‑band GNSS in a premium design.',
 'ACTIVE', '2023-10-26 09:00:00', '2024-06-20 10:00:00', 5, 52),

(93, 'Huawei Watch GT 4',
 '41/46mm AMOLED · 2‑week battery',
 'Watch GT 4 offers long battery life, accurate GNSS, and health tracking in a stylish body.',
 'ACTIVE', '2023-09-14 09:00:00', '2024-06-20 10:00:00', 5, 53),

(94, 'Amazfit Balance',
 '46mm AMOLED · 14‑day battery',
 'Amazfit Balance provides dual‑band GPS, body composition metrics, and long battery life.',
 'ACTIVE', '2023-09-20 09:00:00', '2024-06-20 10:00:00', 5, 54),

(95, 'Suunto Vertical',
 'Rugged GPS · Solar options · Offline maps',
 'Suunto Vertical targets outdoor athletes with offline maps, solar charging options, and multi‑band GNSS.',
 'ACTIVE', '2023-05-16 09:00:00', '2024-06-20 10:00:00', 5, 55),

(96, 'Polar Vantage V3',
 '47mm AMOLED · Dual‑frequency GPS',
 'Vantage V3 includes AMOLED display, ECG/SpO2, and advanced training tools for endurance athletes.',
 'ACTIVE', '2023-10-11 09:00:00', '2024-06-20 10:00:00', 5, 56),

(97, 'Apple Watch SE (2nd gen)',
 '40/44mm Retina · S8 SiP',
 'Apple Watch SE (2nd gen) offers core Apple Watch features with S8 SiP, crash detection, and watchOS support.',
 'ACTIVE', '2022-09-16 10:00:00', '2024-06-20 10:00:00', 5, 46),

(98, 'Samsung Galaxy Watch5 Pro',
 '45mm sapphire · Long battery',
 'Watch5 Pro delivers rugged durability, sapphire crystal, and extended battery life for outdoor use.',
 'ACTIVE', '2022-08-26 09:00:00', '2024-06-20 10:00:00', 5, 47),

(99, 'WHOOP 4.0',
 'Screenless fitness band · Recovery',
 'WHOOP 4.0 provides continuous recovery, strain, and sleep coaching with a screenless wearable.',
 'ACTIVE', '2021-09-08 09:00:00', '2024-06-20 10:00:00', 5, 57),

(100, 'Samsung Galaxy Ring',
 'Titanium smart ring · Sleep & health',
 'Galaxy Ring tracks sleep, activity, and wellness in a lightweight titanium ring with long battery life.',
 'ACTIVE', '2024-07-10 09:00:00', '2024-07-10 09:00:00', 5, 47);

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
-- Smartphones
-- iPhone 15 Pro
(1, 'Brand', 'Apple'),
(1, 'Model', 'iPhone 15 Pro'),
(1, 'Display', '6.1" LTPO Super Retina XDR, 1-120Hz'),
(1, 'Processor', 'Apple A17 Pro'),
(1, 'RAM', '8GB'),
(1, 'Main Camera', '48MP main + 12MP ultra‑wide + 12MP 3x telephoto'),
(1, 'Selfie Camera', '12MP TrueDepth'),
(1, 'Battery', '3274 mAh'),
(1, 'OS', 'iOS 17 (upgradable)'),
(1, 'Connectivity', '5G, Wi‑Fi 6E, Bluetooth 5.3, USB‑C'),

-- iPhone 15
(2, 'Brand', 'Apple'),
(2, 'Model', 'iPhone 15'),
(2, 'Display', '6.1" Super Retina XDR, 60Hz'),
(2, 'Processor', 'Apple A16 Bionic'),
(2, 'RAM', '6GB'),
(2, 'Main Camera', '48MP main + 12MP ultra‑wide'),
(2, 'Selfie Camera', '12MP TrueDepth'),
(2, 'Battery', '3349 mAh'),
(2, 'OS', 'iOS 17 (upgradable)'),
(2, 'Connectivity', '5G, Wi‑Fi 6, Bluetooth 5.3, USB‑C'),

-- Galaxy S24 Ultra
(3, 'Brand', 'Samsung'),
(3, 'Model', 'Galaxy S24 Ultra'),
(3, 'Display', '6.8" QHD+ LTPO AMOLED, 1-120Hz'),
(3, 'Processor', 'Snapdragon 8 Gen 3 for Galaxy'),
(3, 'RAM', '12GB'),
(3, 'Main Camera', '200MP + 50MP 5x + 10MP 3x + 12MP ultra‑wide'),
(3, 'Selfie Camera', '12MP'),
(3, 'Battery', '5000 mAh'),
(3, 'OS', 'Android 14 (One UI 6.1)'),
(3, 'Connectivity', '5G, Wi‑Fi 7, Bluetooth 5.3, UWB'),

-- Galaxy S24
(4, 'Brand', 'Samsung'),
(4, 'Model', 'Galaxy S24'),
(4, 'Display', '6.2" FHD+ AMOLED, 1-120Hz'),
(4, 'Processor', 'Snapdragon 8 Gen 3 / Exynos 2400'),
(4, 'RAM', '8GB'),
(4, 'Main Camera', '50MP + 10MP 3x + 12MP ultra‑wide'),
(4, 'Selfie Camera', '12MP'),
(4, 'Battery', '4000 mAh'),
(4, 'OS', 'Android 14 (One UI 6.1)'),
(4, 'Connectivity', '5G, Wi‑Fi 6E, Bluetooth 5.3'),

-- Pixel 8 Pro
(5, 'Brand', 'Google'),
(5, 'Model', 'Pixel 8 Pro'),
(5, 'Display', '6.7" LTPO OLED, 1-120Hz'),
(5, 'Processor', 'Google Tensor G3'),
(5, 'RAM', '12GB'),
(5, 'Main Camera', '50MP + 48MP 5x + 48MP ultra‑wide'),
(5, 'Selfie Camera', '10.5MP'),
(5, 'Battery', '5050 mAh'),
(5, 'OS', 'Android 14'),
(5, 'Connectivity', '5G, Wi‑Fi 7, Bluetooth 5.3'),

-- Pixel 8
(6, 'Brand', 'Google'),
(6, 'Model', 'Pixel 8'),
(6, 'Display', '6.2" OLED, 120Hz'),
(6, 'Processor', 'Google Tensor G3'),
(6, 'RAM', '8GB'),
(6, 'Main Camera', '50MP + 12MP ultra‑wide'),
(6, 'Selfie Camera', '10.5MP'),
(6, 'Battery', '4575 mAh'),
(6, 'OS', 'Android 14'),
(6, 'Connectivity', '5G, Wi‑Fi 7, Bluetooth 5.3'),

-- OnePlus 12
(7, 'Brand', 'OnePlus'),
(7, 'Model', 'OnePlus 12'),
(7, 'Display', '6.82" LTPO AMOLED, 1-120Hz'),
(7, 'Processor', 'Snapdragon 8 Gen 3'),
(7, 'RAM', '12GB'),
(7, 'Main Camera', '50MP + 64MP 3x periscope + 48MP ultra‑wide'),
(7, 'Selfie Camera', '32MP'),
(7, 'Battery', '5400 mAh'),
(7, 'OS', 'Android 14 (OxygenOS)'),
(7, 'Connectivity', '5G, Wi‑Fi 7, Bluetooth 5.4'),

-- Xiaomi 14
(8, 'Brand', 'Xiaomi'),
(8, 'Model', 'Xiaomi 14'),
(8, 'Display', '6.36" LTPO AMOLED, 1-120Hz'),
(8, 'Processor', 'Snapdragon 8 Gen 3'),
(8, 'RAM', '12GB'),
(8, 'Main Camera', '50MP + 50MP 3.2x + 50MP ultra‑wide (Leica)'),
(8, 'Selfie Camera', '32MP'),
(8, 'Battery', '4610 mAh'),
(8, 'OS', 'Android 14 (HyperOS)'),
(8, 'Connectivity', '5G, Wi‑Fi 7, Bluetooth 5.4'),

-- Sony Xperia 1 V
(9, 'Brand', 'Sony'),
(9, 'Model', 'Xperia 1 V'),
(9, 'Display', '6.5" 4K OLED, 120Hz, 21:9'),
(9, 'Processor', 'Snapdragon 8 Gen 2'),
(9, 'RAM', '12GB'),
(9, 'Main Camera', '48MP + 12MP 85‑125mm tele + 12MP ultra‑wide'),
(9, 'Selfie Camera', '12MP'),
(9, 'Battery', '5000 mAh'),
(9, 'OS', 'Android 14'),
(9, 'Connectivity', '5G, Wi‑Fi 6E, Bluetooth 5.3'),

-- ASUS ROG Phone 8 Pro
(10, 'Brand', 'ASUS'),
(10, 'Model', 'ROG Phone 8 Pro'),
(10, 'Display', '6.78" AMOLED, 165Hz'),
(10, 'Processor', 'Snapdragon 8 Gen 3'),
(10, 'RAM', '16GB'),
(10, 'Main Camera', '50MP + 32MP 3x + 13MP ultra‑wide'),
(10, 'Selfie Camera', '32MP'),
(10, 'Battery', '5500 mAh'),
(10, 'OS', 'Android 14 (ROG UI)'),
(10, 'Connectivity', '5G, Wi‑Fi 7, Bluetooth 5.3'),

-- iPhone 15 Pro Max
(11, 'Brand', 'Apple'),
(11, 'Model', 'iPhone 15 Pro Max'),
(11, 'Display', '6.7" LTPO Super Retina XDR, 1-120Hz'),
(11, 'Processor', 'Apple A17 Pro'),
(11, 'RAM', '8GB'),
(11, 'Main Camera', '48MP main + 12MP ultra‑wide + 12MP 5x tetraprism'),
(11, 'Selfie Camera', '12MP TrueDepth'),
(11, 'Battery', '4422 mAh'),
(11, 'OS', 'iOS 17 (upgradable)'),
(11, 'Connectivity', '5G, Wi‑Fi 6E, Bluetooth 5.3, USB‑C'),

-- iPhone 14 Pro
(12, 'Brand', 'Apple'),
(12, 'Model', 'iPhone 14 Pro'),
(12, 'Display', '6.1" LTPO Super Retina XDR, 1-120Hz'),
(12, 'Processor', 'Apple A16 Bionic'),
(12, 'RAM', '6GB'),
(12, 'Main Camera', '48MP main + 12MP ultra‑wide + 12MP 3x telephoto'),
(12, 'Selfie Camera', '12MP TrueDepth'),
(12, 'Battery', '3200 mAh'),
(12, 'OS', 'iOS 16 (upgradable)'),
(12, 'Connectivity', '5G, Wi‑Fi 6, Bluetooth 5.3, Lightning'),

-- Galaxy Z Fold5
(13, 'Brand', 'Samsung'),
(13, 'Model', 'Galaxy Z Fold5'),
(13, 'Display', '7.6" QXGA+ LTPO AMOLED, 1-120Hz (main); 6.2" cover'),
(13, 'Processor', 'Snapdragon 8 Gen 2 for Galaxy'),
(13, 'RAM', '12GB'),
(13, 'Main Camera', '50MP + 12MP ultra‑wide + 10MP 3x telephoto'),
(13, 'Selfie Camera', '10MP cover + 4MP under‑display'),
(13, 'Battery', '4400 mAh'),
(13, 'OS', 'Android 14 (One UI 6.1)'),
(13, 'Connectivity', '5G, Wi‑Fi 6E, Bluetooth 5.3'),

-- Galaxy Z Flip5
(14, 'Brand', 'Samsung'),
(14, 'Model', 'Galaxy Z Flip5'),
(14, 'Display', '6.7" FHD+ AMOLED, 1-120Hz; 3.4" cover'),
(14, 'Processor', 'Snapdragon 8 Gen 2 for Galaxy'),
(14, 'RAM', '8GB'),
(14, 'Main Camera', '12MP + 12MP ultra‑wide'),
(14, 'Selfie Camera', '10MP'),
(14, 'Battery', '3700 mAh'),
(14, 'OS', 'Android 14 (One UI 6.1)'),
(14, 'Connectivity', '5G, Wi‑Fi 6E, Bluetooth 5.3'),

-- Galaxy S24+
(15, 'Brand', 'Samsung'),
(15, 'Model', 'Galaxy S24+'),
(15, 'Display', '6.7" QHD+ AMOLED, 1-120Hz'),
(15, 'Processor', 'Snapdragon 8 Gen 3 / Exynos 2400'),
(15, 'RAM', '12GB'),
(15, 'Main Camera', '50MP + 10MP 3x + 12MP ultra‑wide'),
(15, 'Selfie Camera', '12MP'),
(15, 'Battery', '4900 mAh'),
(15, 'OS', 'Android 14 (One UI 6.1)'),
(15, 'Connectivity', '5G, Wi‑Fi 7, Bluetooth 5.3'),

-- Pixel 8a
(16, 'Brand', 'Google'),
(16, 'Model', 'Pixel 8a'),
(16, 'Display', '6.1" OLED, 120Hz'),
(16, 'Processor', 'Google Tensor G3'),
(16, 'RAM', '8GB'),
(16, 'Main Camera', '64MP + 13MP ultra‑wide'),
(16, 'Selfie Camera', '13MP'),
(16, 'Battery', '4492 mAh'),
(16, 'OS', 'Android 14'),
(16, 'Connectivity', '5G, Wi‑Fi 6E, Bluetooth 5.3'),

-- Xiaomi 14 Ultra
(17, 'Brand', 'Xiaomi'),
(17, 'Model', 'Xiaomi 14 Ultra'),
(17, 'Display', '6.73" LTPO AMOLED, 1-120Hz'),
(17, 'Processor', 'Snapdragon 8 Gen 3'),
(17, 'RAM', '16GB'),
(17, 'Main Camera', '50MP 1-inch + 50MP 3.2x + 50MP 5x + 50MP ultra‑wide'),
(17, 'Selfie Camera', '32MP'),
(17, 'Battery', '5000 mAh'),
(17, 'OS', 'Android 14 (HyperOS)'),
(17, 'Connectivity', '5G, Wi‑Fi 7, Bluetooth 5.4'),

-- OnePlus 12R
(18, 'Brand', 'OnePlus'),
(18, 'Model', 'OnePlus 12R'),
(18, 'Display', '6.78" LTPO AMOLED, 1-120Hz'),
(18, 'Processor', 'Snapdragon 8 Gen 2'),
(18, 'RAM', '8GB'),
(18, 'Main Camera', '50MP + 8MP ultra‑wide + 2MP macro'),
(18, 'Selfie Camera', '16MP'),
(18, 'Battery', '5500 mAh'),
(18, 'OS', 'Android 14 (OxygenOS)'),
(18, 'Connectivity', '5G, Wi‑Fi 6, Bluetooth 5.3'),

-- Nothing Phone (2)
(19, 'Brand', 'Nothing'),
(19, 'Model', 'Phone (2)'),
(19, 'Display', '6.7" LTPO OLED, 1-120Hz'),
(19, 'Processor', 'Snapdragon 8+ Gen 1'),
(19, 'RAM', '12GB'),
(19, 'Main Camera', '50MP + 50MP ultra‑wide'),
(19, 'Selfie Camera', '32MP'),
(19, 'Battery', '4700 mAh'),
(19, 'OS', 'Android 14 (Nothing OS 2)'),
(19, 'Connectivity', '5G, Wi‑Fi 6, Bluetooth 5.3'),

-- Xperia 5 V
(20, 'Brand', 'Sony'),
(20, 'Model', 'Xperia 5 V'),
(20, 'Display', '6.1" FHD+ OLED, 120Hz, 21:9'),
(20, 'Processor', 'Snapdragon 8 Gen 2'),
(20, 'RAM', '8GB'),
(20, 'Main Camera', '48MP main + 12MP ultra‑wide'),
(20, 'Selfie Camera', '12MP'),
(20, 'Battery', '5000 mAh'),
(20, 'OS', 'Android 14'),
(20, 'Connectivity', '5G, Wi‑Fi 6E, Bluetooth 5.3'),

-- Tablets
-- iPad Pro 11-inch (M4, 2024)
(21, 'Brand', 'Apple'),
(21, 'Model', 'iPad Pro 11-inch (M4, 2024)'),
(21, 'Display', '11" Ultra Retina XDR OLED, 120Hz'),
(21, 'Processor', 'Apple M4'),
(21, 'RAM', '8GB'),
(21, 'Storage', '256GB base'),
(21, 'Rear Camera', '12MP wide + LiDAR'),
(21, 'Front Camera', '12MP ultra‑wide (landscape)'),
(21, 'Battery', '28.65 Wh'),
(21, 'OS', 'iPadOS 17'),
(21, 'Connectivity', 'Wi‑Fi 6E, Bluetooth 5.3, Thunderbolt/USB‑C'),

-- iPad Pro 13-inch (M4, 2024)
(22, 'Brand', 'Apple'),
(22, 'Model', 'iPad Pro 13-inch (M4, 2024)'),
(22, 'Display', '13" Ultra Retina XDR OLED, 120Hz'),
(22, 'Processor', 'Apple M4'),
(22, 'RAM', '8GB'),
(22, 'Storage', '256GB base'),
(22, 'Rear Camera', '12MP wide + LiDAR'),
(22, 'Front Camera', '12MP ultra‑wide (landscape)'),
(22, 'Battery', '38.99 Wh'),
(22, 'OS', 'iPadOS 17'),
(22, 'Connectivity', 'Wi‑Fi 6E, Bluetooth 5.3, Thunderbolt/USB‑C'),

-- iPad Air 11-inch (M2, 2024)
(23, 'Brand', 'Apple'),
(23, 'Model', 'iPad Air 11-inch (M2, 2024)'),
(23, 'Display', '11" Liquid Retina, 60Hz'),
(23, 'Processor', 'Apple M2'),
(23, 'RAM', '8GB'),
(23, 'Storage', '128GB base'),
(23, 'Rear Camera', '12MP wide'),
(23, 'Front Camera', '12MP ultra‑wide (landscape)'),
(23, 'Battery', '28.93 Wh'),
(23, 'OS', 'iPadOS 17'),
(23, 'Connectivity', 'Wi‑Fi 6E, Bluetooth 5.3, USB‑C'),

-- iPad Air 13-inch (M2, 2024)
(24, 'Brand', 'Apple'),
(24, 'Model', 'iPad Air 13-inch (M2, 2024)'),
(24, 'Display', '13" Liquid Retina, 60Hz'),
(24, 'Processor', 'Apple M2'),
(24, 'RAM', '8GB'),
(24, 'Storage', '128GB base'),
(24, 'Rear Camera', '12MP wide'),
(24, 'Front Camera', '12MP ultra‑wide (landscape)'),
(24, 'Battery', '36.59 Wh'),
(24, 'OS', 'iPadOS 17'),
(24, 'Connectivity', 'Wi‑Fi 6E, Bluetooth 5.3, USB‑C'),

-- iPad (10th generation)
(25, 'Brand', 'Apple'),
(25, 'Model', 'iPad (10th generation)'),
(25, 'Display', '10.9" Liquid Retina'),
(25, 'Processor', 'Apple A14 Bionic'),
(25, 'RAM', '4GB'),
(25, 'Storage', '64GB base'),
(25, 'Rear Camera', '12MP wide'),
(25, 'Front Camera', '12MP ultra‑wide (landscape)'),
(25, 'Battery', '28.6 Wh'),
(25, 'OS', 'iPadOS 17'),
(25, 'Connectivity', 'Wi‑Fi 6, Bluetooth 5.2, USB‑C'),

-- iPad mini (6th generation)
(26, 'Brand', 'Apple'),
(26, 'Model', 'iPad mini (6th generation)'),
(26, 'Display', '8.3" Liquid Retina'),
(26, 'Processor', 'Apple A15 Bionic'),
(26, 'RAM', '4GB'),
(26, 'Storage', '64GB base'),
(26, 'Rear Camera', '12MP wide'),
(26, 'Front Camera', '12MP ultra‑wide'),
(26, 'Battery', '19.3 Wh'),
(26, 'OS', 'iPadOS 17'),
(26, 'Connectivity', 'Wi‑Fi 6, Bluetooth 5.0, USB‑C'),

-- Galaxy Tab S9 Ultra
(27, 'Brand', 'Samsung'),
(27, 'Model', 'Galaxy Tab S9 Ultra'),
(27, 'Display', '14.6" Dynamic AMOLED 2X, 120Hz'),
(27, 'Processor', 'Snapdragon 8 Gen 2 for Galaxy'),
(27, 'RAM', '12GB'),
(27, 'Storage', '256GB base'),
(27, 'Rear Camera', '13MP + 8MP ultra‑wide'),
(27, 'Front Camera', '12MP ultra‑wide'),
(27, 'Battery', '11200 mAh'),
(27, 'OS', 'Android 14 (One UI 6.1)'),
(27, 'Connectivity', 'Wi‑Fi 6E, Bluetooth 5.3, USB‑C'),

-- Galaxy Tab S9+
(28, 'Brand', 'Samsung'),
(28, 'Model', 'Galaxy Tab S9+'),
(28, 'Display', '12.4" Dynamic AMOLED 2X, 120Hz'),
(28, 'Processor', 'Snapdragon 8 Gen 2 for Galaxy'),
(28, 'RAM', '12GB'),
(28, 'Storage', '256GB base'),
(28, 'Rear Camera', '13MP + 8MP ultra‑wide'),
(28, 'Front Camera', '12MP ultra‑wide'),
(28, 'Battery', '10090 mAh'),
(28, 'OS', 'Android 14 (One UI 6.1)'),
(28, 'Connectivity', 'Wi‑Fi 6E, Bluetooth 5.3, USB‑C'),

-- Galaxy Tab S9
(29, 'Brand', 'Samsung'),
(29, 'Model', 'Galaxy Tab S9'),
(29, 'Display', '11" Dynamic AMOLED 2X, 120Hz'),
(29, 'Processor', 'Snapdragon 8 Gen 2 for Galaxy'),
(29, 'RAM', '8GB'),
(29, 'Storage', '128GB base'),
(29, 'Rear Camera', '13MP'),
(29, 'Front Camera', '12MP ultra‑wide'),
(29, 'Battery', '8400 mAh'),
(29, 'OS', 'Android 14 (One UI 6.1)'),
(29, 'Connectivity', 'Wi‑Fi 6E, Bluetooth 5.3, USB‑C'),

-- Galaxy Tab S9 FE
(30, 'Brand', 'Samsung'),
(30, 'Model', 'Galaxy Tab S9 FE'),
(30, 'Display', '10.9" LCD, 90Hz'),
(30, 'Processor', 'Exynos 1380'),
(30, 'RAM', '6GB'),
(30, 'Storage', '128GB base'),
(30, 'Rear Camera', '8MP'),
(30, 'Front Camera', '12MP ultra‑wide'),
(30, 'Battery', '8000 mAh'),
(30, 'OS', 'Android 14 (One UI 6.1)'),
(30, 'Connectivity', 'Wi‑Fi 6, Bluetooth 5.3, USB‑C'),

-- Galaxy Tab S9 FE+
(31, 'Brand', 'Samsung'),
(31, 'Model', 'Galaxy Tab S9 FE+'),
(31, 'Display', '12.4" LCD, 90Hz'),
(31, 'Processor', 'Exynos 1380'),
(31, 'RAM', '6GB'),
(31, 'Storage', '128GB base'),
(31, 'Rear Camera', '8MP'),
(31, 'Front Camera', '12MP ultra‑wide'),
(31, 'Battery', '10090 mAh'),
(31, 'OS', 'Android 14 (One UI 6.1)'),
(31, 'Connectivity', 'Wi‑Fi 6, Bluetooth 5.3, USB‑C'),

-- Surface Pro 11
(32, 'Brand', 'Microsoft'),
(32, 'Model', 'Surface Pro 11'),
(32, 'Display', '13" OLED, 120Hz PixelSense'),
(32, 'Processor', 'Snapdragon X Elite / X Plus'),
(32, 'RAM', '16GB'),
(32, 'Storage', '256GB base'),
(32, 'Rear Camera', '10MP'),
(32, 'Front Camera', '1440p'),
(32, 'Battery', '48 Wh'),
(32, 'OS', 'Windows 11'),
(32, 'Connectivity', 'Wi‑Fi 7, Bluetooth 5.4, USB4'),

-- Surface Go 4
(33, 'Brand', 'Microsoft'),
(33, 'Model', 'Surface Go 4'),
(33, 'Display', '10.5" PixelSense'),
(33, 'Processor', 'Intel Processor N200'),
(33, 'RAM', '8GB'),
(33, 'Storage', '128GB base'),
(33, 'Rear Camera', '8MP'),
(33, 'Front Camera', '5MP'),
(33, 'Battery', '28 Wh'),
(33, 'OS', 'Windows 11'),
(33, 'Connectivity', 'Wi‑Fi 6, Bluetooth 5.1, USB‑C'),

-- Lenovo Tab P12
(34, 'Brand', 'Lenovo'),
(34, 'Model', 'Tab P12'),
(34, 'Display', '12.7" 3K LCD'),
(34, 'Processor', 'MediaTek Dimensity 7050'),
(34, 'RAM', '8GB'),
(34, 'Storage', '128GB base'),
(34, 'Rear Camera', '8MP'),
(34, 'Front Camera', '13MP'),
(34, 'Battery', '10200 mAh'),
(34, 'OS', 'Android 13'),
(34, 'Connectivity', 'Wi‑Fi 6, Bluetooth 5.1, USB‑C'),

-- Lenovo Tab P11 Pro (2nd Gen)
(35, 'Brand', 'Lenovo'),
(35, 'Model', 'Tab P11 Pro (2nd Gen)'),
(35, 'Display', '11.2" OLED, 120Hz'),
(35, 'Processor', 'MediaTek Kompanio 1300T'),
(35, 'RAM', '8GB'),
(35, 'Storage', '128GB base'),
(35, 'Rear Camera', '13MP + 8MP ultra‑wide'),
(35, 'Front Camera', '8MP'),
(35, 'Battery', '8200 mAh'),
(35, 'OS', 'Android 13'),
(35, 'Connectivity', 'Wi‑Fi 6, Bluetooth 5.1, USB‑C'),

-- Xiaomi Pad 6
(36, 'Brand', 'Xiaomi'),
(36, 'Model', 'Xiaomi Pad 6'),
(36, 'Display', '11" IPS LCD, 144Hz'),
(36, 'Processor', 'Snapdragon 870'),
(36, 'RAM', '6GB'),
(36, 'Storage', '128GB base'),
(36, 'Rear Camera', '13MP'),
(36, 'Front Camera', '8MP'),
(36, 'Battery', '8840 mAh'),
(36, 'OS', 'Android 13 (HyperOS)'),
(36, 'Connectivity', 'Wi‑Fi 6, Bluetooth 5.2, USB‑C'),

-- OnePlus Pad
(37, 'Brand', 'OnePlus'),
(37, 'Model', 'OnePlus Pad'),
(37, 'Display', '11.61" IPS LCD, 144Hz'),
(37, 'Processor', 'MediaTek Dimensity 9000'),
(37, 'RAM', '8GB'),
(37, 'Storage', '128GB base'),
(37, 'Rear Camera', '13MP'),
(37, 'Front Camera', '8MP'),
(37, 'Battery', '9510 mAh'),
(37, 'OS', 'Android 14 (OxygenOS)'),
(37, 'Connectivity', 'Wi‑Fi 6, Bluetooth 5.3, USB‑C'),

-- Huawei MatePad Pro 13.2
(38, 'Brand', 'Huawei'),
(38, 'Model', 'MatePad Pro 13.2'),
(38, 'Display', '13.2" OLED, 144Hz'),
(38, 'Processor', 'Kirin 9000S'),
(38, 'RAM', '12GB'),
(38, 'Storage', '256GB base'),
(38, 'Rear Camera', '13MP + 8MP ultra‑wide'),
(38, 'Front Camera', '16MP'),
(38, 'Battery', '10100 mAh'),
(38, 'OS', 'HarmonyOS 4'),
(38, 'Connectivity', 'Wi‑Fi 6, Bluetooth 5.2, USB‑C'),

-- Amazon Fire Max 11
(39, 'Brand', 'Amazon'),
(39, 'Model', 'Fire Max 11'),
(39, 'Display', '11" 2000x1200 LCD'),
(39, 'Processor', 'MediaTek MT8188J'),
(39, 'RAM', '4GB'),
(39, 'Storage', '64GB base'),
(39, 'Rear Camera', '8MP'),
(39, 'Front Camera', '8MP'),
(39, 'Battery', '7500 mAh'),
(39, 'OS', 'Fire OS'),
(39, 'Connectivity', 'Wi‑Fi 6, Bluetooth 5.2, USB‑C'),

-- Google Pixel Tablet
(40, 'Brand', 'Google'),
(40, 'Model', 'Pixel Tablet'),
(40, 'Display', '10.95" LCD, 60Hz'),
(40, 'Processor', 'Google Tensor G2'),
(40, 'RAM', '8GB'),
(40, 'Storage', '128GB base'),
(40, 'Rear Camera', '8MP'),
(40, 'Front Camera', '8MP'),
(40, 'Battery', '27 Wh'),
(40, 'OS', 'Android 14'),
(40, 'Connectivity', 'Wi‑Fi 6, Bluetooth 5.2, USB‑C'),

-- Laptops
-- MacBook Pro 14 (M3 Pro)
(41, 'Brand', 'Apple'),
(41, 'Model', 'MacBook Pro 14 (M3 Pro)'),
(41, 'Display', '14.2" Liquid Retina XDR, 3024×1964, 120Hz ProMotion'),
(41, 'Processor', 'Apple M3 Pro'),
(41, 'GPU', 'Integrated (M3 Pro GPU)'),
(41, 'RAM', '18GB'),
(41, 'Storage', '512GB/1TB SSD'),
(41, 'Battery', 'Up to 18 hours video playback'),
(41, 'Weight', '1.61 kg'),
(41, 'OS', 'macOS'),
(41, 'Ports', '3× Thunderbolt 4, HDMI 2.1, SDXC, MagSafe 3, 3.5mm'),

-- MacBook Air 15 (M3)
(42, 'Brand', 'Apple'),
(42, 'Model', 'MacBook Air 15 (M3)'),
(42, 'Display', '15.3" Liquid Retina, 2880×1864'),
(42, 'Processor', 'Apple M3'),
(42, 'GPU', 'Integrated (M3 GPU)'),
(42, 'RAM', '8GB/16GB'),
(42, 'Storage', '256GB/512GB SSD'),
(42, 'Battery', 'Up to 18 hours video playback'),
(42, 'Weight', '1.51 kg'),
(42, 'OS', 'macOS'),
(42, 'Ports', '2× Thunderbolt/USB 4, MagSafe 3, 3.5mm'),

-- Dell XPS 14 (9440)
(43, 'Brand', 'Dell'),
(43, 'Model', 'XPS 14 (9440)'),
(43, 'Display', '14.5" 3.2K OLED, 120Hz'),
(43, 'Processor', 'Intel Core Ultra 7'),
(43, 'GPU', 'NVIDIA GeForce RTX 4050 (Laptop)'),
(43, 'RAM', '16GB/32GB LPDDR5x'),
(43, 'Storage', '512GB/1TB PCIe 4.0 SSD'),
(43, 'Battery', 'Up to 13 hours mixed use'),
(43, 'Weight', '1.68 kg'),
(43, 'OS', 'Windows 11'),
(43, 'Ports', '3× Thunderbolt 4 (USB-C) with adapters'),

-- Dell XPS 13 (9340)
(44, 'Brand', 'Dell'),
(44, 'Model', 'XPS 13 (9340)'),
(44, 'Display', '13.4" FHD+ IPS or 2.8K OLED'),
(44, 'Processor', 'Intel Core Ultra 7'),
(44, 'GPU', 'Intel Arc Graphics'),
(44, 'RAM', '16GB/32GB LPDDR5x'),
(44, 'Storage', '512GB/1TB PCIe 4.0 SSD'),
(44, 'Battery', 'Up to 12 hours mixed use'),
(44, 'Weight', '1.19 kg'),
(44, 'OS', 'Windows 11'),
(44, 'Ports', '2× Thunderbolt 4 (USB-C) with adapters'),

-- HP Spectre x360 14
(45, 'Brand', 'HP'),
(45, 'Model', 'Spectre x360 14'),
(45, 'Display', '14" 2.8K OLED, 120Hz, touchscreen'),
(45, 'Processor', 'Intel Core Ultra 7'),
(45, 'GPU', 'Intel Arc Graphics'),
(45, 'RAM', '16GB/32GB LPDDR5x'),
(45, 'Storage', '512GB/1TB PCIe SSD'),
(45, 'Battery', 'Up to 13 hours mixed use'),
(45, 'Weight', '1.44 kg'),
(45, 'OS', 'Windows 11'),
(45, 'Ports', '2× Thunderbolt 4, USB-A, 3.5mm'),

-- ThinkPad X1 Carbon Gen 12
(46, 'Brand', 'Lenovo'),
(46, 'Model', 'ThinkPad X1 Carbon Gen 12'),
(46, 'Display', '14" 2.8K OLED or 2.2K IPS'),
(46, 'Processor', 'Intel Core Ultra 7'),
(46, 'GPU', 'Intel Arc Graphics'),
(46, 'RAM', '16GB/32GB LPDDR5x'),
(46, 'Storage', '512GB/1TB PCIe SSD'),
(46, 'Battery', 'Up to 15 hours mixed use'),
(46, 'Weight', '1.12 kg'),
(46, 'OS', 'Windows 11 Pro'),
(46, 'Ports', '2× Thunderbolt 4, 2× USB-A, HDMI, 3.5mm'),

-- ThinkPad X1 Yoga Gen 9
(47, 'Brand', 'Lenovo'),
(47, 'Model', 'ThinkPad X1 Yoga Gen 9'),
(47, 'Display', '14" 2.8K OLED, touchscreen, 360° hinge'),
(47, 'Processor', 'Intel Core Ultra 7'),
(47, 'GPU', 'Intel Arc Graphics'),
(47, 'RAM', '16GB/32GB LPDDR5x'),
(47, 'Storage', '512GB/1TB PCIe SSD'),
(47, 'Battery', 'Up to 14 hours mixed use'),
(47, 'Weight', '1.39 kg'),
(47, 'OS', 'Windows 11 Pro'),
(47, 'Ports', '2× Thunderbolt 4, 2× USB-A, HDMI, 3.5mm'),

-- ROG Zephyrus G14 (2024)
(48, 'Brand', 'ASUS'),
(48, 'Model', 'ROG Zephyrus G14 (2024)'),
(48, 'Display', '14" QHD+ 120Hz'),
(48, 'Processor', 'AMD Ryzen 9'),
(48, 'GPU', 'NVIDIA GeForce RTX 4060/4070'),
(48, 'RAM', '16GB/32GB'),
(48, 'Storage', '1TB PCIe SSD'),
(48, 'Battery', '76Wh'),
(48, 'Weight', '1.50 kg'),
(48, 'OS', 'Windows 11'),
(48, 'Ports', 'USB4, 2× USB-A, HDMI 2.1, 3.5mm'),

-- ROG Zephyrus G16 (2024)
(49, 'Brand', 'ASUS'),
(49, 'Model', 'ROG Zephyrus G16 (2024)'),
(49, 'Display', '16" OLED 240Hz'),
(49, 'Processor', 'Intel Core Ultra 9'),
(49, 'GPU', 'NVIDIA GeForce RTX 4070/4080'),
(49, 'RAM', '16GB/32GB'),
(49, 'Storage', '1TB/2TB PCIe SSD'),
(49, 'Battery', '90Wh'),
(49, 'Weight', '1.85 kg'),
(49, 'OS', 'Windows 11'),
(49, 'Ports', 'Thunderbolt 4, 2× USB-A, HDMI 2.1, 3.5mm'),

-- Acer Swift X 14 (2024)
(50, 'Brand', 'Acer'),
(50, 'Model', 'Swift X 14'),
(50, 'Display', '14.5" 2.8K OLED, 120Hz'),
(50, 'Processor', 'Intel Core Ultra 7'),
(50, 'GPU', 'NVIDIA GeForce RTX 4050'),
(50, 'RAM', '16GB/32GB'),
(50, 'Storage', '512GB/1TB PCIe SSD'),
(50, 'Battery', '76Wh'),
(50, 'Weight', '1.55 kg'),
(50, 'OS', 'Windows 11'),
(50, 'Ports', '2× USB-C, 2× USB-A, HDMI 2.1'),

-- Acer Swift Go 14 (2024)
(51, 'Brand', 'Acer'),
(51, 'Model', 'Swift Go 14'),
(51, 'Display', '14" 2.8K OLED, 90Hz'),
(51, 'Processor', 'Intel Core Ultra 5/7'),
(51, 'GPU', 'Intel Arc Graphics'),
(51, 'RAM', '8GB/16GB'),
(51, 'Storage', '256GB/512GB PCIe SSD'),
(51, 'Battery', '65Wh'),
(51, 'Weight', '1.25 kg'),
(51, 'OS', 'Windows 11'),
(51, 'Ports', '2× USB-C, 2× USB-A, HDMI 2.1'),

-- Surface Laptop 6
(52, 'Brand', 'Microsoft'),
(52, 'Model', 'Surface Laptop 6'),
(52, 'Display', '13.5" or 15" PixelSense, 3:2'),
(52, 'Processor', 'Intel Core Ultra 7'),
(52, 'GPU', 'Intel Arc Graphics'),
(52, 'RAM', '16GB/32GB'),
(52, 'Storage', '512GB/1TB SSD'),
(52, 'Battery', 'Up to 18 hours'),
(52, 'Weight', '1.38 kg'),
(52, 'OS', 'Windows 11 Pro'),
(52, 'Ports', '2× Thunderbolt 4, USB-A, 3.5mm'),

-- Surface Laptop Studio 2
(53, 'Brand', 'Microsoft'),
(53, 'Model', 'Surface Laptop Studio 2'),
(53, 'Display', '14.4" PixelSense Flow, 120Hz'),
(53, 'Processor', 'Intel Core i7 H-series'),
(53, 'GPU', 'NVIDIA GeForce RTX 4050/4060'),
(53, 'RAM', '16GB/32GB'),
(53, 'Storage', '512GB/1TB SSD'),
(53, 'Battery', 'Up to 19 hours'),
(53, 'Weight', '1.98 kg'),
(53, 'OS', 'Windows 11'),
(53, 'Ports', '2× Thunderbolt 4, USB-A, microSDXC'),

-- Razer Blade 16
(54, 'Brand', 'Razer'),
(54, 'Model', 'Blade 16'),
(54, 'Display', '16" QHD+ Mini-LED, 240Hz'),
(54, 'Processor', 'Intel Core i9 HX'),
(54, 'GPU', 'NVIDIA GeForce RTX 4080/4090'),
(54, 'RAM', '32GB'),
(54, 'Storage', '1TB/2TB PCIe SSD'),
(54, 'Battery', '95.2Wh'),
(54, 'Weight', '2.45 kg'),
(54, 'OS', 'Windows 11'),
(54, 'Ports', 'Thunderbolt 4, 3× USB-A, HDMI 2.1, SD, 3.5mm'),

-- Razer Blade 14
(55, 'Brand', 'Razer'),
(55, 'Model', 'Blade 14'),
(55, 'Display', '14" QHD+ 240Hz'),
(55, 'Processor', 'AMD Ryzen 9'),
(55, 'GPU', 'NVIDIA GeForce RTX 4070'),
(55, 'RAM', '16GB/32GB'),
(55, 'Storage', '1TB SSD'),
(55, 'Battery', '68.1Wh'),
(55, 'Weight', '1.84 kg'),
(55, 'OS', 'Windows 11'),
(55, 'Ports', 'USB4, 2× USB-A, HDMI 2.1, 3.5mm'),

-- MSI Stealth 16 Studio
(56, 'Brand', 'MSI'),
(56, 'Model', 'Stealth 16 Studio'),
(56, 'Display', '16" QHD+ 240Hz'),
(56, 'Processor', 'Intel Core i9'),
(56, 'GPU', 'NVIDIA GeForce RTX 4070/4080'),
(56, 'RAM', '16GB/32GB'),
(56, 'Storage', '1TB/2TB SSD'),
(56, 'Battery', '99.9Wh'),
(56, 'Weight', '2.10 kg'),
(56, 'OS', 'Windows 11'),
(56, 'Ports', 'Thunderbolt 4, 2× USB-A, HDMI 2.1, microSD'),

-- MSI Raider GE78 HX
(57, 'Brand', 'MSI'),
(57, 'Model', 'Raider GE78 HX'),
(57, 'Display', '17" QHD+ 240Hz'),
(57, 'Processor', 'Intel Core i9 HX'),
(57, 'GPU', 'NVIDIA GeForce RTX 4090'),
(57, 'RAM', '32GB/64GB'),
(57, 'Storage', '1TB/2TB SSD'),
(57, 'Battery', '99.9Wh'),
(57, 'Weight', '2.98 kg'),
(57, 'OS', 'Windows 11'),
(57, 'Ports', 'Thunderbolt 4, 2× USB-A, HDMI 2.1, SD'),

-- Gigabyte AORUS 16X
(58, 'Brand', 'Gigabyte'),
(58, 'Model', 'AORUS 16X'),
(58, 'Display', '16" QHD+ 165Hz'),
(58, 'Processor', 'Intel Core i7/Ultra'),
(58, 'GPU', 'NVIDIA GeForce RTX 4070'),
(58, 'RAM', '16GB/32GB'),
(58, 'Storage', '1TB PCIe SSD'),
(58, 'Battery', '99Wh'),
(58, 'Weight', '2.30 kg'),
(58, 'OS', 'Windows 11'),
(58, 'Ports', 'Thunderbolt 4, 2× USB-A, HDMI 2.1, RJ-45'),

-- Galaxy Book4 Pro 14
(59, 'Brand', 'Samsung'),
(59, 'Model', 'Galaxy Book4 Pro 14'),
(59, 'Display', '14" 3K AMOLED, 120Hz'),
(59, 'Processor', 'Intel Core Ultra 7'),
(59, 'GPU', 'Intel Arc Graphics'),
(59, 'RAM', '16GB/32GB'),
(59, 'Storage', '512GB/1TB SSD'),
(59, 'Battery', '63Wh'),
(59, 'Weight', '1.23 kg'),
(59, 'OS', 'Windows 11'),
(59, 'Ports', '2× Thunderbolt 4, USB-A, HDMI 2.0, microSD'),

-- LG Gram 16
(60, 'Brand', 'LG'),
(60, 'Model', 'Gram 16'),
(60, 'Display', '16" WQXGA IPS'),
(60, 'Processor', 'Intel Core Ultra 7'),
(60, 'GPU', 'Intel Arc Graphics'),
(60, 'RAM', '16GB/32GB'),
(60, 'Storage', '512GB/1TB SSD'),
(60, 'Battery', '80Wh'),
(60, 'Weight', '1.19 kg'),
(60, 'OS', 'Windows 11'),
(60, 'Ports', '2× Thunderbolt 4, 2× USB-A, HDMI, microSD'),

-- Audio & Headphones
-- Sony WH-1000XM5
(61, 'Brand', 'Sony'),
(61, 'Model', 'WH-1000XM5'),
(61, 'Type', 'Over-ear wireless'),
(61, 'Driver', '30mm dynamic'),
(61, 'Noise Cancellation', 'Dual processors with adaptive ANC'),
(61, 'Battery Life', 'Up to 30 hours (ANC on)'),
(61, 'Charging', 'USB-C, 3 min charge = 3 hours playback'),
(61, 'Connectivity', 'Bluetooth 5.2, multipoint'),
(61, 'Audio Codecs', 'SBC, AAC, LDAC'),
(61, 'Weight', '250 g'),

-- Bose QuietComfort Ultra Headphones
(62, 'Brand', 'Bose'),
(62, 'Model', 'QuietComfort Ultra Headphones'),
(62, 'Type', 'Over-ear wireless'),
(62, 'Driver', 'Custom Bose drivers'),
(62, 'Noise Cancellation', 'Advanced ANC with aware mode'),
(62, 'Battery Life', 'Up to 24 hours'),
(62, 'Charging', 'USB-C, 15 min = 2.5 hours playback'),
(62, 'Connectivity', 'Bluetooth 5.3, multipoint'),
(62, 'Audio Codecs', 'SBC, AAC'),
(62, 'Weight', '250 g'),

-- AirPods Pro (2nd gen, USB-C)
(63, 'Brand', 'Apple'),
(63, 'Model', 'AirPods Pro (2nd gen, USB-C)'),
(63, 'Type', 'True wireless in-ear'),
(63, 'Noise Cancellation', 'Active Noise Cancellation, Adaptive Transparency'),
(63, 'Battery Life', 'Up to 6 hours (earbuds), 30 hours with case'),
(63, 'Charging', 'USB-C, MagSafe, Qi'),
(63, 'Connectivity', 'Bluetooth 5.3'),
(63, 'Audio Features', 'Spatial Audio with head tracking'),
(63, 'Water Resistance', 'IPX4 (earbuds and case)'),

-- Sennheiser MOMENTUM 4 Wireless
(64, 'Brand', 'Sennheiser'),
(64, 'Model', 'MOMENTUM 4 Wireless'),
(64, 'Type', 'Over-ear wireless'),
(64, 'Driver', '42mm dynamic'),
(64, 'Noise Cancellation', 'Adaptive ANC'),
(64, 'Battery Life', 'Up to 60 hours'),
(64, 'Charging', 'USB-C'),
(64, 'Connectivity', 'Bluetooth 5.2, multipoint'),
(64, 'Audio Codecs', 'SBC, AAC, aptX, aptX Adaptive'),
(64, 'Weight', '293 g'),

-- Bowers & Wilkins Px7 S2e
(65, 'Brand', 'Bowers & Wilkins'),
(65, 'Model', 'Px7 S2e'),
(65, 'Type', 'Over-ear wireless'),
(65, 'Driver', '40mm biocellulose'),
(65, 'Noise Cancellation', 'Adaptive ANC'),
(65, 'Battery Life', 'Up to 30 hours'),
(65, 'Charging', 'USB-C, 15 min = 7 hours'),
(65, 'Connectivity', 'Bluetooth 5.2'),
(65, 'Audio Codecs', 'SBC, AAC, aptX, aptX Adaptive'),
(65, 'Weight', '307 g'),

-- Bose QuietComfort Ultra Earbuds
(66, 'Brand', 'Bose'),
(66, 'Model', 'QuietComfort Ultra Earbuds'),
(66, 'Type', 'True wireless in-ear'),
(66, 'Noise Cancellation', 'Advanced ANC with Immersive Audio'),
(66, 'Battery Life', 'Up to 6 hours (earbuds), 24 hours with case'),
(66, 'Charging', 'USB-C, wireless charging case'),
(66, 'Connectivity', 'Bluetooth 5.3'),
(66, 'Water Resistance', 'IPX4'),
(66, 'Audio Codecs', 'SBC, AAC'),

-- Sony WF-1000XM5
(67, 'Brand', 'Sony'),
(67, 'Model', 'WF-1000XM5'),
(67, 'Type', 'True wireless in-ear'),
(67, 'Driver', '8.4mm dynamic'),
(67, 'Noise Cancellation', 'Dual proprietary processors'),
(67, 'Battery Life', 'Up to 8 hours (earbuds), 24 hours with case'),
(67, 'Charging', 'USB-C, Qi wireless'),
(67, 'Connectivity', 'Bluetooth 5.3, multipoint'),
(67, 'Audio Codecs', 'SBC, AAC, LDAC'),
(67, 'Water Resistance', 'IPX4'),

-- AirPods Max
(68, 'Brand', 'Apple'),
(68, 'Model', 'AirPods Max'),
(68, 'Type', 'Over-ear wireless'),
(68, 'Noise Cancellation', 'Active Noise Cancellation, Transparency mode'),
(68, 'Battery Life', 'Up to 20 hours'),
(68, 'Charging', 'Lightning'),
(68, 'Connectivity', 'Bluetooth 5.0'),
(68, 'Audio Features', 'Spatial Audio with head tracking'),
(68, 'Weight', '384.8 g'),

-- Beats Studio Pro
(69, 'Brand', 'Beats'),
(69, 'Model', 'Studio Pro'),
(69, 'Type', 'Over-ear wireless'),
(69, 'Noise Cancellation', 'ANC and Transparency'),
(69, 'Battery Life', 'Up to 40 hours'),
(69, 'Charging', 'USB-C, 10 min = 4 hours'),
(69, 'Connectivity', 'Bluetooth 5.3'),
(69, 'Audio Codecs', 'SBC, AAC'),
(69, 'Weight', '260 g'),

-- Soundcore Liberty 4 NC
(70, 'Brand', 'Soundcore'),
(70, 'Model', 'Liberty 4 NC'),
(70, 'Type', 'True wireless in-ear'),
(70, 'Noise Cancellation', 'Adaptive ANC 2.0'),
(70, 'Battery Life', 'Up to 10 hours (earbuds), 50 hours with case'),
(70, 'Charging', 'USB-C'),
(70, 'Connectivity', 'Bluetooth 5.3'),
(70, 'Audio Codecs', 'SBC, AAC, LDAC'),
(70, 'Water Resistance', 'IPX4'),

-- Jabra Elite 10
(71, 'Brand', 'Jabra'),
(71, 'Model', 'Elite 10'),
(71, 'Type', 'True wireless in-ear'),
(71, 'Noise Cancellation', 'Advanced ANC'),
(71, 'Battery Life', 'Up to 8 hours (earbuds), 36 hours with case'),
(71, 'Charging', 'USB-C, wireless'),
(71, 'Connectivity', 'Bluetooth 5.3, multipoint'),
(71, 'Audio Codecs', 'SBC, AAC'),
(71, 'Water Resistance', 'IP57'),

-- Samsung Galaxy Buds2 Pro
(72, 'Brand', 'Samsung'),
(72, 'Model', 'Galaxy Buds2 Pro'),
(72, 'Type', 'True wireless in-ear'),
(72, 'Noise Cancellation', 'Intelligent ANC'),
(72, 'Battery Life', 'Up to 5 hours (ANC on), 18 hours with case'),
(72, 'Charging', 'USB-C, wireless'),
(72, 'Connectivity', 'Bluetooth 5.3'),
(72, 'Audio Codecs', 'SSC, AAC, SBC'),
(72, 'Water Resistance', 'IPX7'),

-- Google Pixel Buds Pro
(73, 'Brand', 'Google'),
(73, 'Model', 'Pixel Buds Pro'),
(73, 'Type', 'True wireless in-ear'),
(73, 'Noise Cancellation', 'Active Noise Cancellation'),
(73, 'Battery Life', 'Up to 11 hours (earbuds), 31 hours with case'),
(73, 'Charging', 'USB-C, wireless'),
(73, 'Connectivity', 'Bluetooth 5.0, multipoint'),
(73, 'Audio Codecs', 'SBC, AAC'),
(73, 'Water Resistance', 'IPX4'),

-- Nothing Ear (2024)
(74, 'Brand', 'Nothing'),
(74, 'Model', 'Ear (2024)'),
(74, 'Type', 'True wireless in-ear'),
(74, 'Noise Cancellation', 'Smart ANC up to 45 dB'),
(74, 'Battery Life', 'Up to 8.5 hours (earbuds), 40.5 hours with case'),
(74, 'Charging', 'USB-C, wireless'),
(74, 'Connectivity', 'Bluetooth 5.3, multipoint'),
(74, 'Audio Codecs', 'SBC, AAC, LDAC'),
(74, 'Water Resistance', 'IP54'),

-- JBL Tour One M2
(75, 'Brand', 'JBL'),
(75, 'Model', 'Tour One M2'),
(75, 'Type', 'Over-ear wireless'),
(75, 'Noise Cancellation', 'True Adaptive ANC'),
(75, 'Battery Life', 'Up to 50 hours (ANC off)'),
(75, 'Charging', 'USB-C'),
(75, 'Connectivity', 'Bluetooth 5.3'),
(75, 'Audio Codecs', 'SBC, AAC'),
(75, 'Weight', '278 g'),

-- Shure AONIC 50 Gen 2
(76, 'Brand', 'Shure'),
(76, 'Model', 'AONIC 50 Gen 2'),
(76, 'Type', 'Over-ear wireless'),
(76, 'Noise Cancellation', 'Adjustable ANC'),
(76, 'Battery Life', 'Up to 45 hours'),
(76, 'Charging', 'USB-C, fast charging'),
(76, 'Connectivity', 'Bluetooth 5.0, multipoint'),
(76, 'Audio Codecs', 'SBC, AAC, aptX, aptX HD, aptX Adaptive'),
(76, 'Weight', '334 g'),

-- Sonos Ace
(77, 'Brand', 'Sonos'),
(77, 'Model', 'Ace'),
(77, 'Type', 'Over-ear wireless'),
(77, 'Noise Cancellation', 'Active Noise Cancellation, Aware mode'),
(77, 'Battery Life', 'Up to 30 hours'),
(77, 'Charging', 'USB-C, fast charging'),
(77, 'Connectivity', 'Bluetooth 5.4, multipoint'),
(77, 'Audio Features', 'Spatial Audio with head tracking'),
(77, 'Weight', '312 g'),

-- Technics EAH-AZ80
(78, 'Brand', 'Technics'),
(78, 'Model', 'EAH-AZ80'),
(78, 'Type', 'True wireless in-ear'),
(78, 'Noise Cancellation', 'Dual hybrid ANC'),
(78, 'Battery Life', 'Up to 7 hours (ANC on), 24 hours with case'),
(78, 'Charging', 'USB-C, wireless'),
(78, 'Connectivity', 'Bluetooth 5.3, multipoint'),
(78, 'Audio Codecs', 'SBC, AAC, LDAC'),
(78, 'Water Resistance', 'IPX4'),

-- Bose SoundLink Flex
(79, 'Brand', 'Bose'),
(79, 'Model', 'SoundLink Flex'),
(79, 'Type', 'Portable Bluetooth speaker'),
(79, 'Drivers', 'Custom full-range'),
(79, 'Battery Life', 'Up to 12 hours'),
(79, 'Charging', 'USB-C'),
(79, 'Connectivity', 'Bluetooth 4.2'),
(79, 'Water Resistance', 'IP67'),
(79, 'Weight', '0.6 kg'),

-- Marshall Motif II ANC
(80, 'Brand', 'Marshall'),
(80, 'Model', 'Motif II ANC'),
(80, 'Type', 'True wireless in-ear'),
(80, 'Noise Cancellation', 'Active Noise Cancellation'),
(80, 'Battery Life', 'Up to 6 hours (ANC on), 30 hours with case'),
(80, 'Charging', 'USB-C, wireless'),
(80, 'Connectivity', 'Bluetooth 5.3'),
(80, 'Audio Codecs', 'SBC, AAC'),
(80, 'Water Resistance', 'IPX5'),

-- Wearables
-- Apple Watch Series 9
(81, 'Brand', 'Apple'),
(81, 'Model', 'Watch Series 9'),
(81, 'Type', 'Smartwatch'),
(81, 'Display', '41/45mm LTPO OLED Retina, up to 2000 nits'),
(81, 'Case Size', '41mm / 45mm'),
(81, 'Chip', 'Apple S9 SiP'),
(81, 'Sensors', 'ECG, optical HR, blood oxygen, temperature, compass, altimeter'),
(81, 'Battery Life', 'Up to 18 hours (low power up to 36 hours)'),
(81, 'Water Resistance', '50 m (WR50)'),
(81, 'OS', 'watchOS 10'),
(81, 'Connectivity', 'GPS, Wi‑Fi, Bluetooth 5.3, optional LTE'),

-- Apple Watch Ultra 2
(82, 'Brand', 'Apple'),
(82, 'Model', 'Watch Ultra 2'),
(82, 'Type', 'Rugged smartwatch'),
(82, 'Display', '1.92" LTPO OLED Retina, up to 3000 nits'),
(82, 'Case Size', '49mm'),
(82, 'Chip', 'Apple S9 SiP'),
(82, 'Sensors', 'ECG, optical HR, blood oxygen, temperature, depth gauge, compass'),
(82, 'Battery Life', 'Up to 36 hours (low power up to 72 hours)'),
(82, 'Water Resistance', '100 m (EN13319)'),
(82, 'OS', 'watchOS 10'),
(82, 'Connectivity', 'Dual‑frequency GPS, Wi‑Fi, Bluetooth 5.3, LTE'),

-- Galaxy Watch6
(83, 'Brand', 'Samsung'),
(83, 'Model', 'Galaxy Watch6'),
(83, 'Type', 'Smartwatch'),
(83, 'Display', 'Super AMOLED, 40/44mm'),
(83, 'Case Size', '40mm / 44mm'),
(83, 'Chip', 'Exynos W930'),
(83, 'Sensors', 'BioActive (HR, ECG, BIA), temperature, accelerometer, barometer'),
(83, 'Battery Life', 'Up to 40 hours'),
(83, 'Water Resistance', '5ATM + IP68, MIL‑STD‑810H'),
(83, 'OS', 'Wear OS (One UI Watch)'),
(83, 'Connectivity', 'GPS, Bluetooth 5.3, Wi‑Fi, NFC'),

-- Galaxy Watch6 Classic
(84, 'Brand', 'Samsung'),
(84, 'Model', 'Galaxy Watch6 Classic'),
(84, 'Type', 'Smartwatch'),
(84, 'Display', 'Super AMOLED, 43/47mm'),
(84, 'Case Size', '43mm / 47mm'),
(84, 'Chip', 'Exynos W930'),
(84, 'Rotating Bezel', 'Yes'),
(84, 'Sensors', 'BioActive (HR, ECG, BIA), temperature, accelerometer, barometer'),
(84, 'Battery Life', 'Up to 40 hours'),
(84, 'Water Resistance', '5ATM + IP68, MIL‑STD‑810H'),
(84, 'OS', 'Wear OS (One UI Watch)'),
(84, 'Connectivity', 'GPS, Bluetooth 5.3, Wi‑Fi, NFC'),

-- Pixel Watch 2
(85, 'Brand', 'Google'),
(85, 'Model', 'Pixel Watch 2'),
(85, 'Type', 'Smartwatch'),
(85, 'Display', '1.2" AMOLED'),
(85, 'Case Size', '41mm'),
(85, 'Chip', 'Qualcomm Snapdragon W5 Gen 1'),
(85, 'Sensors', 'Multi‑path HR, ECG, SpO2, skin temperature'),
(85, 'Battery Life', 'Up to 24 hours'),
(85, 'Water Resistance', '5ATM'),
(85, 'OS', 'Wear OS 4'),
(85, 'Connectivity', 'GPS, Bluetooth 5.0, Wi‑Fi, NFC, optional LTE'),

-- Garmin fēnix 7 Pro
(86, 'Brand', 'Garmin'),
(86, 'Model', 'fēnix 7 Pro'),
(86, 'Type', 'Outdoor multisport watch'),
(86, 'Display', '1.3" MIP sunlight‑visible'),
(86, 'Case Size', '47mm / 51mm'),
(86, 'Sensors', 'Multi‑band GPS, altimeter, compass, Pulse Ox, HR'),
(86, 'Battery Life', 'Up to 18 days (47mm), up to 37 days (51mm), solar extends'),
(86, 'Water Resistance', '10 ATM'),
(86, 'OS', 'Garmin OS'),
(86, 'Connectivity', 'Bluetooth, Wi‑Fi, ANT+'),

-- Garmin Forerunner 965
(87, 'Brand', 'Garmin'),
(87, 'Model', 'Forerunner 965'),
(87, 'Type', 'Performance running watch'),
(87, 'Display', '1.4" AMOLED'),
(87, 'Case Size', '47mm'),
(87, 'Sensors', 'Multi‑band GPS, HR, Pulse Ox, barometer'),
(87, 'Battery Life', 'Up to 23 days (smartwatch mode)'),
(87, 'Water Resistance', '5 ATM'),
(87, 'OS', 'Garmin OS'),
(87, 'Connectivity', 'Bluetooth, Wi‑Fi, ANT+'),

-- Garmin Venu 3
(88, 'Brand', 'Garmin'),
(88, 'Model', 'Venu 3'),
(88, 'Type', 'Health & fitness smartwatch'),
(88, 'Display', 'AMOLED, 45/41mm'),
(88, 'Case Size', '45mm / 41mm'),
(88, 'Sensors', 'HR, Pulse Ox, barometer, accelerometer'),
(88, 'Battery Life', 'Up to 14 days (45mm), up to 10 days (41mm)'),
(88, 'Water Resistance', '5 ATM'),
(88, 'OS', 'Garmin OS'),
(88, 'Connectivity', 'Bluetooth, Wi‑Fi, ANT+'),

-- Fitbit Sense 2
(89, 'Brand', 'Fitbit'),
(89, 'Model', 'Sense 2'),
(89, 'Type', 'Health smartwatch'),
(89, 'Display', 'AMOLED'),
(89, 'Sensors', 'cEDA, ECG, SpO2, skin temperature'),
(89, 'Battery Life', 'Up to 6 days'),
(89, 'Water Resistance', '50 m'),
(89, 'OS', 'Fitbit OS'),
(89, 'Connectivity', 'Bluetooth 5.0, NFC, GPS'),

-- Fitbit Charge 6
(90, 'Brand', 'Fitbit'),
(90, 'Model', 'Charge 6'),
(90, 'Type', 'Fitness tracker'),
(90, 'Display', 'AMOLED'),
(90, 'Sensors', 'HR, SpO2, ECG'),
(90, 'Battery Life', 'Up to 7 days'),
(90, 'Water Resistance', '50 m'),
(90, 'OS', 'Fitbit OS'),
(90, 'Connectivity', 'Bluetooth 5.0, built‑in GPS'),

-- Oura Ring Gen 3
(91, 'Brand', 'Oura'),
(91, 'Model', 'Ring Gen 3'),
(91, 'Type', 'Smart ring'),
(91, 'Material', 'Titanium'),
(91, 'Sensors', 'Infrared LEDs, temperature, accelerometer, gyro'),
(91, 'Battery Life', 'Up to 7 days'),
(91, 'Water Resistance', '100 m'),
(91, 'Connectivity', 'Bluetooth Low Energy'),
(91, 'Sizes', 'US sizes 6-13'),

-- Xiaomi Watch 2 Pro
(92, 'Brand', 'Xiaomi'),
(92, 'Model', 'Watch 2 Pro'),
(92, 'Type', 'Smartwatch'),
(92, 'Display', '1.43" AMOLED, 466×466'),
(92, 'Case Size', '46mm'),
(92, 'Chip', 'Snapdragon W5+ Gen 1'),
(92, 'Battery Life', 'Up to 65 hours (Bluetooth)'),
(92, 'Water Resistance', '5 ATM'),
(92, 'OS', 'Wear OS'),
(92, 'Connectivity', 'Bluetooth 5.2, Wi‑Fi, NFC, optional LTE, GNSS'),

-- Huawei Watch GT 4
(93, 'Brand', 'Huawei'),
(93, 'Model', 'Watch GT 4'),
(93, 'Type', 'Smartwatch'),
(93, 'Display', 'AMOLED, 41/46mm'),
(93, 'Case Size', '41mm / 46mm'),
(93, 'Battery Life', 'Up to 7 days (41mm) / 14 days (46mm)'),
(93, 'Water Resistance', '5 ATM'),
(93, 'OS', 'HarmonyOS'),
(93, 'Connectivity', 'Bluetooth 5.2, GNSS'),

-- Amazfit Balance
(94, 'Brand', 'Amazfit'),
(94, 'Model', 'Balance'),
(94, 'Type', 'Smartwatch'),
(94, 'Display', '1.5" AMOLED'),
(94, 'Case Size', '46mm'),
(94, 'Battery Life', 'Up to 14 days'),
(94, 'Water Resistance', '5 ATM'),
(94, 'OS', 'Zepp OS'),
(94, 'Connectivity', 'Bluetooth 5.0, dual‑band GPS, NFC (select)'),

-- Suunto Vertical
(95, 'Brand', 'Suunto'),
(95, 'Model', 'Vertical'),
(95, 'Type', 'Outdoor GPS watch'),
(95, 'Display', 'MIP display, sapphire options'),
(95, 'Case Size', '49mm'),
(95, 'Battery Life', 'Up to 60 days (solar modes vary)'),
(95, 'Water Resistance', '100 m'),
(95, 'OS', 'Suunto OS'),
(95, 'Connectivity', 'Bluetooth, multi‑band GNSS, offline maps'),

-- Polar Vantage V3
(96, 'Brand', 'Polar'),
(96, 'Model', 'Vantage V3'),
(96, 'Type', 'Multisport watch'),
(96, 'Display', '1.39" AMOLED'),
(96, 'Case Size', '47mm'),
(96, 'Sensors', 'ECG, SpO2, skin temperature, dual‑band GPS'),
(96, 'Battery Life', 'Up to 8 days'),
(96, 'Water Resistance', '50 m'),
(96, 'OS', 'Polar OS'),
(96, 'Connectivity', 'Bluetooth, dual‑band GPS'),

-- Apple Watch SE (2nd gen)
(97, 'Brand', 'Apple'),
(97, 'Model', 'Watch SE (2nd gen)'),
(97, 'Type', 'Smartwatch'),
(97, 'Display', 'Retina OLED'),
(97, 'Case Size', '40mm / 44mm'),
(97, 'Chip', 'Apple S8 SiP'),
(97, 'Sensors', 'Optical HR, accelerometer, gyroscope'),
(97, 'Battery Life', 'Up to 18 hours'),
(97, 'Water Resistance', '50 m (WR50)'),
(97, 'OS', 'watchOS 10'),
(97, 'Connectivity', 'GPS, Wi‑Fi, Bluetooth 5.3, optional LTE'),

-- Galaxy Watch5 Pro
(98, 'Brand', 'Samsung'),
(98, 'Model', 'Galaxy Watch5 Pro'),
(98, 'Type', 'Rugged smartwatch'),
(98, 'Display', '1.4" Super AMOLED'),
(98, 'Case Size', '45mm'),
(98, 'Materials', 'Titanium case, sapphire crystal'),
(98, 'Sensors', 'BioActive (HR, ECG, BIA)'),
(98, 'Battery Life', 'Up to 80 hours'),
(98, 'Water Resistance', '5ATM + IP68'),
(98, 'OS', 'Wear OS (One UI Watch)'),
(98, 'Connectivity', 'GPS, Bluetooth 5.2, Wi‑Fi, NFC'),

-- WHOOP 4.0
(99, 'Brand', 'WHOOP'),
(99, 'Model', '4.0'),
(99, 'Type', 'Screenless fitness band'),
(99, 'Sensors', 'PPG, temperature, accelerometer'),
(99, 'Battery Life', 'Up to 5 days'),
(99, 'Water Resistance', '5 ATM'),
(99, 'OS', 'WHOOP app (iOS/Android)'),
(99, 'Connectivity', 'Bluetooth LE'),
(99, 'Membership', 'Subscription required'),

-- Samsung Galaxy Ring
(100, 'Brand', 'Samsung'),
(100, 'Model', 'Galaxy Ring'),
(100, 'Type', 'Smart ring'),
(100, 'Material', 'Titanium'),
(100, 'Sensors', 'PPG, skin temperature, accelerometer'),
(100, 'Battery Life', 'Up to 7 days'),
(100, 'Water Resistance', '10 ATM'),
(100, 'Connectivity', 'Bluetooth LE'),
(100, 'Sizes', 'US sizes 5-13'),
(100, 'Compatibility', 'Android, Samsung Health');


-- Variants for smartphones (id 1-52)
INSERT INTO product_variants (
    id,
    product_id,
    storage_size,
    color,
    price,
    discount_percent,
    status,
    created_at,
    updated_at,
    version
) VALUES
-- Smartphones
-- iPhone 15 Pro
(1, 1, '128GB', 'Natural Titanium', 999.00, 0, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 0),
(2, 1, '256GB', 'Blue Titanium', 1099.00, 0, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 0),
(3, 1, '512GB', 'Black Titanium', 1299.00, 5, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 0),
-- iPhone 15
(4, 2, '128GB', 'Blue', 799.00, 0, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 0),
(5, 2, '256GB', 'Pink', 899.00, 0, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 0),
(6, 2, '512GB', 'Black', 1099.00, 5, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 0),
-- Galaxy S24 Ultra
(7, 3, '256GB', 'Phantom Black', 1299.00, 0, 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 0),
(8, 3, '512GB', 'Titanium Gray', 1399.00, 5, 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 0),
(9, 3, '1TB', 'Titanium Violet', 1599.00, 8, 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 0),
-- Galaxy S24
(10, 4, '128GB', 'Cobalt Violet', 899.00, 0, 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 0),
(11, 4, '256GB', 'Marble Gray', 999.00, 0, 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 0),
(12, 4, '512GB', 'Amber Yellow', 1099.00, 5, 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 0),
-- Pixel 8 Pro
(13, 5, '128GB', 'Obsidian', 999.00, 0, 'ACTIVE', '2023-10-12 09:00:00', '2024-06-01 10:00:00', 0),
(14, 5, '256GB', 'Bay', 1099.00, 10, 'ACTIVE', '2023-10-12 09:00:00', '2024-06-01 10:00:00', 0),
(15, 5, '512GB', 'Porcelain', 1199.00, 10, 'ACTIVE', '2023-10-12 09:00:00', '2024-06-01 10:00:00', 0),
-- Pixel 8
(16, 6, '128GB', 'Obsidian', 699.00, 0, 'ACTIVE', '2023-10-12 09:00:00', '2024-06-01 10:00:00', 0),
(17, 6, '256GB', 'Hazel', 759.00, 5, 'ACTIVE', '2023-10-12 09:00:00', '2024-06-01 10:00:00', 0),
(18, 6, '256GB', 'Rose', 759.00, 0, 'ACTIVE', '2023-10-12 09:00:00', '2024-06-01 10:00:00', 0),
-- OnePlus 12
(19, 7, '256GB', 'Silky Black', 799.00, 0, 'ACTIVE', '2024-01-23 09:00:00', '2024-06-01 10:00:00', 0),
(20, 7, '256GB', 'Flowy Emerald', 799.00, 0, 'ACTIVE', '2024-01-23 09:00:00', '2024-06-01 10:00:00', 0),
(21, 7, '512GB', 'Silky Black', 899.00, 5, 'ACTIVE', '2024-01-23 09:00:00', '2024-06-01 10:00:00', 0),
-- Xiaomi 14
(22, 8, '256GB', 'Black', 799.00, 0, 'ACTIVE', '2023-10-26 09:00:00', '2024-06-01 10:00:00', 0),
(23, 8, '512GB', 'Green', 899.00, 5, 'ACTIVE', '2023-10-26 09:00:00', '2024-06-01 10:00:00', 0),
(24, 8, '512GB', 'White', 899.00, 0, 'ACTIVE', '2023-10-26 09:00:00', '2024-06-01 10:00:00', 0),
-- Sony Xperia 1 V
(25, 9, '256GB', 'Black', 1199.00, 0, 'ACTIVE', '2023-05-11 09:00:00', '2024-06-01 10:00:00', 0),
(26, 9, '512GB', 'Khaki Green', 1299.00, 10, 'ACTIVE', '2023-05-11 09:00:00', '2024-06-01 10:00:00', 0),
(27, 9, '256GB', 'Platinum Silver', 1199.00, 0, 'ACTIVE', '2023-05-11 09:00:00', '2024-06-01 10:00:00', 0),
-- ASUS ROG Phone 8 Pro
(28, 10, '256GB', 'Phantom Black', 1099.00, 0, 'ACTIVE', '2024-01-08 09:00:00', '2024-06-01 10:00:00', 0),
(29, 10, '512GB', 'Phantom Black', 1299.00, 0, 'ACTIVE', '2024-01-08 09:00:00', '2024-06-01 10:00:00', 0),
(30, 10, '512GB', 'Gray', 1299.00, 5, 'ACTIVE', '2024-01-08 09:00:00', '2024-06-01 10:00:00', 0),

-- iPhone 15 Pro Max
(31, 11, '256GB', 'Natural Titanium', 1199.00, 0, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 0),
(32, 11, '512GB', 'Blue Titanium', 1399.00, 0, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 0),
(33, 11, '1TB', 'Black Titanium', 1599.00, 5, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-01 10:00:00', 0),

-- iPhone 14 Pro
(34, 12, '128GB', 'Space Black', 999.00, 0, 'ACTIVE', '2022-09-16 10:00:00', '2024-06-01 10:00:00', 0),
(35, 12, '256GB', 'Deep Purple', 1099.00, 0, 'ACTIVE', '2022-09-16 10:00:00', '2024-06-01 10:00:00', 0),

-- Galaxy Z Fold5
(36, 13, '256GB', 'Icy Blue', 1799.00, 0, 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 0),
(37, 13, '512GB', 'Phantom Black', 1919.00, 0, 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 0),
(38, 13, '1TB', 'Cream', 2159.00, 5, 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 0),

-- Galaxy Z Flip5
(39, 14, '256GB', 'Mint', 999.00, 0, 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 0),
(40, 14, '512GB', 'Graphite', 1119.00, 0, 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 0),

-- Galaxy S24+
(41, 15, '256GB', 'Onyx Black', 999.00, 0, 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 0),
(42, 15, '512GB', 'Marble Gray', 1119.00, 0, 'ACTIVE', '2024-01-17 09:00:00', '2024-06-01 10:00:00', 0),

-- Pixel 8a
(43, 16, '128GB', 'Obsidian', 499.00, 0, 'ACTIVE', '2024-05-14 09:00:00', '2024-06-01 10:00:00', 0),
(44, 16, '256GB', 'Aloe', 559.00, 0, 'ACTIVE', '2024-05-14 09:00:00', '2024-06-01 10:00:00', 0),

-- Xiaomi 14 Ultra
(45, 17, '512GB', 'Black', 1499.00, 0, 'ACTIVE', '2024-02-22 09:00:00', '2024-06-01 10:00:00', 0),
(46, 17, '1TB', 'White', 1699.00, 5, 'ACTIVE', '2024-02-22 09:00:00', '2024-06-01 10:00:00', 0),

-- OnePlus 12R
(47, 18, '128GB', 'Cool Blue', 499.00, 0, 'ACTIVE', '2024-02-06 09:00:00', '2024-06-01 10:00:00', 0),
(48, 18, '256GB', 'Iron Gray', 599.00, 0, 'ACTIVE', '2024-02-06 09:00:00', '2024-06-01 10:00:00', 0),

-- Nothing Phone (2)
(49, 19, '256GB', 'White', 649.00, 0, 'ACTIVE', '2023-07-17 09:00:00', '2024-06-01 10:00:00', 0),
(50, 19, '512GB', 'Dark Gray', 749.00, 0, 'ACTIVE', '2023-07-17 09:00:00', '2024-06-01 10:00:00', 0),

-- Xperia 5 V
(51, 20, '128GB', 'Black', 999.00, 0, 'ACTIVE', '2023-09-01 09:00:00', '2024-06-01 10:00:00', 0),
(52, 20, '256GB', 'Blue', 1049.00, 0, 'ACTIVE', '2023-09-01 09:00:00', '2024-06-01 10:00:00', 0),

-- Tablet variants (id 53-92)
-- iPad Pro 11-inch (M4)
(53, 21, '256GB', 'Space Black', 999.00, 0, 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 0),
(54, 21, '512GB', 'Silver', 1199.00, 0, 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 0),
-- iPad Pro 13-inch (M4)
(55, 22, '256GB', 'Space Black', 1299.00, 0, 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 0),
(56, 22, '512GB', 'Silver', 1499.00, 0, 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 0),
-- iPad Air 11-inch (M2)
(57, 23, '128GB', 'Blue', 599.00, 0, 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 0),
(58, 23, '256GB', 'Starlight', 699.00, 0, 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 0),
-- iPad Air 13-inch (M2)
(59, 24, '128GB', 'Blue', 799.00, 0, 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 0),
(60, 24, '256GB', 'Starlight', 899.00, 0, 'ACTIVE', '2024-05-15 10:00:00', '2024-06-01 10:00:00', 0),
-- iPad (10th gen)
(61, 25, '64GB', 'Blue', 449.00, 0, 'ACTIVE', '2022-10-26 10:00:00', '2024-06-01 10:00:00', 0),
(62, 25, '256GB', 'Silver', 599.00, 0, 'ACTIVE', '2022-10-26 10:00:00', '2024-06-01 10:00:00', 0),
-- iPad mini (6th gen)
(63, 26, '64GB', 'Purple', 499.00, 0, 'ACTIVE', '2021-09-24 10:00:00', '2024-06-01 10:00:00', 0),
(64, 26, '256GB', 'Space Gray', 649.00, 0, 'ACTIVE', '2021-09-24 10:00:00', '2024-06-01 10:00:00', 0),
-- Galaxy Tab S9 Ultra
(65, 27, '256GB', 'Graphite', 1199.00, 0, 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 0),
(66, 27, '512GB', 'Beige', 1319.00, 5, 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 0),
-- Galaxy Tab S9+
(67, 28, '256GB', 'Graphite', 999.00, 0, 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 0),
(68, 28, '512GB', 'Beige', 1119.00, 0, 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 0),
-- Galaxy Tab S9
(69, 29, '128GB', 'Graphite', 799.00, 0, 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 0),
(70, 29, '256GB', 'Beige', 899.00, 0, 'ACTIVE', '2023-08-11 10:00:00', '2024-06-01 10:00:00', 0),
-- Galaxy Tab S9 FE
(71, 30, '128GB', 'Gray', 449.00, 0, 'ACTIVE', '2023-10-20 10:00:00', '2024-06-01 10:00:00', 0),
(72, 30, '256GB', 'Mint', 519.00, 0, 'ACTIVE', '2023-10-20 10:00:00', '2024-06-01 10:00:00', 0),
-- Galaxy Tab S9 FE+
(73, 31, '128GB', 'Gray', 599.00, 0, 'ACTIVE', '2023-10-20 10:00:00', '2024-06-01 10:00:00', 0),
(74, 31, '256GB', 'Lavender', 669.00, 0, 'ACTIVE', '2023-10-20 10:00:00', '2024-06-01 10:00:00', 0),
-- Surface Pro 11
(75, 32, '256GB', 'Platinum', 1199.00, 0, 'ACTIVE', '2024-06-18 10:00:00', '2024-06-18 10:00:00', 0),
(76, 32, '512GB', 'Black', 1399.00, 0, 'ACTIVE', '2024-06-18 10:00:00', '2024-06-18 10:00:00', 0),
-- Surface Go 4
(77, 33, '128GB', 'Platinum', 599.00, 0, 'ACTIVE', '2023-10-03 10:00:00', '2024-06-01 10:00:00', 0),
(78, 33, '256GB', 'Platinum', 699.00, 0, 'ACTIVE', '2023-10-03 10:00:00', '2024-06-01 10:00:00', 0),
-- Lenovo Tab P12
(79, 34, '128GB', 'Storm Grey', 399.00, 0, 'ACTIVE', '2023-08-01 10:00:00', '2024-06-01 10:00:00', 0),
(80, 34, '256GB', 'Storm Grey', 449.00, 0, 'ACTIVE', '2023-08-01 10:00:00', '2024-06-01 10:00:00', 0),
-- Lenovo Tab P11 Pro (2nd Gen)
(81, 35, '128GB', 'Storm Grey', 499.00, 0, 'ACTIVE', '2022-09-01 10:00:00', '2024-06-01 10:00:00', 0),
(82, 35, '256GB', 'Oat', 599.00, 0, 'ACTIVE', '2022-09-01 10:00:00', '2024-06-01 10:00:00', 0),
-- Xiaomi Pad 6
(83, 36, '128GB', 'Gravity Gray', 329.00, 0, 'ACTIVE', '2023-04-18 10:00:00', '2024-06-01 10:00:00', 0),
(84, 36, '256GB', 'Champagne', 379.00, 0, 'ACTIVE', '2023-04-18 10:00:00', '2024-06-01 10:00:00', 0),
-- OnePlus Pad
(85, 37, '128GB', 'Halo Green', 479.00, 0, 'ACTIVE', '2023-04-28 10:00:00', '2024-06-01 10:00:00', 0),
(86, 37, '256GB', 'Halo Green', 549.00, 0, 'ACTIVE', '2023-04-28 10:00:00', '2024-06-01 10:00:00', 0),
-- Huawei MatePad Pro 13.2
(87, 38, '256GB', 'Black', 999.00, 0, 'ACTIVE', '2023-12-12 10:00:00', '2024-06-01 10:00:00', 0),
(88, 38, '512GB', 'Gold', 1099.00, 0, 'ACTIVE', '2023-12-12 10:00:00', '2024-06-01 10:00:00', 0),
-- Amazon Fire Max 11
(89, 39, '64GB', 'Gray', 229.00, 0, 'ACTIVE', '2023-06-14 10:00:00', '2024-06-01 10:00:00', 0),
(90, 39, '128GB', 'Gray', 279.00, 0, 'ACTIVE', '2023-06-14 10:00:00', '2024-06-01 10:00:00', 0),
-- Google Pixel Tablet
(91, 40, '128GB', 'Porcelain', 499.00, 0, 'ACTIVE', '2023-06-20 10:00:00', '2024-06-01 10:00:00', 0),
 (92, 40, '256GB', 'Hazel', 599.00, 0, 'ACTIVE', '2023-06-20 10:00:00', '2024-06-01 10:00:00', 0),

-- Laptop variants (id 93-132)
-- MacBook Pro 14 (M3 Pro)
(93, 41, '18GB/512GB', 'Space Black', 1999.00, 0, 'ACTIVE', '2023-10-30 09:00:00', '2024-06-10 10:00:00', 0),
(94, 41, '18GB/1TB', 'Silver', 2399.00, 3, 'ACTIVE', '2023-10-30 09:00:00', '2024-06-10 10:00:00', 0),
-- MacBook Air 15 (M3)
(95, 42, '8GB/256GB', 'Midnight', 1299.00, 0, 'ACTIVE', '2024-03-08 09:00:00', '2024-06-05 10:00:00', 0),
(96, 42, '16GB/512GB', 'Starlight', 1499.00, 2, 'ACTIVE', '2024-03-08 09:00:00', '2024-06-05 10:00:00', 0),
-- Dell XPS 14
(97, 43, '16GB/512GB', 'Platinum', 1699.00, 0, 'ACTIVE', '2024-02-15 09:00:00', '2024-06-01 10:00:00', 0),
(98, 43, '32GB/1TB', 'Graphite', 2099.00, 5, 'ACTIVE', '2024-02-15 09:00:00', '2024-06-01 10:00:00', 0),
-- Dell XPS 13
(99, 44, '16GB/512GB', 'Platinum', 1299.00, 0, 'ACTIVE', '2024-02-10 09:00:00', '2024-05-20 10:00:00', 0),
(100, 44, '32GB/1TB', 'Graphite', 1499.00, 4, 'ACTIVE', '2024-02-10 09:00:00', '2024-05-20 10:00:00', 0),
-- HP Spectre x360 14
(101, 45, '16GB/512GB', 'Nightfall Black', 1399.00, 0, 'ACTIVE', '2024-01-20 09:00:00', '2024-05-25 10:00:00', 0),
(102, 45, '32GB/1TB', 'Slate Blue', 1599.00, 3, 'ACTIVE', '2024-01-20 09:00:00', '2024-05-25 10:00:00', 0),
-- ThinkPad X1 Carbon Gen 12
(103, 46, '16GB/512GB', 'Black', 1799.00, 0, 'ACTIVE', '2024-02-01 09:00:00', '2024-05-30 10:00:00', 0),
(104, 46, '32GB/1TB', 'Black', 2199.00, 5, 'ACTIVE', '2024-02-01 09:00:00', '2024-05-30 10:00:00', 0),
-- ThinkPad X1 Yoga Gen 9
(105, 47, '16GB/512GB', 'Storm Gray', 1899.00, 0, 'ACTIVE', '2024-02-05 09:00:00', '2024-05-30 10:00:00', 0),
(106, 47, '32GB/1TB', 'Storm Gray', 2299.00, 5, 'ACTIVE', '2024-02-05 09:00:00', '2024-05-30 10:00:00', 0),
-- ROG Zephyrus G14 (2024)
(107, 48, '16GB/1TB', 'Eclipse Gray', 1599.00, 0, 'ACTIVE', '2024-03-01 09:00:00', '2024-06-15 10:00:00', 0),
(108, 48, '32GB/1TB', 'Moonlight White', 1999.00, 4, 'ACTIVE', '2024-03-01 09:00:00', '2024-06-15 10:00:00', 0),
-- ROG Zephyrus G16 (2024)
(109, 49, '16GB/1TB', 'Eclipse Gray', 1899.00, 0, 'ACTIVE', '2024-03-01 09:00:00', '2024-06-15 10:00:00', 0),
(110, 49, '32GB/2TB', 'Platinum', 2399.00, 5, 'ACTIVE', '2024-03-01 09:00:00', '2024-06-15 10:00:00', 0),
-- Acer Swift X 14
(111, 50, '16GB/512GB', 'Steel Gray', 1199.00, 0, 'ACTIVE', '2024-02-20 09:00:00', '2024-05-10 10:00:00', 0),
(112, 50, '32GB/1TB', 'Steel Gray', 1399.00, 4, 'ACTIVE', '2024-02-20 09:00:00', '2024-05-10 10:00:00', 0),
-- Acer Swift Go 14
(113, 51, '8GB/256GB', 'Silver', 899.00, 0, 'ACTIVE', '2024-02-18 09:00:00', '2024-05-08 10:00:00', 0),
(114, 51, '16GB/512GB', 'Silver', 1099.00, 3, 'ACTIVE', '2024-02-18 09:00:00', '2024-05-08 10:00:00', 0),
-- Surface Laptop 6
(115, 52, '16GB/512GB', 'Platinum', 1199.00, 0, 'ACTIVE', '2024-04-01 09:00:00', '2024-06-12 10:00:00', 0),
(116, 52, '32GB/1TB', 'Black', 1499.00, 4, 'ACTIVE', '2024-04-01 09:00:00', '2024-06-12 10:00:00', 0),
-- Surface Laptop Studio 2
(117, 53, '16GB/512GB', 'Platinum', 1999.00, 0, 'ACTIVE', '2023-10-03 09:00:00', '2024-05-20 10:00:00', 0),
(118, 53, '32GB/1TB', 'Graphite', 2499.00, 5, 'ACTIVE', '2023-10-03 09:00:00', '2024-05-20 10:00:00', 0),
-- Razer Blade 16
(119, 54, '32GB/1TB', 'Black', 2799.00, 0, 'ACTIVE', '2024-01-15 09:00:00', '2024-05-18 10:00:00', 0),
(120, 54, '32GB/2TB', 'Black', 3299.00, 5, 'ACTIVE', '2024-01-15 09:00:00', '2024-05-18 10:00:00', 0),
-- Razer Blade 14
(121, 55, '16GB/1TB', 'Black', 2299.00, 0, 'ACTIVE', '2024-01-15 09:00:00', '2024-05-18 10:00:00', 0),
(122, 55, '32GB/1TB', 'Mercury', 2699.00, 4, 'ACTIVE', '2024-01-15 09:00:00', '2024-05-18 10:00:00', 0),
-- MSI Stealth 16 Studio
(123, 56, '16GB/1TB', 'Core Black', 1799.00, 0, 'ACTIVE', '2024-02-08 09:00:00', '2024-05-22 10:00:00', 0),
(124, 56, '32GB/2TB', 'Core Black', 2299.00, 4, 'ACTIVE', '2024-02-08 09:00:00', '2024-05-22 10:00:00', 0),
-- MSI Raider GE78 HX
(125, 57, '32GB/1TB', 'Black', 2499.00, 0, 'ACTIVE', '2024-02-08 09:00:00', '2024-05-22 10:00:00', 0),
(126, 57, '64GB/2TB', 'Black', 2999.00, 5, 'ACTIVE', '2024-02-08 09:00:00', '2024-05-22 10:00:00', 0),
-- Gigabyte AORUS 16X
(127, 58, '16GB/1TB', 'Black', 1699.00, 0, 'ACTIVE', '2024-02-12 09:00:00', '2024-05-12 10:00:00', 0),
(128, 58, '32GB/1TB', 'Black', 2099.00, 4, 'ACTIVE', '2024-02-12 09:00:00', '2024-05-12 10:00:00', 0),
-- Galaxy Book4 Pro 14
(129, 59, '16GB/512GB', 'Moonstone Gray', 1399.00, 0, 'ACTIVE', '2024-02-26 09:00:00', '2024-05-15 10:00:00', 0),
(130, 59, '32GB/1TB', 'Moonstone Gray', 1699.00, 3, 'ACTIVE', '2024-02-26 09:00:00', '2024-05-15 10:00:00', 0),
-- LG Gram 16
(131, 60, '16GB/512GB', 'Black', 1299.00, 0, 'ACTIVE', '2024-02-25 09:00:00', '2024-05-15 10:00:00', 0),
(132, 60, '32GB/1TB', 'Black', 1499.00, 3, 'ACTIVE', '2024-02-25 09:00:00', '2024-05-15 10:00:00', 0),

-- Audio & Headphones variants (id 133-172)
-- Sony WH-1000XM5
(133, 61, 'Standard', 'Black', 399.00, 0, 'ACTIVE', '2023-05-15 09:00:00', '2024-06-01 10:00:00', 0),
(134, 61, 'Standard', 'Silver', 399.00, 0, 'ACTIVE', '2023-05-15 09:00:00', '2024-06-01 10:00:00', 0),
-- Bose QuietComfort Ultra Headphones
(135, 62, 'Standard', 'Black', 429.00, 0, 'ACTIVE', '2023-10-05 09:00:00', '2024-06-01 10:00:00', 0),
(136, 62, 'Standard', 'Sandstone', 429.00, 0, 'ACTIVE', '2023-10-05 09:00:00', '2024-06-01 10:00:00', 0),
-- AirPods Pro (2nd gen, USB-C)
(137, 63, 'USB-C', 'White', 249.00, 0, 'ACTIVE', '2023-09-22 09:00:00', '2024-06-01 10:00:00', 0),
(138, 63, 'USB-C + MagSafe', 'White', 249.00, 0, 'ACTIVE', '2023-09-22 09:00:00', '2024-06-01 10:00:00', 0),
-- Sennheiser MOMENTUM 4 Wireless
(139, 64, 'Standard', 'Black', 379.00, 0, 'ACTIVE', '2022-08-23 09:00:00', '2024-06-01 10:00:00', 0),
(140, 64, 'Standard', 'White', 379.00, 0, 'ACTIVE', '2022-08-23 09:00:00', '2024-06-01 10:00:00', 0),
-- Bowers & Wilkins Px7 S2e
(141, 65, 'Standard', 'Anthracite Black', 399.00, 0, 'ACTIVE', '2023-10-04 09:00:00', '2024-06-01 10:00:00', 0),
(142, 65, 'Standard', 'Cloud Grey', 399.00, 0, 'ACTIVE', '2023-10-04 09:00:00', '2024-06-01 10:00:00', 0),
-- Bose QuietComfort Ultra Earbuds
(143, 66, 'Standard', 'Black', 299.00, 0, 'ACTIVE', '2023-10-05 09:00:00', '2024-06-01 10:00:00', 0),
(144, 66, 'Standard', 'White Smoke', 299.00, 0, 'ACTIVE', '2023-10-05 09:00:00', '2024-06-01 10:00:00', 0),
-- Sony WF-1000XM5
(145, 67, 'Standard', 'Black', 299.00, 0, 'ACTIVE', '2023-07-24 09:00:00', '2024-06-01 10:00:00', 0),
(146, 67, 'Standard', 'Silver', 299.00, 0, 'ACTIVE', '2023-07-24 09:00:00', '2024-06-01 10:00:00', 0),
-- AirPods Max
(147, 68, 'Standard', 'Space Gray', 549.00, 0, 'ACTIVE', '2020-12-15 09:00:00', '2024-06-01 10:00:00', 0),
(148, 68, 'Standard', 'Silver', 549.00, 0, 'ACTIVE', '2020-12-15 09:00:00', '2024-06-01 10:00:00', 0),
-- Beats Studio Pro
(149, 69, 'Standard', 'Black', 349.00, 0, 'ACTIVE', '2023-07-19 09:00:00', '2024-06-01 10:00:00', 0),
(150, 69, 'Standard', 'Sandstone', 349.00, 0, 'ACTIVE', '2023-07-19 09:00:00', '2024-06-01 10:00:00', 0),
-- Soundcore Liberty 4 NC
(151, 70, 'Standard', 'Black', 99.00, 0, 'ACTIVE', '2023-06-29 09:00:00', '2024-06-01 10:00:00', 0),
(152, 70, 'Standard', 'White', 99.00, 0, 'ACTIVE', '2023-06-29 09:00:00', '2024-06-01 10:00:00', 0),
-- Jabra Elite 10
(153, 71, 'Standard', 'Titanium Black', 249.00, 0, 'ACTIVE', '2023-09-01 09:00:00', '2024-06-01 10:00:00', 0),
(154, 71, 'Standard', 'Cream', 249.00, 0, 'ACTIVE', '2023-09-01 09:00:00', '2024-06-01 10:00:00', 0),
-- Samsung Galaxy Buds2 Pro
(155, 72, 'Standard', 'Graphite', 229.00, 0, 'ACTIVE', '2022-08-26 09:00:00', '2024-06-01 10:00:00', 0),
(156, 72, 'Standard', 'White', 229.00, 0, 'ACTIVE', '2022-08-26 09:00:00', '2024-06-01 10:00:00', 0),
-- Google Pixel Buds Pro
(157, 73, 'Standard', 'Charcoal', 199.00, 0, 'ACTIVE', '2022-07-21 09:00:00', '2024-06-01 10:00:00', 0),
(158, 73, 'Standard', 'Fog', 199.00, 0, 'ACTIVE', '2022-07-21 09:00:00', '2024-06-01 10:00:00', 0),
-- Nothing Ear (2024)
(159, 74, 'Standard', 'White', 149.00, 0, 'ACTIVE', '2024-04-18 09:00:00', '2024-06-01 10:00:00', 0),
(160, 74, 'Standard', 'Black', 149.00, 0, 'ACTIVE', '2024-04-18 09:00:00', '2024-06-01 10:00:00', 0),
-- JBL Tour One M2
(161, 75, 'Standard', 'Black', 299.00, 0, 'ACTIVE', '2023-01-05 09:00:00', '2024-06-01 10:00:00', 0),
(162, 75, 'Standard', 'Champagne', 299.00, 0, 'ACTIVE', '2023-01-05 09:00:00', '2024-06-01 10:00:00', 0),
-- Shure AONIC 50 Gen 2
(163, 76, 'Standard', 'Black', 349.00, 0, 'ACTIVE', '2023-11-15 09:00:00', '2024-06-01 10:00:00', 0),
(164, 76, 'Standard', 'Brown', 349.00, 0, 'ACTIVE', '2023-11-15 09:00:00', '2024-06-01 10:00:00', 0),
-- Sonos Ace
(165, 77, 'Standard', 'Black', 449.00, 0, 'ACTIVE', '2024-06-05 09:00:00', '2024-06-15 10:00:00', 0),
(166, 77, 'Standard', 'Soft White', 449.00, 0, 'ACTIVE', '2024-06-05 09:00:00', '2024-06-15 10:00:00', 0),
-- Technics EAH-AZ80
(167, 78, 'Standard', 'Black', 299.00, 0, 'ACTIVE', '2023-06-15 09:00:00', '2024-06-01 10:00:00', 0),
(168, 78, 'Standard', 'Silver', 299.00, 0, 'ACTIVE', '2023-06-15 09:00:00', '2024-06-01 10:00:00', 0),
-- Bose SoundLink Flex
(169, 79, 'Standard', 'Black', 149.00, 0, 'ACTIVE', '2022-05-12 09:00:00', '2024-06-01 10:00:00', 0),
(170, 79, 'Standard', 'Stone Blue', 149.00, 0, 'ACTIVE', '2022-05-12 09:00:00', '2024-06-01 10:00:00', 0),
-- Marshall Motif II ANC
(171, 80, 'Standard', 'Black', 199.00, 0, 'ACTIVE', '2023-09-12 09:00:00', '2024-06-01 10:00:00', 0),
(172, 80, 'Standard', 'Cream', 199.00, 0, 'ACTIVE', '2023-09-12 09:00:00', '2024-06-01 10:00:00', 0),

-- Wearables variants (id 173-212)
-- Apple Watch Series 9
(173, 81, 'GPS 41mm', 'Midnight', 399.00, 0, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-20 10:00:00', 0),
(174, 81, 'GPS 45mm', 'Starlight', 429.00, 0, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-20 10:00:00', 0),
-- Apple Watch Ultra 2
(175, 82, '49mm', 'Natural Titanium', 799.00, 0, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-20 10:00:00', 0),
(176, 82, '49mm', 'Titanium/Blue Trail', 829.00, 0, 'ACTIVE', '2023-09-22 10:00:00', '2024-06-20 10:00:00', 0),
-- Galaxy Watch6
(177, 83, '40mm Bluetooth', 'Graphite', 299.00, 0, 'ACTIVE', '2023-07-26 10:00:00', '2024-06-20 10:00:00', 0),
(178, 83, '44mm Bluetooth', 'Silver', 329.00, 0, 'ACTIVE', '2023-07-26 10:00:00', '2024-06-20 10:00:00', 0),
-- Galaxy Watch6 Classic
(179, 84, '43mm Bluetooth', 'Black', 399.00, 0, 'ACTIVE', '2023-07-26 10:00:00', '2024-06-20 10:00:00', 0),
(180, 84, '47mm Bluetooth', 'Silver', 429.00, 0, 'ACTIVE', '2023-07-26 10:00:00', '2024-06-20 10:00:00', 0),
-- Pixel Watch 2
(181, 85, 'Wi‑Fi', 'Black', 349.00, 0, 'ACTIVE', '2023-10-12 09:00:00', '2024-06-20 10:00:00', 0),
(182, 85, 'LTE', 'Polished Silver', 399.00, 0, 'ACTIVE', '2023-10-12 09:00:00', '2024-06-20 10:00:00', 0),
-- Garmin fēnix 7 Pro
(183, 86, '47mm', 'Slate Gray', 799.00, 0, 'ACTIVE', '2023-05-31 09:00:00', '2024-06-20 10:00:00', 0),
(184, 86, '51mm Solar', 'Carbon Gray', 899.00, 0, 'ACTIVE', '2023-05-31 09:00:00', '2024-06-20 10:00:00', 0),
-- Garmin Forerunner 965
(185, 87, '47mm', 'Black', 599.00, 0, 'ACTIVE', '2023-03-01 09:00:00', '2024-06-20 10:00:00', 0),
(186, 87, '47mm', 'Amp Yellow', 599.00, 0, 'ACTIVE', '2023-03-01 09:00:00', '2024-06-20 10:00:00', 0),
-- Garmin Venu 3
(187, 88, '45mm', 'Black', 449.00, 0, 'ACTIVE', '2023-08-31 09:00:00', '2024-06-20 10:00:00', 0),
(188, 88, '41mm (Venu 3S)', 'Cream Gold', 449.00, 0, 'ACTIVE', '2023-08-31 09:00:00', '2024-06-20 10:00:00', 0),
-- Fitbit Sense 2
(189, 89, 'Standard', 'Lunar White', 249.00, 0, 'ACTIVE', '2022-09-23 09:00:00', '2024-06-20 10:00:00', 0),
(190, 89, 'Standard', 'Shadow Grey', 249.00, 0, 'ACTIVE', '2022-09-23 09:00:00', '2024-06-20 10:00:00', 0),
-- Fitbit Charge 6
(191, 90, 'Standard', 'Obsidian', 159.00, 0, 'ACTIVE', '2023-09-28 09:00:00', '2024-06-20 10:00:00', 0),
(192, 90, 'Standard', 'Porcelain', 159.00, 0, 'ACTIVE', '2023-09-28 09:00:00', '2024-06-20 10:00:00', 0),
-- Oura Ring Gen 3
(193, 91, 'Size 8', 'Silver', 299.00, 0, 'ACTIVE', '2022-10-26 09:00:00', '2024-06-20 10:00:00', 0),
(194, 91, 'Size 10', 'Black', 299.00, 0, 'ACTIVE', '2022-10-26 09:00:00', '2024-06-20 10:00:00', 0),
-- Xiaomi Watch 2 Pro
(195, 92, 'Bluetooth 46mm', 'Black', 249.00, 0, 'ACTIVE', '2023-10-26 09:00:00', '2024-06-20 10:00:00', 0),
(196, 92, 'LTE 46mm', 'Silver', 299.00, 0, 'ACTIVE', '2023-10-26 09:00:00', '2024-06-20 10:00:00', 0),
-- Huawei Watch GT 4
(197, 93, '46mm', 'Green', 249.00, 0, 'ACTIVE', '2023-09-14 09:00:00', '2024-06-20 10:00:00', 0),
(198, 93, '41mm', 'White', 249.00, 0, 'ACTIVE', '2023-09-14 09:00:00', '2024-06-20 10:00:00', 0),
-- Amazfit Balance
(199, 94, '46mm', 'Midnight', 249.00, 0, 'ACTIVE', '2023-09-20 09:00:00', '2024-06-20 10:00:00', 0),
(200, 94, '46mm', 'Sunset Gray', 249.00, 0, 'ACTIVE', '2023-09-20 09:00:00', '2024-06-20 10:00:00', 0),
-- Suunto Vertical
(201, 95, 'Steel Solar', 'Black', 799.00, 0, 'ACTIVE', '2023-05-16 09:00:00', '2024-06-20 10:00:00', 0),
(202, 95, 'Titanium Solar', 'Sand', 999.00, 0, 'ACTIVE', '2023-05-16 09:00:00', '2024-06-20 10:00:00', 0),
-- Polar Vantage V3
(203, 96, 'Standard', 'Night Black', 599.00, 0, 'ACTIVE', '2023-10-11 09:00:00', '2024-06-20 10:00:00', 0),
(204, 96, 'Standard', 'Sky Blue', 599.00, 0, 'ACTIVE', '2023-10-11 09:00:00', '2024-06-20 10:00:00', 0),
-- Apple Watch SE (2nd gen)
(205, 97, '40mm GPS', 'Midnight', 249.00, 0, 'ACTIVE', '2022-09-16 10:00:00', '2024-06-20 10:00:00', 0),
(206, 97, '44mm GPS', 'Silver', 279.00, 0, 'ACTIVE', '2022-09-16 10:00:00', '2024-06-20 10:00:00', 0),
-- Galaxy Watch5 Pro
(207, 98, '45mm', 'Black Titanium', 399.00, 0, 'ACTIVE', '2022-08-26 09:00:00', '2024-06-20 10:00:00', 0),
(208, 98, '45mm', 'Gray Titanium', 399.00, 0, 'ACTIVE', '2022-08-26 09:00:00', '2024-06-20 10:00:00', 0),
-- WHOOP 4.0
(209, 99, 'Standard', 'Black', 299.00, 0, 'ACTIVE', '2021-09-08 09:00:00', '2024-06-20 10:00:00', 0),
(210, 99, 'Standard', 'Onyx', 299.00, 0, 'ACTIVE', '2021-09-08 09:00:00', '2024-06-20 10:00:00', 0),
-- Samsung Galaxy Ring
(211, 100, 'Size 9', 'Titanium Black', 399.00, 0, 'ACTIVE', '2024-07-10 09:00:00', '2024-07-10 09:00:00', 0),
(212, 100, 'Size 11', 'Titanium Silver', 399.00, 0, 'ACTIVE', '2024-07-10 09:00:00', '2024-07-10 09:00:00', 0);

-- Inventories per variant
INSERT INTO inventories (
    product_id,
    total_quantity,
    reserved_quantity
) VALUES
(1, 25, 0),(2, 25, 0),(3, 20, 0),(4, 22, 0),(5, 22, 0),(6, 18, 0),
(7, 16, 0),(8, 14, 0),(9, 10, 0),(10, 20, 0),(11, 18, 0),(12, 16, 0),
(13, 18, 0),(14, 16, 0),(15, 12, 0),(16, 20, 0),(17, 18, 0),(18, 18, 0),
(19, 16, 0),(20, 16, 0),(21, 12, 0),(22, 18, 0),(23, 16, 0),(24, 16, 0),
(25, 12, 0),(26, 10, 0),(27, 10, 0),(28, 14, 0),(29, 12, 0),(30, 12, 0),
(31, 20, 0),(32, 18, 0),(33, 14, 0),(34, 12, 0),(35, 12, 0),(36, 10, 0),
(37, 10, 0),(38, 8, 0),(39, 12, 0),(40, 10, 0),(41, 14, 0),(42, 12, 0),
(43, 20, 0),(44, 16, 0),(45, 10, 0),(46, 8, 0),(47, 16, 0),(48, 14, 0),
(49, 14, 0),(50, 12, 0),(51, 10, 0),(52, 10, 0),

(53, 18, 0),(54, 18, 0),(55, 18, 0),(56, 18, 0),(57, 18, 0),(58, 18, 0),
(59, 18, 0),(60, 18, 0),(61, 18, 0),(62, 18, 0),(63, 18, 0),(64, 18, 0),
(65, 18, 0),(66, 18, 0),(67, 18, 0),(68, 18, 0),(69, 18, 0),(70, 18, 0),
(71, 18, 0),(72, 18, 0),(73, 18, 0),(74, 18, 0),(75, 18, 0),(76, 18, 0),
(77, 18, 0),(78, 18, 0),(79, 18, 0),(80, 18, 0),(81, 18, 0),(82, 18, 0),
(83, 18, 0),(84, 18, 0),(85, 18, 0),(86, 18, 0),(87, 18, 0),(88, 18, 0),
(89, 18, 0),(90, 18, 0),(91, 18, 0),(92, 18, 0),

(93, 12, 0),(94, 12, 0),(95, 12, 0),(96, 12, 0),(97, 12, 0),(98, 12, 0),
(99, 12, 0),(100, 12, 0),(101, 12, 0),(102, 12, 0),(103, 12, 0),(104, 12, 0),
(105, 12, 0),(106, 12, 0),(107, 12, 0),(108, 12, 0),(109, 12, 0),(110, 12, 0),
(111, 12, 0),(112, 12, 0),(113, 12, 0),(114, 12, 0),(115, 12, 0),(116, 12, 0),
(117, 12, 0),(118, 12, 0),(119, 12, 0),(120, 12, 0),(121, 12, 0),(122, 12, 0),
(123, 12, 0),(124, 12, 0),(125, 12, 0),(126, 12, 0),(127, 12, 0),(128, 12, 0),
(129, 12, 0),(130, 12, 0),(131, 12, 0),(132, 12, 0),

(133, 40, 0),(134, 40, 0),(135, 40, 0),(136, 40, 0),(137, 40, 0),(138, 40, 0),
(139, 40, 0),(140, 40, 0),(141, 40, 0),(142, 40, 0),(143, 40, 0),(144, 40, 0),
(145, 40, 0),(146, 40, 0),(147, 40, 0),(148, 40, 0),(149, 40, 0),(150, 40, 0),
(151, 40, 0),(152, 40, 0),(153, 40, 0),(154, 40, 0),(155, 40, 0),(156, 40, 0),
(157, 40, 0),(158, 40, 0),(159, 40, 0),(160, 40, 0),(161, 40, 0),(162, 40, 0),
(163, 40, 0),(164, 40, 0),(165, 40, 0),(166, 40, 0),(167, 40, 0),(168, 40, 0),
(169, 40, 0),(170, 40, 0),(171, 40, 0),(172, 40, 0),

(173, 30, 0),(174, 30, 0),(175, 25, 0),(176, 25, 0),(177, 35, 0),(178, 35, 0),
(179, 28, 0),(180, 28, 0),(181, 30, 0),(182, 30, 0),(183, 20, 0),(184, 20, 0),
(185, 22, 0),(186, 22, 0),(187, 26, 0),(188, 26, 0),(189, 32, 0),(190, 32, 0),
(191, 40, 0),(192, 40, 0),(193, 25, 0),(194, 25, 0),(195, 30, 0),(196, 30, 0),
(197, 30, 0),(198, 30, 0),(199, 30, 0),(200, 30, 0),(201, 18, 0),(202, 18, 0),
(203, 22, 0),(204, 22, 0),(205, 35, 0),(206, 35, 0),(207, 28, 0),(208, 28, 0),
(209, 30, 0),(210, 30, 0),(211, 24, 0),(212, 24, 0);


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
(1, 1, 3197.00, 'PENDING', '123 Elm Street, District 1, Ho Chi Minh City', '0901234567', 'Van An Nguyen', '2024-02-10 11:00:00', '2024-02-10 11:30:00'),
(2, 2, 3546.00, 'PROCESSING', '456 Pine Avenue, District 2, Ho Chi Minh City', '0902345678', 'Thi Binh Tran', '2024-02-15 15:00:00', '2024-02-15 15:15:00'),
(3, 3, 3797.00, 'SHIPPED', '789 Oak Road, District 3, Ho Chi Minh City', '0903456789', 'Hoang Cuong Le', '2024-03-05 09:20:00', '2024-03-06 10:00:00'),
(4, 4, 2097.00, 'DELIVERED', '321 Maple Street, District 4, Ho Chi Minh City', '0904567890', 'Minh Dung Pham', '2024-03-18 14:10:00', '2024-03-20 16:30:00'),
(5, 5, 4996.00, 'PROCESSING', '654 Cedar Lane, District 5, Ho Chi Minh City', '0905678901', 'Thi Hanh Vo', '2024-04-02 08:45:00', '2024-04-02 09:10:00'),
(6, 1, 3596.00, 'PENDING', '123 Elm Street, District 1, Ho Chi Minh City', '0901234567', 'Van An Nguyen', '2024-04-15 10:30:00', '2024-04-15 10:45:00');

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
-- Order 1 items (uses product_variants.id)
(1, 2, 'Apple iPhone 15 Pro 256GB Blue Titanium', 1099.00, 1, 1099.00, '2024-02-10 11:05:00'),
(1, 97, 'Dell XPS 14 16GB/512GB Platinum', 1699.00, 1, 1699.00, '2024-02-10 11:06:00'),
(1, 173, 'Apple Watch Series 9 GPS 41mm Midnight', 399.00, 1, 399.00, '2024-02-10 11:07:00'),
-- Order 2 items
(2, 41, 'Samsung Galaxy S24+ 256GB Onyx Black', 999.00, 1, 999.00, '2024-02-15 15:05:00'),
(2, 55, 'Apple iPad Pro 13 256GB Space Black', 1299.00, 1, 1299.00, '2024-02-15 15:06:00'),
(2, 181, 'Google Pixel Watch 2 Wi‑Fi Black', 349.00, 1, 349.00, '2024-02-15 15:07:00'),
(2, 113, 'Acer Swift Go 14 8GB/256GB Silver', 899.00, 1, 899.00, '2024-02-15 15:08:00'),
-- Order 3 items
(3, 31, 'Apple iPhone 15 Pro Max 256GB Natural Titanium', 1199.00, 1, 1199.00, '2024-03-05 09:25:00'),
(3, 93, 'Apple MacBook Pro 14 18GB/512GB Space Black', 1999.00, 1, 1999.00, '2024-03-05 09:26:00'),
(3, 203, 'Polar Vantage V3 Night Black', 599.00, 1, 599.00, '2024-03-05 09:27:00'),
-- Order 4 items
(4, 67, 'Samsung Galaxy Tab S9+ 256GB Graphite', 999.00, 1, 999.00, '2024-03-18 14:15:00'),
(4, 145, 'Sony WF-1000XM5 Black', 299.00, 1, 299.00, '2024-03-18 14:16:00'),
(4, 201, 'Suunto Vertical Steel Solar Black', 799.00, 1, 799.00, '2024-03-18 14:17:00'),
-- Order 5 items
(5, 45, 'Xiaomi 14 Ultra 512GB Black', 1499.00, 1, 1499.00, '2024-04-02 08:50:00'),
(5, 119, 'Razer Blade 16 32GB/1TB Black', 2799.00, 1, 2799.00, '2024-04-02 08:51:00'),
(5, 165, 'Sonos Ace Black', 449.00, 1, 449.00, '2024-04-02 08:52:00'),
(5, 205, 'Apple Watch SE (2nd gen) 40mm GPS Midnight', 249.00, 1, 249.00, '2024-04-02 08:53:00'),
-- Order 6 items
(6, 14, 'Google Pixel 8 Pro 256GB Bay', 1099.00, 1, 1099.00, '2024-04-15 10:35:00'),
(6, 69, 'Samsung Galaxy Tab S9 128GB Graphite', 799.00, 1, 799.00, '2024-04-15 10:36:00'),
(6, 131, 'LG Gram 16 16GB/512GB Black', 1299.00, 1, 1299.00, '2024-04-15 10:37:00'),
(6, 211, 'Samsung Galaxy Ring Size 9 Titanium Black', 399.00, 1, 399.00, '2024-04-15 10:38:00');

