/*
 Navicat Premium Dump SQL

 Source Server         : AuraSound_Project_DB
 Source Server Type    : MySQL
 Source Server Version : 80407 (8.4.7)
 Source Host           : localhost:3306
 Source Schema         : aurasound_db

 Target Server Type    : MySQL
 Target Server Version : 80407 (8.4.7)
 File Encoding         : 65001

 Date: 03/04/2026 16:07:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for banners
-- ----------------------------
DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `sort_order` int NULL DEFAULT 0,
  `is_active` tinyint(1) NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of banners
-- ----------------------------
INSERT INTO `banners` VALUES (1, 'https://promotion.sony.com.vn:5001/storage/2025/07/15/extended_warranty_mdr.jpg', '/product', 'bo suu tap moi', '', 1, 1, '2026-01-25 13:58:13');
INSERT INTO `banners` VALUES (2, 'https://promotion.sony.com.vn:5001/storage/2025/03/31/Upgrade-headphone_Extended.png', '/product', 'aa', '', 1, 1, '2026-01-25 13:59:01');
INSERT INTO `banners` VALUES (3, 'https://www.winwinstore.vn/wp-content/uploads/2021/07/1313Banner-1324x745-1.jpg', '/product', 'aa', 'a', 1, 1, '2026-01-25 13:59:51');
INSERT INTO `banners` VALUES (4, 'https://promotion.sony.com.vn:5001/storage/2025/03/31/Upgrade-headphone_Extended.png', '/product', 'bộ sưu tập mới', 'a', 1, 1, '2026-01-25 14:03:10');
INSERT INTO `banners` VALUES (5, 'https://bizweb.dktcdn.net/100/479/913/themes/901218/assets/slider_1.jpg?1762450834625', '/product', 'bộ sưu tập mới', 'a', 2, 1, '2026-01-25 14:03:37');
INSERT INTO `banners` VALUES (6, '1769324638457_banner_3.jpg', '/product', 'BST mới', '', 1, 1, '2026-01-25 14:03:58');
INSERT INTO `banners` VALUES (7, '1769325329411_banner_1.png', '/product', 'BST 1', '', 1, 1, '2026-01-25 14:15:29');

-- ----------------------------
-- Table structure for brands
-- ----------------------------
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of brands
-- ----------------------------
INSERT INTO `brands` VALUES (1, 'Sony', 'https://hdradio.vn/upload/hinhanh/tai-nghe/icon/logo-sony.jpg');
INSERT INTO `brands` VALUES (2, 'JBL', 'https://logosmarcas.net/wp-content/uploads/2020/12/JBL-Emblema-650x366.png');
INSERT INTO `brands` VALUES (3, 'Rezo', 'https://cdn.shopify.com/s/files/1/2187/5605/collections/rezo.jpg?v=1554667120');
INSERT INTO `brands` VALUES (4, 'Baseus', 'https://tse1.mm.bing.net/th/id/OIP.eeqU0aiiBn_xpAkiHvwXegHaB3?pid=Api&P=0&h=180');
INSERT INTO `brands` VALUES (5, 'LG', 'https://images.seeklogo.com/logo-png/8/1/lg-logo-png_seeklogo-83705.png');
INSERT INTO `brands` VALUES (6, 'HAVIT', 'https://chemicygaming.com/image/cache/~BRAND/T1IdTKXoFkXXb1upjX-600x315.jpg');
INSERT INTO `brands` VALUES (7, 'Apple ', 'https://i.pinimg.com/originals/fb/66/c9/fb66c922b0ad029e61fdab87badd8e27.jpg');
INSERT INTO `brands` VALUES (8, 'Marshall', 'https://images.seeklogo.com/logo-png/8/1/marshall-logo-png_seeklogo-88775.png');
INSERT INTO `brands` VALUES (9, 'Xiaomi', 'https://www.kindpng.com/picc/m/2-26372_xiaomi-logo-white-png-transparent-png.png');
INSERT INTO `brands` VALUES (10, 'Huawei', 'https://vectorseek.com/wp-content/uploads/2023/04/Huawei-icon-Logo-Vector-600x600.jpg');
INSERT INTO `brands` VALUES (11, 'Realme', 'https://www.mobilityindia.com/wp-content/uploads/2021/10/realme-logo-1.png');
INSERT INTO `brands` VALUES (12, 'Razer', 'https://tse4.mm.bing.net/th/id/OIP.Kk9oJyopsbsRPy5l0Tvy3wHaHa?pid=Api&P=0&h=180');
INSERT INTO `brands` VALUES (13, 'SamSung', 'https://images.samsung.com/is/image/samsung/assets/global/about-us/brand/logo/mo/256_144_2.png?$512_N_PNG$');

-- ----------------------------
-- Table structure for cartitems
-- ----------------------------
DROP TABLE IF EXISTS `cartitems`;
CREATE TABLE `cartitems`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `carts_id` int NOT NULL,
  `productvariants_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `carts_id`(`carts_id` ASC) USING BTREE,
  INDEX `productvariants_id`(`productvariants_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cartitems
-- ----------------------------

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `users_id` int NOT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_id`(`users_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carts
-- ----------------------------
INSERT INTO `carts` VALUES (1, 1, '2026-03-20 18:39:22');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parents_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_category_name`(`name` ASC, `parents_id` ASC) USING BTREE,
  INDEX `fk_category_parent`(`parents_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (2, 'Loa', NULL);
INSERT INTO `categories` VALUES (6, 'Loa di động', 2);
INSERT INTO `categories` VALUES (7, 'Loa Karaoke', 2);
INSERT INTO `categories` VALUES (1, 'Tai nghe', NULL);
INSERT INTO `categories` VALUES (3, 'Tai nghe chụp tai', 1);
INSERT INTO `categories` VALUES (5, 'Tai nghe kẹp tai', 1);
INSERT INTO `categories` VALUES (4, 'Tai nghe nhét tai', 1);

-- ----------------------------
-- Table structure for contactreplies
-- ----------------------------
DROP TABLE IF EXISTS `contactreplies`;
CREATE TABLE `contactreplies`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `contact_id` int NOT NULL,
  `sender_type` enum('User','Admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `contact_id`(`contact_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contactreplies
-- ----------------------------

-- ----------------------------
-- Table structure for contacts
-- ----------------------------
DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `users_id` int NULL DEFAULT NULL,
  `sender_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reply_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` tinyint NULL DEFAULT 0 COMMENT '0: New, 1: Replied',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `users_id`(`users_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contacts
-- ----------------------------
INSERT INTO `contacts` VALUES (1, NULL, 'Thuong Nguyen', 'nhthuong.1305@gmail.com', '0708870329', 'giá sỉ 80 cái ava trắng 310+', 'Chào Thuong Nguyen...', 1, '2025-12-27 17:55:10');
INSERT INTO `contacts` VALUES (2, NULL, 'Thuong Nguyen', 'nhthuong.1305@gmail.com', '0708870329', 'giá sỉ 80 cái ava trắng 310+', 'Chào Thuong Nguyen...', 1, '2025-12-27 17:56:12');
INSERT INTO `contacts` VALUES (3, NULL, '', '', '', '', NULL, 0, '2025-12-29 15:36:04');
INSERT INTO `contacts` VALUES (4, NULL, '', '', '', '', NULL, 0, '2025-12-29 15:40:36');
INSERT INTO `contacts` VALUES (5, NULL, 'Thuong Nguyen', 'nhthuong.1305@gmail.com', '0708870329', 'tư vấn mở chi nhánh', 'Chào Thuong Nguyen...', 1, '2025-12-29 15:42:42');
INSERT INTO `contacts` VALUES (6, NULL, 'Thuong Nguyen', '27130508@st.hcmuaf.edu.vn', '0708870329', 'Mấy giờ đóng cửa', 'Chào Thuong Nguyen...', 1, '2025-12-29 18:03:51');
INSERT INTO `contacts` VALUES (7, NULL, 'Thuong Nguyen', 'nhthuong.1305@gmail.com', '0708870329', 'Giao hàng bao lâu có', 'Chào Thuong Nguyen...', 1, '2025-12-29 18:28:29');
INSERT INTO `contacts` VALUES (8, 1, 'Nguyễn Hoài Thương', '23130327@st.hcmuaf.edu.vn', '0708870329', 'ĐỔi hàng thế  nào', 'Chào Nguyễn Hoài Thương...', 1, '2025-12-29 18:35:20');
INSERT INTO `contacts` VALUES (9, NULL, '23130238', '23130238@st.hcmuaf.edu.vn', '', 'Tôi muốn mở đại lý, chiết khấu, chính sách thế nào', 'Chào 23130238...', 1, '2026-01-23 20:21:35');
INSERT INTO `contacts` VALUES (10, 1, 'Nguyễn Hoài Thương', '23130327@st.hcmuaf.edu.vn', '0708870329', 'Khi nào về air pod mới', 'Chào Nguyễn Hoài Thương...', 1, '2026-01-27 02:10:50');
INSERT INTO `contacts` VALUES (11, 3, 'Nguyễn Hoài Bảo', 'nhbao@gmail.com', '0901234567', 'Chào AuraSound, tai nghe Sony WH-1000XM5 bên mình còn màu bạc không ạ?', NULL, 0, '2026-01-27 02:19:05');
INSERT INTO `contacts` VALUES (12, NULL, 'Trần Minh Tâm', 'minhtam.tran@gmail.com', '0345678901', 'Mình muốn đặt số lượng lớn loa JBL Flip 6 làm quà tặng công ty, có chiết khấu tốt không?', NULL, 0, '2026-01-27 02:19:05');
INSERT INTO `contacts` VALUES (13, 5, 'Võ Thị Kiều Tiên', 'vtkt@gmail.com', '0912345678', 'Sản phẩm mình mua tuần trước bị rè một bên tai, shop hỗ trợ bảo hành giúp mình nhé.', NULL, 0, '2026-01-27 02:19:05');
INSERT INTO `contacts` VALUES (14, NULL, 'Lê Thị Hồng', 'hongle92@yahoo.com', '0987654321', 'AuraSound có bán lẻ phụ kiện đệm tai cho Marshall Major IV không shop?', NULL, 0, '2026-01-27 02:19:05');
INSERT INTO `contacts` VALUES (15, 1, 'Nguyễn Hoài Thương', '23130327@st.hcmuaf.edu.vn', '0708870329', 'Shop tư vấn giúp mình dòng loa Marshall nào phù hợp cho phòng 30m2 với ạ.', NULL, 0, '2026-01-27 02:19:05');
INSERT INTO `contacts` VALUES (16, NULL, 'Phạm Thành Long', 'long.pham@outlook.com', '0933445566', 'Mình ở Đà Nẵng thì ship bao lâu thì nhận được hàng vậy shop?', NULL, 0, '2026-01-27 02:19:05');
INSERT INTO `contacts` VALUES (17, 2, 'Thuong Nguyen', 'nhthuong.1305@gmail.com', '0708870329', 'Cần tìm mua tai nghe AirPods Pro 2 chính hãng, shop cho hỏi là bản USB-C hay Lightning?', NULL, 0, '2026-01-27 02:19:05');
INSERT INTO `contacts` VALUES (18, NULL, 'Hoàng Anh Tuấn', 'tuananh_h@gmail.com', '0944556677', 'Loa JBL PartyBox 310 có đang được khuyến mãi kèm micro không ạ?', NULL, 0, '2026-01-27 02:19:05');
INSERT INTO `contacts` VALUES (19, NULL, 'Ngô Thanh Vân', 'vanngo_88@gmail.com', '0922113344', 'Sản phẩm của shop có cho phép trả góp qua thẻ tín dụng không?', NULL, 0, '2026-01-27 02:19:05');
INSERT INTO `contacts` VALUES (20, 5, 'Võ Thị Kiều Tiên', 'vtkt@gmail.com', '0912345678', 'Cảm ơn shop đã hỗ trợ đổi trả nhiệt tình ạ!', NULL, 1, '2026-01-27 02:19:05');

-- ----------------------------
-- Table structure for orderitems
-- ----------------------------
DROP TABLE IF EXISTS `orderitems`;
CREATE TABLE `orderitems`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `orders_id` int NOT NULL,
  `productvariants_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price_at_purchase` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_variant`(`orders_id` ASC, `productvariants_id` ASC) USING BTREE,
  INDEX `productvariants_id`(`productvariants_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orderitems
-- ----------------------------
INSERT INTO `orderitems` VALUES (1, 1, 5, 1, 2500000.00);
INSERT INTO `orderitems` VALUES (2, 2, 3, 2, 2600000.00);
INSERT INTO `orderitems` VALUES (3, 3, 10, 1, 1200000.00);
INSERT INTO `orderitems` VALUES (4, 4, 12, 1, 850000.00);
INSERT INTO `orderitems` VALUES (5, 5, 7, 1, 3100000.00);
INSERT INTO `orderitems` VALUES (6, 6, 2, 1, 4500000.00);
INSERT INTO `orderitems` VALUES (7, 7, 15, 2, 1050000.00);
INSERT INTO `orderitems` VALUES (8, 8, 1, 1, 6700000.00);
INSERT INTO `orderitems` VALUES (9, 9, 8, 1, 1550000.00);
INSERT INTO `orderitems` VALUES (10, 10, 19, 1, 950000.00);
INSERT INTO `orderitems` VALUES (11, 11, 4, 1, 1850000.00);
INSERT INTO `orderitems` VALUES (12, 12, 8, 2, 1600000.00);
INSERT INTO `orderitems` VALUES (13, 13, 10, 1, 750000.00);
INSERT INTO `orderitems` VALUES (14, 14, 1, 1, 1250000.00);
INSERT INTO `orderitems` VALUES (15, 15, 2, 1, 4500000.00);
INSERT INTO `orderitems` VALUES (16, 16, 12, 3, 316666.67);
INSERT INTO `orderitems` VALUES (17, 17, 7, 1, 2100000.00);
INSERT INTO `orderitems` VALUES (18, 21, 37, 2, 1690000.00);
INSERT INTO `orderitems` VALUES (19, 21, 13, 4, 570000.00);
INSERT INTO `orderitems` VALUES (20, 22, 20, 1, 290000.00);
INSERT INTO `orderitems` VALUES (21, 22, 14, 1, 560000.00);
INSERT INTO `orderitems` VALUES (22, 23, 36, 1, 1690000.00);
INSERT INTO `orderitems` VALUES (23, 23, 13, 1, 570000.00);
INSERT INTO `orderitems` VALUES (24, 24, 13, 1, 570000.00);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `users_id` int NULL DEFAULT NULL,
  `vouchers_id` int NULL DEFAULT NULL,
  `order_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_date` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint NULL DEFAULT 0 COMMENT '0:Pending, 1:Shipping, 2:Completed, 3:Cancelled',
  `payment_status` tinyint NULL DEFAULT 0 COMMENT '0:Unpaid, 1:Paid, 2:Refunded',
  `total_products_price` decimal(10, 2) NOT NULL,
  `shipping_fee` decimal(10, 2) NULL DEFAULT 0.00,
  `discount_amount` decimal(10, 2) NULL DEFAULT 0.00,
  `final_amount` decimal(10, 2) NOT NULL,
  `admin_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `finished_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_code`(`order_code` ASC) USING BTREE,
  INDEX `users_id`(`users_id` ASC) USING BTREE,
  INDEX `vouchers_id`(`vouchers_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, NULL, 'ORD001', '2026-01-12 23:45:10', 2, 1, 2500000.00, 30000.00, 0.00, 2530000.00, 'Đã gọi xác nhận với khách, khách dặn giao sau 17h chiều tại KTX.', NULL);
INSERT INTO `orders` VALUES (2, 2, 1, 'ORD002', '2026-01-14 09:12:05', 1, 1, 5200000.00, 0.00, 200000.00, 5000000.00, 'Đơn hàng giá trị cao (5tr), đã đóng gói 3 lớp xốp nổ...', NULL);
INSERT INTO `orders` VALUES (3, 3, NULL, 'ORD003', '2026-01-15 14:20:33', 3, 0, 1200000.00, 30000.00, 0.00, 1230000.00, 'Khách báo đặt nhầm màu trắng...', NULL);
INSERT INTO `orders` VALUES (4, 1, NULL, 'ORD004', '2026-01-17 10:05:45', 2, 1, 850000.00, 25000.00, 0.00, 875000.00, 'da đóng gói, chờ xuất', NULL);
INSERT INTO `orders` VALUES (5, 4, 2, 'ORD005', '2026-01-18 21:30:12', 2, 1, 3100000.00, 0.00, 150000.00, 2950000.00, 'Khách dùng Voucher 150k...', NULL);
INSERT INTO `orders` VALUES (6, 5, NULL, 'ORD006', '2026-01-20 08:45:22', 2, 1, 4500000.00, 35000.00, 0.00, 4535000.00, 'chưa bàn giao cho đơn vị vận chuyển...', NULL);
INSERT INTO `orders` VALUES (7, 2, NULL, 'ORD007', '2026-01-21 15:10:00', 2, 1, 2100000.00, 30000.00, 0.00, 2130000.00, 'Khách nhận hàng xong đã gọi điện khen...', NULL);
INSERT INTO `orders` VALUES (8, 3, 1, 'ORD008', '2026-01-22 11:25:50', 3, 0, 6700000.00, 0.00, 200000.00, 6500000.00, 'Đơn hàng hơn 6tr nhưng khách chưa thanh toán...', NULL);
INSERT INTO `orders` VALUES (9, 1, NULL, 'ORD009', '2026-01-23 19:18:03', 2, 1, 1550000.00, 30000.00, 0.00, 1580000.00, 'Khách hẹn chuyển khoản qua ngân hàng...', NULL);
INSERT INTO `orders` VALUES (10, 4, NULL, 'ORD010', '2026-01-24 10:05:12', 3, 0, 950000.00, 25000.00, 0.00, 975000.00, 'Địa chỉ số nhà hơi lạ...', NULL);
INSERT INTO `orders` VALUES (11, 2, NULL, 'ORD011', '2026-01-24 14:20:00', 0, 0, 1850000.00, 30000.00, 0.00, 1880000.00, 'Khách chọn thanh toán chuyển khoản...', NULL);
INSERT INTO `orders` VALUES (12, 5, NULL, 'ORD012', '2026-01-24 16:45:12', 0, 1, 3200000.00, 0.00, 150000.00, 3050000.00, 'Đã nhận thanh toán qua VNPay...', NULL);
INSERT INTO `orders` VALUES (13, 1, NULL, 'ORD013', '2026-01-25 08:30:00', 1, 0, 750000.00, 25000.00, 0.00, 775000.00, 'Khách mới, cần gọi xác nhận...', NULL);
INSERT INTO `orders` VALUES (14, 3, NULL, 'ORD014', '2026-01-25 09:15:22', 0, 0, 1250000.00, 30000.00, 50000.00, 1230000.00, 'Đơn hàng đặt vào khung giờ Flash Sale...', NULL);
INSERT INTO `orders` VALUES (15, 4, NULL, 'ORD015', '2026-01-25 10:00:45', 2, 1, 4500000.00, 0.00, 0.00, 4500000.00, 'Thanh toán thẻ quốc tế thành công...', NULL);
INSERT INTO `orders` VALUES (16, 2, NULL, 'ORD016', '2026-01-25 11:10:05', 3, 0, 950000.00, 25000.00, 0.00, 975000.00, 'Đặt nhầm', NULL);
INSERT INTO `orders` VALUES (17, 5, NULL, 'ORD017', '2026-01-25 11:30:50', 2, 1, 2100000.00, 30000.00, 100000.00, 2030000.00, 'Khách cũ thân thiết...', NULL);
INSERT INTO `orders` VALUES (18, NULL, NULL, '639051656032628713', '2026-01-28 02:53:23', 0, 0, 1690000.00, 0.00, 0.00, 1690000.00, NULL, NULL);
INSERT INTO `orders` VALUES (19, NULL, NULL, '639051658139987960', '2026-01-28 02:56:54', 0, 0, 2260000.00, 0.00, 0.00, 2260000.00, NULL, NULL);
INSERT INTO `orders` VALUES (20, NULL, NULL, '639051670950995492', '2026-01-28 03:18:15', 0, 0, 6780000.00, 0.00, 0.00, 6780000.00, NULL, NULL);
INSERT INTO `orders` VALUES (21, NULL, NULL, '639051674252046043', '2026-01-28 03:23:45', 0, 0, 5660000.00, 0.00, 0.00, 5660000.00, NULL, NULL);
INSERT INTO `orders` VALUES (22, 0, NULL, '639051691434143517', '2026-01-28 03:52:23', 0, 0, 850000.00, 0.00, 0.00, 850000.00, NULL, NULL);
INSERT INTO `orders` VALUES (23, 1, NULL, '639051702192634410', '2026-01-28 04:10:19', 0, 0, 2260000.00, 0.00, 0.00, 2260000.00, NULL, NULL);
INSERT INTO `orders` VALUES (24, 4, NULL, 'AR2PS4', '2026-01-28 04:21:10', 3, 0, 570000.00, 0.00, 0.00, 570000.00, 'Không có note\nko\nko', NULL);

-- ----------------------------
-- Table structure for ordershippings
-- ----------------------------
DROP TABLE IF EXISTS `ordershippings`;
CREATE TABLE `ordershippings`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `orders_id` int NOT NULL,
  `useraddresses_id` int NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `orders_id`(`orders_id` ASC) USING BTREE,
  INDEX `useraddresses_id`(`useraddresses_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ordershippings
-- ----------------------------
INSERT INTO `ordershippings` VALUES (1, 1, 1, 'Giao vào buổi chiều sau 5h giúp mình.');
INSERT INTO `ordershippings` VALUES (2, 2, 1, 'Gọi trước khi giao 15 phút.');
INSERT INTO `ordershippings` VALUES (3, 3, 1, 'Hàng dễ vỡ, xin nhẹ tay.');
INSERT INTO `ordershippings` VALUES (4, 4, 1, NULL);
INSERT INTO `ordershippings` VALUES (5, 5, 1, 'Giao giờ hành chính, tại văn phòng công ty.');
INSERT INTO `ordershippings` VALUES (6, 6, 1, 'Nhà trong hẻm, nếu không tìm thấy vui lòng gọi.');
INSERT INTO `ordershippings` VALUES (7, 7, 1, 'Để ở bảo vệ nếu mình không có nhà.');
INSERT INTO `ordershippings` VALUES (8, 8, 1, 'Cần gấp để làm quà tặng sinh nhật.');
INSERT INTO `ordershippings` VALUES (9, 9, 1, NULL);
INSERT INTO `ordershippings` VALUES (10, 10, 1, 'Giao sau giờ hành chính.');
INSERT INTO `ordershippings` VALUES (11, 11, 1, 'Giao sau giờ hành chính.');
INSERT INTO `ordershippings` VALUES (12, 12, 1, 'Giao tại quầy lễ tân.');
INSERT INTO `ordershippings` VALUES (13, 13, 1, NULL);
INSERT INTO `ordershippings` VALUES (14, 14, 1, 'Giao tại cổng KTX.');
INSERT INTO `ordershippings` VALUES (15, 15, 1, 'Gói quà giúp mình nhé.');
INSERT INTO `ordershippings` VALUES (16, 16, 1, 'Giao trong sáng nay.');
INSERT INTO `ordershippings` VALUES (17, 17, 1, 'Nhà có chó dữ, vui lòng gọi trước.');
INSERT INTO `ordershippings` VALUES (18, 22, 1, '');
INSERT INTO `ordershippings` VALUES (19, 23, 1, '');
INSERT INTO `ordershippings` VALUES (20, 24, 1, '');

-- ----------------------------
-- Table structure for productgalleries
-- ----------------------------
DROP TABLE IF EXISTS `productgalleries`;
CREATE TABLE `productgalleries`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `products_id` int NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `products_id`(`products_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10209 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of productgalleries
-- ----------------------------
INSERT INTO `productgalleries` VALUES (1, 1, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-1000xm5-4.png', 2);
INSERT INTO `productgalleries` VALUES (2, 1, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-1000xm5-hk_11_.png', 4);
INSERT INTO `productgalleries` VALUES (3, 1, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-1000xm5-2.png', 6);
INSERT INTO `productgalleries` VALUES (4, 1, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-1000xm5-1.png', 1);
INSERT INTO `productgalleries` VALUES (5, 1, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-1000xm5_1_.png', 5);
INSERT INTO `productgalleries` VALUES (6, 1, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-1000xm5_5_.png', 3);
INSERT INTO `productgalleries` VALUES (7, 2, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/3/_/3_jbl_flip6_front_pink_29503_x1.jpg', 0);
INSERT INTO `productgalleries` VALUES (8, 2, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/j/b/jbl_flip_6_6.png', 0);
INSERT INTO `productgalleries` VALUES (9, 2, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/j/b/jbl_flip_6_5.png', 0);
INSERT INTO `productgalleries` VALUES (10, 2, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/j/b/jbl_flip_6_8.png', 0);
INSERT INTO `productgalleries` VALUES (11, 2, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/o/loa-bluetooth-jbl-6_1_.png', 0);
INSERT INTO `productgalleries` VALUES (12, 2, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/o/loa-bluetooth-jbl-6.png', 0);
INSERT INTO `productgalleries` VALUES (13, 3, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/344793/tai-nghe-bluetooth-true-wireless-rezo-wave-pro-anc-xanh-duong-8-638974188681341038-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (14, 3, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/344793/tai-nghe-bluetooth-true-wireless-rezo-wave-pro-anc-xanh-duong-13-638974188720860755-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (15, 3, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/344793/tai-nghe-bluetooth-true-wireless-rezo-wave-pro-anc-hong-5-638974184016718862-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (16, 3, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/344793/tai-nghe-bluetooth-true-wireless-rezo-wave-pro-anc-hong-3-638974184003070569-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (17, 3, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/344793/tai-nghe-bluetooth-true-wireless-rezo-wave-pro-anc-hong-15-638974184089888176-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (18, 3, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/344793/tai-nghe-bluetooth-true-wireless-rezo-wave-pro-anc-be-8-638974184714659044-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (19, 3, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/344793/tai-nghe-bluetooth-true-wireless-rezo-wave-pro-anc-be-12-638974184741522797-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (20, 4, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/329299/tai-nghe-bluetooth-true-wireless-rezo-k50-den-2-638627076799209187-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (21, 4, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/329299/tai-nghe-bluetooth-true-wireless-rezo-k50-den-3-638627076806435115-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (22, 4, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/329299/tai-nghe-bluetooth-true-wireless-rezo-k50-den-1-638627076792093732-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (23, 4, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/329299/tai-nghe-bluetooth-true-wireless-rezo-k50-den-11-638627076887100869-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (24, 4, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/329299/tai-nghe-bluetooth-true-wireless-rezo-k50-den-13-638627076910991288-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (25, 4, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/329299/tai-nghe-bluetooth-true-wireless-rezo-k50-den-14-638627076918247445-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (26, 5, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330249/tai-nghe-bluetooth-true-wireless-rezo-rz09-anc-trang-1-638635681929043024-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (27, 5, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330249/tai-nghe-bluetooth-true-wireless-rezo-rz09-anc-trang-3-638635681950087781-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (28, 5, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330249/tai-nghe-bluetooth-true-wireless-rezo-rz09-anc-trang-7-638635681982092251-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (29, 5, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330249/tai-nghe-bluetooth-true-wireless-rezo-rz09-anc-trang-13-638635682018030471-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (30, 5, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330249/tai-nghe-bluetooth-true-wireless-rezo-rz09-anc-den-2-638635680823309047-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (31, 5, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330249/tai-nghe-bluetooth-true-wireless-rezo-rz09-anc-den-7-638635680852113475-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (32, 5, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330249/tai-nghe-bluetooth-true-wireless-rezo-rz09-anc-den-11-638635680881398792-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (33, 6, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330711/tai-nghe-bluetooth-true-wireless-rezo-air-5-deluxe-anc-trang-1-638642418916430535-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (34, 6, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330711/tai-nghe-bluetooth-true-wireless-rezo-air-5-deluxe-anc-trang-2-638642418922429241-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (35, 6, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330711/tai-nghe-bluetooth-true-wireless-rezo-air-5-deluxe-anc-trang-3-638642418928950008-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (36, 6, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330711/tai-nghe-bluetooth-true-wireless-rezo-air-5-deluxe-anc-trang-9-638642418966269010-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (37, 6, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330711/tai-nghe-bluetooth-true-wireless-rezo-air-5-deluxe-anc-trang-5-638642418941236821-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (38, 6, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330711/tai-nghe-bluetooth-true-wireless-rezo-air-5-deluxe-anc-trang-6-638642418946795962-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (39, 6, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330711/tai-nghe-bluetooth-true-wireless-rezo-air-5-deluxe-anc-trang-13-638642419000549826-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (40, 6, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330711/tai-nghe-bluetooth-true-wireless-rezo-air-5-deluxe-anc-trang-11-638642418985852513-750x500.jpg', 0);
INSERT INTO `productgalleries` VALUES (41, 7, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/m/image_1042_2.png', 0);
INSERT INTO `productgalleries` VALUES (42, 7, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-2i-fit_2_.png', 0);
INSERT INTO `productgalleries` VALUES (43, 7, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-2i-fit_3_.png', 0);
INSERT INTO `productgalleries` VALUES (44, 7, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-2i-fit_1_.png', 0);
INSERT INTO `productgalleries` VALUES (45, 7, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-2i-fit_2_.jpg', 0);
INSERT INTO `productgalleries` VALUES (46, 7, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-2i-fit_1_.jpg', 0);
INSERT INTO `productgalleries` VALUES (47, 7, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-2i-fit_5_.jpg', 0);
INSERT INTO `productgalleries` VALUES (48, 8, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-sport-2-open-ear_1_.png', 0);
INSERT INTO `productgalleries` VALUES (49, 8, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-sport-2-open-ear_8_.jpg', 0);
INSERT INTO `productgalleries` VALUES (50, 8, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-sport-2-open-ear_11_.jpg', 0);
INSERT INTO `productgalleries` VALUES (51, 8, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-sport-2-open-ear_2_.jpg', 0);
INSERT INTO `productgalleries` VALUES (52, 8, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-sport-2-open-ear_2_.png', 0);
INSERT INTO `productgalleries` VALUES (53, 8, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-sport-2-open-ear_6_.png', 0);
INSERT INTO `productgalleries` VALUES (54, 8, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-sport-2-open-ear_3_.png', 0);
INSERT INTO `productgalleries` VALUES (55, 10, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e11_2_.png', 0);
INSERT INTO `productgalleries` VALUES (56, 10, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e11_5_.png', 0);
INSERT INTO `productgalleries` VALUES (57, 10, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e11_4_.png', 0);
INSERT INTO `productgalleries` VALUES (58, 10, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e11-ksp.png', 0);
INSERT INTO `productgalleries` VALUES (59, 9, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e17_7_.png', 0);
INSERT INTO `productgalleries` VALUES (60, 9, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e17_5_.png', 0);
INSERT INTO `productgalleries` VALUES (61, 9, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e17_3_.png', 0);
INSERT INTO `productgalleries` VALUES (62, 9, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e17_13_.png', 0);
INSERT INTO `productgalleries` VALUES (63, 9, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e17_15_.png', 0);
INSERT INTO `productgalleries` VALUES (64, 9, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e17_12_.png', 0);
INSERT INTO `productgalleries` VALUES (65, 11, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-encok-d02-pro_14_.png', 0);
INSERT INTO `productgalleries` VALUES (66, 11, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-encok-d02-pro_13_.png', 0);
INSERT INTO `productgalleries` VALUES (67, 11, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-encok-d02-pro_16_.png', 0);
INSERT INTO `productgalleries` VALUES (68, 11, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-encok-d02-pro_18_.png', 0);
INSERT INTO `productgalleries` VALUES (69, 11, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-encok-d02-pro_22_.png', 0);
INSERT INTO `productgalleries` VALUES (70, 11, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-encok-d02-pro_20_.png', 0);
INSERT INTO `productgalleries` VALUES (71, 11, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-encok-d02-pro_19_.png', 0);
INSERT INTO `productgalleries` VALUES (72, 12, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bass-35-max_3_.png', 0);
INSERT INTO `productgalleries` VALUES (73, 12, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bass-35-max_4_.png', 0);
INSERT INTO `productgalleries` VALUES (74, 12, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bass-35-max.png', 0);
INSERT INTO `productgalleries` VALUES (75, 12, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bass-35-max_5_.png', 0);
INSERT INTO `productgalleries` VALUES (76, 13, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-bluetooth-baseus-bass-bh1_5_.jpg', 0);
INSERT INTO `productgalleries` VALUES (77, 13, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-bluetooth-baseus-bass-bh1_4_.jpg', 0);
INSERT INTO `productgalleries` VALUES (78, 13, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-bluetooth-baseus-bass-bh1_2_.jpg', 0);
INSERT INTO `productgalleries` VALUES (79, 13, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-bluetooth-baseus-bass-bh1_8_.jpg', 0);
INSERT INTO `productgalleries` VALUES (80, 13, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-bluetooth-baseus-bass-bh1_3_.jpg', 0);
INSERT INTO `productgalleries` VALUES (81, 13, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:58:58/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-bluetooth-baseus-bass-bh1_9_.jpg', 0);
INSERT INTO `productgalleries` VALUES (82, 14, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-wm02_1__1.png', 0);
INSERT INTO `productgalleries` VALUES (83, 14, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-wm02_2__1.png', 0);
INSERT INTO `productgalleries` VALUES (84, 14, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-wm02_3__1.png', 0);
INSERT INTO `productgalleries` VALUES (85, 14, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-wm02-01.png', 0);
INSERT INTO `productgalleries` VALUES (86, 15, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e16_2_.png', 0);
INSERT INTO `productgalleries` VALUES (87, 15, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e16_3_.png', 0);
INSERT INTO `productgalleries` VALUES (88, 15, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e16-ksp.png', 0);
INSERT INTO `productgalleries` VALUES (89, 16, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-baseus-bowie-m2s-ultra_2_.png', 0);
INSERT INTO `productgalleries` VALUES (90, 16, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-baseus-bowie-m2s-ultra_5_.png', 0);
INSERT INTO `productgalleries` VALUES (91, 16, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-baseus-bowie-m2s-ultra_3_.png', 0);
INSERT INTO `productgalleries` VALUES (92, 16, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-baseus-bowie-m2s-ultra_9_.png', 0);
INSERT INTO `productgalleries` VALUES (93, 16, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-baseus-bowie-m2s-ultra_8_.png', 0);
INSERT INTO `productgalleries` VALUES (94, 17, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bowie-h1i_2__1.png', 0);
INSERT INTO `productgalleries` VALUES (95, 17, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bowie-h1i_5_.png', 0);
INSERT INTO `productgalleries` VALUES (96, 17, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bowie-h1i_3__1.png', 0);
INSERT INTO `productgalleries` VALUES (97, 17, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bowie-h1i_4_.png', 0);
INSERT INTO `productgalleries` VALUES (98, 18, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_718_6.png', 0);
INSERT INTO `productgalleries` VALUES (99, 18, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/_/3_629_4.png', 0);
INSERT INTO `productgalleries` VALUES (100, 18, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/2/_/2_690_3.png', 0);
INSERT INTO `productgalleries` VALUES (101, 18, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_7_1_.png', 0);
INSERT INTO `productgalleries` VALUES (102, 18, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_6_1_.png', 0);
INSERT INTO `productgalleries` VALUES (103, 19, 'https://www.lg.com/content/dam/channel/wcms/vn/images/tai-nghe-khong-day/tone-fp5_cvnmllk_eavh_vn_c/gallery/DZ-01.jpg?w=800', 0);
INSERT INTO `productgalleries` VALUES (104, 19, 'https://www.lg.com/content/dam/channel/wcms/vn/images/tai-nghe-khong-day/tone-fp5_cvnmllk_eavh_vn_c/gallery/DZ-02.jpg?w=800', 0);
INSERT INTO `productgalleries` VALUES (105, 19, 'https://www.lg.com/content/dam/channel/wcms/vn/images/tai-nghe-khong-day/tone-fp5_cvnmllk_eavh_vn_c/gallery/DZ-04.jpg?w=800', 0);
INSERT INTO `productgalleries` VALUES (106, 19, 'https://www.lg.com/content/dam/channel/wcms/vn/images/tai-nghe-khong-day/tone-fp5_cvnmllk_eavh_vn_c/gallery/DZ-10.jpg?w=800', 0);
INSERT INTO `productgalleries` VALUES (107, 19, 'https://www.lg.com/content/dam/channel/wcms/vn/images/tai-nghe-khong-day/tone-fp5_cvnmllk_eavh_vn_c/gallery/DZ-13.jpg?w=800', 0);
INSERT INTO `productgalleries` VALUES (108, 19, 'https://www.lg.com/content/dam/channel/wcms/vn/images/tai-nghe-khong-day/tone-fp5_cvnmllk_eavh_vn_c/gallery/DZ-15.jpg?w=800', 0);
INSERT INTO `productgalleries` VALUES (109, 21, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/6/1600_2_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (110, 21, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/6/1600_4_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (111, 21, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/6/1600_7_1_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (112, 21, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/2/0/2087224-removebg-preview.png', 0);
INSERT INTO `productgalleries` VALUES (113, 21, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/g/lg_tone_free_fn6_1.png', 0);
INSERT INTO `productgalleries` VALUES (114, 21, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/g/lg_tone_free_fn6_2.png', 0);
INSERT INTO `productgalleries` VALUES (115, 20, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/_/0/_0003_dz-01.jpg', 0);
INSERT INTO `productgalleries` VALUES (116, 20, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-lg-tone-free-fp9.jpg', 0);
INSERT INTO `productgalleries` VALUES (117, 20, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/_/0/_0001_dz-13_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (118, 20, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/_/0/_0002_dz-03.jpg', 0);
INSERT INTO `productgalleries` VALUES (119, 20, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/_/0/_0000_dz-12.jpg', 0);
INSERT INTO `productgalleries` VALUES (120, 20, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/_/0/_0004_dz-06_2.jpg', 0);
INSERT INTO `productgalleries` VALUES (121, 22, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/_/0/_0004_dz-06_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (122, 22, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-lg-tone-free-fp8-3_2.jpg', 0);
INSERT INTO `productgalleries` VALUES (123, 22, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-lg-tone-free-fp8.jpg', 0);
INSERT INTO `productgalleries` VALUES (124, 22, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-lg-tone-free-fp8-4.jpg', 0);
INSERT INTO `productgalleries` VALUES (125, 22, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-lg-tone-free-fp8-6.jpg', 0);
INSERT INTO `productgalleries` VALUES (126, 23, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-havit-tw-931-den.png', 0);
INSERT INTO `productgalleries` VALUES (127, 23, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-havit-tw-931_1_.png', 0);
INSERT INTO `productgalleries` VALUES (128, 23, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-havit-tw-931_2_.png', 0);
INSERT INTO `productgalleries` VALUES (129, 23, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-havit-tw-931_6__1.png', 0);
INSERT INTO `productgalleries` VALUES (130, 23, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-havit-tw-931_2__2_1.png', 0);
INSERT INTO `productgalleries` VALUES (131, 24, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/5/_/5_179.jpg', 0);
INSERT INTO `productgalleries` VALUES (132, 24, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/e/beigi.png', 0);
INSERT INTO `productgalleries` VALUES (133, 24, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/u/butter.png', 0);
INSERT INTO `productgalleries` VALUES (134, 24, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/4/_/4_209.jpg', 0);
INSERT INTO `productgalleries` VALUES (135, 24, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/_/3_251.jpg', 0);
INSERT INTO `productgalleries` VALUES (136, 83, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-stage-320_6_.png?_gl=1*nw21rp*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4MzY1OTAkajIzJGwwJGgyOT', 0);
INSERT INTO `productgalleries` VALUES (137, 83, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-stage-320_5_.png', 0);
INSERT INTO `productgalleries` VALUES (138, 83, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-stage-320_8_.png', 0);
INSERT INTO `productgalleries` VALUES (139, 83, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-stage-320_9_.png', 0);
INSERT INTO `productgalleries` VALUES (140, 83, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-stage-320_10_.png', 0);
INSERT INTO `productgalleries` VALUES (141, 83, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-stage-320_13_.png', 0);
INSERT INTO `productgalleries` VALUES (142, 83, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-stage-320_14_.png', 0);
INSERT INTO `productgalleries` VALUES (143, 83, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl-partybox-stage-320-7.jpg', 0);
INSERT INTO `productgalleries` VALUES (144, 83, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl-partybox-stage-320-8.jpg', 0);
INSERT INTO `productgalleries` VALUES (146, 83, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl-partybox-stage-320-3.jpg', 0);
INSERT INTO `productgalleries` VALUES (147, 83, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl-partybox-stage-320-1.png?_gl=1*gt8cvu*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4Mzc3OTYkajU3JGwwJGgyOTAwMTQzNTI.', 0);
INSERT INTO `productgalleries` VALUES (148, 84, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_partybox_310_6.png?_gl=1*1cbprt8*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4MzcxMzkkajMwJGwwJGgyOTAwMTQzNTI.', 0);
INSERT INTO `productgalleries` VALUES (149, 84, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_partybox_310_5.png', 0);
INSERT INTO `productgalleries` VALUES (150, 84, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_partybox_310_7.png', 0);
INSERT INTO `productgalleries` VALUES (151, 84, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_partybox_310_8.png', 0);
INSERT INTO `productgalleries` VALUES (152, 84, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_partybox_310_9.png', 0);
INSERT INTO `productgalleries` VALUES (153, 84, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-310_3_.png', 0);
INSERT INTO `productgalleries` VALUES (154, 84, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-310_2_.png', 0);
INSERT INTO `productgalleries` VALUES (155, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/b/bb4.png?_gl=1*ctda4o*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4Mzg3MzEkajYwJGwwJGgyOTAwMTQzNTI.', 0);
INSERT INTO `productgalleries` VALUES (156, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/b/bb5.png', 0);
INSERT INTO `productgalleries` VALUES (157, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/b/bb3.png', 0);
INSERT INTO `productgalleries` VALUES (158, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/b/bb8.png', 0);
INSERT INTO `productgalleries` VALUES (159, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-boombox-4_26_.png', 0);
INSERT INTO `productgalleries` VALUES (160, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-boombox-4_15_.png', 0);
INSERT INTO `productgalleries` VALUES (161, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-boombox-4_13_.png', 0);
INSERT INTO `productgalleries` VALUES (162, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-boombox-4_12_.png', 0);
INSERT INTO `productgalleries` VALUES (163, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-boombox-4_11_.png', 0);
INSERT INTO `productgalleries` VALUES (164, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-boombox-4_24_.png?_gl=1*1dpgj9o*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4Mzg3OTMkajYwJGwwJGgyOTAwMTQzN', 0);
INSERT INTO `productgalleries` VALUES (165, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-boombox-4_25_.png', 0);
INSERT INTO `productgalleries` VALUES (166, 86, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-500_10_.png', 0);
INSERT INTO `productgalleries` VALUES (167, 86, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-500_8_.png', 0);
INSERT INTO `productgalleries` VALUES (168, 86, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-500_5_.png', 0);
INSERT INTO `productgalleries` VALUES (169, 86, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-500_7_.png', 0);
INSERT INTO `productgalleries` VALUES (170, 86, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-500-ksp.png', 0);
INSERT INTO `productgalleries` VALUES (171, 86, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-500_4_.png', 0);
INSERT INTO `productgalleries` VALUES (172, 86, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-500_3_.png', 0);
INSERT INTO `productgalleries` VALUES (173, 86, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-500_2_.png', 0);
INSERT INTO `productgalleries` VALUES (174, 87, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/e/0/e0.png?_gl=1*l3eexu*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4Mzk2OTUkajUxJGwwJGgyOTAwMTQzNTI.', 0);
INSERT INTO `productgalleries` VALUES (175, 87, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/e/1/e1.png', 0);
INSERT INTO `productgalleries` VALUES (176, 87, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/e/2/e2.png', 0);
INSERT INTO `productgalleries` VALUES (177, 87, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/e/3/e3_3.png', 0);
INSERT INTO `productgalleries` VALUES (178, 87, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/e/4/e4.png', 0);
INSERT INTO `productgalleries` VALUES (179, 87, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/_/2_989359-2048x1365.jpg', 0);
INSERT INTO `productgalleries` VALUES (180, 87, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_partybox_encore_essential_2_0_.jpg', 0);
INSERT INTO `productgalleries` VALUES (181, 87, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_partybox_encore_essential_2.jpg', 0);
INSERT INTO `productgalleries` VALUES (182, 88, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/4/_/4_114_1.png', 0);
INSERT INTO `productgalleries` VALUES (183, 88, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/_/2_135_2.png', 0);
INSERT INTO `productgalleries` VALUES (184, 88, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/5/_/5_102_1.png', 0);
INSERT INTO `productgalleries` VALUES (185, 88, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-encore-essential_3__1.png', 0);
INSERT INTO `productgalleries` VALUES (186, 88, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-encore-essential.png', 0);
INSERT INTO `productgalleries` VALUES (187, 88, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-encore-essential_1__1.png', 0);
INSERT INTO `productgalleries` VALUES (188, 89, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-horizon_1.png?_gl=1*bte2cf*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4NDExMDckajYwJGwwJGgyOTAwMTQzNTI.', 0);
INSERT INTO `productgalleries` VALUES (189, 89, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-horizon-04.png', 0);
INSERT INTO `productgalleries` VALUES (190, 89, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-horizon-03.png', 0);
INSERT INTO `productgalleries` VALUES (191, 89, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-horizon-02.png', 0);
INSERT INTO `productgalleries` VALUES (192, 89, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-horizon-ksp.png?_gl=1*nk865v*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4NDExMDckajYwJGwwJGgyOTAwMTQzNTI.', 0);
INSERT INTO `productgalleries` VALUES (193, 89, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Loa/JBL/loa-jbl-horizon-3.jpg', 0);
INSERT INTO `productgalleries` VALUES (194, 89, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Loa/JBL/loa-jbl-horizon-1.jpg', 0);
INSERT INTO `productgalleries` VALUES (195, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_hero_black_v2_0245_x4.jpg?_gl=1*3jlb6g*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4NDIwNDkkajYwJGwwJGgyOTAwMTQ', 0);
INSERT INTO `productgalleries` VALUES (196, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_back_black_v3_0265_x1.jpg', 0);
INSERT INTO `productgalleries` VALUES (197, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_top_black_v2_0280_x1.jpg', 0);
INSERT INTO `productgalleries` VALUES (198, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_right_black_v2_0267_x2.jpg', 0);
INSERT INTO `productgalleries` VALUES (199, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_bottom_black_v2_0281_x2.jpg', 0);
INSERT INTO `productgalleries` VALUES (200, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_top_down_black_v2_0276_x2.jpg', 0);
INSERT INTO `productgalleries` VALUES (201, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_hero_grey_v2_0240_x5.jpg', 0);
INSERT INTO `productgalleries` VALUES (202, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_back_grey_v2_0263_x1.jpg', 0);
INSERT INTO `productgalleries` VALUES (203, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_bottom_grey_v2_0282_x2.jpg', 0);
INSERT INTO `productgalleries` VALUES (204, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_top_down_grey_v2_0277_x4.jpg', 0);
INSERT INTO `productgalleries` VALUES (205, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_right_grey_v20268_x3.jpg', 0);
INSERT INTO `productgalleries` VALUES (206, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_top_grey_v2_0279_x3.jpg', 0);
INSERT INTO `productgalleries` VALUES (207, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/6/_/6_200_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (208, 90, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/h/o/horizon2_livestyle_image.jpg', 0);
INSERT INTO `productgalleries` VALUES (209, 90, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Loa/JBL/Horizon/loa-bluetooth-jbl-horizon-2-1.jpg', 0);
INSERT INTO `productgalleries` VALUES (210, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-xam_2_.png', 0);
INSERT INTO `productgalleries` VALUES (211, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-xam_8_.png', 0);
INSERT INTO `productgalleries` VALUES (212, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-xam_4_.png', 0);
INSERT INTO `productgalleries` VALUES (213, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-xam_6_.png', 0);
INSERT INTO `productgalleries` VALUES (214, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-xam_5_.png', 0);
INSERT INTO `productgalleries` VALUES (215, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-xam_7_.png', 0);
INSERT INTO `productgalleries` VALUES (216, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-xam_9_.png', 0);
INSERT INTO `productgalleries` VALUES (217, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-den_2_.png', 0);
INSERT INTO `productgalleries` VALUES (218, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-den_5_.png', 0);
INSERT INTO `productgalleries` VALUES (219, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-den_4_.png', 0);
INSERT INTO `productgalleries` VALUES (220, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-den_6_.png', 0);
INSERT INTO `productgalleries` VALUES (221, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-den_8_.png', 0);
INSERT INTO `productgalleries` VALUES (222, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-den_7_.png', 0);
INSERT INTO `productgalleries` VALUES (223, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-den_9_.png', 0);
INSERT INTO `productgalleries` VALUES (224, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3_3_.png', 0);
INSERT INTO `productgalleries` VALUES (225, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3_1_.png', 0);
INSERT INTO `productgalleries` VALUES (226, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3_2_.png', 0);
INSERT INTO `productgalleries` VALUES (227, 91, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3.png', 0);
INSERT INTO `productgalleries` VALUES (228, 92, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-flip-7_16_.png', 0);
INSERT INTO `productgalleries` VALUES (229, 92, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-flip-7_24_.png', 0);
INSERT INTO `productgalleries` VALUES (230, 92, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-flip-7_14_.png', 0);
INSERT INTO `productgalleries` VALUES (231, 92, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-flip-7_4_.png?_gl=1*1haphu3*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4NDMxOTAkajE5JGwwJGgyOTAwMTQzNTI.', 0);
INSERT INTO `productgalleries` VALUES (232, 92, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-flip-7_12_.png', 0);
INSERT INTO `productgalleries` VALUES (233, 92, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-flip-7_2_.png', 0);
INSERT INTO `productgalleries` VALUES (234, 92, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-flip-7_9_.png', 0);
INSERT INTO `productgalleries` VALUES (235, 92, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-flip-7_40_.png', 0);
INSERT INTO `productgalleries` VALUES (236, 92, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl-flip-7-3.png', 0);
INSERT INTO `productgalleries` VALUES (237, 92, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl-flip-7-5.png', 0);
INSERT INTO `productgalleries` VALUES (238, 93, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/6/_/6_jbl_go_essential_detail_black_31543_x1.png', 0);
INSERT INTO `productgalleries` VALUES (239, 93, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_go_essential_left_black_31566_x1.png', 0);
INSERT INTO `productgalleries` VALUES (240, 93, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_go_essential_right_open_black_31599_x1.png', 0);
INSERT INTO `productgalleries` VALUES (241, 93, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_go_essential_bottom_black_31517_x1.pngg', 0);
INSERT INTO `productgalleries` VALUES (242, 93, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-essential_1.png', 0);
INSERT INTO `productgalleries` VALUES (243, 93, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-essential_2_.png', 0);
INSERT INTO `productgalleries` VALUES (244, 94, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-essential-2_11_.png', 0);
INSERT INTO `productgalleries` VALUES (245, 94, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-essential-2_4_.png', 0);
INSERT INTO `productgalleries` VALUES (246, 94, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-essential-2_9_.png', 0);
INSERT INTO `productgalleries` VALUES (247, 94, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-essential-2_7_.png', 0);
INSERT INTO `productgalleries` VALUES (248, 94, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-essential-2_6_.png', 0);
INSERT INTO `productgalleries` VALUES (249, 94, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-essential-2_1_.png', 0);
INSERT INTO `productgalleries` VALUES (250, 95, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-go-3-blue_1.png', 0);
INSERT INTO `productgalleries` VALUES (251, 95, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-3_4_.png', 0);
INSERT INTO `productgalleries` VALUES (252, 95, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-3_1.png', 0);
INSERT INTO `productgalleries` VALUES (253, 95, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-3_5_.png', 0);
INSERT INTO `productgalleries` VALUES (254, 95, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-3_1_.png', 0);
INSERT INTO `productgalleries` VALUES (255, 95, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-3_2_.png', 0);
INSERT INTO `productgalleries` VALUES (256, 96, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-4_9_.png', 0);
INSERT INTO `productgalleries` VALUES (257, 96, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-4_10_.png', 0);
INSERT INTO `productgalleries` VALUES (258, 96, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-4_13_.png', 0);
INSERT INTO `productgalleries` VALUES (259, 96, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-4-_2_.png', 0);
INSERT INTO `productgalleries` VALUES (260, 96, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-4-_1_.png', 0);
INSERT INTO `productgalleries` VALUES (261, 96, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-4-.png', 0);
INSERT INTO `productgalleries` VALUES (262, 97, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/d/s/dsc_4620-1.jpg', 0);
INSERT INTO `productgalleries` VALUES (263, 97, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/1/21_13_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (264, 97, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/1/11_71_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (265, 97, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/2/12_53_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (266, 97, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/accessories/speaker/Loa-JBL-Clip3-3.jpg', 0);
INSERT INTO `productgalleries` VALUES (267, 97, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/accessories/speaker/Loa-JBL-Clip3-4.jpg', 0);
INSERT INTO `productgalleries` VALUES (268, 98, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_clip_4_6.png', 0);
INSERT INTO `productgalleries` VALUES (269, 98, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_clip_4_14.png', 0);
INSERT INTO `productgalleries` VALUES (270, 98, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_clip_4_2.png', 0);
INSERT INTO `productgalleries` VALUES (271, 98, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_clip_4_3.png', 0);
INSERT INTO `productgalleries` VALUES (272, 98, 'https://cdn-media.sforum.vn/storage/app/media/wp-content/uploads/2021/02/JBL-Clip4-9.jpg', 0);
INSERT INTO `productgalleries` VALUES (273, 98, 'https://cellphones.com.vn/sforum/wp-content/uploads/2021/02/JBL-Clip4-11.jpg', 0);
INSERT INTO `productgalleries` VALUES (274, 99, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-clip-5-_10_.png', 0);
INSERT INTO `productgalleries` VALUES (275, 99, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-clip-5-_11_.png', 0);
INSERT INTO `productgalleries` VALUES (276, 99, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-clip-5-ksp.png', 0);
INSERT INTO `productgalleries` VALUES (277, 99, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-clip-5-_1_.png', 0);
INSERT INTO `productgalleries` VALUES (278, 99, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Loa/JBL/Clip/loa-bluetooth-jbl-clip-5-1.jpg', 0);
INSERT INTO `productgalleries` VALUES (279, 99, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Loa/JBL/loa-bluetooth-jbl-clip-5-4.jpg', 0);
INSERT INTO `productgalleries` VALUES (280, 100, ' https://cdn2.cellphones.com.vn/x/media/catalog/product/6/1/61tlmjhyfdl._sl1000_.jpg', 0);
INSERT INTO `productgalleries` VALUES (281, 100, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/6/1/61jpckwyryl._sl1000_.jpg', 0);
INSERT INTO `productgalleries` VALUES (282, 100, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/6/1/61pmvjdiojl._sl1000_.jpg', 0);
INSERT INTO `productgalleries` VALUES (283, 100, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-charge-4-ksp.png', 0);
INSERT INTO `productgalleries` VALUES (284, 100, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Loa/JBL/Charge/loa-bluetooth-jbl-charge-4-4.jpg', 0);
INSERT INTO `productgalleries` VALUES (285, 100, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Loa/JBL/Charge/loa-bluetooth-jbl-charge-4-2.jpg', 0);
INSERT INTO `productgalleries` VALUES (286, 101, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_charge_5_2.png', 0);
INSERT INTO `productgalleries` VALUES (287, 101, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_charge_5_3.png', 0);
INSERT INTO `productgalleries` VALUES (288, 101, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_charge_5_4.png', 0);
INSERT INTO `productgalleries` VALUES (289, 101, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_charge_5_5.png', 0);
INSERT INTO `productgalleries` VALUES (290, 101, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-charge-5-ksp.png', 0);
INSERT INTO `productgalleries` VALUES (291, 101, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-charge-5-7_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (292, 102, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl-charge-6-bl-3.png', 0);
INSERT INTO `productgalleries` VALUES (293, 102, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl-charge-6-bl-1.png', 0);
INSERT INTO `productgalleries` VALUES (294, 102, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl-charge-6-bl-2.png', 0);
INSERT INTO `productgalleries` VALUES (295, 102, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-charge-6_5_.png?_gl=1*r1es5w*_gcl_au*MTI1ODQyODgyMC4xNzY0MDU3NTM3*_ga*MjI3MzQzMjQ0LjE3NjQwNTc1Mzc.*_ga_QLK8WFHNK9*czE3NjQ5NDQzNjckbzMkZzEkdDE3NjQ5NTIxMzkkajYwJGwwJGgxMDIzNjcyMDE4', 0);
INSERT INTO `productgalleries` VALUES (296, 102, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-charge-6-4_1.png', 0);
INSERT INTO `productgalleries` VALUES (297, 102, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-charge-6-1_1.png', 0);
INSERT INTO `productgalleries` VALUES (298, 103, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_pulse_4_5.png', 0);
INSERT INTO `productgalleries` VALUES (299, 103, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_pulse_4_3.png', 0);
INSERT INTO `productgalleries` VALUES (300, 103, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_pulse_4_2.png', 0);
INSERT INTO `productgalleries` VALUES (301, 103, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_pulse_4_1.png', 0);
INSERT INTO `productgalleries` VALUES (302, 103, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_pulse_4_6.png', 0);
INSERT INTO `productgalleries` VALUES (303, 103, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_pulse_4_7.png', 0);
INSERT INTO `productgalleries` VALUES (304, 104, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/_/2_jbl_pulse_5_3_4_left_34343_x2_1.png', 0);
INSERT INTO `productgalleries` VALUES (305, 104, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_pulse_5_top_down_x3_1.png', 0);
INSERT INTO `productgalleries` VALUES (306, 104, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/5/_/5_jbl_pulse_5_back__1_x3_1.png', 0);
INSERT INTO `productgalleries` VALUES (307, 104, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-pulse-5_2_.png', 0);
INSERT INTO `productgalleries` VALUES (308, 104, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-pulse-5_1_.png', 0);
INSERT INTO `productgalleries` VALUES (309, 104, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-pulse-5_3_.png', 0);
INSERT INTO `productgalleries` VALUES (310, 105, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-xtreme-3-ksp.png', 0);
INSERT INTO `productgalleries` VALUES (311, 105, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-xtreme-3_1_.png', 0);
INSERT INTO `productgalleries` VALUES (312, 105, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-xtreme-3_2_.png', 0);
INSERT INTO `productgalleries` VALUES (313, 105, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/accessories/loa/Bluetooth-JBL-Xtreme-3.jpg', 0);
INSERT INTO `productgalleries` VALUES (314, 105, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/accessories/loa/Bluetooth-JBL-Xtreme-3-2.jpg', 0);
INSERT INTO `productgalleries` VALUES (315, 105, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/accessories/loa/Bluetooth-JBL-Xtreme-3-3.jpg', 0);
INSERT INTO `productgalleries` VALUES (316, 106, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-xtreme-4_2_.png', 0);
INSERT INTO `productgalleries` VALUES (317, 106, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-xtreme-4_3_.png', 0);
INSERT INTO `productgalleries` VALUES (318, 106, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-xtreme-4_7_.png', 0);
INSERT INTO `productgalleries` VALUES (319, 106, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-xtreme-4_5_.png', 0);
INSERT INTO `productgalleries` VALUES (320, 106, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-xtreme-4-spa.png', 0);
INSERT INTO `productgalleries` VALUES (321, 106, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Loa/JBL/loa-bluetooth-jbl-xtreme-4-2_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (322, 107, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-di-dong-jbl-boombox-2-6.jpg', 0);
INSERT INTO `productgalleries` VALUES (323, 107, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-di-dong-jbl-boombox-2-4.jpg', 0);
INSERT INTO `productgalleries` VALUES (324, 107, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-di-dong-jbl-boombox-2-7.jpg', 0);
INSERT INTO `productgalleries` VALUES (325, 107, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-di-dong-jbl-boombox-2-5.jpg', 0);
INSERT INTO `productgalleries` VALUES (326, 107, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-di-dong-jbl-boombox-2-1.jpg', 0);
INSERT INTO `productgalleries` VALUES (327, 107, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-boombox-2-0.png', 0);
INSERT INTO `productgalleries` VALUES (328, 108, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_boombox_3_top_down_black_33246_x2.png?_gl=1*vh2a27*_gcl_au*MTI1ODQyODgyMC4xNzY0MDU3NTM3*_ga*MjI3MzQzMjQ0LjE3NjQwNTc1Mzc.*_ga_QLK8WFHNK9*czE3NjQ5NDQzNjckbzMkZzEkdDE3NjQ5NTU2NTgkajYwJGwwJGgxMDIz', 0);
INSERT INTO `productgalleries` VALUES (329, 108, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/4/_/4_jbl_boombox_3_top_black_33253_x2.png', 0);
INSERT INTO `productgalleries` VALUES (330, 108, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/3/_/3_jbl_boombox_3_back_33206_x2.png', 0);
INSERT INTO `productgalleries` VALUES (331, 108, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/5/_/5_jbl_boombox_3_right_black_33243_x2.png', 0);
INSERT INTO `productgalleries` VALUES (332, 108, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_boombox_3_beach_1_x1_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (333, 108, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_boombox_3_16mm_2_1.jpg', 0);
INSERT INTO `productgalleries` VALUES (334, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/b/bb4.png?_gl=1*ctda4o*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4Mzg3MzEkajYwJGwwJGgyOTAwMTQzNTI..', 0);
INSERT INTO `productgalleries` VALUES (336, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/b/bb7.png', 0);
INSERT INTO `productgalleries` VALUES (339, 85, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/b/bb1.png', 0);
INSERT INTO `productgalleries` VALUES (340, 109, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/5/25_1_28.jpg', 0);
INSERT INTO `productgalleries` VALUES (341, 109, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/4/24_43.jpg', 0);
INSERT INTO `productgalleries` VALUES (342, 109, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/7/27_1_25.jpg', 0);
INSERT INTO `productgalleries` VALUES (343, 109, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/6/26_1_28.jpg', 0);
INSERT INTO `productgalleries` VALUES (344, 109, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-710_2_.png', 0);
INSERT INTO `productgalleries` VALUES (345, 109, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-710_1_.png', 0);
INSERT INTO `productgalleries` VALUES (346, 110, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-520_15_.png', 0);
INSERT INTO `productgalleries` VALUES (347, 110, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-520_14_.png', 0);
INSERT INTO `productgalleries` VALUES (348, 110, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-520_12_.png', 0);
INSERT INTO `productgalleries` VALUES (349, 110, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-520_10_.png', 0);
INSERT INTO `productgalleries` VALUES (350, 110, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-520_1_.png', 0);
INSERT INTO `productgalleries` VALUES (351, 110, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-520_18_.png', 0);
INSERT INTO `productgalleries` VALUES (352, 111, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-300_9_.png', 0);
INSERT INTO `productgalleries` VALUES (353, 111, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-300_8_.png', 0);
INSERT INTO `productgalleries` VALUES (354, 111, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-300_7_.png', 0);
INSERT INTO `productgalleries` VALUES (355, 111, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-300_5_.png', 0);
INSERT INTO `productgalleries` VALUES (356, 111, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-300_2_.png', 0);
INSERT INTO `productgalleries` VALUES (357, 111, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-300_3_.png', 0);
INSERT INTO `productgalleries` VALUES (358, 26, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-havit-life-04t-tw888-_4_.png', 0);
INSERT INTO `productgalleries` VALUES (359, 26, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-havit-life-04t-tw888_2__1.png', 0);
INSERT INTO `productgalleries` VALUES (360, 26, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-havit-life-04t-tw888-.png', 0);
INSERT INTO `productgalleries` VALUES (361, 26, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-havit-life-04t-tw888_1_.png', 0);
INSERT INTO `productgalleries` VALUES (362, 26, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-havit-life-04t-tw888_3_.png', 0);
INSERT INTO `productgalleries` VALUES (363, 26, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-havit-life-04t-tw888-_1_.png', 0);
INSERT INTO `productgalleries` VALUES (364, 27, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-havit-h619bt-_1__1.png', 0);
INSERT INTO `productgalleries` VALUES (365, 27, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-havit-h619bt-_2__1.png', 0);
INSERT INTO `productgalleries` VALUES (366, 27, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-havit-h619bt-0_2_.png', 0);
INSERT INTO `productgalleries` VALUES (367, 27, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-havit-h619bt-0_3_.png', 0);
INSERT INTO `productgalleries` VALUES (368, 27, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-havit-h619bt-0_1_.png', 0);
INSERT INTO `productgalleries` VALUES (369, 28, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-co-day-havit-h2002e_18_.png', 0);
INSERT INTO `productgalleries` VALUES (370, 28, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-co-day-havit-h2002e_4_.png', 0);
INSERT INTO `productgalleries` VALUES (371, 28, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-co-day-havit-h2002e_3_.png', 0);
INSERT INTO `productgalleries` VALUES (372, 28, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-co-day-havit-h2002e_2_.png', 0);
INSERT INTO `productgalleries` VALUES (373, 28, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-co-day-havit-h2002e_12_.png', 0);
INSERT INTO `productgalleries` VALUES (374, 28, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-co-day-havit-h2002e_14_.png', 0);
INSERT INTO `productgalleries` VALUES (375, 28, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-co-day-havit-h2002e_15_.png', 0);
INSERT INTO `productgalleries` VALUES (376, 28, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-co-day-havit-h2002e_16_.png', 0);
INSERT INTO `productgalleries` VALUES (377, 29, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-sony-wf-c510_16_.png', 0);
INSERT INTO `productgalleries` VALUES (378, 29, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:58:58/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-sony-wf-c510_17_.png', 0);
INSERT INTO `productgalleries` VALUES (379, 29, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:58:58/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-sony-wf-c510_21_.png', 0);
INSERT INTO `productgalleries` VALUES (381, 29, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:58:58/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-sony-wf-c510_5_.png', 0);
INSERT INTO `productgalleries` VALUES (382, 30, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/_/1_75_35.jpg', 0);
INSERT INTO `productgalleries` VALUES (383, 30, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/4/_/4_45_26.jpg', 0);
INSERT INTO `productgalleries` VALUES (384, 30, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/3/_/3_60_25.jpg', 0);
INSERT INTO `productgalleries` VALUES (385, 30, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-gaming-sony-inzone-h3-den_2_.jpg', 0);
INSERT INTO `productgalleries` VALUES (386, 31, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/w/h/wh-ch720_black05_m.png', 0);
INSERT INTO `productgalleries` VALUES (387, 31, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/w/h/wh-ch720_black06_m.png', 0);
INSERT INTO `productgalleries` VALUES (388, 31, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/o/sony-wh-ch720n-b.png', 0);
INSERT INTO `productgalleries` VALUES (389, 31, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/o/sony-wh-ch720n-p-3.png', 0);
INSERT INTO `productgalleries` VALUES (390, 31, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/o/sony-wh-ch720n-p-4.png', 0);
INSERT INTO `productgalleries` VALUES (391, 31, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/w/h/wh-ch720_black07_m.png', 0);
INSERT INTO `productgalleries` VALUES (392, 31, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/o/sony-wh-ch720n-p-5.png', 0);
INSERT INTO `productgalleries` VALUES (393, 32, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/o/sony-wf-c710n-7.png', 0);
INSERT INTO `productgalleries` VALUES (394, 32, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/o/sony-wf-c710n.png', 0);
INSERT INTO `productgalleries` VALUES (395, 32, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/o/sony-wf-c710n-4.png', 0);
INSERT INTO `productgalleries` VALUES (396, 32, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/o/sony-wf-c710n-8.png', 0);
INSERT INTO `productgalleries` VALUES (397, 33, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-sony-linkbuds-fit_3_.jpg', 0);
INSERT INTO `productgalleries` VALUES (398, 33, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-sony-linkbuds-fit_6_.jpg', 0);
INSERT INTO `productgalleries` VALUES (399, 33, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-sony-linkbuds-fit_8_.jpg', 0);
INSERT INTO `productgalleries` VALUES (400, 33, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-sony-linkbuds-fit_4_.jpg', 0);
INSERT INTO `productgalleries` VALUES (401, 33, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/n/sn2.png', 0);
INSERT INTO `productgalleries` VALUES (402, 33, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-sony-linkbuds-fit_1_.jpg', 0);
INSERT INTO `productgalleries` VALUES (403, 34, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-sony-inzone-buds_12_.png', 0);
INSERT INTO `productgalleries` VALUES (404, 34, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-sony-inzone-buds_7_.png', 0);
INSERT INTO `productgalleries` VALUES (405, 34, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:58:58/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-sony-inzone-buds_5_.png', 0);
INSERT INTO `productgalleries` VALUES (406, 34, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-sony-inzone-buds_11_.png', 0);
INSERT INTO `productgalleries` VALUES (407, 34, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-sony-inzone-buds_6_.png', 0);
INSERT INTO `productgalleries` VALUES (408, 34, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-sony-inzone-buds_4_.png', 0);
INSERT INTO `productgalleries` VALUES (409, 35, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-inzone-h5_7_.png', 0);
INSERT INTO `productgalleries` VALUES (410, 35, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-inzone-h5_5_.png', 0);
INSERT INTO `productgalleries` VALUES (411, 35, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-inzone-h5_3_.png', 0);
INSERT INTO `productgalleries` VALUES (412, 35, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-inzone-h5_6_.png', 0);
INSERT INTO `productgalleries` VALUES (413, 35, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-inzone-h5_2_.png', 0);
INSERT INTO `productgalleries` VALUES (414, 36, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-ult900n_10_.png', 0);
INSERT INTO `productgalleries` VALUES (415, 36, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-ult900n_11_.png', 0);
INSERT INTO `productgalleries` VALUES (416, 36, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-ult900n_9_.png', 0);
INSERT INTO `productgalleries` VALUES (417, 36, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-ult900n_7_.png', 0);
INSERT INTO `productgalleries` VALUES (418, 36, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-ult900n_17_.png', 0);
INSERT INTO `productgalleries` VALUES (419, 36, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-ult900n_19_.png', 0);
INSERT INTO `productgalleries` VALUES (420, 36, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-ult900n_21_.png', 0);
INSERT INTO `productgalleries` VALUES (421, 37, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/o/sony_wh-1000xm4_5.png', 0);
INSERT INTO `productgalleries` VALUES (422, 37, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/o/sony_wh-1000xm4_1.png', 0);
INSERT INTO `productgalleries` VALUES (423, 37, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:58:58/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/o/sony_wh-1000xm4_3.png', 0);
INSERT INTO `productgalleries` VALUES (424, 37, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/o/sony_wh-1000xm4_2.png', 0);
INSERT INTO `productgalleries` VALUES (425, 37, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/o/sony_wh-1000xm4_4.png', 0);
INSERT INTO `productgalleries` VALUES (426, 38, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-gaming-khong-day-sony-inzone-h9-ii_10_.png', 0);
INSERT INTO `productgalleries` VALUES (427, 38, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-gaming-khong-day-sony-inzone-h9-ii_11_.png', 0);
INSERT INTO `productgalleries` VALUES (428, 38, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-gaming-khong-day-sony-inzone-h9-ii_13_.png', 0);
INSERT INTO `productgalleries` VALUES (429, 38, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-gaming-khong-day-sony-inzone-h9-ii_9_.png', 0);
INSERT INTO `productgalleries` VALUES (430, 39, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods3_3.png', 0);
INSERT INTO `productgalleries` VALUES (431, 39, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/p/h/photo_2021-10-19_00-20-12_4.jpg', 0);
INSERT INTO `productgalleries` VALUES (432, 39, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:58:58/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/i/airpods3_2_1.png', 0);
INSERT INTO `productgalleries` VALUES (433, 40, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/p/h/photo_2021-10-19_00-20-12.jpg', 0);
INSERT INTO `productgalleries` VALUES (435, 40, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods3.png', 0);
INSERT INTO `productgalleries` VALUES (436, 41, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods-4-chong-on-2.png', 0);
INSERT INTO `productgalleries` VALUES (437, 41, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods-4-chong-on-1.png', 0);
INSERT INTO `productgalleries` VALUES (438, 41, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods-4-chong-on-7.png', 0);
INSERT INTO `productgalleries` VALUES (439, 41, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods-4-chong-on-9.png', 0);
INSERT INTO `productgalleries` VALUES (440, 42, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods-4-chong-on-2.png', 0);
INSERT INTO `productgalleries` VALUES (441, 42, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods-4-chong-on-1.png', 0);
INSERT INTO `productgalleries` VALUES (442, 42, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods-4-chong-on-7.png', 0);
INSERT INTO `productgalleries` VALUES (443, 42, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods-4-chong-on-9.png', 0);
INSERT INTO `productgalleries` VALUES (444, 43, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/m/image_2019-03-29_09-12-07_2.jpg', 0);
INSERT INTO `productgalleries` VALUES (445, 43, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/maxresdefault_1_2.jpg', 0);
INSERT INTO `productgalleries` VALUES (446, 43, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/z/azaudio-tai-nghe-bluetooth-apple-airpod-2_2.jpg', 0);
INSERT INTO `productgalleries` VALUES (447, 43, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/g/r/group_169_2.pngg', 0);
INSERT INTO `productgalleries` VALUES (448, 44, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods_pro_2_sep24_pdp_image_position_1__vn-vi.jpg', 0);
INSERT INTO `productgalleries` VALUES (450, 44, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods_pro_2_sep24_pdp_image_position_6__vn-vi.jpg', 0);
INSERT INTO `productgalleries` VALUES (451, 45, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods_pro_3_sep25_pdp_image_position_1__vn-vi_1.png', 0);
INSERT INTO `productgalleries` VALUES (452, 45, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods_pro_3_sep25_pdp_image_position_2__vn-vi_1.png', 0);
INSERT INTO `productgalleries` VALUES (453, 45, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods_pro_3_sep25_pdp_image_position_8__vn-vi_1.png', 0);
INSERT INTO `productgalleries` VALUES (454, 46, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-3_1.png', 0);
INSERT INTO `productgalleries` VALUES (455, 46, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-4.png', 0);
INSERT INTO `productgalleries` VALUES (456, 46, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-1_1.png', 0);
INSERT INTO `productgalleries` VALUES (457, 46, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-2_1.png', 0);
INSERT INTO `productgalleries` VALUES (458, 46, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-8.png', 0);
INSERT INTO `productgalleries` VALUES (459, 47, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-2021_12_.jpg', 0);
INSERT INTO `productgalleries` VALUES (460, 47, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-2021_18_.jpg', 0);
INSERT INTO `productgalleries` VALUES (461, 47, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-2021_2_.jpg', 0);
INSERT INTO `productgalleries` VALUES (462, 47, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-2021_5_.jpg', 0);
INSERT INTO `productgalleries` VALUES (463, 47, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-2021_8_.jpg', 0);
INSERT INTO `productgalleries` VALUES (464, 47, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-2021_7_.jpg', 0);
INSERT INTO `productgalleries` VALUES (465, 47, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-2021_16_.jpg', 0);
INSERT INTO `productgalleries` VALUES (466, 47, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-2021_17_.jpg', 0);
INSERT INTO `productgalleries` VALUES (467, 47, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-2021_1_.png', 0);
INSERT INTO `productgalleries` VALUES (468, 47, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-airpods-max-2021_3_.png', 0);
INSERT INTO `productgalleries` VALUES (470, 48, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-marshall-minor-4-1_3_.png', 0);
INSERT INTO `productgalleries` VALUES (471, 48, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-marshall-minor-4-1_1_.png', 0);
INSERT INTO `productgalleries` VALUES (472, 48, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-marshall-minor-4-1_5_.png', 0);
INSERT INTO `productgalleries` VALUES (473, 48, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/3/_/3_629_19.png', 0);
INSERT INTO `productgalleries` VALUES (474, 48, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/_/2_690_21.png', 0);
INSERT INTO `productgalleries` VALUES (475, 48, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/_/1_718_25.png', 0);
INSERT INTO `productgalleries` VALUES (476, 49, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-marshall-minor-3-3.jpg', 0);
INSERT INTO `productgalleries` VALUES (477, 49, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-marshall-minor-3-4.jpg', 0);
INSERT INTO `productgalleries` VALUES (478, 49, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-marshall-minor-3-1.jpg', 0);
INSERT INTO `productgalleries` VALUES (479, 50, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-major-5-_9_.png', 0);
INSERT INTO `productgalleries` VALUES (480, 50, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-major-5-_11_.png', 0);
INSERT INTO `productgalleries` VALUES (481, 50, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-major-5-_12_.png', 0);
INSERT INTO `productgalleries` VALUES (482, 50, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/m/image_1013.png', 0);
INSERT INTO `productgalleries` VALUES (483, 50, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/m/image_1015.png', 0);
INSERT INTO `productgalleries` VALUES (484, 51, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-major-4_14_.png', 0);
INSERT INTO `productgalleries` VALUES (485, 51, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-major-4_1_.png', 0);
INSERT INTO `productgalleries` VALUES (486, 51, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-major-4_15_.png', 0);
INSERT INTO `productgalleries` VALUES (487, 51, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-major-4_2_.png', 0);
INSERT INTO `productgalleries` VALUES (488, 52, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall_motif_anc_3.png', 0);
INSERT INTO `productgalleries` VALUES (489, 52, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall_motif_anc_7.png', 0);
INSERT INTO `productgalleries` VALUES (490, 52, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall_motif_anc_6.png', 0);
INSERT INTO `productgalleries` VALUES (491, 52, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall_motif_anc_4.png', 0);
INSERT INTO `productgalleries` VALUES (492, 53, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-marshall-motif-ii-anc_9_.png', 0);
INSERT INTO `productgalleries` VALUES (493, 53, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-marshall-motif-ii-anc_7_.png', 0);
INSERT INTO `productgalleries` VALUES (494, 53, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-marshall-motif-ii-anc_8_.png', 0);
INSERT INTO `productgalleries` VALUES (495, 54, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/h/mh-monitor-ii-anc-large-2.png', 0);
INSERT INTO `productgalleries` VALUES (496, 54, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/h/mh-monitor-ii-anc-large-3.png', 0);
INSERT INTO `productgalleries` VALUES (497, 54, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:58:58/q:90/plain/https://cellphones.com.vn/media/catalog/product/m/h/mh-monitor-ii-anc-large-1_1_.png', 0);
INSERT INTO `productgalleries` VALUES (498, 55, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-monitor-iii-anc_4_.png', 0);
INSERT INTO `productgalleries` VALUES (499, 55, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-monitor-iii-anc_3_.png', 0);
INSERT INTO `productgalleries` VALUES (500, 55, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-monitor-iii-anc_5_.png', 0);
INSERT INTO `productgalleries` VALUES (501, 55, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-monitor-iii-anc_6_.png', 0);
INSERT INTO `productgalleries` VALUES (502, 55, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-monitor-iii-anc_8_.png', 0);
INSERT INTO `productgalleries` VALUES (503, 56, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/6/165_1_1.png', 0);
INSERT INTO `productgalleries` VALUES (504, 56, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/6/166_1_2.png', 0);
INSERT INTO `productgalleries` VALUES (505, 56, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/7/172_1_1.png', 0);
INSERT INTO `productgalleries` VALUES (506, 56, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-xiaomi-redmi-buds-6-active.png', 0);
INSERT INTO `productgalleries` VALUES (507, 56, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/6/167_1_2.png', 0);
INSERT INTO `productgalleries` VALUES (508, 56, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/7/174_1.png', 0);
INSERT INTO `productgalleries` VALUES (509, 56, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:58:58/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/7/173_1_1.png', 0);
INSERT INTO `productgalleries` VALUES (510, 57, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6_14_.png', 0);
INSERT INTO `productgalleries` VALUES (511, 57, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6_11_.png', 0);
INSERT INTO `productgalleries` VALUES (512, 57, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6_5_.png', 0);
INSERT INTO `productgalleries` VALUES (513, 57, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6_6_.png', 0);
INSERT INTO `productgalleries` VALUES (514, 57, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6_6_.png', 0);
INSERT INTO `productgalleries` VALUES (515, 58, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6-pro_1_.png', 0);
INSERT INTO `productgalleries` VALUES (516, 58, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6-pro_20_.png', 0);
INSERT INTO `productgalleries` VALUES (517, 58, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6-pro_21_.png', 0);
INSERT INTO `productgalleries` VALUES (518, 58, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6-pro_14_.png', 0);
INSERT INTO `productgalleries` VALUES (519, 58, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6-pro_10_.png', 0);
INSERT INTO `productgalleries` VALUES (520, 58, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6-pro_7_.png', 0);
INSERT INTO `productgalleries` VALUES (521, 59, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/_/t_i_xu_ng_24__4_4.png', 0);
INSERT INTO `productgalleries` VALUES (522, 59, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/_/t_i_xu_ng_25__3_4.png', 0);
INSERT INTO `productgalleries` VALUES (523, 59, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/_/t_i_xu_ng_26__1_5.png', 0);
INSERT INTO `productgalleries` VALUES (524, 59, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/_/t_i_xu_ng_27__1_8.png', 0);
INSERT INTO `productgalleries` VALUES (525, 60, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-openwear-stereo-4.png', 0);
INSERT INTO `productgalleries` VALUES (526, 60, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/7/176_2.png', 0);
INSERT INTO `productgalleries` VALUES (527, 60, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-openwear-stereo-7.png', 0);
INSERT INTO `productgalleries` VALUES (528, 60, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/7/179_1_1.png', 0);
INSERT INTO `productgalleries` VALUES (529, 60, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/8/181_1_1.png', 0);
INSERT INTO `productgalleries` VALUES (530, 61, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/u/buds2-black_2__1.png', 0);
INSERT INTO `productgalleries` VALUES (531, 61, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/f/r/frame_290.png', 0);
INSERT INTO `productgalleries` VALUES (532, 61, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/f/r/frame_291_1_1.png', 0);
INSERT INTO `productgalleries` VALUES (533, 61, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-the-thao-xiaomi-openwear-stereo-pro-_3_.png', 0);
INSERT INTO `productgalleries` VALUES (534, 61, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-the-thao-xiaomi-openwear-stereo-pro-_2_.png', 0);
INSERT INTO `productgalleries` VALUES (535, 61, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/f/r/frame_294_1_5.png', 0);
INSERT INTO `productgalleries` VALUES (536, 61, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/u/buds2-black_3_.png', 0);
INSERT INTO `productgalleries` VALUES (537, 62, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/7/_/7_276_16.png', 0);
INSERT INTO `productgalleries` VALUES (538, 62, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/_/1_718_31.png', 0);
INSERT INTO `productgalleries` VALUES (539, 62, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/_/2_690_27.png', 0);
INSERT INTO `productgalleries` VALUES (540, 62, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/5/_/5_483_22.png', 0);
INSERT INTO `productgalleries` VALUES (541, 62, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/3/_/3_629_34.png', 0);
INSERT INTO `productgalleries` VALUES (542, 62, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/1/11_60_15.png', 0);
INSERT INTO `productgalleries` VALUES (543, 63, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/0/20_5_3_1.png', 0);
INSERT INTO `productgalleries` VALUES (544, 63, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/8/18_10_7_1.png', 0);
INSERT INTO `productgalleries` VALUES (545, 63, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/9/19_9_5_1.png', 0);
INSERT INTO `productgalleries` VALUES (546, 63, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/1/21_7_5_1.png', 0);
INSERT INTO `productgalleries` VALUES (547, 63, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/3/23_2_7_1.png', 0);
INSERT INTO `productgalleries` VALUES (548, 81, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tour-one-m3-0-_4_.png?_gl=1*1n3p0vu*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTU5MDczJGo1MyRsMCRoM', 0);
INSERT INTO `productgalleries` VALUES (549, 81, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tour-one-m3-0-_7_.png?_gl=1*1ozm5sr*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTU5MDczJGo1MyRsMCRoM', 0);
INSERT INTO `productgalleries` VALUES (550, 81, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tour-one-m3-0-_10_.png?_gl=1*dm44i3*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTU5MDczJGo1MyRsMCRoM', 0);
INSERT INTO `productgalleries` VALUES (551, 81, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tour-one-m3-0-_9_.png?_gl=1*dm44i3*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTU5MDczJGo1MyRsMCRoMT', 0);
INSERT INTO `productgalleries` VALUES (552, 80, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-3_4_.png?_gl=1*1pe0w9q*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYwNTA2JGo2MCRsMCRoMTc5', 0);
INSERT INTO `productgalleries` VALUES (553, 80, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-3_5_.png?_gl=1*ffkifi*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYwNTA2JGo2MCRsMCRoMTc5N', 0);
INSERT INTO `productgalleries` VALUES (554, 80, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-3_1_.png?_gl=1*ffkifi*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYwNTA2JGo2MCRsMCRoMTc5N', 0);
INSERT INTO `productgalleries` VALUES (555, 80, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-3_11_.png?_gl=1*1kd7502*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYwNTk4JGo2MCRsMCRoMTc', 0);
INSERT INTO `productgalleries` VALUES (556, 80, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-3_13_.png?_gl=1*1kd7502*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYwNTk4JGo2MCRsMCRoMTc', 0);
INSERT INTO `productgalleries` VALUES (557, 80, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-3_10_.png?_gl=1*1xv547e*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYwNzIxJGo0MyRsMCRoMTc', 0);
INSERT INTO `productgalleries` VALUES (558, 79, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-07-29_15-35-34.jpg?_gl=1*mh2d1s*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYxNjc2JGo0MCRsMCRoMTc5NTY3NDcyM', 0);
INSERT INTO `productgalleries` VALUES (559, 79, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-live-770nc-2.png?_gl=1*lnc21w*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYxNzg4JGo2MCRsMCRoMTc5NTY', 0);
INSERT INTO `productgalleries` VALUES (560, 79, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-live-770nc-7.png?_gl=1*109jb1w*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYxNzg4JGo2MCRsMCRoMTc5NT', 0);
INSERT INTO `productgalleries` VALUES (561, 79, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-live-770nc-5.png?_gl=1*109jb1w*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYxNzg4JGo2MCRsMCRoMTc5NT', 0);
INSERT INTO `productgalleries` VALUES (562, 78, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-2-vang4_1.png?_gl=1*1jb6lj6*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyMzExJGozMCRsMCR', 0);
INSERT INTO `productgalleries` VALUES (563, 78, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-2-vang6_1.png?_gl=1*cmvjbm*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyMzExJGozMCRsMCRo', 0);
INSERT INTO `productgalleries` VALUES (564, 78, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-2-vang2_1.png?_gl=1*cmvjbm*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyMzExJGozMCRsMCRo', 0);
INSERT INTO `productgalleries` VALUES (565, 78, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-2-2.png?_gl=1*1rvo7b9*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyMzk4JGo2MCRsMCRoMTc5N', 0);
INSERT INTO `productgalleries` VALUES (566, 78, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-2-6.png?_gl=1*1rvo7b9*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyMzk4JGo2MCRsMCRoMTc5N', 0);
INSERT INTO `productgalleries` VALUES (567, 78, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-2-5.png?_gl=1*1rvo7b9*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyMzk4JGo2MCRsMCRoMTc5N', 0);
INSERT INTO `productgalleries` VALUES (568, 77, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-live-beam-3-_12_.png?_gl=1*rm22vx*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjU3JGo5JGwwJGgxNz', 0);
INSERT INTO `productgalleries` VALUES (569, 77, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-live-beam-3-_14_.png?_gl=1*12oemv6*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjU3JGo5JGwwJGgxN', 0);
INSERT INTO `productgalleries` VALUES (570, 77, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-live-beam-3-.png?_gl=1*12oemv6*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjU3JGo5JGwwJGgxNzk1N', 0);
INSERT INTO `productgalleries` VALUES (571, 77, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-live-beam-3-_4_.png?_gl=1*12oemv6*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjU3JGo5JGwwJGgxNz', 0);
INSERT INTO `productgalleries` VALUES (572, 77, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-live-beam-3-_19_.png?_gl=1*12oemv6*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjU3JGo5JGwwJGgxN', 0);
INSERT INTO `productgalleries` VALUES (573, 77, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-live-beam-3-_21_.png?_gl=1*56l2rx*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjU3JGo5JGwwJGgxNz', 0);
INSERT INTO `productgalleries` VALUES (574, 77, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-live-beam-3-_9_.png?_gl=1*56l2rx*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjU3JGo5JGwwJGgxNzk', 0);
INSERT INTO `productgalleries` VALUES (575, 77, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-live-beam-3-_11_.png?_gl=1*56l2rx*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjU3JGo5JGwwJGgxNz', 0);
INSERT INTO `productgalleries` VALUES (576, 76, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-live-670nc_7__1.png?_gl=1*11vk4ot*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNDYzJGo2MCRsMCRoMTc', 0);
INSERT INTO `productgalleries` VALUES (577, 76, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-live-670nc_6__1.png?_gl=1*11vk4ot*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNDYzJGo2MCRsMCRoMTc', 0);
INSERT INTO `productgalleries` VALUES (578, 76, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-live-670nc_1__1.png?_gl=1*11vk4ot*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNDYzJGo2MCRsMCRoMTc', 0);
INSERT INTO `productgalleries` VALUES (579, 76, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-live-670nc_9_.png?_gl=1*klloju*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNDYzJGo2MCRsMCRoMTc5NT', 0);
INSERT INTO `productgalleries` VALUES (580, 76, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-live-670nc_10_.png?_gl=1*klloju*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNDYzJGo2MCRsMCRoMTc5N', 0);
INSERT INTO `productgalleries` VALUES (581, 75, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-the-thao-jbl-sence-lite_13__1.png?_gl=1*1hrtpd1*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzQxJGoxOSRsMCRoMT', 0);
INSERT INTO `productgalleries` VALUES (582, 75, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-the-thao-jbl-sence-lite_18__1.png?_gl=1*1hrtpd1*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzQxJGoxOSRsMCRoMT', 0);
INSERT INTO `productgalleries` VALUES (583, 75, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-the-thao-jbl-sence-lite_5_.png?_gl=1*zhozy*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzc2JGo2MCRsMCRoMTc5NTY', 0);
INSERT INTO `productgalleries` VALUES (584, 75, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-the-thao-jbl-sence-lite_4_.png?_gl=1*zhozy*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzc2JGo2MCRsMCRoMTc5NTY', 0);
INSERT INTO `productgalleries` VALUES (585, 75, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-the-thao-jbl-sence-lite_10__1.png?_gl=1*zhozy*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzc2JGo2MCRsMCRoMTc5', 0);
INSERT INTO `productgalleries` VALUES (586, 75, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-the-thao-jbl-sence-lite_9__1.png?_gl=1*zhozy*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzc2JGo2MCRsMCRoMTc5N', 0);
INSERT INTO `productgalleries` VALUES (587, 75, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/e/a/ear-b_1.png?_gl=1*zhozy*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzc2JGo2MCRsMCRoMTc5NTY3NDcyMw..', 0);
INSERT INTO `productgalleries` VALUES (588, 75, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/l/bl_1_4.png?_gl=1*zhozy*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzc2JGo2MCRsMCRoMTc5NTY3NDcyMw..', 0);
INSERT INTO `productgalleries` VALUES (589, 82, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-tune-buds-2_16_.png?_gl=1*178pgfg*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0MjEyJGo1NyRsMCRoMT', 0);
INSERT INTO `productgalleries` VALUES (590, 82, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-tune-buds-2_18_.png?_gl=1*178pgfg*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0MjEyJGo1NyRsMCRoMT', 0);
INSERT INTO `productgalleries` VALUES (591, 82, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-tune-buds-2_21_.png?_gl=1*178pgfg*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0MjEyJGo1NyRsMCRoMT', 0);
INSERT INTO `productgalleries` VALUES (592, 82, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-tune-buds-2_22_.png?_gl=1*vczcsc*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0MjEyJGo1NyRsMCRoMTc', 0);
INSERT INTO `productgalleries` VALUES (593, 82, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-tune-buds-2_10_.png?_gl=1*vczcsc*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0MjEyJGo1NyRsMCRoMTc', 0);
INSERT INTO `productgalleries` VALUES (594, 82, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-tune-buds-2_6_.png?_gl=1*vczcsc*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0MjEyJGo1NyRsMCRoMTc5', 0);
INSERT INTO `productgalleries` VALUES (595, 74, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-wave-buds-2-_23_.png?_gl=1*11rrfha*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NzA2JGo2MCRsMCRoM', 0);
INSERT INTO `productgalleries` VALUES (596, 74, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-wave-buds-2-_25_.png?_gl=1*11rrfha*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NzA2JGo2MCRsMCRoM', 0);
INSERT INTO `productgalleries` VALUES (597, 74, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-wave-buds-2-_17__1.png?_gl=1*rguioe*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NzA2JGo2MCRsMCRo', 0);
INSERT INTO `productgalleries` VALUES (598, 74, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-wave-buds-2-_15__1.png?_gl=1*rguioe*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NzA2JGo2MCRsMCRo', 0);
INSERT INTO `productgalleries` VALUES (599, 74, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-wave-buds-2-_7__1.png?_gl=1*rguioe*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NzA2JGo2MCRsMCRoM', 0);
INSERT INTO `productgalleries` VALUES (600, 74, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-wave-buds-2-_9_.png?_gl=1*rguioe*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NzA2JGo2MCRsMCRoMTc', 0);
INSERT INTO `productgalleries` VALUES (601, 74, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-wave-buds-2-_1_.png?_gl=1*rguioe*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NzA2JGo2MCRsMCRoMTc', 0);
INSERT INTO `productgalleries` VALUES (602, 74, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-wave-buds-2-_2_.png?_gl=1*rguioe*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NzA2JGo2MCRsMCRoMTc', 0);
INSERT INTO `productgalleries` VALUES (603, 73, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tune-beam-1.png?_gl=1*13lz5b6*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MDU2JGoxNSRsMCRoMTc5NT', 0);
INSERT INTO `productgalleries` VALUES (604, 73, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tune-beam-3.png?_gl=1*13lz5b6*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MDU2JGoxNSRsMCRoMTc5NT', 0);
INSERT INTO `productgalleries` VALUES (605, 73, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tune-beam-2.png?_gl=1*13lz5b6*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MDU2JGoxNSRsMCRoMTc5NT', 0);
INSERT INTO `productgalleries` VALUES (606, 73, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tune-beam-8.png?_gl=1*13lz5b6*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MDU2JGoxNSRsMCRoMTc5NT', 0);
INSERT INTO `productgalleries` VALUES (607, 73, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tune-beam-13.png?_gl=1*rryunm*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MDU2JGoxNSRsMCRoMTc5NT', 0);
INSERT INTO `productgalleries` VALUES (608, 73, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tune-beam-14.png?_gl=1*rryunm*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MDU2JGoxNSRsMCRoMTc5NT', 0);
INSERT INTO `productgalleries` VALUES (609, 73, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tune-beam-12.png?_gl=1*rryunm*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MDU2JGoxNSRsMCRoMTc5NT', 0);
INSERT INTO `productgalleries` VALUES (610, 72, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/_/t_i_xu_ng_-_2023-02-11t195647.477.png?_gl=1*iztg64*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1ODY4JGozNCRsMCRoMTc5NTY3', 0);
INSERT INTO `productgalleries` VALUES (611, 72, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/_/t_i_xu_ng_-_2023-02-11t195730.185.png?_gl=1*11ecjsb*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1ODY4JGozNCRsMCRoMTc5NTY', 0);
INSERT INTO `productgalleries` VALUES (612, 72, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/_/t_i_xu_ng_-_2023-02-11t195702.959.png?_gl=1*iztg64*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1ODY4JGozNCRsMCRoMTc5NTY3', 0);
INSERT INTO `productgalleries` VALUES (613, 72, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/_/t_i_xu_ng_-_2023-02-11t211953.503.png?_gl=1*iztg64*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1ODY4JGozNCRsMCRoMTc5NTY3', 0);
INSERT INTO `productgalleries` VALUES (614, 72, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/_/t_i_xu_ng_-_2023-02-11t211941.802.png?_gl=1*iztg64*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1ODY4JGozNCRsMCRoMTc5NTY3', 0);
INSERT INTO `productgalleries` VALUES (615, 71, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tune-520bt_4_.png?_gl=1*i6vz1f*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwODEzJGoyNCRsMCRoMTMyNz', 0);
INSERT INTO `productgalleries` VALUES (616, 71, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tune-520bt_2_.png?_gl=1*1bj4egj*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwODEzJGoyNCRsMCRoMTMyN', 0);
INSERT INTO `productgalleries` VALUES (617, 71, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tune-520bt_3_.png?_gl=1*1bj4egj*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwODEzJGoyNCRsMCRoMTMyN', 0);
INSERT INTO `productgalleries` VALUES (618, 71, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tune-520bt_5_.png?_gl=1*1bj4egj*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwODEzJGoyNCRsMCRoMTMyN', 0);
INSERT INTO `productgalleries` VALUES (619, 71, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tune-520bt_9_.png?_gl=1*1bj4egj*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwODEzJGoyNCRsMCRoMTMyN', 0);
INSERT INTO `productgalleries` VALUES (620, 71, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tune-520bt_7_.png?_gl=1*1bj4egj*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwODEzJGoyNCRsMCRoMTMyN', 0);
INSERT INTO `productgalleries` VALUES (621, 70, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/g/h/ghost0.png?_gl=1*c352hz*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQxNjA1JGo0MyRsMCRoMTMyNzAwMDEyNg..', 0);
INSERT INTO `productgalleries` VALUES (622, 70, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/g/h/ghost1.png?_gl=1*c352hz*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQxNjA1JGo0MyRsMCRoMTMyNzAwMDEyNg..', 0);
INSERT INTO `productgalleries` VALUES (623, 70, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-tune-beam-2-tim-trong_9__1.png?_gl=1*1vyeoq9*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQxNjI0JGo', 0);
INSERT INTO `productgalleries` VALUES (624, 70, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-tune-beam-2-tim-trong_2__1.png?_gl=1*1vyeoq9*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQxNjI0JGo', 0);
INSERT INTO `productgalleries` VALUES (625, 70, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-tune-beam-2-den-trong_10__1.png?_gl=1*1qv7qwx*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQxNzA5JG', 0);
INSERT INTO `productgalleries` VALUES (626, 70, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-tune-beam-2-den-trong_5__1.png?_gl=1*1sykq8*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQxNzA5JGo2', 0);
INSERT INTO `productgalleries` VALUES (627, 113, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-willen-ii_20_.png', 0);
INSERT INTO `productgalleries` VALUES (628, 113, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-willen-ii_18_.png', 0);
INSERT INTO `productgalleries` VALUES (629, 113, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-willen-ii_22_.png', 0);
INSERT INTO `productgalleries` VALUES (630, 113, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-willen-ii_32_.png', 0);
INSERT INTO `productgalleries` VALUES (631, 113, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-willen-ii_33_.png', 0);
INSERT INTO `productgalleries` VALUES (632, 113, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-willen-ii_30_.png', 0);
INSERT INTO `productgalleries` VALUES (633, 114, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall_emberton_ii_3.png', 0);
INSERT INTO `productgalleries` VALUES (634, 114, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall_emberton_ii_4.png', 0);
INSERT INTO `productgalleries` VALUES (635, 114, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-emberton-ii-3.png', 0);
INSERT INTO `productgalleries` VALUES (636, 114, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-emberton-ii_1_.png', 0);
INSERT INTO `productgalleries` VALUES (637, 114, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-emberton-ii.png', 0);
INSERT INTO `productgalleries` VALUES (638, 114, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-emberton-ii_2_.png', 0);
INSERT INTO `productgalleries` VALUES (639, 115, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-emberton-iii-_7_.png', 0);
INSERT INTO `productgalleries` VALUES (640, 115, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-emberton-iii-_12_.png', 0);
INSERT INTO `productgalleries` VALUES (641, 115, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-emberton-iii-_4_.png', 0);
INSERT INTO `productgalleries` VALUES (642, 115, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-emberton-iii_4_.png', 0);
INSERT INTO `productgalleries` VALUES (643, 115, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-emberton-iii_3_.png', 0);
INSERT INTO `productgalleries` VALUES (644, 115, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-emberton-iii-1.png', 0);
INSERT INTO `productgalleries` VALUES (645, 116, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-stockwell-2_4_.png', 0);
INSERT INTO `productgalleries` VALUES (646, 116, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-stockwell-2_3_.png', 0);
INSERT INTO `productgalleries` VALUES (647, 116, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-stockwell-2_2_.png', 0);
INSERT INTO `productgalleries` VALUES (648, 116, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-stockwell-2-ksp.png', 0);
INSERT INTO `productgalleries` VALUES (649, 116, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/accessories/speaker/marshall-stockwell-ii-3.jpg', 0);
INSERT INTO `productgalleries` VALUES (650, 116, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/accessories/speaker/loa-di-dong-marshall-stockwell-ii-7.jpg', 0);
INSERT INTO `productgalleries` VALUES (651, 118, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall_kilburn_2_3.png', 0);
INSERT INTO `productgalleries` VALUES (652, 118, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-di-dong-marshall-killburn-ii--1-.jpg', 0);
INSERT INTO `productgalleries` VALUES (653, 118, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall_kilburn_2_2.png', 0);
INSERT INTO `productgalleries` VALUES (654, 118, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall_kilburn_2_4.png', 0);
INSERT INTO `productgalleries` VALUES (655, 118, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/accessories/speaker/loa-bluetooth-marshall-killburn-2-1.jpg', 0);
INSERT INTO `productgalleries` VALUES (656, 118, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-killburn-2-ksp_1.png', 0);
INSERT INTO `productgalleries` VALUES (657, 119, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-kilburn-iii_13_.png', 0);
INSERT INTO `productgalleries` VALUES (658, 119, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-kilburn-iii_12_.png', 0);
INSERT INTO `productgalleries` VALUES (659, 119, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-kilburn-iii_10_.png', 0);
INSERT INTO `productgalleries` VALUES (660, 119, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-kilburn-iii_11_.png', 0);
INSERT INTO `productgalleries` VALUES (661, 119, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-kilburn-iii_8_.png', 0);
INSERT INTO `productgalleries` VALUES (662, 119, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-kilburn-iii_7_.png', 0);
INSERT INTO `productgalleries` VALUES (663, 120, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-heston-sub-200_7_.png', 0);
INSERT INTO `productgalleries` VALUES (664, 120, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-heston-sub-200_8_.png', 0);
INSERT INTO `productgalleries` VALUES (665, 120, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-heston-sub-200_9_.png', 0);
INSERT INTO `productgalleries` VALUES (666, 120, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-heston-sub-200_4_.png', 0);
INSERT INTO `productgalleries` VALUES (667, 120, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-heston-sub-200_2_.png', 0);
INSERT INTO `productgalleries` VALUES (668, 120, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-heston-sub-200_3_.png', 0);
INSERT INTO `productgalleries` VALUES (669, 121, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall_tufton_3.png', 0);
INSERT INTO `productgalleries` VALUES (670, 121, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall_tufton_2.png', 0);
INSERT INTO `productgalleries` VALUES (671, 121, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/p/o/pos-marshall-speakers-tufton-black-03_1.png', 0);
INSERT INTO `productgalleries` VALUES (672, 121, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/p/o/pos-marshall-speakers-tufton-black-02_1.png', 0);
INSERT INTO `productgalleries` VALUES (673, 121, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall-tufton-usp03-desktop_1.41x.png', 0);
INSERT INTO `productgalleries` VALUES (674, 121, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-marshall-tufton-ksp_1.png', 0);
INSERT INTO `productgalleries` VALUES (675, 69, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-endurance-zone-_4_.png?_gl=1*z0z0l1*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjExODcyJGo2MCRsMCRo', 0);
INSERT INTO `productgalleries` VALUES (676, 69, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_endurance_zone_3_.png?_gl=1*15b7fl1*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjExODcyJGo2MCRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (677, 69, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_endurance_zone_2_.png?_gl=1*15b7fl1*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjExODcyJGo2MCRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (678, 68, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/6/_/6_243_4.png?_gl=1*6beeeb*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyNTEyJGoyMyRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (679, 68, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/7/_/7_175_3.png?_gl=1*1xy6e7n*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyNTEyJGoyMyRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (680, 68, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/8/_/8_126_5.png?_gl=1*1xy6e7n*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyNTEyJGoyMyRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (681, 68, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/9/_/9_84_4.png?_gl=1*1xy6e7n*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyNTEyJGoyMyRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (682, 68, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/1/11_43_4.png?_gl=1*1xy6e7n*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyNTEyJGoyMyRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (683, 68, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/0/10_64_4.png?_gl=1*1xy6e7n*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyNTEyJGoyMyRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (684, 67, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-samsung-galaxy-buds-3-pro_4_.png?_gl=1*1drgc1i*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEzMDYxJGo0MCRsMCRoMTU', 0);
INSERT INTO `productgalleries` VALUES (685, 67, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-samsung-galaxy-buds-3-pro_6_.png?_gl=1*vlmg8x*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEzMDYxJGo0MCRsMCRoMTUw', 0);
INSERT INTO `productgalleries` VALUES (686, 67, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-samsung-galaxy-buds-3-pro_2_.png?_gl=1*vlmg8x*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEzMDYxJGo0MCRsMCRoMTUw', 0);
INSERT INTO `productgalleries` VALUES (687, 67, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-samsung-galaxy-buds-3-pro_1_.png?_gl=1*vlmg8x*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEzMDYxJGo0MCRsMCRoMTUw', 0);
INSERT INTO `productgalleries` VALUES (688, 67, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-samsung-galaxy-buds-3-pro_20__1.png?_gl=1*1fd4nnq*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEzMTIzJGo2MCRsM', 0);
INSERT INTO `productgalleries` VALUES (689, 67, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-samsung-galaxy-buds-3-pro_16_.png?_gl=1*1fd4nnq*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEzMTIzJGo2MCRsMCRoMT', 0);
INSERT INTO `productgalleries` VALUES (690, 67, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-samsung-galaxy-buds-3-pro_11_.png?_gl=1*1fd4nnq*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEzMTIzJGo2MCRsMCRoMT', 0);
INSERT INTO `productgalleries` VALUES (691, 67, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-samsung-galaxy-buds-3-pro_14_.png?_gl=1*n8lgba*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEzMTIzJGo2MCRsMCRoMTU', 0);
INSERT INTO `productgalleries` VALUES (692, 66, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-3-6.png?_gl=1*oij2vn*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0MjAzJGoyMSRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (693, 66, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-3-10.png?_gl=1*oij2vn*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0MjAzJGoyMSRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (694, 66, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-3-1.png?_gl=1*oij2vn*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0MjAzJGoyMSRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (695, 66, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-3-2.png?_gl=1*1dj5phf*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0MjAzJGoyMSRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (696, 66, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-3_3_.png?_gl=1*ig5rok*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0MjMwJGo2MCRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (697, 66, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-3_2_.png?_gl=1*ig5rok*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0MjMwJGo2MCRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (698, 66, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-3_1_.png?_gl=1*ig5rok*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0MjMwJGo2MCRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (699, 66, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-3.png?_gl=1*ig5rok*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0MjMwJGo2MCRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (700, 65, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/c/_/c_4_2.png?_gl=1*t0709g*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NTM5JGozOCRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (701, 65, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/h/3/h3-2.png?_gl=1*t0709g*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NTM5JGozOCRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (702, 65, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/c/2/c2_1_1.png?_gl=1*t0709g*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NTM5JGozOCRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (703, 65, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/c/1/c1_1_1.png?_gl=1*t0709g*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NTM5JGozOCRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (704, 65, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/1/b1_2_4.png?_gl=1*1cylpai*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NTU5JGoxOCRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (705, 65, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/3/b3_1_3.png?_gl=1*1cylpai*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NTU5JGoxOCRsMCRoMTUwNzM1MDM4MA..', 0);
INSERT INTO `productgalleries` VALUES (706, 64, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-fe_1__1.png?_gl=1*14hn0jg*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NzUzJGoyOSRsMCRoMTUwNzM1MDM4M', 0);
INSERT INTO `productgalleries` VALUES (707, 64, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-fe_4__1.png?_gl=1*wqmg3x*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NzUzJGoyOSRsMCRoMTUwNzM1MDM4MA', 0);
INSERT INTO `productgalleries` VALUES (708, 64, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-fe_6__1.png?_gl=1*wqmg3x*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NzUzJGoyOSRsMCRoMTUwNzM1MDM4MA', 0);
INSERT INTO `productgalleries` VALUES (709, 64, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-fe_5__1.png?_gl=1*wqmg3x*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NzUzJGoyOSRsMCRoMTUwNzM1MDM4MA', 0);
INSERT INTO `productgalleries` VALUES (710, 64, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-fe_7__1.png?_gl=1*wqmg3x*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NzUzJGoyOSRsMCRoMTUwNzM1MDM4MA', 0);
INSERT INTO `productgalleries` VALUES (711, 64, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-fe_12__1.png?_gl=1*wqmg3x*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NzUzJGoyOSRsMCRoMTUwNzM1MDM4M', 0);
INSERT INTO `productgalleries` VALUES (712, 64, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/s/a/samsung-galaxy-buds-fe_11__1.png?_gl=1*wqmg3x*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NzUzJGoyOSRsMCRoMTUwNzM1MDM4M', 0);
INSERT INTO `productgalleries` VALUES (2416, 100, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/6/1/61tlmjhyfdl._sl1000_.jpg', 0);

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `brands_id` int NOT NULL,
  `categories_id` int NOT NULL,
  `sku` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `avg_rating` decimal(2, 1) NULL DEFAULT 5.0,
  `sold_count` int NULL DEFAULT 0,
  `is_active` tinyint(1) NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `display_sell_price` decimal(10, 2) NULL DEFAULT 0.00,
  `display_market_price` decimal(10, 2) NULL DEFAULT 0.00,
  `display_image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `search_count` int NULL DEFAULT 30,
  `view_count` int NULL DEFAULT 20,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sku`(`sku` ASC) USING BTREE,
  INDEX `brands_id`(`brands_id` ASC) USING BTREE,
  INDEX `categories_id`(`categories_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 221 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 1, 3, 'SN-XM5', 'Tai nghe Sony chup tai WH-1000XM5', 'Tai nghe Sony WH-1000XM5 - Chống ồn dịu tai, sử dụng thoải mái\r\nSony WH-1000XM5 với thiết kế chống ồn dòng cao cấp, được trang bị bộ xử lý QN1. Đây là một trong những tai nghe chụp tai tốt trong phân khúc chống ồn chủ động.\r\n\r\nThiết kế đẹp mắt, cá tính và có tính năng hạn chế chống ồn dịu tai\r\nTai nghe sở hữu thiết kế kiểu choàng đầu phong cách cá tính. Khi không sử dụng, bạn có thể gấp gọn lại và thuận tiện cho bạn mang theo trong công việc hay bất cứ nơi đâu. Đặc biệt, bao bì tai nghe không sử dụng nhựa thay vào đó là các vật liệu tái chế an toàn cho môi trường.\r\n\r\nChiếc tai nghe WH-1000XM5 này đẹp bắt mắt về kiểu dáng, tốt về chất lượng với lớp vỏ được bao bọc bằng nhựa cứng chắc, mượt mà, không hề thô cứng cùng với miếng đệm tai nghe bằng da màu đen sang trọng và tạo cảm giác êm ái. Đệm tai được hoàn thiện từ da mềm cùng thiết kế ôm khít đầu nhưng không hề gây áp lực lên đôi tai.', 5.0, 0, 0, '2025-12-14 01:17:02', 7900000.00, 8000000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-1000xm5-2-removebg-preview.png', 190, 326);
INSERT INTO `products` VALUES (2, 2, 6, 'JBL-F6', 'Loa Bluetooth di động JBL Flip 6', 'Với Kiểu dáng nhỏ gọn thời trang, thời lượng hoạt động ấn tượng\r\nJBL Flip 6 có thiết kế mang tính di động cao, đảm bảo thuận tiện để bạn mang đến bất kỳ đâu và tận hưởng âm nhạc yêu thích mọi lúc mọi nơi. Loa sở hữu kiểu dáng thanh lịch cùng gam màu trẻ trung. JBL Flip 6 sở hữu tới 6 phiên bản màu sắc khau nhau lần lượt là hồng, xanh (Lục - lá cây - da trời), trắng, đỏ, xám, đen. JBL Flip 6 mang đến trải nghiệm âm thanh tuyệt vời nhờ subwoofer dạng racetrack, bao gồm 2 loa bass thụ động và 1 tweeter tách rời, cung cấp chất âm có độ sâu, đầy sống động để lan tỏa đến bạn nguồn năng lượng mạnh mẽ, nâng cao cảm giác đắm chìm khi nghe nhạc.', 5.0, 0, 1, '2025-12-14 01:17:32', 2500000.00, 3000000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/j/b/jbl_flip_6_7.png', 30, 26);
INSERT INTO `products` VALUES (3, 3, 4, 'RZO-PANC', 'Tai nghe Bluetooth True Wireless Rezo Wave Pro ANC', 'Chống ồn chủ động, âm thanh sống động từng chi tiết Rezo Wave Pro ANC được trang bị công nghệ chống ồn chủ động (ANC) tiên tiến, giúp loại bỏ hiệu quả các tạp âm từ môi trường xung quanh, mang lại không gian âm nhạc riêng tư và trọn vẹn. Chất âm trầm ấm, mạnh mẽ cùng khả năng tái tạo chi tiết tốt giúp nâng tầm trải nghiệm giải trí của bạn.\n\nThiết kế bo tròn mềm mại, bám tai chắc chắn Tai nghe sở hữu ngôn ngữ thiết kế hiện đại với hộp sạc được bo cong mềm mại, tạo cảm giác cầm nắm thoải mái và gọn nhẹ khi bỏ túi. Phần housing (củ tai) được thiết kế công thái học, đi kèm các nút đệm silicone êm ái giúp bám chắc vào tai nhưng vẫn đảm bảo sự thông thoáng, không gây đau nhức khi sử dụng liên tục trong thời gian dài.', 5.0, 0, 1, '2025-12-14 01:23:17', 590000.00, 590000.00, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/344793/tai-nghe-bluetooth-true-wireless-rezo-wave-pro-anc-hong-3-638974184003070569-750x500.jpg', 111, 783);
INSERT INTO `products` VALUES (4, 3, 4, 'RZO-K50', 'Tai nghe Bluetooth True Wireless Rezo K50', 'Kết nối mượt mà, ngoại hình thời thượng Rezo K50 nổi bật trong phân khúc nhờ công nghệ kết nối Bluetooth hiện đại, đảm bảo đường truyền ổn định và độ trễ thấp, cực kỳ phù hợp cho nhu cầu nghe nhạc lẫn chơi game. Sản phẩm mang đến chất lượng âm thanh trong trẻo, cân bằng, đáp ứng tốt đa dạng các thể loại nhạc từ Ballad nhẹ nhàng đến EDM sôi động.\n\nKiểu dáng nhỏ gọn, tiện lợi mang theo mọi nơi Điểm cộng lớn nhất của Rezo K50 là thiết kế cực kỳ nhỏ gọn và tinh tế. Lớp vỏ ngoài được hoàn thiện tỉ mỉ từ nhựa cứng cao cấp, vừa bảo vệ linh kiện bên trong vừa tạo vẻ ngoài bóng bẩy, bắt mắt. Thiết kế tai nghe vừa vặn với khuôn tai người dùng phổ thông, mang lại cảm giác đeo \"nhẹ tựa không\", giúp bạn thoải mái tận hưởng âm nhạc suốt cả ngày dài.', 5.0, 0, 1, '2025-12-14 01:23:17', 470000.00, 550000.00, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/329299/tai-nghe-bluetooth-true-wireless-rezo-k50-den-2-638627076799209187-750x500.jpg', 222, 683);
INSERT INTO `products` VALUES (5, 3, 4, 'RZO-RZ09', 'Tai nghe Bluetooth True Wireless Rezo RZ09 ANC', 'Công nghệ ANC lọc ồn hiệu quả, đàm thoại rõ ràng Rezo RZ09 ANC là giải pháp hoàn hảo cho những ai cần sự tập trung nhờ tính năng chống ồn chủ động, giúp giảm thiểu tiếng ồn giao thông hay tiếng ồn văn phòng. Bên cạnh đó, micro tích hợp được tối ưu hóa giúp giọng nói trong trẻo hơn, hỗ trợ đàm thoại rõ ràng ngay cả khi bạn đang di chuyển ngoài đường.\n\nThiết kế tối giản, chất liệu thân thiện Sản phẩm theo đuổi phong cách tối giản (minimalism) nhưng vẫn toát lên vẻ sang trọng. Hộp sạc và tai nghe được làm từ vật liệu an toàn, có độ bền cao, chống trầy xước tốt. Kiểu dáng in-ear (nhét tai) với đệm tai mềm mại giúp cách âm thụ động hiệu quả, đồng thời giữ cho tai nghe nằm cố định chắc chắn ngay cả khi bạn vận động mạnh hay tập thể thao.', 5.0, 0, 1, '2025-12-14 01:23:17', 570000.00, 690000.00, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330249/tai-nghe-bluetooth-true-wireless-rezo-rz09-anc-trang-1-638635681929043024-750x500.jpg', 980, 692);
INSERT INTO `products` VALUES (6, 3, 4, 'RZO-AIR5', 'Tai nghe Bluetooth True Wireless Rezo Air 5 Deluxe ANC', 'Trải nghiệm âm thanh cao cấp, không gian tĩnh lặng Đúng như tên gọi \"Deluxe\", phiên bản Rezo Air 5 mang đến trải nghiệm nghe nhìn cao cấp với dải âm rộng và độ chi tiết cao. Tính năng chống ồn ANC hoạt động mạnh mẽ, tách biệt bạn khỏi sự ồn ào của thế giới bên ngoài chỉ với một thao tác chạm. Đây là lựa chọn lý tưởng cho các tín đồ âm thanh yêu thích sự hoàn hảo.\n\nThiết kế \"Air\" nhẹ tênh, êm ái tuyệt đối Tai nghe được thiết kế chú trọng tối đa vào sự thoải mái với trọng lượng siêu nhẹ, giảm áp lực lên ống tai khi đeo. Hộp sạc được thiết kế sang trọng, đóng mở linh hoạt. Đặc biệt, các đường nét trên tai nghe được trau chuốt mượt mà, không chỉ đẹp mắt mà còn mang lại cảm giác đeo êm ái, dễ chịu như không đeo, phù hợp cho những chuyến đi dài.', 5.0, 0, 1, '2025-12-14 01:23:17', 710000.00, 890000.00, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330711/tai-nghe-bluetooth-true-wireless-rezo-air-5-deluxe-anc-trang-3-638642418928950008-750x500.jpg', 651, 21);
INSERT INTO `products` VALUES (7, 4, 5, 'BU-E2F', 'Tai nghe Bluetooth thể thao Baseus Eli 2i Fit', 'Tai nghe không dây thể thao Baseus Eli 2i Fit là lựa chọn lý tưởng để thưởng thức âm nhạc mỗi khi vận động. Qua các đặc điểm vượt trội, mẫu tai nghe này có thể đáp ứng đa dạng nhu cầu khác nhau.\n\nDynamic driver 14.2mm, âm trầm tăng cường\nTai nghe không dây thể thao Baseus Eli 2i Fit được tích hợp Dynamic driver kích thước lớn 14.2mm, thể hiện rõ chất lượng trong trải nghiệm thực tế. Nhờ driver kích thước lớn, tai nghe có thể tái hiện dải âm rộng một cách sống động.\n\nThiết kế móc tai, kiểu dáng tinh tế\nTai nghe không dây thể thao Baseus Eli 2i Fit nổi bật với phong cách móc tai thể thao, hạn chế bị rơi ra khi di chuyển. Thiết kế này giúp tai nghe ôm gọn, bám chắc vào tai khi chơi thể thao hoặc vận động hàng ngày.', 5.0, 0, 1, '2025-12-14 01:23:17', 560000.00, 690000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-2i-fit_1_.png', 30, 20);
INSERT INTO `products` VALUES (8, 4, 5, 'BU-ES2', 'Tai nghe Bluetooth thể thao Baseus Eli Sport 2 Open-Ear', 'Tai nghe không dây thể thao Baseus Eli Sport 2 Open-Ear là sự lựa chọn lý tưởng cho những ai yêu thích vận động, mang đến trải nghiệm âm thanh sống động. Thiết kế mở độc đáo của tai nghe Baseus này mang lại cảm giác thoải mái vượt trội trong mọi hoạt động.\n\nTrải nghiệm nghe mở với chất lượng không dây\nBaseus Eli Sport 2 được trang bị màng loa động có đường kính 17mm, phủ lớp Titanium nhằm tăng cường độ cứng và cải thiện khả năng tái tạo âm thanh. Thiết kế Open-Ear, không nhét tai, không chỉ giữ nguyên chất lượng âm thanh mà còn mang lại cảm giác thoải mái, tự nhiên.', 5.0, 0, 1, '2025-12-14 01:23:17', 990000.00, 1190000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-sport-2-open-ear_8_.jpg', 98, 250);
INSERT INTO `products` VALUES (9, 4, 4, 'BU-BE17', 'Tai nghe Bluetooth True Wireless Baseus Bowie E17', 'Tai nghe Bluetooth Baseus Bowie E17 là mẫu tai nghe bỏ túi sở hữu chất âm trong trẻo, rõ ràng với bộ driver 12mm lớn hơn phần lớn các sản phẩm hiện có. Không chỉ sở hữu chất lượng âm thanh tốt hơn, Baseus Bowie E17 còn được thiết kế để mang tới sự thoải mái khi đeo, tiện lợi mang theo bên mình và thời lượng hoạt động ấn tượng.\n\nÂm thanh trong và rõ ràng với driver kích thước lớn hơn\nTai nghe Bluetooth Baseus Bowie E17 dù thuộc phân khúc sản phẩm phổ thông nhưng vẫn được ưu ái trang bị driver có kích thước 12mm. Với driver lớn hơn, dải âm bass trên Baseus Bowie E17 sẽ được cải thiện rõ rệt để phù hợp với những dòng nhạc phổ biến như Pop, Acoustic, EDM, Ballad, Rock,... Đồng thời, âm lượng tai nghe cũng sẽ lớn hơn để thể hiện các bản nhạc, lời bài hát một cách rõ ràng.', 5.0, 0, 1, '2025-12-14 01:23:17', 290000.00, 290000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e17_2_.png', 555, 223);
INSERT INTO `products` VALUES (10, 4, 4, 'BU-BE11', 'Tai nghe Bluetooth True Wireless Baseus Bowie E11', 'Baseus Bowie E11 tuy nằm trong phân khúc các dòng sản phẩm bình dân nhưng vẫn có thể mang đến chất âm ấn tượng, sinh động. Sản phẩm tai nghe Baseus được trang bị driver tiên tiến kết hợp cùng công nghệ âm thanh hiện đại hứa hẹn mang đến trải nghiệm nghe nhạc trọn vẹn. \n\nKhả năng phát nhạc đỉnh cao với chất âm Hi-Fi ấn tượng\nCấu trúc bên trong của chiếc tai nghe bao gồm driver 12mm với khả năng phát nhạc Hi-Fi độc đáo. Nhờ vào đó, những bản nhạc khi được phát cùng với tai nghe sẽ trở nên sống động, chân thực và không bị lẫn các tạp âm bên ngoài. Hơn nữa, tai nghe cũng có khả năng phát nhạc ở dải tần số rộng từ 20hz - 20kHz. Trong dải tần này, bạn có thể trải nghiệm đa dạng mọi chất âm như âm trầm, âm trung và âm cao sắc nét. \n\nKiểu dáng xinh xắn cùng độ bền vượt trội\nĐiểm nhấn ở dòng tai nghe Bluetooth đến từ thương hiệu Baseus nằm ở kiểu dáng nhỏ gọn và vô cùng xinh xắn. Chiếc tai nghe mang đến cho người dùng các gam màu để lựa chọn bao gồm đen, tím và trắng. ', 5.0, 0, 1, '2025-12-14 01:23:17', 260000.00, 419000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e11_5_.png', 30, 20);
INSERT INTO `products` VALUES (11, 4, 3, 'BU-D02P', 'Tai nghe Bluetooth chụp tai Baseus Encok D02 Pro', 'Tai nghe chụp tai Baseus Encok D02 Pro được đánh giá là sự hòa quyện hoàn hảo giữa khả năng thể hiện âm thanh tinh thế cùng trải nghiệm đeo nghe vô cùng thoải mái, êm ái. Nổi bật với tạo hình hiện đại cùng với chất lượng âm thanh sống động, thế hệ tai nghe Baseus này sẽ là người bạn đồng hành hoàn hảo trong mọi khoảnh khắc giải trí mà bạn không nên bỏ qua nhé!\n\nTrải nghiệm âm nhạc siêu sống động và có độ chính xác cao\nTrải nghiệm âm thanh trên tai nghe chụp tai Baseus Encok D02 Pro luôn được đánh giá là chân thực và có độ chính xác cực cao khi sở hữu bộ xử lý âm thanh 40mm tiên tiến. ', 5.0, 0, 1, '2025-12-14 01:23:17', 390000.00, 510000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-encok-d02-pro_15_.png', 666, 90);
INSERT INTO `products` VALUES (12, 4, 3, 'BU-B35M', 'Tai nghe Bluetooth chụp tai Baseus Bass 35 Max', 'Baseus Bass 35 Max là mẫu tai nghe chụp tai được trang bị thiết kế tối ưu âm thanh cùng nhiều công nghệ hỗ trợ. Tai nghe đáp ứng được nhiều nhu cầu dùng cùng một thiết kế với khả năng gập gọn tối ưu.\n\nMàng loa 40mm cùng công nghệ 3D Surround, Bass Boost\nTai nghe Bass 35 Max được trang bị một thiết kế với màng loa kích thước lên đến 40mm. Cùng với đó, tai nghe còn được trang bị nhiều công nghệ tối ưu cho các trải nghiệm âm thanh như 3D Surround hay Bass Boost. Trong đó, công nghệ Bass Boost hỗ trợ mang lại âm thanh đầy sống động cùng âm trầm sâu. Công nghệ 3D Surround giúp các trải nghiệm nghe nhạc trên Baseus Bass 35 Max trở nên ấn tượng hơn với âm thanh không gian đầy sống động.\n\n', 5.0, 0, 1, '2025-12-14 01:23:17', 550000.00, 990000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bass-35-max_3_.png', 318, 284);
INSERT INTO `products` VALUES (13, 4, 3, 'BU- BBH1', 'Tai nghe Bluetooth chụp tai Baseus Bass BH1', 'Âm trầm mạnh mẽ với Dynamic Super Bass 40mm\nTai nghe chụp tai Bluetooth Baseus Bass BH1 được trang bị màng loa Dynamic Super Bass 40mm, mang đến âm trầm sâu và mạnh mẽ. Hệ thống xử lý âm thanh thông minh tự động phát hiện tần số thấp và tăng cường đầu ra âm trầm, mang đến không gian âm nhạc chân thực. \nChế độ DCLL với độ trễ cực thấp chỉ 38ms giúp đồng bộ giữa âm thanh và hình ảnh, lý tưởng cho chơi game hay xem phim. Khi kích hoạt chế độ này, mọi giai điệu và hiệu ứng đều được truyền tải gần như tức thời, đem đến trải nghiệm giải trí liền mạch và tự nhiên.\n\nThiết kế tinh tế, thoải mái\nTai nghe chụp tai Bluetooth Baseus Bass BH1 được thiết kế tinh tế với chất liệu cao cấp, mang lại sự êm ái và thoải mái khi sử dụng. Kiểu dáng vừa vặn giúp giảm áp lực lên tai, tạo sự thoải mái khi đeo trong thời gian dài.', 5.0, 0, 1, '2025-12-14 01:23:17', 690000.00, 890000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-bluetooth-baseus-bass-bh1_8_.jpg', 30, 20);
INSERT INTO `products` VALUES (14, 4, 4, 'BU-WM02', 'Tai nghe Bluetooth Wireless Baseus Bowie WM02', 'Tai nghe bluetooth Baseus Bowie WM02 là chiếc tai nghe baseus mang màu sắc trẻ trung, truyền tải âm thanh chất lượng liền mạch. Bất cứ ai sử dụng sản phẩm này đều hài lòng và rung động khi thưởng thức các giai điệu âm thanh. Đoạn mô tả dưới đây sẽ cho bạn biết rõ có nên chọn Baseus Bowie WM02 đồng hành trong thời gian sắp tới hay không.\n\nThiết kế nâng niu tai, đèn led báo lệnh\nBaseus Bowie WM02 có dạng viên con nhộng, xinh đẹp và gọn gàng trong từng chi tiết. Cân nặng tai nghe chỉ 3.8g, không làm đau tai và không có chi tiết thừa gây khó chịu.\n\nBowie WM02 được tích hợp thêm vùng đèn led cảm ứng đặc biệt để hạn chế lỗi chạm không đúng lệnh. Nhờ vậy bạn có thể điều khiển tai nghe dễ dàng, chuẩn xác hơn trong mọi trường hợp.', 5.0, 0, 1, '2025-12-14 01:23:17', 350000.00, 560000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-wm02_1__1.png', 30, 20);
INSERT INTO `products` VALUES (15, 4, 4, 'BU-E16', 'Tai nghe Bluetooth True Wireless Baseus Bowie E16\n', 'Baseus Bowie E16 với thiết kế nhỏ gọn tiện dụng, âm thanh vượt trội. Tai nghe đáp ứng được nhiều nhu cầu sử dụng khác nhau của người dùng. Vậy chính xác mẫu tai nghe Baseus này có gì nổi trội, có đáng để mua sử dụng không?\n\nMang loa lớn 13mm mang lại âm thanh to rõ\nBaseus Bowie E16 sở hữu một màng loa kích thước lên tới 13 mm nhờ đó hỗ trợ mang lại âm thanh trong trẻo, tạp âm ít và to rõ. Chất lượng âm thanh trên thiết bị giúp người dùng có thể sử dụng trong nhiều nhu cầu từ giải trí đến làm việc.\n\nBaseus Bowie E16 sở hữu một thiết kế tối ưu được lấy cảm hứng từ hòn sỏi nhờ đó sản phẩm sở hữu những góc cạnh bo tròn. Tai nghe với tổng trọng lượng chỉ hơn 3g nhờ đó người dùng có thể dễ dàng cất và mang theo sử dụng. Tai nghe với thiết kế Earpod quen thuộc nhờ đó giúp mang lại cho người dùng trải nghiệm dùng thoải mái, không đau tai khi sử dụng lâu.\n\n', 5.0, 0, 1, '2025-12-14 01:23:17', 320000.00, 490000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e16_3_.png', 30, 20);
INSERT INTO `products` VALUES (16, 4, 4, 'BU-M2SU', 'Tai nghe không dây chống ồn Baseus Bowie M2S Ultra', 'Baseus Bowie M2S Ultra là tai nghe không dây cao cấp được thiết kế để mang đến chất âm chân thực. Không chỉ có khả năng phát nhạc chất lượng cao, mẫu tai nghe Baseus này còn sở hữu công nghệ hiện đại giúp nâng cao trải nghiệm nghe của người dùng.\n\nÂm thanh chất lượng cao, loại bỏ tạp âm mạnh mẽ\nChất lượng âm thanh luôn là yếu tố quan trọng khi lựa chọn tai nghe, và Baseus Bowie M2S Ultra đã không làm người dùng thất vọng với hàng loạt các nâng cấp mạnh mẽ. Nhờ được chứng nhận Hi-Res Audio Wireless, tai nghe không dây Baseus Bowie M2S Ultra hỗ trợ chuẩn LHDC 96kHz/24bit.\n\nNhờ vậy mà Baseus Bowie M2S Ultra đảm bảo giúp tái tạo âm thanh sắc nét với độ sâu và chi tiết cao. Người dùng có thể cảm nhận được sự rõ ràng trong từng nốt nhạc, từ âm bass trầm ấm đến âm cao trong trẻo.', 5.0, 0, 1, '2025-12-14 01:23:17', 1690000.00, 2390000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-baseus-bowie-m2s-ultra_2_.png', 380, 983);
INSERT INTO `products` VALUES (17, 4, 3, 'BU-BH1I', 'Tai nghe Bluetooth chụp tai Baseus Bowie H1i', 'Tai nghe Bluetooth chụp tai Baseus Bowie H1i nhận về nhiều phản hồi tốt từ phía người dùng khi sở hữu thiết kế chụp tai cao cấp, tạo sự thoải mái khi trải nghiệm âm thanh trong thời gian dài. Cùng với đó là công nghệ xử lý âm thanh hiện đại, chống ồn chủ động tiên tiến, mang tới chất lượng âm thanh vượt trội, sống động và cực kỳ cuốn hút. Dưới này là các ưu điểm nổi trội của dòng tai nghe Baseus này mà bạn có thể tìm hiểu thêm nhé!\n\nNghe nhạc giải trí mượt mà với driver 13mm cùng chống ồn tiên tiến\nTai nghe Bluetooth chụp tai Baseus Bowie H1i thực sự đem tới cho người dùng những trải nghiệm âm thanh đỉnh cao khi sở hữu tính năng chống ồn chủ động hiện đại. Qua đó, nó tạo ra môi trường âm thanh tĩnh lặng, thoải mái cho việc tận hưởng âm nhạc và cuộc gọi.', 5.0, 0, 1, '2025-12-14 01:23:17', 710000.00, 1190000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bowie-h1i_2__1.png', 30, 20);
INSERT INTO `products` VALUES (18, 4, 3, 'BU-GP1', 'Tai Nghe Gaming chụp tai Có Dây Baseus Goplay 1 Max', 'Baseus GoPlay 1 Max không chỉ là một chiếc tai nghe có dây thông thường, mà còn là lựa chọn đáng cân nhắc cho những ai yêu thích âm thanh sống động và thiết kế hiện đại. Cùng khám phá các điểm nhấn ấn tượng của mẫu tai nghe này qua các khía cạnh dưới đây nhé!\r\n\r\nDriver 40mm mạnh mẽ, công nghệ âm thanh chi tiết\r\nTai nghe có dây Baseus Goplay 1 Max được trang bị driver 40mm, mang đến chất âm ấn tượng với âm trầm mạnh mẽ và âm cao trong trẻo. Driver kích thước lớn này cho phép thiết bị tái tạo âm tần một cách chi tiết và chính xác, đặc biệt là trong các tựa game cần xác định vị trí âm thanh. ', 5.0, 0, 1, '2025-12-14 01:23:17', 710000.00, 890000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/_/3_629_4.png', 30, 20);
INSERT INTO `products` VALUES (19, 5, 4, 'LG-FP5', 'Tai nghe LG Bluetooth TONE Free FP5', '- Thiết kế tai nghe: được nghiên cứu dựa trên hình dáng tai người, cho phép housing ôm khít khi đeo và mang lại sự thoải mái cả khi sử dụng trong thời gian dài.\n\nĐệm tai của TONE Free FP5 sử dụng silicone tiêu chuẩn y tế, không chỉ đem lại sự êm ái mà còn đảm bảo độ an toàn, không gây dị ứng cho người sử dụng. Đệm tai được thiết kế với 03 kích thước (lớn - vừa - nhỏ), cho phép bạn lựa chọn hình dáng phù hợp và thoải mái nhất cho đôi tai của mình.\nĐắm chìm trong chất âm tuyệt vời từ TONE Free FP5\nKết hợp cùng Meridian (tổ chức hàng đầu về Xử lý Tín hiệu số và tiên phong về âm thanh độ phân giải cao), LG mang tới cho người nghe những âm thanh tuyệt vời nhất.\n\n- Headphone Spatial Processing (HSP): công nghệ xử lý không gian tai nghe, mô phỏng âm thanh thực như nghe qua loa với giọng hát rõ ràng và nguyên sơ. HSP giúp tai nghe khắc phục các vấn đề thường gặp là kích thước nhỏ, thiếu \"sự trao đổi\" giữa các kênh trái phải.', 5.0, 0, 1, '2025-12-14 01:23:17', 990000.00, 1980000.00, 'https://www.lg.com/content/dam/channel/wcms/vn/images/tai-nghe-khong-day/tone-fp5_cvnmllk_eavh_vn_c/gallery/DZ-01.jpg?w=800', 30, 20);
INSERT INTO `products` VALUES (20, 5, 4, 'LG-FP9', 'Tai nghe LG Bluetooth Tone Free FP9 Đen', 'Tai nghe LG Bluetooth Tone Free FP9 được trang bị rất nhiều công nghệ cao cấp như chống ồn chủ động ANC, âm thanh vòm 3D (3D Sound Stage), hộp sạc diệt khuẩn Uvnano, pin 10 tiếng, bộ xử lý Không gian (Spatial Processing), chế độ Whispering dùng tai nghe làm mic, âm thanh tinh chỉnh bởi Meridian và chống nước IPX4.\n\nThiết kế tối ưu cho sự thoải mái\nTai nghe LG Tone Free FP9 thuộc dòng tai nghe Bluetooth không dây, loại bỏ sự vướng víu khó chịu, không lo dây bị rối khi đặt trong túi hay balo. Được phát triển bằng cách phân tích hàng trăm chiếc tai, FP9 có thiết kế Vòng cung (Arc Design) với phần thân tai nghe ngắn hơn 4.4mm so với các mẫu LG TONE Free trước đó phù hợp với hình dạng của tai bạn để ngăn tai nghe rơi ra ngoài, đồng thời mang lại cảm giác vừa vặn và thoải mái hơn.', 5.0, 0, 1, '2025-12-14 01:23:17', 1790000.00, 3220000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/_/0/_0001_dz-13_1.jpg', 30, 20);
INSERT INTO `products` VALUES (21, 5, 4, 'LG-FN6', 'Tai nghe Bluetooth LG Tone Free HBS-FN6 Trắng', 'Thiết kế thông minh ôm khít tạo sự thoải mái tuyệt đối\nTai nghe Bluetooth LG Tone Free HBS-FN6 thiết kế ôm khít vừa vặn trong tai bạn với phân bổ trọng lượng tập trung vào phần đầu giúp chúng luôn thoải mái và chắc chắn. Đệm tai chất liệu silicone cao cấp không gây kích ứng giúp chống ồn hiệu quả, tạo cảm giác êm ái để bạn có thể thưởng thức nhạc lâu hơn mà không cảm thấy đang đeo tai nghe. Mọi âm thanh bạn nghe sẽ luôn sống động và không bị lẫn tạp âm, giúp bạn thưởng thức trọn vẹn những bản nhạc hay đảm bảo tiếp nhận mọi thông tin liên lạc với âm thanh rõ ràng. ', 5.0, 0, 1, '2025-12-14 01:23:17', 3490000.00, 3490000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/6/1600_6_1.jpg', 30, 20);
INSERT INTO `products` VALUES (22, 5, 4, 'LG-FP8', 'Tai nghe Bluetooth True Wireless LG Tone Free FP8', 'Tai nghe LG Tone Free FP8 còn được trang bị công nghệ chống nước IPX4. Với chuẩn chống nước hiệu quả này, người dùng có thể sử dụng thiết bị trong nhiều điều khiện thời tiết hoặc trong quá trình tập luyện.   \n\nĐèn UVnano diệt 99% vi khuẩn, gel đạt chuẩn y tế\nQuan tâm đến sức khỏe người dùng, LG trang bị cho Tone Free FP8 hộp sạc LG Free FP8 với khả năng kháng khuẩn lên đến 99.9%.\n\nVới đèn UVnano được trang bị trong bộ case, khi bạn cất giữ chiếc tai nghe vào bộ case này thì đèn UVnano sẽ được kích hoạt. Theo nhà sản xuất chỉ trong 5 giây, tai nghe LG Free FP8 sẽ loại bỏ đến 99,9% vi khuẩn.', 5.0, 0, 1, '2025-12-14 01:23:17', 1290000.00, 2320000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/_/0/_0004_dz-06_1.jpg', 30, 20);
INSERT INTO `products` VALUES (23, 6, 4, 'HV-931', 'Tai nghe Bluetooth True Wireless Havit 931', 'Về kết nối, tai nghe với chuẩn Bluetooth 5.4 giúp mang lại kết nối không dây ổn định. Cùng với đó, sản phẩm với tính năng two-way tranmission và master-slave nhờ đó cho phép người dùng có thể sử dụng độc lập riêng biệt từng tai nghe.\n\nPin 300 mAh, sử dụng bền bỉ đến 6 giờ\nTai nghe không dây Havit TW 931 được trang bị pin 30 mAh mỗi bên tai nghe cho thời gian dùng lên đến 6 giờ. Case sạc tai nghe với dung lượng 300 mAh hỗ trợ nâng cao thời gian sử dụng. Ngoài ra, sản phẩm còn được trang bị sạc nhanh qua cổng USB-C hỗ trợ bổ sung năng lượng nhanh chóng.', 5.0, 0, 1, '2025-12-14 01:23:17', 219000.00, 390000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-havit-tw-931-den.png', 30, 20);
INSERT INTO `products` VALUES (24, 6, 3, 'HV-H360', 'Tai nghe Bluetooth chụp tai Havit H630BT', 'Tai nghe H630BT chỉ cần mở ra và ốp lên tai, có thể điều chỉnh được kích thước để vừa vặn với khuôn đầu từng người. Do tính linh hoạt mà H630BT thích hợp cho nhiều đối tượng, độ tuổi.\n\nÂm thanh cực êm, pin ổn\nTai nghe Bluetooth chụp tai Havit H630BT được tích hợp driver có kích thước 40mm. Bạn có thể thưởng thức được nhiều âm thanh hay, êm dịu và trầm lắng ấn tượng.\n\nViên pin trang bị cho tai nghe Havit H630BT có thể cung cấp thời lượng nghe nhạc lên đến 36 giờ. Bạn có thể mang theo tai nghe đi đâu đó vài ngày không cần lo hết pin giữa chừng.', 5.0, 0, 1, '2025-12-14 01:23:17', 390000.00, 470000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/5/_/5_179.jpg', 30, 20);
INSERT INTO `products` VALUES (25, 6, 4, 'HV-T981', 'Tai nghe Bluetooth True Wireless Havit TW981', 'Tai nghe Havit TW981 được trang bị một thiết kế độc đáo cùng với âm thanh chất lượng vượt trội. Đây là sản phẩm đánh để mua và trải nghiệm. Vậy chính xác mẫu tai nghe Havit này có gì, hãy cùng tìm hiểu chi tiết ngay sau đây.\r\n\r\nDriver 13mm cùng công nghệ âm thanh nổi\r\nTai nghe không dây Havit TW981 được trang bị driver âm thanh kích thước lớn 13mm mang lại âm thanh chất lượng cao. Cùng với công nghệ âm thanh nổi giúp tai nghe mang lại những trải nghiệm âm chất lượng với âm bổng rõ ràng và âm trầm mạnh mẽ. Tai nghe không sử dụng núm cao su mà được trang bị thiết kế Earbuds nhờ đó giúp mang lại trải nghiệm đeo thoải mái. Tổng trọng lượng tai nghe Havit TW981 khá nhẹ, chỉ 25,72g (tính cả case sạc) nhờ đó người dùng có thể dễ dàng mang theo và sử dụng.\r\n\r\nPin dung lượng lớn, sử dụng tới 4 giờ\r\nVề thời lượng sử dụng, tai nghe bluetooth Havit TW981 được trang bị viên pin dung lượng lớn với 30 mah mỗi tai nghe và 300 mAh trong case sạc. Với dung lượng này, tai nghe mang lại 4 giờ chơi nhạc (Với mức âm lượng 60%). \r\n', 5.0, 0, 1, '2025-12-14 01:23:17', 800000.00, 890000.00, 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769428908/uoy3njkfhnuchgaad9ik.png', 30, 20);
INSERT INTO `products` VALUES (26, 6, 4, 'HV-TW888', 'Tai nghe Bluetooth True Wireless Havit LIFE 04T TW888', 'Havit Life 04T TW888 hiện đang nhận được nhiều phản hồi tích cực từ phía người dùng phổ thông. Mẫu tai nghe Havit này sở hữu kiểu dáng nhỏ gọn cùng chất lượng âm thanh ấn tượng. \n\nTrình điều khiển động 1.3cm, phản hồi nhanh\nTai nghe Bluetooth Havit Life 04T TW888 sử dụng trình điều khiển lớn 1.3cm, giúp âm thanh có độ sâu và độ rộng rõ rệt. Cấu trúc màng loa lớn tăng cường âm trầm, tái hiện hiệu ứng bass dày, lan tỏa. Âm trung và cao được cân bằng hợp lý, mang đến trải nghiệm nghe đa dạng từ nhạc nhẹ, pop đến các bản phối có tiết tấu mạnh.\nCông nghệ xử lý âm thanh được tối ưu giúp giảm thiểu méo tiếng, giữ được độ chi tiết khi phát ở mức âm lượng cao. Sự phối hợp giữa bộ giải mã âm thanh và chip Bluetooth hiện đại đảm bảo tín hiệu truyền ổn định, hạn chế hiện tượng trễ hoặc nhiễu.\n\nHavit Life 04T TW888 cũng hướng đến khả năng giải trí liền mạch, nhờ chế độ độ trễ thấp giúp đồng bộ giữa hình và tiếng khi xem video, chơi trò chơi. Từ thao tác bấm cho tới phản hồi âm thanh, mọi thứ diễn ra liền mạch, phù hợp cho cả nghe nhạc lẫn trải nghiệm nội dung đa phương tiện.\n\nPhong cách in-ear năng động, thoải mái\nTai nghe Bluetooth Havit Life 04T TW888 có kiểu dáng in-ear gọn nhẹ, mang lại cảm giác thoải mái khi đeo trong thời gian dài. Phần housing bo tròn, vừa khít tai, giúp tăng khả năng cách âm thụ động và giảm tiếng ồn bên ngoài. Kèm theo đó là hộp sạc hình vuông bo góc, nhỏ gọn và dễ bỏ túi khi di chuyển.', 5.0, 0, 1, '2025-12-14 01:23:17', 280000.00, 280000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-havit-life-04t-tw888-_4_.png', 30, 20);
INSERT INTO `products` VALUES (27, 6, 3, 'HV-H619', 'Tai nghe Bluetooth chụp tai Havit H619BT', 'Tai nghe chụp tai Havit H619BT - Trải nghiệm âm thanh vượt trội\nTai nghe Havit H619BT mang lại âm thanh sắc nét, thiết kế hiện đại, đáp ứng nhu cầu giải trí và làm việc hiệu quả. Sản phẩm nổi bật với công nghệ tiên tiến, phù hợp cho người dùng yêu thích âm nhạc chất lượng cao, cần thiết bị bền bỉ và tiện lợi khi di chuyển.\n\nÂm thanh sắc nét với công nghệ tiên tiến\nTai nghe chụp tai Havit H619BT được trang bị màng loa 40mm, mang đến âm thanh chi tiết và sống động. Dải tần 20Hz-20KHz tạo âm trầm sâu, âm trung mượt mà và âm cao rõ ràng, phù hợp với nhiều thể loại nhạc từ pop, rock đến cổ điển. Sản phẩm đáp ứng kỳ vọng của người dùng yêu cầu chất lượng âm thanh cao cấp, mang lại trải nghiệm nghe nhạc tuyệt vời.\nCông nghệ khử tiếng ồn môi trường (ENC) đảm bảo âm thanh trong trẻo, hỗ trợ giảm thiểu hiệu quả các tạp âm từ môi trường xung quanh. Công nghệ này mang lại không gian chỉ tập trung vào âm nhạc, giúp người dùng đắm chìm trong từng giai điệu. Mẫu tai nghe Havit này lý tưởng cho việc thưởng thức podcast, xem phim hoặc các buổi hòa nhạc trực tuyến.\n\nThiết kế tinh tế, màu sắc thời thượng\nVới trọng lượng chỉ 190g, tai nghe chụp tai Havit H619BT mang lại cảm giác thoải mái khi đeo trong một thời gian dài. Màu đen bóng bẩy tạo vẻ ngoài sang trọng, dễ dàng phối hợp với mọi phong cách. Chất liệu cao cấp đảm bảo độ bền lâu dài, giữ được thẩm mỹ qua thời gian sử dụng, phù hợp với người dùng chú trọng cả chức năng và kiểu dáng.', 5.0, 0, 1, '2025-12-14 01:23:17', 240000.00, 390000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-havit-h619bt-_1__1.png', 30, 20);
INSERT INTO `products` VALUES (28, 6, 3, 'HV-H02E', 'Tai nghe có dây Gaming Havit H2002E', NULL, 5.0, 0, 1, '2025-12-14 01:23:17', 590000.00, 880000.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-co-day-havit-h2002e_4_.png', 30, 20);
INSERT INTO `products` VALUES (29, 1, 4, 'SN-C510', 'Tai nghe Bluetooth Sony WF-C510', 'Tai nghe Bluetooth Sony WF-C510 cung cấp chất lượng âm thanh sôi động với bộ màng loa 6mm, cho phép bạn tận hưởng trọn vẹn mọi giai điệu yêu thích. Kèm theo đó là kết nối Bluetooth thế hệ mới, hỗ trợ quá trình ghép nối không dây ổn định, tiện lợi trong phạm vi rộng. Ngoài ra, thời lượng pin trên tai nghe Sony này còn đạt mức 22h, mang đến trải nghiệm âm nhạc liền mạch cả ngày dài mà không cần lo lắng về việc sạc pin.', 5.0, 0, 1, '2025-12-14 01:23:17', 1069000.00, 1690000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-sony-wf-c510_22_.png', 33, 20);
INSERT INTO `products` VALUES (30, 1, 3, 'SN-H3', 'Tai nghe chụp tai Gaming Sony Inzone H3', 'Tai nghe chụp tai Gaming Sony Inzone H3 sở hữu màng loa 40mm, hỗ trợ công nghệ âm thanh 360 Spatial Sound nhằm tối ưu trải nghiệm định vị trong game. Tai nghe nặng khoảng 299g cùng dây kết nối dài, hỗ trợ tương thích với nhiều nền tảng khác nhau. Với micro tích hợp, thiết kế có thể gập lên xuống, âm thanh thu được cũng rõ ràng hơn.', 5.0, 0, 1, '2025-12-14 01:23:17', 1190000.00, 1550000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-gaming-sony-inzone-h3-0.png', 33, 20);
INSERT INTO `products` VALUES (31, 1, 3, 'SN-CH720N', 'Tai nghe Sony WH-CH720N', 'Tai nghe Sony WH-CH720N được thiết kế theo dạng Over-ear hiện đại. Do được hoàn thiện từ chất liệu Composite sợi Carbon cao cấp, CH720N có độ bền bỉ và vô cùng chắc chắn trong quá trình sử dụng. Đồng thời, ưu điểm này cũng giúp phân khúc tai nghe mới này có trọng lượng khá nhẹ. Do đó, nó được quảng cáo là chiếc tai nghe chụp chống ồn chủ động nhẹ nhất hiện nay. Phần đệm tai và đầu của Sony WH-CH720N cũng khá êm ái. Tạo cảm giác nhẹ nhàng, thăng hoa trong từng giai điệu.\n', 5.0, 0, 1, '2025-12-14 01:23:17', 1845000.00, 2990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/w/h/wh-ch720_black01_m_1__1.png', 33, 20);
INSERT INTO `products` VALUES (32, 1, 4, 'SN-C710N', 'Tai nghe không dây Sony WF-C710N', 'Tai nghe không dây Sony WF-C710N sở hữu bộ màng loa 5mm, có dải tần số phản hồi từ 20Hz đến 20000Hz, tích hợp công nghệ khử ồn và âm thanh xung quanh. Sản phẩm hỗ trợ Bluetooth 5.3, kháng nước IPX4, có thời lượng pin lên đến 12 giờ (khi tắt khử ồn). Sony WF-C710N có thiết kế công thái học, hộp sạc 38g.', 5.0, 0, 1, '2025-12-14 01:23:17', 1850000.00, 2490000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/o/sony-wf-c710n-11.jpg', 33, 20);
INSERT INTO `products` VALUES (33, 1, 4, 'SN-LBF', 'Tai nghe không dây Sony LinkBuds Fit', 'Tai nghe không dây Sony LinkBuds Fit có thiết kế open-ear với trọng lượng chỉ 4.9g mỗi tai, hỗ trợ kết nối Bluetooth 5.3, khả năng chống nước IPX4. Tai nghe trang bị củ loa dạng vòng 8.4mm, tích hợp công nghệ DSEE, điều khiển âm lượng thích ứng. Thiết bị có thời lượng pin lên đến 21 giờ, kích thước nhỏ gọn 47.2 x 47.2 x 32.6mm.', 5.0, 0, 1, '2025-12-14 01:23:17', 3450000.00, 5390000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/n/sn1.png', 33, 20);
INSERT INTO `products` VALUES (34, 1, 3, 'SN-INZ', 'Tai nghe không dây Sony INZONE Buds', 'Tai nghe không dây Sony INZONE Buds đem tới trải nghiệm âm thanh sống động với hàng loạt các công nghệ tiên tiến như chống ồn chủ động, 360 Spatial Sound. Bên cạnh đó, thế hệ tai nghe này còn sở hữu thời lượng pin lên đến 12 giờ cho tai nghe và 24 giờ khi sử dụng cùng hộp sạc, đem tới trải nghiệm nghe nhạc giải trí suốt ngày dài. Đặc biệt hơn, tai nghe còn đi kèm với khả năng kháng nước IPX4, mang lại sự thoải mái và linh hoạt cho người dùng ngay cả khi đang ở trong môi trường nước. ', 5.0, 0, 1, '2025-12-14 01:23:17', 3650000.00, 4790000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-sony-inzone-buds_1__1.png', 33, 20);
INSERT INTO `products` VALUES (35, 1, 3, 'SN-INZ5', 'tai nghe chụp tai Sony INZONE H5', 'Với công nghệ 360 Spatial Sound, tai nghe chụp tai Sony INZONE H5 cho phép bạn nghe thấy hướng và khoảng cách đến đối thủ trong trò chơi. Tai nghe còn có một thời lượng pin lên đến 28 giờ, cho phép bạn chơi game suốt cả ngày mà không lo hết pin. Được thiết kế nhẹ nhàng với trọng lượng 260g, bạn có thể chơi game trong thời gian dài mà không cảm thấy mệt mỏi hay không thoải mái.', 5.0, 0, 1, '2025-12-14 01:23:17', 2540000.00, 3790000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-inzone-h5_9_.png', 33, 20);
INSERT INTO `products` VALUES (36, 1, 3, 'SN-WH900N', 'Tai nghe chụp tai Sony WHULT900N', 'Tai nghe chụp tai Sony WHULT900N được trang bị công nghệ cảm biến tiếng ồn kép và chip xử lý V1 mang tới khả năng chống ồn hoàn hảo khi sử dụng. Điều khiển cảm ứng tiện ích, công nghệ bluetooth ấn tượng, micro và điều khiển linh hoạt cùng khả năng sử dụng tới 50 giờ sử dụng khi tắt chế độ chống ồn cho mỗi lần sạc.', 5.0, 0, 1, '2025-12-14 01:23:17', 3650000.00, 4490000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-ult900n_13__1.png', 33, 20);
INSERT INTO `products` VALUES (37, 1, 3, 'SN-XM4', 'tai nghe Sony WH-1000XM4', 'Sony WH-1000XM4 được trang bị khả năng phân tích và điều khiển thời gian thực. Nhờ đó giúp tai nghe chụp tai WH-1000MX4 luôn phân tích các tiếng ồn xung quanh và điều chỉnh mức độ chống ồn nhằm mang lại cho người dùng âm thanh chất lượng tốt nhất.', 5.0, 0, 1, '2025-12-14 01:23:17', 4790000.00, 6690000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/6/4/6428314_sd.jpg', 33, 20);
INSERT INTO `products` VALUES (38, 1, 3, 'SN-H92', 'Tai nghe gaming không dây Sony Inzone H9 II ', 'Tai nghe gaming không dây Sony Inzone H9 II nổi bật với công nghệ chống ồn chủ động, được trang bị màng loa 30mm kết hợp với micro boom khử ồn vượt trội. Sản phẩm có trọng lượng nhẹ chỉ 260g, trang bị kết nối không dây kép qua Bluetooth 5.3. Mẫu tai nghe Sony này có thời lượng pin lên đến 30 giờ, có thể đáp ứng trọn vẹn các phiên chơi kéo dài.', 5.0, 0, 1, '2025-12-14 01:23:17', 7590000.00, 0.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-gaming-khong-day-sony-inzone-h9-ii_7_.png', 33, 20);
INSERT INTO `products` VALUES (39, 7, 4, 'AAP3', 'Apple Airpods 3 2022', 'Apple Airpods 3 2022 là mẫu tai nghe bluetooth mới nhất đến từ ông trùm công nghệ Apple. Tai nghe sở hữu thiết kế nhỏ gọn cùng rất nhiều công nghệ hiện đại tai nghe mang tới cho người dùng trải nghiệm âm thanh cực sống động. Dưới đây là điểm nổi bật trên Airpod 3 2022 mà bạn không nên bỏ qua.', 5.0, 0, 1, '2025-12-14 01:23:17', 2590000.00, 4490000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods3_1_1.png', 30, 20);
INSERT INTO `products` VALUES (40, 7, 4, 'AAP3-MS', 'Tai nghe Apple AirPods 3 Magsafe', 'Một trong những thế hệ tai nghe không dây được ưa chuộng nhất trên thị trường hiện nay là Apple AirPods 3 Magsafe. Tuy mới chỉ có được ra mắt giữa tháng 10 vừa qua nhưng AirPods 3 của Apple đã nhận được nhiều sự ưa chuộng từ phía người dùng và nhanh chóng trở nên phổ biến trên thị trường thời gian vừa rồi. Với thiết kế gọn nhẹ, bền bỉ cùng chất lượng âm thanh đỉnh cao, AirPods 3 chắc chắn là mẫu tai nghe Apple hoàn hảo mà bạn rất nên sở hữu.', 5.0, 0, 1, '2025-12-14 01:23:17', 2890000.00, 4790000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods3.png', 30, 20);
INSERT INTO `products` VALUES (41, 7, 4, 'AAP4-ANC', 'Apple Airpods 4 ANC', 'Apple AirPods 4 ANC sở hữu nhiều công nghệ âm thanh tiên tiến ấn tượng như công nghệ chống ồn chủ động thế hệ mới và âm thanh không gian. Tai nghe tích hợp driver chất lượng cao, cải thiện âm thanh phát ra được sống động và rõ ràng hơn. Với thiết kế in-ear thoải mái, AirPod 4 còn hỗ trợ sạc không dây Qi, hoặc có dây qua cổng sạc USB-C hiện đại. Thời lượng pin dài và sạc nhanh giúp đảm bảo tai nghe luôn sẵn sàng cho những trải nghiệm âm nhạc liền mạch.', 5.0, 0, 1, '2025-12-14 01:23:17', 4690000.00, 4990000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods-4-chong-on-2.png', 30, 20);
INSERT INTO `products` VALUES (42, 7, 4, 'AAP4', 'Apple Airpods 4 ', 'AirPods 4 là tai nghe không dây Apple với chip H2 cùng EQ thích ứng và âm thanh không gian cá nhân hóa mang lại trải nghiệm âm thanh ấn tượng. Tai nghe được trang bị Micrô kép với cảm biến quang học cùng micro hướng vào trong giúp thu âm tốt hơn. Cùng với điều khiển chạm cho phép người dùng điều khiển qua các thao tác nhấn tiện lợi.', 5.0, 0, 1, '2025-12-14 01:23:17', 4690000.00, 4990000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods-4-chong-on-2.png', 30, 20);
INSERT INTO `products` VALUES (43, 7, 4, 'APP2', 'Apple Airpods 2', 'Apple Airpods 2 sở hữu chip H1 được dành riêng giúp chuyển nhanh các cuộc gọi từ iPhone sang Airpods cũng như giảm mức tiêu thụ điện năng cực kỳ thấp. Thời gian sử dụng đến 5 giờ nghe nhạc hoặc 3 giờ đàm thoại và khi kết hợp với hộp sạc cho thời gian đến 24 giờ. Kết nối không dây chất lượng cao, tự động bật và luôn kết nối giúp sẵn sàng theo bạn đến bất kỳ đâu. Cùng tham khảo thêm về chiếc Airpod 2 này nhé.', 5.0, 0, 1, '2025-12-14 01:23:17', 2290000.00, 3990000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/m/image_2019-03-29_09-12-07_2.jpg', 30, 20);
INSERT INTO `products` VALUES (44, 7, 4, 'APP2-PRO', 'Tai nghe Bluetooth Apple AirPods Pro 2 2023', 'Airpods Pro 2 Type-C với công nghệ khử tiếng ồn chủ động mang lại khả năng khử ồn lên gấp 2 lần mang lại trải nghiệm nghe - gọi và trải nghiệm âm nhạc ấn tượng. Cùng với đó, điện thoại còn được trang bị công nghệ âm thanh không gian giúp trải nghiệm âm nhạc thêm phần sống động. Airpods Pro 2 Type-C với cổng sạc Type C tiện lợi cùng viên pin mang lại thời gian trải nghiệm lên đến 6 giờ tiện lợi.', 5.0, 0, 1, '2025-12-14 01:23:17', 5190000.00, 6190000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-pro-2-usb-c_8__1.png', 30, 20);
INSERT INTO `products` VALUES (45, 7, 4, 'APP3-PRO', 'Tai nghe Bluetooth Apple AirPods Pro 3 2025 Type-C', 'AirPods Pro 3 ra mắt tháng 9/2025, mang đến bước tiến lớn với khả năng khử tiếng ồn chủ động gấp đôi thế hệ trước, thiết kế gọn nhẹ và pin bền bỉ vượt trội. Apple tích hợp cảm biến đo nhịp tim trực tiếp trên tai nghe, biến AirPods Pro thế hệ thứ 3 thành trợ lý sức khỏe thông minh cho người dùng.', 5.0, 0, 1, '2025-12-14 01:23:17', 6790000.00, 0.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/app3.png', 30, 20);
INSERT INTO `products` VALUES (46, 7, 3, 'APP-MAX2024', 'Tai nghe chụp tai chống ồn Apple AirPods Max 2024', 'Apple Airpods Max 2024 là sản phẩm tai nghe chụp tai được trang bị trình điều khiển động do Apple thiết kế. Cùng với tính năng khử ồn chủ động và âm thanh không gian cá nhân hóa giúp mang lại âm thanh chất lượng. Tai nghe còn sở hữu màu sắc đa dạng với 5 lựa chọn màu cùng với 9 micro đàm thoại chất lượng.', 5.0, 0, 1, '2025-12-14 01:23:17', 13590000.00, 14990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-max_5__1.png', 30, 20);
INSERT INTO `products` VALUES (47, 7, 3, 'APP-MAX2021', 'Tai nghe Apple AirPods Max 2021', 'Apple AirPods Max 2021 sở hữu driver hiện đại, được thiết kế riêng bởi Apple, mang lại chất âm chi tiết và cân bằng giữa âm bass, âm trung và âm cao. Với chip H1 trên cả hai tai, thế hệ tai nghe AirPods này hỗ trợ Adaptive EQ và Spatial Audio, giúp tối ưu trải nghiệm âm thanh 3D. Hơn nữa, Active Noise Cancellation (ANC) của thiết bị còn giúp loại bỏ tiếng ồn hiệu quả, cho bạn cảm giác âm nhạc trọn vẹn nhất.', 5.0, 0, 1, '2025-12-14 01:23:17', 9490000.00, 13190000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-max-2021_1__1.jpg', 30, 20);
INSERT INTO `products` VALUES (48, 8, 4, 'MS-MN4', 'Tai nghe Bluetooth True Wireless Marshall Minor 4', 'Marshall Minor 4 là mẫu tai nghe không dây được trang bị viên pin cho thời gian sử dụng lên đến 30 giờ cùng chuẩn kháng nước IPX4 giúp tối ưu sử dụng. Tai nghe sở hữu thiết kế mang lại cho người dùng trải nghiệm dùng thoải mái. Tai nghe còn sở hữu công nghệ âm thanh giúp cho người dùng những trải nghiệm giải trí âm thanh sống động.', 5.0, 0, 1, '2025-12-14 01:23:17', 3430000.00, 3630000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/g/r/group_1160_1.png', 30, 20);
INSERT INTO `products` VALUES (49, 8, 4, 'MS-MN3', 'Tai nghe Bluetooth True Wireless Marshall Minor 3', 'Tai nghe không dây Marshall Minor 3 sẽ là một trong những lựa chọn tuyệt vời không nên bỏ qua. Sở hữu chất lượng âm thanh tuyệt hảo, thiết kế sang trọng và khả năng kết nối không dây ổn định, thế hệ tai nghe Marshall này sẽ mang đến cho bạn nhiều trải nghiệm nghe nhạc chất lượng cao và cực kỳ thoải mái.', 5.0, 0, 1, '2025-12-14 01:23:17', 2250000.00, 3990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-marshall-minor-3-2_1.jpg', 30, 20);
INSERT INTO `products` VALUES (50, 8, 3, 'MS-MJ5', 'Tai nghe Bluetooth chụp tai Marshall Major 5', 'Marshall Major 5 (V) là mẫu tai nghe cao cấp của Marshall với tinh chỉnh âm thanh đặc trưng cùng với trình điều khiển động. Tai nghe mang lại trải nghiệm âm thanh đầy sống động với độ méo tiếng thấp cùng với viên pin cho thời lượng sử dụng ấn tượng. Tai nghe còn có thể kết nối với app Marshall Bluetooth.', 5.0, 0, 1, '2025-12-14 01:23:17', 3800000.00, 4220000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-06-17_14-31-24.jpg', 30, 20);
INSERT INTO `products` VALUES (51, 8, 3, 'MS-MJ4', 'Tai nghe Bluetooth chụp tai Marshall Major 4', 'Marshall Major 4 được trang bị thiết kế không quá nhiều khác biệt với Major 3. Tai nghe được hoàn thiện từ chất liệu giả da, ở giữa chụp tai là logo Marshall. Earpad của tai mềm mại, nhờ đó người dùng có thể thoải mái sử dụng trong một thời gian dài. Tai nghe trùm đầu Marshall Major IV với nhiều thay đổi về công nghệ, nhờ đó viên pin khủng trên tai nghe có thể sử dụng lên đên 80 giờ.', 5.0, 0, 1, '2025-12-14 01:23:17', 3190000.00, 4290000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-major-4_16_.png', 30, 20);
INSERT INTO `products` VALUES (52, 8, 4, 'MS-MT', 'Tai nghe Bluetooth True Wireless Marshall Motif ANC', 'Marshall Motif ANC sở hữu một thiết kế nhỏ gọn kèm theo đó là mút tai ba kích thước giúp người dùng thoải mái hơn khi sử dụng tai nghe trong thời gian dài. Tai nghe được trang bị công nghệ chống nước IPX5 nhờ đó người dùng có thể sử dụng ngay cả khi tập luyện.', 5.0, 0, 1, '2025-12-14 01:23:17', 4110000.00, 5990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-marshall-motif-anc-5_1.jpg', 30, 20);
INSERT INTO `products` VALUES (53, 8, 4, 'MS-MT2', 'Tai nghe Bluetooth True Wireless Marshall Motif 2 ANC', 'Tai nghe không dây Marshall Motif II ANC mang lại chất lượng âm thanh ấn tượng với chức năng chống ồn chủ động (ANC) mặc dù sở hữu kích thước nhỏ gọn. Với khả năng chơi nhạc liên tục trong 30 giờ, bạn có thể thưởng thức âm nhạc suốt cả ngày mà không cần lo lắng về việc sạc lại. Sản phẩm cũng được trang bị công nghệ Bluetooth 5.3 LE, đảm bảo kết nối ổn định và nhanh chóng.', 5.0, 0, 1, '2025-12-14 01:23:17', 4860000.00, 5400000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/e/text_ng_n_-_2023-05-29t223851.134.png', 30, 20);
INSERT INTO `products` VALUES (54, 8, 3, 'MS-MN2ANC', 'Tai nghe Bluetooth Chụp Tai Marshall Monitor 2 ANC', 'Tai nghe bluetooth Marshall Monitor 2 ANC - khử tiếng ồn chủ động\nMới đây một thương hiệu nổi tiếng của Mỹ về âm thanh đã cho ra đời dòng tai nghe cao cấp với tên gọi tai nghe bluetooth Marshall Monitor 2 ANC. Tai nghe mang đến cho người dùng trải nghiệm chế độ không dây và chống ồn tự động đầy hiệu quả mang đến trải nghiệm cực kỳ thú vị.', 5.0, 0, 1, '2025-12-14 01:23:17', 6550000.00, 7850000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/h/mh-monitor-ii-anc-large-1_1__1.png', 30, 20);
INSERT INTO `products` VALUES (55, 8, 3, 'MS-MN3ANC', 'Tai nghe chụp tai chống ồn Marshall Monitor 3 ANC', 'Tai nghe Marshall Monitor 3 (III) ANC sở hữu hệ thống dynamic driver kích thước 32mm kết hợp công suất lớn, cùng công nghệ ANC chủ động chống ồn. Bên cạnh chất lượng âm thanh tuyệt hảo, mẫu tai nghe chụp tai này còn cho phép hoạt động lên tới 70 giờ. Ngoài ra, thiết kế đậm nét cổ điển cùng chất liệu da bền cũng giúp phiên bản phù hợp với nhiều đối tượng.', 5.0, 0, 1, '2025-12-14 01:23:17', 9810000.00, 0.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/o/monitor-iii-den.jpg', 30, 20);
INSERT INTO `products` VALUES (56, 9, 4, 'XM-RB6A', 'Tai nghe Bluetooth True Wireless Xiaomi Redmi Buds 6 Active', 'Tai nghe Xiaomi Redmi Buds 6 Active được trang bị trình điều khiển 14.2mm cùng 5 chế độ âm thanh để luôn mang tới chất âm trầm sâu và trải nghiệm nghe tuyệt vời cho người dùng. Mẫu tai nghe Xiaomi này còn có thời lượng hoạt động bền bỉ lên tới 30 giờ cùng khả năng sạc pin nhanh chóng. Với công nghệ Bluetooth 5.4 mới nhất, tốc độ kết nối và độ ổn định, độ trễ của Xiaomi Redmi Buds 6 Active sẽ còn được cải thiện.', 5.0, 0, 1, '2025-12-14 01:23:17', 580000.00, 590000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-xiaomi-redmi-buds-6-active_1__1.png', 30, 20);
INSERT INTO `products` VALUES (57, 9, 4, 'XM-RB6', 'Tai nghe không dây Xiaomi Redmi Buds 6', 'Tai nghe Xiaomi Redmi Buds 6 có trang bị trình điều khiển 12.4mm, pin tai nghe cho thời gian sử dụng đến 26 giờ khi tích hợp công nghệ ENC lọc tiếng ồn. Mẫu tai nghe Bluetooth này sử dụng chuẩn kết nối Bluetooth 5.4 với phạm vi 10m, hỗ trợ điều khiển cảm ứng chạm, sạc qua cổng Type-C. Hộp sạc có kích thước 61.01 x 51.71 x 24.80 mm, tai nghe 31.13 x 21.34 x 23.5 mm với khối lượng 4g.', 5.0, 0, 1, '2025-12-14 01:23:17', 1390000.00, 1490000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6_13__1.png', 30, 20);
INSERT INTO `products` VALUES (58, 9, 4, 'XM-RB6PRO', 'Tai nghe không dây Xiaomi Redmi Buds 6 Pro', 'Tai nghe không dây Xiaomi Redmi Buds 6 Pro trang bị thiết kế dạng in-ear nhằm đảm bảo trải nghiệm đeo chắc chắn khi dùng trong các hoạt động thể chất. Mẫu tai nghe không dây này được trang bị 3 micro AI với khả năng lọc gió lên tới 12m/s. Tai nghe Redmi Buds 6 Pro mang đến thời lượng pin lên đến 9.5 giờ mỗi lần sử dụng và có tổng thời lượng nghe tối đa 36 giờ.', 5.0, 0, 1, '2025-12-14 01:23:17', 1720000.00, 2490000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6-pro_17__1.png', 30, 20);
INSERT INTO `products` VALUES (59, 9, 4, 'XM-RB4LITE', 'Tai nghe Bluetooth True Wireless Redmi Buds 4 Lite', 'Redmi Buds 4 Lite là mẫu tai nghe Xiaomi mới phát triển và ra mắt quý I năm 2023. Tai nghe được trang bị trình điều khiển động kích thước 12mm giúp mang lại âm thanh chất lượng với âm trầm phong phú, âm cao rõ ràng cùng độ méo thấp. Redmi Buds 4 Lite khá nhỏ gọn với trọng lượng chỉ khoảng 3.92g cùng khả năng chống nước IP54 vượt trội. Redmi Buds 4 Lite cũng được trang bị viên pin cho thời gian sử dụng ấn tượng tới 20 giờ khi sử dụng kết hợp case sạc.\n\n', 5.0, 0, 1, '2025-12-14 01:23:17', 390000.00, 550000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/_/t_i_xu_ng_22__4_5.png', 30, 20);
INSERT INTO `products` VALUES (60, 9, 5, 'XM-OS', 'Tai nghe thể thao Xiaomi Openwear Stereo', 'Tai nghe Xiaomi OpenWear Stereo sở hữu thiết kế mở open-ear thoải mái với trọng lượng siêu nhẹ mang đến cảm giác êm ái trên tai. Tai nghe được trang bị driver động 17x12mm cùng công nghệ Hi-Res Wireless, codec LHDC với tần số đến 96kHz cho âm thanh tuyệt hảo. Xiaomi OpenWear tích hợp micro kết hợp tính năng khử ồn AI cho đàm thoại tập trung hơn. Ngoài ra tai nghe Xiaomi này còn dễ dàng kết nối với hệ sinh thái Xiaomi HyperOS vô cùng tiện lợi.', 5.0, 0, 1, '2025-12-14 01:23:17', 2050000.00, 2990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/m/image_1323.png', 30, 20);
INSERT INTO `products` VALUES (61, 9, 5, 'XM-OSPRO', 'Tai nghe Bluetooth thể thao Xiaomi OpenWear Stereo Pro', 'Tai nghe thể thao Xiaomi Openwear Stereo Pro mang đến thời lượng sử dụng ấn tượng với 8.5 giờ nghe liên tục và lên đến 45 giờ khi dùng kèm hộp sạc. Mỗi tai nghe nặng 9.7g, trang bị chuẩn kết nối Bluetooth 5.4 và có thể kết nối tiện lợi qua app Xiaomi Earbuds. Sản phẩm có thiết kế open-ear phù hợp cho các hoạt động thể thao và vận động hàng ngày.', 5.0, 0, 1, '2025-12-14 01:23:17', 4690000.00, 4990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/f/r/frame_293_1.png', 30, 20);
INSERT INTO `products` VALUES (62, 9, 4, 'XM-B5P', 'Tai nghe không dây Xiaomi Buds 5 Pro', 'Tai nghe không dây Xiaomi Buds 5 Pro thiết kế cực kỳ nhỏ gọn với dải tần siêu rộng 15–50kHz cùng công nghệ Qualcomm® aptX™ sẽ đảm bảo chất lượng âm thanh. Mẫu tai nghe Xiaomi có bộ điều khiển ba đồng trục khuếch đại kép cho trải nghiệm nghe chân thực. Tai nghe hỗ trợ khử tiếng ồn chủ động 55dB cùng thời lượng pin tới 40 giờ khi dùng chung với hộp sạc.', 5.0, 0, 1, '2025-12-14 01:23:17', 5090000.00, 5190000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/i/xiaomi-buds-5-pro.png', 30, 20);
INSERT INTO `products` VALUES (63, 9, 4, 'XM-B5PWF', 'Tai nghe không dây Xiaomi Buds 5 Pro Wifi', 'Tai nghe không dây Xiaomi Buds 5 Pro Wifi sử dụng kết nối Wi-Fi, cung cấp độ ổn định cao hơn, giúp tái hiện âm thanh Lossless với băng thông rộng. Với công nghệ chống ồn chủ động lên đến 55dB, thiết bị giúp loại bỏ hiệu quả tạp âm. Với thời lượng pin lên đến 40 giờ, sản phẩm tai nghe bluetooth này đáp ứng nhu cầu sử dụng dài lâu mà không cần sạc thường xuyên.', 5.0, 0, 1, '2025-12-14 01:23:17', 5690000.00, 5880000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/m/image_1262702217.png', 30, 20);
INSERT INTO `products` VALUES (64, 13, 4, 'SS-GBF', 'Samsung Galaxy Buds FE', 'Samsung Galaxy Buds FE tích hợp chức năng chống ồn chủ động (ANC) đi kèm loa một chiều giúp tạo không gian yên tĩnh và cho chất lượng âm thanh tuyệt vời. Thiết kế in-ear dạng vây cá mập của tai nghe đảm bảo ôm sát và thoải mái. Không chỉ vậy, viên pin dung lượng lớn cho cả tai nghe và hộp sạc đảm bảo nguồn năng lượng cả ngày dài. ', 5.0, 0, 1, '2025-12-14 01:23:17', 950000.00, 1990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/a/samsung-galaxy-buds-fe-trang.png?_gl=1*ww1qqe*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NzI4JGo1NCRsMCRoMTUwNzM1MD', 30, 20);
INSERT INTO `products` VALUES (65, 13, 4, 'SS-GBC', 'Samsung Galaxy Buds Core', 'Tai nghe Bluetooth Samsung Galaxy Buds Core sở hữu công nghệ âm thanh không dây hiện đại, với chuẩn kết nối Bluetooth 5.4, cùng khả năng kháng nước IP54. Thời lượng pin ấn tượng đạt 35 giờ sử dụng khi tắt ANC. Sản phẩm trang bị codec AAC, SBC, Scalable Codec, tích hợp AI hỗ trợ đàm thoại rõ ràng, với khả năng phiên dịch cuộc gọi.', 5.0, 0, 1, '2025-12-14 01:23:17', 1190000.00, 0.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/c/_/c_4_1.png?_gl=1*40bgvw*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0Mzg2JGo2MCRsMCRoMTUwNzM1MDM4MA..', 30, 20);
INSERT INTO `products` VALUES (66, 13, 4, 'SS-GB3', 'SamSung Galaxy Buds 3 ', 'Samsung Galaxy Buds 3 là mẫu tai nghe không dây sở hữu thiết kế Open-type cùng 2 lựa chọn màu sắc là trắng và bạc sang trọng. Tai nghe với công nghệ  âm thanh Hi-Fi cùng với ANC hỗ trợ mang lại trải nghiệm âm sống động. Cùng với đó, tai nghe còn hỗ trợ AI, hỗ trợ dịch thuật trực tiếp một cách hiệu quả.', 5.0, 0, 1, '2025-12-14 01:23:17', 3500000.00, 3920000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/a/samsung-galaxy-buds-3-6_1.png?_gl=1*17426mw*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEzMjM3JGo0NyRsMCRoMTUwNzM1MDM4', 30, 20);
INSERT INTO `products` VALUES (67, 13, 4, 'SS-GB3P', 'SamSung Galaxy Buds 3 Pro ', 'Tai nghe SamSung Galaxy Buds 3 Pro trang bị dải tần âm rộng từ 2.4GHz đến 2.48GHz và phạm vi kết nối lên đến 10-12 mét giúp đảm bảo kết nối ổn định hơn. Sản phẩm trang bị công nghệ Bluetooth 5.0 + EDR kết hợp sạc không dây Qi và tương thích với cả dòng điện thoại thông minh iPhone và Android. Bên cạnh đó, hộp sạc có pin dung lượng là 400mAh , cung cấp thời gian sạc nhanh trong khoảng 1-2 giờ và đủ để sử dụng trong thời gian dài. Các loa được tích hợp bao gồm loa trầm 11mm và loa 6.5mm, mang lại âm thanh rõ ràng. ', 5.0, 0, 1, '2025-12-14 01:23:17', 3990000.00, 5400000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-samsung-galaxy-buds-3-pro_9__1.png?_gl=1*924016*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyNjQwJGo2JGwwJGg', 30, 20);
INSERT INTO `products` VALUES (68, 2, 4, 'JBL-LP2', 'JBL Live Pro 2 ', 'Sản phẩm JBL Live Pro 2 có thiết kế độc đáo, hút mắt cùng khả năng loại bỏ tiếng ồn tuyệt vời đã thu hút sự quan tâm của không ít người dùng. Dòng tai nghe không dây có thể thưởng thức âmnhạc, thực hiện cuộc gọi và không bị ảnh hưởng bởi bất kỳ tiếng ồn nào từ môi trường xung quanh. ', 5.0, 0, 1, '2025-12-14 01:23:17', 2150000.00, 3990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/7/_/7_60_1_2.png?_gl=1*1torzzp*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyMDk1JGo1MyRsMCRoMTUwNzM1MDM4MA..', 30, 20);
INSERT INTO `products` VALUES (69, 2, 4, 'JBL-EZ', 'JBL Endurance Zone', 'Tai nghe Bluetooth JBL Endurance Zone trang bị công nghệ JBL OpenSound sống động, cho phép người dùng nghe nhạc mà vẫn nhận biết âm thanh xung quanh. Driver dynamic 18x11mm kết hợp thuật toán tăng cường âm trầm giúp âm thanh thêm phần sâu lắng. Thiết kế móc tai silicon mềm mại, trọng lượng nhẹ hỗ trợ dễ dàng mang theo cả ngày.', 5.0, 0, 1, '2025-12-14 01:23:17', 3490000.00, 0.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/j/b/jbl_endurance_zone_1.png?_gl=1*16smani*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEwMTE5JGoyNSRsMCRoMTUwNzM1MDM4MA..', 30, 20);
INSERT INTO `products` VALUES (70, 2, 4, 'JBL-TB2G', 'JBL Tune Beam 2 Ghost', 'Tai nghe JBL Tune Beam 2 Ghost là mẫu tai nghe sở hữu âm thanh JBL Pure Bass cùng trình điều khiển 10mm tối ưu trải nghiệm. Tau nghe còn sở hữu công nghệ Adaptive Noise Cancelling hỗ trợ loại bỏ tiếng ồn giúp mang lại cho người dùng trải nghiệm nghe hiệu quả, không ảnh hưởng từ môi trường. Sản phẩm cũng sở hữu 6 micro giúp cho quá trình đàm thoại rõ nét hơn.', 5.0, 0, 1, '2025-12-14 01:23:17', 0.00, 0.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/g/h/ghost.png?_gl=1*1302p2v*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwOTYwJGozNCRsMCRoMTMyNzAwMDEyNg..', 30, 20);
INSERT INTO `products` VALUES (71, 2, 4, 'JBL-T520BT', 'JBL Tune 520BT', 'Tai nghe JBL Tune 520BT là sản phẩm tai nghe bluetooth mới của JBL. Tai nghe với thiết kế nhiều màu sắc cùng với đó là nhiều công nghệ âm thanh giúp mang lại cho người dùng trải nghiệm giải trí vượt trội.', 5.0, 0, 1, '2025-12-14 01:23:17', 990000.00, 1360000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tune-520bt_4__1.png?_gl=1*1yafa1*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwNjY1JGoxOSRsMCRoM', 30, 20);
INSERT INTO `products` VALUES (72, 2, 4, 'JBL-TF', 'JBL Tune Flex', 'Tai nghe JBL Tune Flex với trình điều khiển 12 mm cùng thiết kế thông minh nhờ đố mang lại trải nghiệm âm thanh vượt trội, đặc biệt là âm bass. Tai nghe với 4 micro hỗ trợ đàm thoại tiện lợi cùng với công nghệ khử ồn thông minh. Thiết bị với viên pin mang lại thời gian sử dụng lên tới 32 giờ, trong đó 8 giờ sử dụng với tai nghe và 24 giờ trên case sạc.', 5.0, 0, 1, '2025-12-14 01:23:17', 1890000.00, 1990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/_/t_i_xu_ng_-_2023-02-11t211953.503_1.png?_gl=1*kcbslm*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MzUzJGo2MCRsMCRoMTc', 30, 20);
INSERT INTO `products` VALUES (73, 2, 4, 'JBL-TB', 'JBL Tune Beam', 'Tai nghe JBL Tune Beam được trang bị đệm tai êm ái cùng thiết kế nhỏ gọn phù hợp nhiều khuôn tai cùng nhiều màu sắc lựa chọn như đen, trắng, tím và xanh dương. Tai nghe còn được trang bị tới 4 micro cùng công nghệ khử ồn chủ động ANC nhờ đó mang lại những cuộc đàm thoại rõ nét. Cùng với đó, mẫu tai nghe JBL này còn được trang bị viên pin dung lượng lớn mang lại thời gian sử dụng lên đến 12 giờ và có thể tới 36 giờ nếu kết hợp case sạc.', 5.0, 0, 1, '2025-12-14 01:23:17', 1750000.00, 2490000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tune-beam-den.png?_gl=1*jybdqx*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MDExJGo2MCRsMCRoMT', 30, 20);
INSERT INTO `products` VALUES (74, 2, 4, 'JBL-WB2', 'JBL Wave Buds 2', 'Chiếc tai nghe JBL Wave Buds 2 là sản phẩm âm thanh nổi bật với công nghệ âm thanh JBL Pure Bass, nhờ đó mà nó mang đến âm bass mạnh mẽ, sống động. Tính năng Khử tiếng ồn chủ động (ANC) giúp loại bỏ tiếng ồn xung quanh, trong khi Smart Ambient cho phép điều chỉnh âm thanh môi trường. Với 4 micro, cuộc gọi luôn rõ ràng và chuẩn IP54 đảm bảo khả năng kháng nước và bụi. Thời lượng pin lên đến 40 giờ cùng khả năng sạc nhanh, và tính năng Multi-point giúp tai nghe kết nối hai thiết bị Bluetooth cùng lúc.', 5.0, 0, 1, '2025-12-14 01:23:17', 1590000.00, 1690000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/w/a/wave.png?_gl=1*1ezpwto*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NTQ2JGo1MyRsMCRoMTc5NTY3NDcyMw..', 30, 20);
INSERT INTO `products` VALUES (75, 2, 4, 'JBL-SL', 'JBL Sense Lite', 'Tai nghe thể thao JBL Sense Lite là mẫu tai nghe nổi bật với công nghệ JBL OpenSound độc quyền, mang đến trải nghiệm âm thanh sống động. Sản phẩm được trang bị driver 18x11mm cùng thuật toán tăng bass tự động, giúp tái tạo âm thanh mạnh mẽ. Bên cạnh đó, JBL Sense Lite còn tích hợp 4 micro cùng thiết kế chống ồn gió hiệu quả. ', 5.0, 0, 1, '2025-12-14 01:23:17', 2590000.00, 0.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-the-thao-jbl-sence-lite_19__2.png?_gl=1*1ninkpl*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzAwJGo2MCRsMCR', 30, 20);
INSERT INTO `products` VALUES (76, 2, 3, 'JBL-L670NC', 'JBL Live 670NC', 'Tai nghe chụp tai JBL Live 670NC sở hữu viên pin dung lượng lớn, cung cấp thời gian chơi nhạc lên đến 65h cùng khả năng kết nối Bluetooth 5.3 siêu mượt mà. Chất âm trên thế hệ tai nghe JBL này cũng được đánh giá là khá sôi động, lôi cuốn nhờ được trang bị củ loa 40mm cùng công nghệ xử lý âm thanh Personi-Fi 2.0. Ngoài ra, sản phẩm tai nghe JBL còn sở hữu đa dạng các phiên bản màu sắc đa dạng cho tai nghe trở nên phong cách và cực kỳ cá tính.', 5.0, 0, 1, '2025-12-14 01:23:17', 2690000.00, 2990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-live-670nc_7_.png?_gl=1*uq2uqc*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzMzY1JGo2MCRsMCRoMTc', 30, 20);
INSERT INTO `products` VALUES (77, 2, 4, 'JBL-LB3', 'JBL Live Beam 3', 'Tai nghe JBL Live Beam 3 được trang bị driver 6mm, tích hợp công nghệ JBL Pure Bass Sound, khử ồn chủ động ANC và tính năng TalkThru tiện lợi. Tai nghe đem đến thời gian sử dụng lâu dài lên đến 48 giờ khi tắt ANC và 40 giờ khi bật ANC. Người dùng còn có thể dễ dàng tùy chỉnh âm thanh theo sở thích thông qua ứng dụng JBL Headphones.', 5.0, 0, 1, '2025-12-14 01:23:17', 3915000.00, 0.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-08-03_10-14-57.jpg?_gl=1*158376c*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjI0JGo0MiRsMCRoMTc5NTY3NDcy', 30, 20);
INSERT INTO `products` VALUES (78, 2, 4, 'JBL-TP2', 'JBL Tour Pro 2', 'JBL Tour Pro 2 với thiết kế hộp sạc thông minh cho phép người dùng có thể kiểm soát các cài đặt âm thanh, quản lý cuộc gọi hay phát lại nhạc, đặt báo thức mà không cần điện thoại. Tai nghe JBL Tour Pro 2 được trang bị  4 micrô với cảm biến tiếng ồn giúp tự động khử tiếng ồn theo môi trường giúp người dùng có những trải nghiệm nghe hiệu quả.', 5.0, 0, 1, '2025-12-14 01:23:17', 3999000.00, 5990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-2-vang_1.png?_gl=1*18p2p5h*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyMDE3JGo1MSRsM', 30, 20);
INSERT INTO `products` VALUES (79, 2, 3, 'JBL-L770NC', 'JBL Live 770NC', 'Tai nghe chụp tai JBL Live 770NC là một tai nghe over-ear gập gọn với thiết kế nhẹ nhàng với khả năng hủy tiếng ồn thông minh và tính năng cá nhân hóa. Sở hữu thời lượng pin ấn tượng lên đến 65 giờ cùng khả năng sạc nhanh, bạn có thể tận hưởng âm nhạc suốt cả ngày mà không lo gián đoạn. Chất âm JBL Signature được tái hiện sống động qua trình điều khiển động 40mm. Mẫu tai nghe JBL này còn có công nghệ JBL True Adaptive ANC để loại bỏ tiếng ồn và môi trường xung quanh. Kết nối Bluetooth 5.3 và LE Audio đảm bảo truyền phát âm thanh không dây chất lượng cao, mang đến trải nghiệm âm nhạc đỉnh cao.', 5.0, 0, 1, '2025-12-14 01:23:17', 4090000.00, 4490000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-07-29_15-35-34.jpg?_gl=1*1trszsf*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYxNDMxJGo2MCRsMCRoMTc5NTY3NDcy', 30, 20);
INSERT INTO `products` VALUES (80, 2, 4, 'JBL-TP3', 'JBL Tour Pro 3', 'Tai nghe JBL Tour Pro 3 đem tới chất lượng âm thanh lôi cuốn hàng đầu với công nghệ JBL Pro Sound cao cấp cùng chống ồn chủ động (ANC) cực xịn. Mẫu tai nghe JBL mới này cũng được cải tiến về mặt thiết kế để có tạo hình nhỏ gọn, dễ đeo và không gây khó chịu khi nghe nhạc giải trí. Ngoài ra, màn hình cảm ứng sắc nét của tai nghe cũng được nâng cấp lên đến 1.57’’, cho phép truy cập nhanh vào các tính năng quan trọng chỉ bằng cách chạm nhẹ.', 5.0, 0, 1, '2025-12-14 01:23:17', 5880000.00, 0.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-3-latte.jpg?_gl=1*1i8i86w*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTU5Mzg5JGo1OCRsMC', 30, 20);
INSERT INTO `products` VALUES (81, 2, 3, 'JBL-TOM3', 'JBL Tour ONE M3', 'JBL Tour ONE M3 không chỉ mang đến âm thanh chất lượng cao mà còn nâng tầm trải nghiệm nghe nhạc của bạn với hàng loạt công nghệ tiên tiến. Dù bạn đang làm việc, thư giãn hay di chuyển, mẫu tai nghe JBL này giúp bạn đắm chìm trong không gian âm nhạc cá nhân mà không bị ảnh hưởng bởi tiếng ồn xung quanh.', 5.0, 0, 1, '2025-12-14 01:23:17', 9805000.00, 0.00, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tour-one-m3-0-_8_.png', 30, 20);
INSERT INTO `products` VALUES (82, 2, 4, 'JBL-TB2', 'JBL Tune Buds 2', 'JBL Tune Buds 2 tích hợp kích thước driver đạt đến 10mm cùng chỉ số kháng nước, bụi bẩn đạt chuẩn IP54 và khả năng chống ồn chủ động. Đi kèm theo đó là 6 micro đảm bảo cuộc gọi của bạn luôn mượt mà. Ngoài ra, tai nghe còn có thời gian sạc đầy pin chỉ 2 giờ và tổng thời gian phát nhạc đến 48 giờ khi sử dụng chung với dock sạc. ', 5.0, 0, 1, '2025-12-14 01:23:17', 2590000.00, 2690000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/u/tune-bl.png?_gl=1*2txrjl*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzODU1JGo0NCRsMCRoMTc5NTY3NDcyMw..', 30, 20);
INSERT INTO `products` VALUES (83, 2, 6, 'JBL-PS320', ' JBL PartyBox Stage 320', 'Loa JBL PartyBox Stage 320 có khả năng phát nhạc sôi động và mạnh mẽ khi sở hữu công suất lên đến 240W cùng thời lượng pin lâu dài 18 giờ liên tục. Kết hợp với đó là công nghệ Bluetooth 5.4 và khả năng kết nối với ứng dụng JBL PartyBox trên điện thoại. Thiết bị cũng có chỉ số chống nước IPX4 và hệ thống đèn LED bắt mắt.\nƯu điểm nổi bật ở sản phẩm nhà JBL nằm ở công nghệ phân tích tín hiệu Ai Sound Boost thông minh. Theo đó, thuật toán Ai có khả năng phân tích và tối ưu chất âm giúp những bản nhạc mạnh mẽ và hay hơn. Ngoài ra, công nghệ Ai trên loa karaoke JBL Stage 320 còn giảm tối đa hiện tượng méo tiếng khi phát nhạc ở âm lượng lớn. \nKiểu dáng nhỏ gọn cùng hệ thống đèn LED bắt mắt\nMang đến chất âm mạnh mẽ với tính năng ghép nối 2 loa\nThoải mái giải trí nhờ có thời lượng pin lâu dài', 5.0, 0, 1, '2025-12-14 01:23:17', 14900000.00, 15610000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/j/b/jbl-partybox-stage-320.jpg', 30, 20);
INSERT INTO `products` VALUES (84, 2, 6, 'JBL-P310', 'Loa Bluetooth JBL PartyBox 310', 'JBL PartyBox 310 là một sản phẩm đến từ thương hiệu JBL chất lượng với chất âm mạnh mẽ, hiệu ứng ánh sáng độc đáo. JBL PartyBox 310 hứa hẹn mang đến cho người dùng trải nghiệm âm thanh tuyệt vời.\nThiết kế nhỏ gọn – đèn LED màu sắc bắt mắt – chân kéo tiện lợi\nPhía chính nổi bật với hai vàng loa được trang bị hệ thống ánh sáng LED RGB có thể thay đổi hệ thống màu sắc với nhiều chế độ khác nhau như Meter, Pulse và Party Mode. Nhờ đó mang đến không gian âm nhạc sống động, như ở trong một bữa tiệc lớn.\nCông nghệ JBL Signature Sound cùng TWS\nÂm thanh công suất 240W, âm trầm sâu\n', 5.0, 0, 1, '2025-12-14 01:23:17', 10990000.00, 14900000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_partybox_310_1.png', 30, 20);
INSERT INTO `products` VALUES (85, 2, 6, 'JBL-B4', 'Loa Bluetooth JBL Boombox 4', 'JBL Boombox 4 nổi bật với công suất mạnh mẽ, thiết kế hiện đại và khả năng kháng nước IP68 tối ưu, đáp ứng mọi nhu cầu giải trí không dây của người dùng. Với kích thước gọn gàng, chỉ 506.4mm x 262.9mm x 212.9mm, loa mang lại sự tiện lợi khi di chuyển. Loa Boombox 4 của JBL này còn sở hữu kết nối Bluetooth 5.4, giúp đường truyền ổn định suốt quá trình sử dụng.\nÂm thanh JBL Pro và AI Sound Boost\nThiết kế cứng cáp, màu sắc hiện đại\nKết nối ổn định với chuẩn Bluetooth 5.4 hiện đại\nThời lượng pin lên tới 34 giờ và có hỗ trợ sạc nhanh\nKhả năng kháng nước, kháng bụi IP68 cực bền bỉ', 5.0, 0, 1, '2025-12-14 01:23:17', 13900000.00, 13900000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/b/bb6_1.png?_gl=1*co4z0n*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4Mzc5MTUkajMkbDAkaDI5MDAxNDM1Mg..', 30, 20);
INSERT INTO `products` VALUES (86, 2, 6, 'JBL-A500', 'Loa Bluetooth JBL Authentics 500', 'Loa JBL Authentics 500 là một sản phẩm cao cấp của nhà JBL với công suất 270W và hệ thống âm thanh kênh 3.1 giúp tái tạo âm thanh chi tiết. Được trang bị công nghệ Dolby Atmos Music, loa mang đến trải nghiệm âm thanh sống động. Kết nối qua Bluetooth 5.3 và Wi-Fi tích hợp, loa JBL Authentics 500 cho phép truyền phát nhạc từ xa và truy cập vào các dịch vụ nhạc trực tuyến. \nThiết kế tinh tế: kết hợp với phong retro hoài cổ, JBL Authentics 500 trở thành chiếc loa có tính thẩm mỹ cao và linh hoạt bố trí ở nhiều căn phòng khác nhau.\nCông nghệ âm thanh: công suất 270W cùng công nghệ Dolby Atmos tạo nên trải nghiệm âm thanh sống động như đang ngồi trong buổi hoà nhạc đích thực.\nKết nối thông minh: Chỉ cần có Wifi, mạng ethernet, Bluetooth và các ứng dụng kết nối, bạn dễ dàng stream nhạc nhanh chóng với vài thao tác đơn giản. \nSự kết hợp hoàn hảo giữa hiện đại và cổ điển retro\nStream nhạc nhanh chóng qua Wifi và JBL One App', 5.0, 0, 1, '2025-12-14 01:23:17', 13490000.00, 16900000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-500_9_.png', 30, 20);
INSERT INTO `products` VALUES (87, 2, 6, 'JBL-PEE2', 'Loa Bluetooth JBL Partybox Encore Essential 2', 'Loa JBL Partybox Encore Essential 2 mang lại âm thanh mạnh mẽ với công suất 100W và công nghệ JBL Original Pro Sound, giúp thể hiện rõ từng chất âm. Hệ thống đèn LED nhấp nháy theo nhạc tạo không khí sôi động cho mọi bữa tiệc. Hỗ trợ Bluetooth 5.4, kết nối nhanh và ổn định. Với chuẩn kháng nước IPX4, loa hoạt động tốt trong nhiều điều kiện.\nCông suất mạnh mẽ, công nghệ âm thanh sống động\nThiết kế nhỏ gọn, màu sắc hiện đại\nTính năng đa dạng, hỗ trợ kết nối linh hoạt\nThời lượng pin ổn định, phù hợp sử dụng dài lâu\nKhả năng bảo vệ tốt, kháng nước IPX4', 5.0, 0, 1, '2025-12-14 01:23:17', 9900000.00, 9900000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/e/_/e_4.png', 30, 20);
INSERT INTO `products` VALUES (88, 2, 6, 'JBL-PEE', 'Loa JBL PartyBox Encore Essential', 'Loa bluetooth JBL Encore Essential sở hữu thiết kế khá mới mẻ, độc đáo, và kích thước cực nhỏ gọn. JBL Encore Essential có dạng hình vuông, và những đường góc cạnh vát cong nhẹ nhàng. Bên cạnh đó, phía trên loa karaoke thiết kế tay cầm giúp người dùng mang theo đến bất kỳ sự kiện, bữa tiệc nào một cách dễ dàng.\nKiểu dáng vuông vắn sang trọng\nÂm thanh sống động\n', 5.0, 0, 1, '2025-12-14 01:23:17', 5490000.00, 5490000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/3/_/3_121_1.png', 30, 20);
INSERT INTO `products` VALUES (89, 2, 6, 'JBL-H', 'Loa Bluetooth JBL Horizon', 'Loa JBL Horizon là mẫu loa bluetooth kết hợp đồng hồ báo thức độc đáo với hai phiên bản màu trắng và đen, loa với màn hình LCD có thể tự đồng điều chỉnh độ sáng. Phiên bản loa JBL này với công nghệ kết nối không dây bluetooth nhờ đó có thể kết nối với nhiều thiết bị khác nhau.\nThiết kế loa kết hợp đồng hồ độc đáo\nKết nối không dây Bluetooth ổn định\nÂm thanh nổi sống động', 5.0, 0, 1, '2025-12-14 01:23:17', 1350000.00, 2490000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/f/r/frame_11.png', 30, 20);
INSERT INTO `products` VALUES (90, 2, 6, 'JBL-H2', 'Loa Bluetooth JBL Horizon 2', 'Loa JBL Horizon 2 với thiết kế tròn lạ mắt, đèn LED viền hiện đại và màn hình LCD lớn hiển thị rõ ràng thông tin cần thiết trên thiết bị. Hệ thống âm thanh công suất 2 x 4W RMS kết hợp dải tần 75Hz–20kHz mang đến trải nghiệm nghe ấn tượng. Công nghệ âm thanh JBL Pro tạo ra chất âm trong trẻo khi nghe.\nJBL Horizon 2 là mẫu loa Bluetooth kết hợp đồng hồ báo thức hiện đại, mang đến sự tiện lợi và tinh tế cho không gian sống. Với thiết kế đẹp mắt cùng chất âm ấn tượng, loa phục vụ tốt nhu cầu nghe nhạc và tạo điểm nhấn cho bàn làm việc của người dùng.\nCông suất lớn và chất âm rõ ràng\nThiết kế độc đáo và điều chỉnh đơn giản\nCông nghệ âm thanh sống động', 5.0, 0, 1, '2025-12-14 01:23:17', 2690000.00, 2990000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_front_black_v2_0254_x5.jpg', 30, 20);
INSERT INTO `products` VALUES (91, 2, 6, 'JBL-H3', 'Loa Bluetooth JBL Horizon 3', 'Loa Bluetooth JBL Horizon 3 nổi bật với hệ thống âm thanh nổi JBL Signature, kết hợp công nghệ Bluetooth 5.3 kèm tính năng Auracast ghép nối nhiều loa. Thêm vào đó, phiên bản này còn tích hợp tính năng báo thức, cùng với khả năng điều chỉnh độ sáng và nhiệt độ màu. Ngoài ra, chiếc loa JBL này sử dụng cổng sạc USB-C tiện lợi áp dụng cho mọi thiết bị.\nJBL Horizon 3 tiếp tục khẳng định đẳng cấp với công nghệ âm thanh JBL Signature, mang đến trải nghiệm âm thanh trọn vẹn và sống động. Theo đó, loa thể hiện chất âm mạnh mẽ, cân bằng giữa dải âm trầm sâu lắng, trung âm rõ ràng và âm cao trong trẻo. \nThiết kế tiện lợi, màu thanh lịch\nÂm thanh không gian, ghép nối loa Auracast \nCổng sạc USB-C, núm điều khiển thân thiện', 5.0, 0, 1, '2025-12-14 01:23:17', 3490000.00, 4990000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-xam_10_.png', 30, 20);
INSERT INTO `products` VALUES (92, 2, 6, 'JBL-F7', 'Loa Bluetooth JBL Flip 7', 'Loa bluetooth JBL Flip 7 sở hữu công suất đầu ra 35W RMS cùng thiết kế Tweeter riêng biệt, mang đến âm thanh mạnh mẽ với dải cao sắc nét ấn tượng. Loa sở hữu viên pin Li-ion polymer 4800mAh giúp người dùng tận hưởng tới 14 giờ phát nhạc liên tục. Chuẩn kháng nước, chống bụi IP68 cho phép Flip 7 hoạt động bền bỉ trong nhiều môi trường khác nhau.\nChất âm mạnh mẽ, thiết kế năng động\nCông nghệ AI Sound Boost tối ưu âm thanh\nThiết kế gọn nhẹ, bền bỉ, tiện dụng cho mọi hành trình\nKết nối Bluetooth 5.4 tiên tiến, hỗ trợ ghép nối đa loa\nChuẩn kháng nước IP68, đảm bảo độ bền bỉ cao', 5.0, 0, 1, '2025-12-14 01:23:17', 3520000.00, 3520000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-flip-7_23__1.png', 30, 20);
INSERT INTO `products` VALUES (93, 2, 6, 'JBL-GE', 'Loa Bluetooth JBL Go Essential', 'Loa Bluetooth JBL GO Essential là một trong những thiết bị âm thanh của thương hiệu JBL thành công nhất tại thị trường Việt Nam. Nhờ vào thiết kế nhỏ gọn cùng chất lượng âm thanh mềm mại, lôi cuốn, chiếc loa JBL này sẽ mang tới cho người dùng những trải nghiệm giải trí tuyệt vời nhất.\nThiết kế gọn nhẹ, khả năng chống nước, chống bụi hoàn hảo\nChất âm sống động, lôi cuốn\n', 5.0, 0, 1, '2025-12-14 01:23:17', 690000.00, 790000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/_/2_jbl_go_essential_front_black_31581_x1.png', 30, 20);
INSERT INTO `products` VALUES (94, 2, 6, 'JBL-GE2', 'Loa Bluetooth JBL Go Essential 2', 'JBL Go Essential 2 là dòng loa di động chất lượng cao của thương hiệu JBL. Dòng loa Go Essential 2 của thương hiệu JBL luôn được người dùng đánh giá cao nhờ chất lượng vượt trội dù ngoại hình khá nhỏ gọn.\nCông suất ấn tượng, độ nhiễu thấp\nTrọng lượng nhẹ, tính di động cao\nKết nối ổn định, cổng sạc Type-C tiện lợi\nChống bụi, kháng nước tốt theo chuẩn IP67', 5.0, 0, 1, '2025-12-14 01:23:17', 890000.00, 970000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-essential-2_10_.png', 30, 20);
INSERT INTO `products` VALUES (95, 2, 6, 'JBL-G3', 'Loa Bluetooth JBL Go 3', 'Hầu hết trên thị trường có rất ít dòng loa Bluetooth có sự nhỏ gọn vừa vặn lòng bàn tay nhưng chất lượng âm thanh rất tốt. Loa JBL GO 3 là một trong những sản phẩm đi đầu trong xu hướng này và mang đến một chất lượng tuyệt vời nhất cho người dùng khi sử dụng hằng ngày.\nNhỏ gọn vừa lòng bàn tay, quai xỏ ngón chắc chắn, nhiều màu sắc\nChống nước và chống bụi IP67, pin sạc nhanh sử dụng lên đến 5 giờ liên tục\nChất lượng âm thanh tốt âm lượng vừa, kết nối Bluetooth 5.1', 5.0, 0, 1, '2025-12-14 01:23:17', 790000.00, 1090000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_go_3_11.png', 30, 20);
INSERT INTO `products` VALUES (96, 2, 6, 'JBL-G4', 'Loa Bluetooth JBL Go 4', 'Loa Bluetooth JBL Go 4 sở hữu âm thanh JBL Pro Sound mang lại âm trầm mạnh mẽ cùng viên pin cho thời gian sử dụng lên đến 7 giờ. Cùng với đó sản phẩm loa JBL còn được trang bị chuẩn kháng nước IP67 cùng với đó là thiết kế từ vật liệu tái chế với nhiều màu như đỏ, xanh, trắng, tím, đen. Để nâng cao các trải nghiệm âm thanh, loa còn được trang bị Auracast cho phép ghép đôi 2 loa JBL Go 4, nâng cao trải nghiệm giải trí.\nÂm thanh JBL Pro sống động, màu sắc bắt mắt\nÂm thanh JBL Pro, công suất âm thanh 4,2 RMS\nThiết kế màu sắc bắt mắt, thân thiện với môi trường\nChuẩn bảo vệ IP67, sạc thông minh', 5.0, 0, 1, '2025-12-14 01:23:17', 1070000.00, 1070000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-4_5_.png', 30, 20);
INSERT INTO `products` VALUES (97, 2, 6, 'JBL-C3', 'Loa Bluetooth JBL CLIP 3', 'Loa bluetooth JBL Clip 3 là sản phẩm đến từ hãng JBL – thương hiệu nổi tiếng về các dòng loa bluetooth cao cấp. Tiếp nối người đàn anh JBL Clip 2 của mình cùng với những tính năng vượt trội mới, hứa hẹn sẽ là sự lựa chọn hoàn hảo cho những ai đang có nhu cầu sở hữu một chiếc loa chính hãng tốt.\nThiết kế dáng tròn, móc treo, khung kim loại cứng cáp, trọng lượng 210g\nÂm thanh trong trẻo, đường kính 40mm, âm tần 120 Hz – 20 kHz\nChống nước chuẩn IPX7, công nghệ JBL Connect + được tích hợp trên loa bluetooth JBL Clip 3\nThời lượng pin 1000 mAh nghe nhạc liên tục 10 tiếng, jack cắm 3.5 mm', 5.0, 0, 1, '2025-12-14 01:23:17', 1480000.00, 1480000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/1/_/1_17_25_2.jpg', 30, 20);
INSERT INTO `products` VALUES (98, 2, 6, 'JBL-C4', 'Loa Bluetooth JBL Clip 4', 'Đa số người hay nghe nhạc đều lựa chọn cho mình những chiếc loa có kích thước nhỏ gọn nhưng chất âm lại rất tốt khi nghe. Biết được điều này JBL đã trang bị cho loa Bluetooth JBL CLIP 4 rất nhiều tính năng hiện đại với khả năng phát ra âm thanh rất tốt tiện lợi và chất lượng nhất cho bạn.\nKích thước nhỏ gọn, móc đeo tiện lợi, nhiều màu sắc\nPin sạc nhanh qua cổng USB - C phát liên tục 10 giờ, chống nước IP67\nCông nghệ Bluetooth 5.1, chất lượng âm thanh cao cấp', 5.0, 0, 1, '2025-12-14 01:23:17', 1590000.00, 1590000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-clip-4-den_1.jpg', 30, 20);
INSERT INTO `products` VALUES (99, 2, 6, 'JBL-C5', 'Loa Bluetooth JBL Clip 5', 'Loa JBL Clip 5 sở hữu vẻ ngoài nhỏ gọn cùng tần số 120Hz-20 kHz, thời gian sử dụng lên tới 4-5 tiếng giúp mang lại khả năng phát nhạc hoàn hảo. Không chỉ vậy, sản phẩm cũng sở hữu kết nối bluetooth, jack cắm AUX và thẻ nhớ TF hỗ trợ đa dạng trải nghiệm của người dùng. \nThiết kế nhẹ nhàng ẩn chứa chất âm vô cùng đỉnh cao\nCông suất, công nghệ âm thanh cực đỉnh giúp tái tạo âm thanh uy lực\nThiết kế gọn nhẹ nhưng mang đầy ấn tượng\nĐược trang bị tính năng Bluetooth V3.0\nThời lượng pin cho trải nghiệm 10 tiếng lâu dài', 5.0, 0, 1, '2025-12-14 01:23:17', 1490000.00, 1490000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/c/l/clip-5-xanh-cam.jpg', 30, 20);
INSERT INTO `products` VALUES (100, 2, 6, 'JBL-Ch4', 'Loa Bluetooth JBL Charge 4', 'Loa bluetooth JBL Charge 4 được trang bị kết nối chuẩn Bluetooth 4.2, cho tốc độ kết nối nhanh hơn và ổn định hơn so với các sản phẩm loa thông thường khác. Bên cạnh đó, loa còn hỗ trợ kết nối Bluetooth hai thiết bị cùng lúc lần lượt phát âm thanh Stereo ấn tượng, cho khả năng kết nối linh hoạt hơn trong việc sử dụng rất nhiều.\nLoa Charge 4 được trang bị chuẩn chống nước IPX7\n', 5.0, 0, 1, '2025-12-14 01:23:17', 2490000.00, 3490000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/j/b/jbl_charge4_front_midnight_black_1605x1605px_1.jpg', 30, 20);
INSERT INTO `products` VALUES (101, 2, 6, 'JBL-Ch5', 'Loa Bluetooth JBL Charge 5', 'Tiếp nối sự thành công của người tiền nhiệm, dòng loa huyền thoại loa JBL Charge 5 với sự thay đổi mạnh mẽ cả về thiết kế lẫn công nghệ âm thanh mang đến chất lượng âm thanh vượt trội dù là ngoài trời hay trong nhà. Là sản phẩm loa bluetooth đồng hành cùng bạn ở mọi cuộc vui.\nThiết kế mạnh mẽ, hỗ trợ kháng nước, chống bụi tiêu chuẩn IP67\nCủ loa thiết kế mới mang đến chất lượng âm thanh to và rõ ràng\nDung lượng pin lên đến 7500mAh, hỗ trợ sạc cho các thiết bị di động\nTiệc vui thêm rộn rã với công nghệ PartyBoost kết nối không giới hạn với các loa khác', 5.0, 0, 1, '2025-12-14 01:23:17', 3490000.00, 3990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-jbl-charge-5-den-black-4_1.jpg', 30, 20);
INSERT INTO `products` VALUES (102, 2, 6, 'JBL-Ch6', 'Loa Bluetooth JBL Charge 6', 'Loa bluetooth JBL Charge 6 sở hữu kích thước nhỏ gọn và trọng lượng nhẹ chưa đến 1kg, công nghệ AI Sound Boost giúp âm thanh rõ ràng và mạnh mẽ hơn. Loa hỗ trợ kết nối bluetooth 5.4, khả năng phát nhạc lên đến 28 giờ và trang bị tính năng sạc nhanh tiện lợi. Loa đạt chuẩn kháng nước và bụi IP68, có thể sạc thiết bị di động qua USB-C và hỗ trợ kết nối đa loa.\nÂm bass mạnh mẽ, thiết kế bền bỉ\nCông suất mạnh mẽ và công nghệ tiên tiến\nThiết kế hiện đại và màu sắc trẻ trung\nTrải nghiệm linh hoạt với Auracast\nThời lượng pin bền bỉ cho cả ngày dài\nKhả năng kháng nước và chống bụi đạt chuẩn IP68\nKết nối bluetooth 5.4 ổn định và linh hoạt\nTrang bị tính năng hỗ trợ người dùng hiệu quả', 5.0, 0, 1, '2025-12-14 01:23:17', 4500000.00, 4505000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/l/bluetooth-jbl-charge-6-den-cam.png', 30, 20);
INSERT INTO `products` VALUES (103, 2, 6, 'JBL-P4', 'Loa Bluetooth JBL Pulse 4', 'Thiết kế của JBL Pulse 4 thay đổi đáng kể phần chân đế đã biến mất làm cho loa trở nên trong suốt, tổng thể hài hòa thanh thoát hơn. Cho cảm giác loa thực sự chắc chắn, một phần nữa là giúp loa được chống rung tốt hơn khi đặt trên mặt phẳng. Các nút điều khiển đã được làm dày giúp dễ bấm hơn và được dời lên ở trên vòng loa và chia đều ra làm 3 nhóm gồm Nguồn / Bluetooth, Partyboost / Lights, Play / Volume.\nThiết kế mới ấn tượng, nút điều khiển dày dễ bấm\nDải loa woofer cho âm thanh vượt trội, sống động trên JBL Pulse 4\nNghe nhạc liên tục 12 giờ, đèn LED bắt mắt trên JBL Pulse 4', 5.0, 0, 1, '2025-12-14 01:23:17', 4990000.00, 4990000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_pulse_4_4.png', 30, 20);
INSERT INTO `products` VALUES (104, 2, 6, 'JBL-P5', 'Loa Bluetooth JBL Pulse 5', 'Loa Bluetooth Pulse 5 là một sản phẩm mới nhất được thêm vào bộ sưu tập loa Pulse của thương hiệu JBL. Thiết bị loa bluetooth mới này nổi bật với chất âm sống động, thiết kế linh hoạt, cùng các hiệu ứng ánh sáng bắt mắt. Khi sở hữu chiếc loa này trong tay, chắc chắn bạn sẽ có được những buổi tiệc đầy vui nhộn và tuyệt vời.\nThiết kế nổi bật với hiệu ứng ánh sáng đầy sống động\nSở hữu chất âm mạnh mẽ, cùng khả năng kết nối hữu ích\n', 5.0, 0, 1, '2025-12-14 01:23:17', 6350000.00, 6690000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/_/1_jbl_pulse_5_hero_34364_x2_1.png', 30, 20);
INSERT INTO `products` VALUES (105, 2, 6, 'JBL-X3', 'Loa Bluetooth JBL Xtreme 3', 'Trong cuộc sống hằng ngày người dùng luôn có nhu cầu nghe nhạc ở bất cứ không gian nào của mình. Để có thể mang đến những giây phút thư giãn ở mọi nơi loa Bluetooth JBL Xtreme 3 với những tính năng tiện lợi, pin dung lượng cao, âm thanh tốt mở đưa bạn hòa mình vào âm nhạc.\nThiết kế nhỏ gọn tiện lợi, chất liệu nhựa cao cấp tản nhiệt tốt\nChất lượng âm thanh cao cấp công suất nổi bật, pin sử dụng 15 giờ\nChống nước và chống bụi IP67, tương thích mọi thiết bị với Bluetooth v5.1', 5.0, 0, 1, '2025-12-14 01:23:17', 5090000.00, 6590000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/_/t_i_xu_ng_82__4_3.png', 30, 20);
INSERT INTO `products` VALUES (106, 2, 6, 'JBL-X4', 'Loa Bluetooth JBL Xtreme 4', 'JBL Xtreme 4 mang đến một thiết kế thời trang kết hợp với âm thanh sống động và trung thực. Dòng loa bluetooth rất phù hợp với những buổi tiệc ngoài trời hay có thể tận dụng để giải trí khi đi du lịch. Không chỉ có khả năng phát nhạc, dòng sản phẩm còn hỗ trợ người dùng với tính năng nghe gọi vô cùng tiện lợi.\nNgoại hình lịch lãm với khả năng chống nước vượt trội\nChất âm sống động, hỗ trợ nghe gọi tiện lợi', 5.0, 0, 1, '2025-12-14 01:23:17', 7790000.00, 7840000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/o/a/oa-bluetooth-jbl-xtreme-4-den.jpg', 30, 20);
INSERT INTO `products` VALUES (107, 2, 6, 'JBL-B2', 'Loa Bluetooth JBL Boombox 2', 'Từ khi được ra đời loa JBL Boom Box nhận được rất nhiều sự ủng hộ. Để đáp ứng kỳ vọng của người hâm mộ hơn nữa, JBL đã tiếp tục cho ra mắt phiên bản tiếp theo với tên gọi là loa JBL Boom Box 2. Sản phẩm có thiết kế tương đồng với người tiền nhiệm nhưng được nâng cấp về phần cứng.\nThiết kế khá lớn, trang bị quai xách, dễ dàng khi di chuyển\nÂm thanh JBL Signature Pro Sound, âm trầm sâu\nTính năng PartyBoost, chống nước IPX7 cao cấp, nghe nhạc liên tục 24 giờ', 5.0, 0, 1, '2025-12-14 01:23:17', 9690000.00, 9690000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-di-dong-jbl-boombox-2-3.jpg', 30, 20);
INSERT INTO `products` VALUES (108, 2, 6, 'JBL-B3', 'Loa Bluetooth JBL Boombox 3', 'Loa bluetooth JBL Boombox 3 được trang bị công suất 180W ở chế độ AC cùng công nghệ JBL Original Pro Sound, giúp mang lại chất lượng âm thanh sống động, cuốn hút, phù hợp cho nhiều không gian giải trí. Loa nổi bật với chuẩn chống nước IP67, pin 24 giờ và Bluetooth 5.3, đáp ứng nhu cầu giải trí mọi lúc, mọi nơi.\nKiểu dáng năng động, chất âm hàng đầu\nTrải nghiệm chất âm bùng nổ cùng công nghệ tiên tiến\nThiết kế sắc nét, chi tiết\nĐa dạng tính năng, chất âm cực đỉnh\nThời lượng pin 24h cho âm nhạc bất tận\nĐộ bền vượt trội với chuẩn kháng bụi và nước chuẩn IP67', 5.0, 0, 1, '2025-12-14 01:23:17', 10490000.00, 11770000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/u/n/untitled-1_copy_17_2.jpg', 30, 20);
INSERT INTO `products` VALUES (109, 2, 6, 'JBL-P710', 'Loa Bluetooth JBL Partybox 710', 'Loa Bluetooth JBL PartyBox 710 sở hữu thiết kế ấn tượng nhờ kết hợp đèn LED và đèn nháy cực đẹp. Cùng với đó là chất lượng âm thanh mạnh mẽ với công suất 800W cho âm trầm sâu hơn và còn nhiều nét nổi trội khác của loa karaoke mà bạn có thể ghé CellphoneS để tìm hiểu kỹ nhé!\nKháng nước tốt\nThiết kế tinh tế từ chất liệu nhựa cao cấp, kháng nước và chịu va đập tốt\nÂm thanh mạnh mẽ với công suất đạt 800W', 5.0, 0, 1, '2025-12-14 01:23:17', 18990000.00, 21500000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/3/23_2_10.jpg', 30, 20);
INSERT INTO `products` VALUES (110, 2, 6, 'JBL-520', 'Loa Bluetooth JBL Partybox 520', 'Loa Bluetooth JBL Partybox 520 có công suất đạt đến 400W, tích hợp công nghệ AI Sound Boost hiệu chỉnh các âm bass, treble, mid cân bằng theo thể loại. Loa sở hữu phong cách thiết kế đậm chất party trẻ trung cùng hệ thống đèn LED vòng sáng kép độc đáo. Tính năng Auracast giúp tạo nên hệ thống âm nhạc bùng nổ.\nÂm thanh AI sống động\nChất âm tuyệt hảo cùng công nghệ AI tái hiện âm thanh sôi động\nNgoại hình đậm chất party cuốn hút\nGhép nối Auracast tạo nên hệ thống loa JBL bùng nổ\nTận hưởng âm nhạc liên tục trong những buổi tiệc kéo dài\nChống nước IPX4 tận hưởng âm nhạc bất cứ đâu', 5.0, 0, 1, '2025-12-14 01:23:17', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (111, 2, 6, 'JBL-A300', 'Loa Bluetooth JBL Authentics 300', 'Loa JBL Authentics 300 là dòng loa không dây với thiết kế cặp loa tweeter 1 inch cùng với đó sản phẩm với thiết kế retro cổ điển cùng gam màu đen sang trọng. Loa có công suất lên đến 100W và cấu trúc âm thanh hai đường tiếng gồm một cho âm thanh chi tiết và một củ loa trầm toàn dải 5,25 inch (133mm).\nTận hưởng âm thanh đa chiều\nTrải nghiệm âm thanh đỉnh cao với công suất lên đến 100W\nSự kết hợp độc đáo của thiết kế Retro và công nghệ tiên tiến\nTrải nghiệm giải trí không giới hạn với thời lượng Pin khủng\nTrải nghiệm nghe nhạc giải trí tiện lợi hơn với các trợ lý ảo thông minh\nDễ dàng kết nối, đồng bộ âm thanh với các thế hệ loa Authentics 300 khác\nDễ dàng tương thích với các thiết bị khác qua kết nối không dây hiện đại\nTùy chỉnh dễ dàng hơn bằng các nút vật lý và giọng nói', 5.0, 0, 1, '2025-12-14 01:23:17', 9990000.00, 11900000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-jbl-authentics-300_10__1.png', 30, 20);
INSERT INTO `products` VALUES (112, 8, 6, 'M-W', 'Loa Bluetooth Marshall Willen', 'Loa Marshall Willen sở hữu một thiết kế sang trọng với âm thanh chất lượng cao, hứa hẹn mang lại trải nghiệm ấn tượng cho người dùng.\nThiết kế cổ điển sang trọng, kết nối bluetooth tiện lợi\nÂm thanh chất lượng, pin dùng nhiều giờ', 5.0, 0, 1, '2025-12-14 01:23:17', 2185000.00, 2790000.00, 'https://tse1.mm.bing.net/th/id/OIP.PG7A8LgALRV5WcESw5_bTwHaHa?rs=1&pid=ImgDetMain&o=7&rm=3', 30, 20);
INSERT INTO `products` VALUES (113, 8, 6, 'M-WII', 'Loa Bluetooth Marshall Willen II', 'Loa bluetooth Marshall Willen II (2)  là loa không dây với công suất 10 Watt và mang đến âm thanh mạnh mẽ khi nghe nhạc, chiến game vượt xa so với kích thước nhỏ gọn của nó. Dù người dùng dựng thẳng hay treo lên thì sản phẩm vẫn đảm bảo sự ổn định và gọn nhẹ nhờ kích thước 100.5 x 100.5 x 43.4 mm\nCông suất lớn lên đến 10W\nMàu sắc hiện đại và kích thước chỉ 100.5 x 100.5 x 43.4 mm\nGhép nối với nhiều thiết bị và kết nối không dây bluetooth', 5.0, 0, 1, '2025-12-14 01:23:17', 2700000.00, 2990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-marshall-willen-ii-den.jpg', 30, 20);
INSERT INTO `products` VALUES (114, 8, 6, 'M-EII', 'Loa Bluetooth Marshall Emberton II', 'Loa Bluetooth Marshall Emberton II có tích hợp 2 bộ driver công suất 10 W, công nghệ âm thanh 360° True Stereophonic và kết nối ổn định với Bluetooth 5.1. Loa được làm với thiết kế cổ điển, vỏ ngoài chống va đập và kháng nước theo chuẩn IP67. Marshall Emberton II còn có thời lượng pin dùng được cả ngày mà chỉ mất 3 giờ để sạc đầy qua cổng Type C. \nThiết kế cá tính, nhỏ gọn\nKhuấy động mọi không gian âm thanh công suất 20W\nCông nghệ kháng nước đỉnh cao', 5.0, 0, 1, '2025-12-14 01:23:17', 3280000.00, 4990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-marshall-emberton-ii-xam_1.png', 30, 20);
INSERT INTO `products` VALUES (115, 8, 6, 'M-EIII', 'Loa Bluetooth Marshall Emberton III', 'Loa Bluetooth Marshall emberton III là sản phẩm loa được trang bị công nghệ âm thanh nổi với dải tần 65-20.000 Hz cùng với bộ khuếch đại âm Class D 2X38 W. Loa với pin dung lượng cho thời lượng sử dụng đến 32+ giờ ấn tượng cùng khả năng sạc trong 2 tiếng qua cổng USB-C 5V/3A.\nTính di động cao, chống nước bền bỉ\nKết nối ổn định trong phạm vi lên tới 10m với chuẩn Bluetooth hiện đại\nTận hưởng âm nhạc giải trí với thời lượng pin suốt cả ngày dài\nTuỳ chỉnh âm thanh dễ dàng hơn thông qua ứng dụng Marshall', 5.0, 0, 1, '2025-12-14 01:23:17', 4520000.00, 5300000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/marshall_emberton-iii_black_prod.jpg', 30, 20);
INSERT INTO `products` VALUES (116, 8, 6, 'M-S2', 'Loa Bluetooth Marshall Stockwell 2', 'Đối với một người yêu âm nhạc thì chiếc loa bluetooth cầm tay chính hãng chiếm một vai trò quan trọng, không thể thiếu trong cuộc sống. Và chiếc loa bluetooth Marshall Stockwell II chính là một người bạn đồng hành lý tưởng.\nLà thương hiệu nổi tiếng đến từ Anh quốc\nThiết kế gọn gàng chỉ 1,4kg cùng màng bảo vệ loa bằng lưới thép \nKết nối bluetooth 5.0 hiện đại cùng công suất loa 20W\nKhả năng chống nước IPX4 cùng thời lượng sử dụng liên tục lên đến 20 tiếng', 5.0, 0, 1, '2025-12-14 01:23:17', 5920000.00, 6570000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-marshall-stockwell-2.jpg', 30, 20);
INSERT INTO `products` VALUES (117, 8, 6, 'M--M', 'Loa Bluetooth Marshall Middleton', 'Loa Marshall Middleton là sản phẩm loa âm thanh tiếp theo của thương hiệu Marshall. Thiết bị loa Marshall được thiết kế với nhiều công nghệ hiện đại, mang lại cho người dùng trải nghiệm âm thanh vượt trội.\nThiết kế sang trọng, tone đen trang nhã\nÂm thanh chất lượng, kết nối bluetooth tiện lợi\nCó biến hoá thành sạc dự phòng trong trường hợp khẩn cấp\nKhả năng kháng nước, kháng bụi mạnh mẽ với tiêu chuẩn IP67\nKết nối dễ dàng với những loa Marshall khác thông qua Stack Mode\nHỗ trợ kết nối với các thiết bị ngoại vi thông qua cổng AUX\nTuỳ chỉnh linh hoạt hơn qua bảng điều khiển phía trên\nThiết lập loa dễ dàng hơn với ứng dụng Marshall Bluetooth', 5.0, 0, 1, '2025-12-14 01:23:17', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (118, 8, 6, 'M-KII', 'Loa Bluetooth Marshall Kilburn II', 'Là bản nâng cấp của loa Marshall Kilburn ra mắt năm 2015, loa bluetooth Marshall Kilburn 2 sở hữu nhiều điểm mới trong thiết kế cũng như tính năng, chất lượng âm thanh,… Sở hữu loa Marshall Kilburn 2 sẽ giúp bạn tận hưởng thế giới âm thanh tuyệt vời hơn.\nThiết kế cổ điển, thể thao, bọc da cao cấp, bốn góc bo tròn và quai xách tiện lợi\nCông suất 36W, thùng loa Bass-Reflex, dải tần 52 – 20.000Hz, hệ thống loa 2 kênh stereo \nKết nối bluetooth 5.0 aptX, cổng kết nối 3.5mm\nPin có thời lượng sử dụng đến 20 giờ, hỗ trợ sạc nhanh sạc đầy pin trong 2.5 giờ', 5.0, 0, 1, '2025-12-14 01:23:17', 7060000.00, 7060000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/marshall-kilburn-ii-black-brass-01.png', 30, 20);
INSERT INTO `products` VALUES (119, 8, 6, 'M-KIII', 'Loa Bluetooth Marshall Kilburn III', 'Loa Marshall Kilburn 3 có thiết kế mang đậm phong cách cổ điển cùng lớp vỏ bọc giả da sang trọng, lưới tản nhiệt kim loại đặc trưng. Loa còn trang bị hệ thống âm thanh đa hướng và thời lượng pin lên đến 50 giờ. Công nghệ Bluetooth 5.3 giúp kết nối nhanh chóng, ổn định và cho phép ghép nối đồng thời với nhiều thiết bị.\nNhỏ gọn, âm thanh mạnh mẽ\nHiệu suất âm thanh mạnh mẽ cùng công nghệ tiên tiến\nNgôn ngữ thiết kế hoài cổ kết hợp tính linh hoạt trong di chuyển\nKết nối linh hoạt cùng những tính năng tiện ích\nChơi nhạc liền mạch với thời lượng lên tới 50+ giờ\nĐắm chìm trong tiệc âm thanh ngoài trời với chuẩn IP54', 5.0, 0, 1, '2025-12-14 01:23:17', 10490000.00, 10490000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-marshall-kilburn-iii_14__1.png', 30, 20);
INSERT INTO `products` VALUES (120, 8, 6, 'M-HS200', 'Loa Bluetooth Marshall Heston Sub 200', 'Loa Bluetooth Marshall Heston Sub 200 mang đến trải nghiệm âm thanh sống động nhờ công suất đỉnh 236W, tái hiện âm trầm chính xác trong dải tần 30-150 Hz. Loa được trang bị hệ thống 2 loa trầm 5.25 inch cùng ampli Class-D kép, giúp kiểm soát âm lượng ổn định. Thiết kế nhỏ gọn cùng trọng lượng chỉ 7.62 kg tạo nên sự tiện lợi trong bố trí không gian.\nCông suất mạnh mẽ, âm trầm sống động\nThiết kế nhỏ gọn, tinh tế với 2 lựa chọn màu \nKết nối Bluetooth 5.3 LE Audio và hỗ trợ Marshall App \nĐộ bền cao nhờ vật liệu tái chế thân thiện môi trường ', 5.0, 0, 1, '2025-12-14 01:23:17', 13900000.00, 13900000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-marshall-heston-sub-200_6__1.png', 30, 20);
INSERT INTO `products` VALUES (121, 8, 6, 'M-T', 'Loa Bluetooth Marshall Tufton', 'Marshall Tufton là một trong những sản phẩm loa bluetooth cầm tay di động mới nhất mang thương hiệu Marshall. Trong khi Marshall Stockwell 2 là được thiết kế với kích thước nhỏ thì loa bluetooth Marshall Tufton lại khá lớn và được coi là lớn nhất cho đến thời điểm hiện tại của hãng. Sản phẩm giúp người dùng trải nghiệm được chất âm đỉnh cao cũng như khả năng phát nhạc đa hướng.\nThiết kế cổ điển, trọng lượng chỉ 4,5kg\nBa núm điều chỉnh quen thuộc, quai xách dễ dàng di chuyển\nCông nghệ bluetooth 5.0 mới nhất, kết nối nhiều thiết bị cùng lúc\nChất âm cực đỉnh, chính hiệu Marshall Tufton\nPin thời lượng đến 20 giờ, công nghệ sạc nhanh', 5.0, 0, 1, '2025-12-14 01:23:17', 11490000.00, 12760000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/marshall-tufton-black-brass-01.png', 30, 20);
INSERT INTO `products` VALUES (122, 9, 4, 'XM-B5', 'Tai nghe Bluetooth True Wireless Xiaomi Buds 5', 'Tai nghe Xiaomi Buds 5 được trang bị Qualcomm aptX và âm thanh lossless, mic đàm thoại và khử tiếng ồn micro kép AI. Tai nghe đạt chuẩn kháng bụi, nước IP54, thời lượng pin tai nghe 6.5 giờ, hộp sạc 39 giờ và sử dụng cổng sạc USB-C. Tai nghe có kích thước nhỏ gọn, vỏ ngoài nhựa nhám mờ và hỗ trợ kết nối Bluetooth 5.4.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 23);
INSERT INTO `products` VALUES (123, 9, 4, 'XM-B3', 'Tai nghe Bluetooth True Wireless Xiaomi Buds 3', 'Xiaomi Buds 3 là dòng tai nghe không dây vừa mới ra mắt đã nhận được cơn mưa lời khen từ giới công nghệ âm thanh. Tiếp nối từ chất lượng công nghệ từ thế hệ trước, Xiaomi đã đưa vào những cải tiến vượt trội dựa trên trải nghiệm của người dùng.', 5.0, 0, 1, '2025-12-27 21:52:42', 560000.00, 569000.00, 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769430806/gw9adexrsucsmtubtivl.jpg', 30, 20);
INSERT INTO `products` VALUES (124, 9, 4, 'XM-B3TPRO', 'Tai nghe Bluetooth True Wireless Xiaomi Buds 3T Pro', 'Tai nghe không dây Xiaomi Buds 3T Pro với công nghệ âm thanh tiên tiến kết hợp khử ồn chủ động thông minh và thời lượng pin dài lâu. Sản phẩm tai nghe không dây này là một trong những thiết bị mà Xiaomi mang đến cho các fan công nghệ toàn cầu.', 2.0, 0, 1, '2025-12-27 21:52:42', 60000.00, 62000.00, 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769430569/pcurzvcwxwvalxxgla48.jpg', 30, 20);
INSERT INTO `products` VALUES (125, 10, 4, 'HW-FE', 'Tai nghe Bluetooth True Wireless HUAWEI FreeClip', 'Huawei Freeclip là tai nghe không dây với thiết kế C-bridge ấn tượng cùng với Driver nam châm kép 10,8 mm mang lại trải nghiệm âm thanh vượt trội. Tai nghe có hai phiên bản màu là đen và tím cùng với đó là nhiều công nghệ âm thanh như âm thanh trực tiếp, âm thanh mở. Bên cạnh đó, sản phẩm tai nghe Huawei này còn sở hữu viên pin lớn mang lại tổng thời gian sử dụng lên đến 36 giờ cùng với đó là khả năng kháng nước và bụi bẩn chuẩn IP54.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (126, 10, 4, 'HW-7i', 'Tai nghe Bluetooth True Wireless Huawei Freebuds 7i', 'Tai nghe Bluetooth True Wireless Huawei Freebuds 7i được trang bị driver động 11mm sử dụng 4 nam châm, kèm công nghệ ANC 3.0 và hiệu chỉnh âm thanh EQ. Bên cạnh đó, mẫu tai nghe này còn sở hữu thiết kế đạt chuẩn IP54. Ngoài ra, công nghệ kết nối Bluetooth 5.3 cũng hỗ trợ truyền tải mượt mà, ổn định.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (127, 10, 4, 'HW-6i', 'Tai nghe Bluetooth True Wireless Huawei Freebuds 6i', 'Tai nghe Huawei Freebuds 6i có thiết kế nhỏ gọn, thời trang và chất âm bass sâu, âm trung rõ ràng, âm cao mượt mà. Tai nghe cũng được trang bị tính năng chống ồn chủ động 2.0, giúp loại bỏ tạp âm từ môi trường xung quanh. Về thời lượng pin, Freebuds 6i cho phép người dùng thưởng thức âm nhạc và cuộc gọi trong thời gian lên đến 7.5 giờ.', 5.0, 0, 1, '2025-12-27 21:52:42', 1100000.00, 1101000.00, 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769432914/odjv0tqawxrcsnkvsnoh.jpg', 30, 20);
INSERT INTO `products` VALUES (128, 10, 4, 'HW-5i', 'Tai nghe Bluetooth True Wireless Huawei FreeBuds 5i', 'Sản phẩm Huawei Freebuds 5i được tập trung công nghệ chống ồn chủ động ở phân khúc giá phải chăng. Và đây cũng là thiết bị được kỳ vọng rất nhiều trong thời gian gần đây.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (129, 10, 4, 'HW-SE2', 'Tai nghe Bluetooth True Wireless Huawei FreeBuds SE 2', 'Huawei FreeBuds SE 2 được tích hợp Huawei Smart Life, cho phép tùy chỉnh lệnh cảm ứng linh hoạt. Từ đó, giúp những bạn thường xuyên chạy bộ chuyển bài hát, trả lời cuộc gọi nhanh chóng.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (130, 10, 4, 'HW-SE', 'Tai nghe Bluetooth True Wireless Huawei Freebuds SE', 'Tai nghe không dây Huawei Freebuds SE được trang bị củ loa driver dynamic với màng loa 10mm mang lại những trải nghiệm âm thanh chân thực và sống động. Sản phẩm sử dụng viên pin dung lượng lớn cung cấp thời lượng nghe liên tục 6 tiếng và lên tới 24 giờ với hộp sạc. Tận hưởng những giai động theo cách riêng của bạn mọi lúc, mọi nơi với chuẩn kháng nước IPX4. Vô tư ghép nối với thiết bị cá nhân bằng Bluetooth trong phạm vi 10 mét. ', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (131, 10, 4, 'HW-SE4', 'Tai nghe Bluetooth True Wireless Huawei Freebuds SE 4', 'Tai nghe Bluetooth True Wireless Huawei Freebuds SE 4 nổi bật nhờ được tích hợp công nghệ chống ồn chủ động cùng khả năng ghép nối Bluetooth ổn định. Thiết bị đạt chuẩn bảo vệ Class III, vận hành ở mức điện năng thấp phù hợp cho nhu cầu sử dụng dài lâu. Bên cạnh đó, tai nghe còn đạt nhiều chứng nhận chất lượng tại các thị trường lớn trên toàn cầu.', 5.0, 0, 1, '2025-12-27 21:52:42', 120000.00, 1111111.00, 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769435701/oglibmuffjqoejwd0qpl.jpg', 30, 20);
INSERT INTO `products` VALUES (132, 10, 4, 'HW-FA', 'Tai nghe Bluetooth True Wireless Huawei FreeArc', 'Tai nghe Huawei Freearc được ưu ái trang bị Driver 17×12 mm kết hợp công nghệ Sterling Sound, mang đến trải nghiệm nghe nhạc chất lượng cao. Với thời lượng pin 28h nhờ hộp sạc 510mAh, sản phẩm đáp ứng tốt nhu cầu sử dụng dài ngày. Kèm theo đó là cấu trúc kháng nước IP57 giúp người dùng yên tâm đeo khi vận động, tập luyện ngoài trời.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (133, 11, 4, 'RM-BAP', 'Realme Buds Air Pro', 'Tai nghe Bluetooth Realme Buds Air Pro là dòng tai nghe true wireless với khử tiếng ồn chủ động (ANC) 35dB, chống ồn kép khi đàm thoại, Bluetooth 5.0, điều khiển cảm ứng, pin 5-6 giờ (ANC bật/tắt) + 25 giờ (hộp sạc), chống nước IPX4, hỗ trợ Google Fast Pair, có chế độ Transparency cho phép nghe âm thanh bên ngoài, phù hợp nghe nhạc và gaming nhờ độ trễ thấp', 5.0, 0, 1, '2025-12-27 21:52:42', 120000.00, 120000.00, 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769435910/dkedvvx4g08ld0pfuy2m.jpg', 30, 20);
INSERT INTO `products` VALUES (134, 11, 4, 'RM-BTL', 'Realme Buds T200 Lite', 'Tai nghe không dây realme Buds T200 Lite được trang bị trình điều khiển động 12.4mm tái tạo âm thanh mạnh mẽ và sâu lắng, đặc biệt là ở dải âm trầm. Mẫu tai nghe realme này sử dụng công nghệ AI để loại bỏ tiếng ồn, tạp âm xung quanh. Thời gian sử dụng của tai nghe lên đến 7 giờ cho mỗi lần sạc và 48 giờ khi dùng hộp sạc.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (135, 11, 4, 'RM-BT300', 'Realme Buds T300', 'Tai nghe không dây realme Buds T300 mang đến trải nghiệm âm thanh chất lượng nhờ vào trình Dynamic Driver 12.4 mm và hiệu ứng 360 Spatial Sound. Tích hợp công nghệ Chống ồn chủ động (ANC) và hai micrô chất lượng cao, đảm bảo đàm thoại rõ ràng ngay cả trong môi trường ồn ào. Với thời lượng pin lên tới 40 giờ và khả năng sạc nhanh 10 phút cho khả năng sử dụng đến 7 giờ, tai nghe đáp ứng mọi nhu cầu trong ngày. Thiết kế gọn nhẹ chỉ 4.1g và Bluetooth 5.3 hiện đại giúp kết nối mạnh mẽ, linh hoạt.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (136, 11, 4, 'RM-BQ', 'Realme Buds Q2S', 'Tai nghe không dây Realme Buds Q2S đáng chú ý với thiết kế nhỏ gọn và thời lượng pin liên tục đến 7 giờ và hộp sạc có thể cung cấp thêm cho tổng thời gian dùng đến 30 giờ sử dụng. Việc sạc pin cũng nhanh chóng chỉ trong 2.5 giờ thông qua cổng USB-C. Tai nghe được chứng nhận IPX4, cho phép chống nước mồ hôi và nước bắn. Với công nghệ chống ồn chủ động và xuyên âm, tai nghe mang đến trải nghiệm âm thanh rõ ràng và mạnh mẽ. Với Bluetooth 5.2 và hỗ trợ codec AAC và SBC, đảm bảo kết nối ổn định và âm thanh chất lượng cao.', 5.0, 0, 1, '2025-12-27 21:52:42', 219000.00, 220000.00, 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769444841/h08xntm0vcuk8trbmbei.jpg', 30, 20);
INSERT INTO `products` VALUES (137, 12, 4, 'RZ-O', 'Razer Opus', 'Tai nghe chụp tai Razer Opus sở hữu kích thước màng loa 40mm với công nghệ Ambient sound và chống ồn chủ động giúp chất âm trở nên sắc nét và mượt mà. Với 4 micro tích hợp, mẫu tai nghe Razer hỗ trợ người dùng đàm thoại vô cùng hiệu quả. Tai nghe cũng ghi điểm với người dùng nhờ có công nghệ Bluetooth 4.2 và thời lượng sử dụng đến 25 giờ.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (138, 12, 4, 'RZ-BP', 'Razer Barracuda Pro', 'Tai nghe chụp tai Razer Barracuda Pro là một tai nghe chơi game cao cấp với công nghệ âm thanh THX AAA, chống tiếng ồn chủ động ANC tối ưu trải nghiệm người dùng. Razer Barracuda Pro có viên pin dung lượng ấn tượng tối đa 40 giờ sử dụng. Tai nghe có trọng lượng nhẹ chỉ 300g, giúp người dùng có thể đeo thoải mái trong nhiều giờ liền mà không cảm thấy mỏi. Ngoài ra, mẫu tai nghe Razer này còn có thiết kế over-ear với earcup được làm từ chất liệu cao cấp, ôm sát tai không gây khó chịu cho người dùng đeo trong thời gian dài. ', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (139, 12, 4, 'RZ-BX', 'Razer Barracuda X', 'Tai nghe chụp tai Razer Barracuda X sở hữu bộ driver Razer Triforce 40mm độc quyền để có được khả năng xử lý các dải âm từ cao tới thấp hiệu quả, nhằm mang tới trải nghiệm chơi game, giải trí tốt hơn. Với trọng lượng nhẹ, phần đệm tai thoáng khí người dùng sẽ luôn có được sự thoải mái khi đeo tai nghe nhiều giờ. Mẫu tai nghe Razer này còn được trang bị mic đàm thoại độc quyền để giúp nâng cao chất lượng giao tiếp và mang tới kết quả tốt hơn trong các trận đấu.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (140, 12, 4, 'RZ-HP', 'Razer Hammerhead Pro', 'Tai nghe không dây Razer Hammerhead Pro có độ nhạy 95dB và dải tần số 20Hz-20kHz cho phép tái tạo âm thanh một cách chân thực khi dùng trong thời gian dài. Sản phẩm tai nghe Razer có trọng lượng nhẹ chỉ 53g , mang lại sự thoải mái cho người dùng trong suốt thời gian sử dụng. Khả năng chống mồ hôi và nước văng theo chuẩn IPX4 giúp bạn yên tâm sử dụng trong mọi hoạt động.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (141, 12, 4, 'RZ-HH', 'Razer Hammerhead Hyperspeed', 'Tai nghe không dây Razer Hammerhead Hyperspeed được trang bị driver 10mm cùng dải tần 20Hz - 20000Hz cho chất lượng audio mạnh mẽ và vô cùng bắt tai. Mẫu tai nghe Razer này được tích hợp công nghệ khử ồn chủ động ANC để bạn tập trung hơn trong khi làm việc hay học tập. Thiết kế tai nghe vừa vặn và có phần mút silicon êm ái, giúp tăng hiệu quả chống ồn. Thời lượng pin tối đa lên tới 32.5 tiếng cho bạn thỏa sức đắm chìm trong những playlist nhạc yêu thích.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (142, 12, 3, 'RZ-HCS2', 'HyperX Cloud Stinger II Core', 'Tai nghe Gaming HyperX Cloud Stinger II Core được trang bị công nghệ Razer Triforce kết hợp với màng loa 50mm drivers, cho chất âm mạnh mẽ và trầm ấm. Micro tích hợp Razer Hyperclear Cardioid giảm ồn, tái tạo đàm thoại tốt hơn. Bên cạnh đó, chiếc tai nghe Razer có kiểu dáng cực ngầu với trọng lượng nhẹ cùng hỗ trợ jack 3.5mm tương thích cực tốt.', 5.0, 0, 0, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (143, 12, 4, 'RZ-BSV2', 'Razer BlackShark V2 X USB', 'Tai nghe chụp tai có dây Razer BlackShark V2 X USB mang lại âm thanh rõ ràng cho mọi dải âm, từ bass đến treble. Razer BlackShark V2 X USB có thể dễ dàng tương thích với nhiều thiết bị thông qua USB-A đảm bảo âm thanh mạnh mẽ, ổn định. Sản phẩm tai nghe Razer còn sở hữu hệ thống microphone HyperClear Cardioid giảm thiểu tạp âm, đảm bảo giọng nói rõ ràng, phù hợp cho trải nghiệm giao tiếp trong game hoặc họp trực tuyến.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (144, 13, 4, 'SS-GBP2', 'Samsung Galaxy Buds Pro 2', 'Sau sản phẩm Galaxy Buds Pro, hãng công nghệ Samsung tiếp tục nghiên cứu và cải tiến để cho ra phiên bản mới với tên gọi Samsung Galaxy Buds Pro 2. Là thế hệ mới được Samsung tân trang với thiết kế hiện đại hơn, nhưng vẫn giữ kiểu dáng in-ear “hạt đậu” đặc trưng của dòng sản phẩm này. Có thể, nhà sản xuất tinh chỉnh lại ngoại hình nhỏ gọn hơn, mang lại cảm giác đeo lên tai dễ chịu, thoải mái.', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 30, 20);
INSERT INTO `products` VALUES (145, 8, 6, 'M-SII', 'Loa Bluetooth Marshall Stanmore II', 'Các sản phẩm âm thanh của thương hiệu Marshall luôn mang lại cho người dùng cảm giác sang trọng và chất lượng âm thanh không cần phải bàn cãi. Nếu đang tìm kiếm cho mình một sản phẩm loa âm thanh mà chất lượng đạt AAA thì sản phẩm loa Marshall Stanmore II sẽ làm bạn hài lòng.\nThiết kế sang trọng theo phong cách cổ điển\nTrang bị tính năng multi-host cùng khả năng kết nối bluetooth v5.0 và cổng AUX/RCA\nTích hợp công nghệ DPS và công suất lên đến 80W', 5.0, 0, 1, '2025-12-27 21:52:42', 11190000.00, 11190000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-marshall-stanmore-ii-brown-nau.png', 30, 20);
INSERT INTO `products` VALUES (146, 8, 6, 'M-SIII', 'Loa Bluetooth Marshall Stanmore III', 'Loa bluetooth Marshall Stanmore 3 với thiết kế trang nhã cùng âm thanh chất lượng. Đặc biệt trên loa Marshall Stanmore 3 đó chính là thiết kế đậm chất cổ điển cùng với công nghệ âm thanh Dynamic Loudness với hai loa cho tổng công suất lên đến 80W.\nLoa Marshall Stanmore III là sản phẩm loa được đánh giá cao và đáng mua nhất trên thị trường hiện nay. Là sản phẩm loa không dây nổi tiếng, với chất lượng âm thanh ấn tượng cùng với thiết kế phong cách ấn tượng.\nThiết kế đẹp mắt\nÂm thanh mạnh mẽ\nKết nối Bluetooth\nNguồn điện trực tiếp, thoải mái sử dụng', 5.0, 0, 1, '2025-12-27 21:52:42', 10590000.00, 11780000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/t/stan3.png', 30, 20);
INSERT INTO `products` VALUES (147, 8, 6, 'M-WoIII', 'Loa Bluetooth Marshall Woburn III', 'Loa Marshall Woburn 3 là mẫu loa cao cấp với thiết kế sang nhã cùng công nghệ âm thanh vượt trội. Loa với âm trường rộng cùng hệ thống điều khiển được thiết kế lại nhờ đó người dùng có thể kiểm soát nhiều hơn.\nLoa Bluetooth Marshall Woburn 3 nằm trong phân khúc thiết bị âm thanh cao cấp nhất ở thời điểm hiện tại. Dòng sản phẩm Marshall này thu hút được sự chú ý của người dùng nhờ thiết kế sang trọng, hiện đại cùng chất lượng âm thanh có mức độ chi tiết cao. \nThiết kế hoài cổ, sang trọng trong từng chi tiết\nCông nghệ xử lý âm thanh hiện đại, chất lượng âm thanh chi tiết\nKết nối linh hoạt với Bluetooth 5.2 hiện đại\nCác thao tác tuỳ chỉnh khá dễ dàng\nChất âm đỉnh cao, phù hợp với nhiều nhu cầu sử dụng của người dùng', 5.0, 0, 1, '2025-12-27 21:52:42', 15990000.00, 17670000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/marshall-woburn-iii-2.jpg', 30, 20);
INSERT INTO `products` VALUES (149, 1, 7, 'S-SRS-XP500', 'Loa Karaoke Sony SRS-XP500', 'Loa Bluetooth Sony SRS-XP500 có kiểu dáng hiện đại và bạn có thể cầm thoải mái bằng một tay. Phụ kiện loa bluetooth Sony có âm thanh sống động với sự kết hợp của loa woofer và tweeter để luôn sẵn sàng phục vụ bạn ở mọi thời điểm.\nThiết kế bền chắc, tay cầm tiện lợi và kháng nước IPX4 \nÂm thanh tuyệt đỉnh, sạc nhanh, dùng lâu\nTương thích hoàn hảo, phạm vi kết nối rộng với chuẩn Bluetooth 5.2\nToàn quyền điều chỉnh âm thanh trên loa qua ứng dụng Music Center\nDễ dàng kết nối với thẻ nhớ và USB thông qua cổng cắm tiện lợi phía sau\nHỗ trợ nạp pin điện thoại thông minh thông qua 2 cổng sạc USB', 5.0, 0, 1, '2025-12-27 21:52:42', 6590000.00, 9990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-srs-xp500_1.png', 32, 20);
INSERT INTO `products` VALUES (150, 1, 7, 'S-SRS-XV900', 'Loa Karaoke Sony SRS-XV900', 'Những chiếc loa bluetooth SONY SRS-XV900 chắc chắn là món phụ kiện công nghệ chẳng thể thiếu trong mọi cuộc vui. Được thiết kế với ngoại hình năng động, cực chất và chất âm mạnh mẽ cuốn hút, loa SONY SRS-XV900 mang không khí vui vẻ đến mọi không gian mà nó tồn tại.\nÂm thanh đa hướng, bước tiến mới đến từ X-Balanced Speaker Unit\nThiết kế năng động, đèn tiệc đa hướng', 5.0, 0, 1, '2025-12-27 21:52:42', 15990000.00, 23490000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-srs-xv900-3_1.png', 32, 20);
INSERT INTO `products` VALUES (151, 1, 7, 'S-SRS-XV800', 'Loa Karaoke Sony SRS-XV800', 'Loa Bluetooth Sony SRS-XV800 là sản phẩm phù hợp với bạn nếu đam mê âm nhạc và muốn tận hưởng âm thanh chất lượng cao mọi lúc, mọi nơi. Với thiết kế hiện đại và các tính năng mới lạ, sản phẩm loa Sony sẽ mang đến trải nghiệm âm thanh ấn tượng.\nThiết kế hiện đại, chất lừ\nÂm thanh sống động, chân thật', 5.0, 0, 1, '2025-12-27 21:52:42', 11350000.00, 14990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-srs-xv800-1_1.png', 32, 21);
INSERT INTO `products` VALUES (152, 1, 7, 'S-SRS-XV500', 'Loa Karaoke Sony SRS-XV500', 'Loa Sony SRS-XV500 với 2 củ loa cùng công nghệ âm DSEE, Clear Audio+, LIVE SOUND giúp mang lại âm thanh sống động, mạnh mẽ. Loa với hệ thống đèn LED bắt mắt cùng với quai xách hỗ trợ quá trình di chuyển tiện lợi. Cùng với đó loa Sony này sở hữu pin mang lại thời lượng sử dụng lên đến 25 giờ cũng như sạc nhanh chóng chỉ 10 phút sạc cho thêm 2 tiếng sử dụng.\nÂm thanh X-Balanced Speaker Unit cho trải nghiệm giải trí sôi động\nThiết kế quai xách cùng đèn LED bắt mắt\nBảng điều khiển trực quan, ghép đôi tối đa 100 loa\nPin sử dụng 24 giờ vượt trội, kháng nước IPX4', 5.0, 0, 1, '2025-12-27 21:52:42', 6590000.00, 9990000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/m/image_1191.png', 32, 20);
INSERT INTO `products` VALUES (153, 1, 6, 'S-ULTF1', 'Loa Bluetooth Sony ULT Field 1', 'Loa Sony ULT Field 1 sở hữu bộ sưu tập màu sắc đa dạng từ đen, cam, trắng đến xám cùng trọng lượng chỉ 650g. Loa với loa tweeter và woofer cùng chế độ âm thanh ULT Field Sound. Mẫu loa Sony này cũng được trang bị viên pin cho thời lượng sử dụng lên đến 12 giờ cũng như cổng sạc USB-C tiện lợi.\nMàu sắc đa dạng, âm thanh chất lượng\nCông nghệ ULT Power Sound, âm trầm lớn\nThiết kế nhỏ gọn cùng quai xách tiện lợi, bốn màu sắc đa dạng\nMicro khử ồn cùng khả năng ghép nối qua Stereo Pair\nPin sử dụng 12 giờ cùng kháng nước chuẩn IP67', 5.0, 0, 1, '2025-12-27 21:52:42', 2075000.00, 2990000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-1_1_.png', 32, 20);
INSERT INTO `products` VALUES (154, 1, 6, 'S-ULTF3', 'Loa Bluetooth Sony ULT Field 3', 'Loa Bluetooth Sony ULT Field 3 sở hữu công nghệ ULT POWER SOUND, cung cấp âm trầm mạnh mẽ, mang đến trải nghiệm âm nhạc sống động như ở buổi hòa nhạc. Thời lượng pin của loa khoảng 24 giờ, cho phép tận hưởng âm nhạc cả ngày dài. Mẫu loa Bluetooth này còn luôn sẵn sàng đồng hành trong mọi chuyến đi với chuẩn kháng nước và bụi IP66/IP67.\nChất âm sống động, thời lượng pin lớn\nCông nghệ xử lý ULT POWER SOUND hiện đại\nThiết kế nhỏ gọn, đa dạng màu sắc\nMở rộng trải nghiệm âm thanh với Party Connect\nThời lượng pin ấn tượng lên tới khoảng 24 giờ\nKháng nước và bụi chuẩn IP66/IP67 cực kỳ bền bỉ', 5.0, 0, 1, '2025-12-27 21:52:42', 3790000.00, 4990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-3_3__1.png', 32, 20);
INSERT INTO `products` VALUES (155, 1, 6, 'S-ULTF5', 'Loa Bluetooth Sony ULT Field 5', 'Loa Bluetooth Sony ULT Field 5 được tích hợp công nghệ ULT POWER SOUND, hỗ trợ kết nối Bluetooth 5.3, thời lượng pin 25 giờ và có khối lượng 3.3 kg. Mẫu loa Bluetooth này được trang bị 1 loa woofer. 2 loa tweeter, hỗ trợ codec SBC, AAC, LDAC và có dải tần 20-20.000 Hz. Sản phẩm sở hữu thiết kế hiện đại với dây đeo vai, cổng USB-C, giắc mini âm thanh nổi, đèn LED đồng bộ nhạc.\nCông nghệ âm thanh hiện đại\nThiết kế tinh tế và di động\nHiệu ứng ánh sáng đồng bộ nhạc\nThời lượng pin dài lâu\nKhả năng kháng nước và bụi bền bỉ', 5.0, 0, 1, '2025-12-27 21:52:42', 6540000.00, 8190000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-5_3__1.png', 32, 20);
INSERT INTO `products` VALUES (156, 1, 7, 'S-ULTF7', 'Loa Karaoke Sony ULT Field 7', 'oa Sony Ult Field 7 với tone đen cùng trọng lượng khoảng 6.3kg giúp di chuyển dễ dàng cùng chuẩn kháng nước IP67. Loa với 2 loa tweeter đường kính 46mm và loa woofer 114mm. Mẫu loa Sony này mang lại âm thanh chất lượng với bộ tản âm thụ động cùng âm thanh X-Balanced Speaker Unit.\nMàng loa kích thước lớn, âm thanh X-Balanced Speaker Unit\nThiết kế dễ mang theo, kháng nước tiện lợi\nGhép nối với Fast Pair và Bluetooth\nPin sử dụng 30 giờ ấn lượng', 5.0, 0, 1, '2025-12-27 21:52:42', 8990000.00, 11990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-7_3__1.png', 32, 20);
INSERT INTO `products` VALUES (157, 1, 7, 'S-ULTT9', 'Loa Karaoke Sony ULT Tower 9', 'Loa Bluetooth Sony ULT Tower 9 được người dùng đánh giá cao với khả năng kết nối Bluetooth 5.3 ổn định, hỗ trợ đa dạng các giao thức ghép nối thế hệ mới. Hệ thống âm thanh gồm loa woofer, loa trung, cùng 4 loa tweeter được bố trí thông minh mang đến trải nghiệm âm thanh 360 độ sống động. Dải tần 20Hz – 20.000 Hz giúp tái tạo âm thanh đầy đủ, từ trầm đến cao.\nLoa công suất lớn, có hỗ trợ Codecs\nThiết kế dạng đứng mạnh mẽ, tông đen sang trọng\nCông nghệ âm thanh không gian 360, kết nối đa dạng\nPin 25 tiếng, sạc nhanh 10 phút dùng 3 tiếng', 5.0, 0, 1, '2025-12-27 21:52:42', 24290000.00, 27990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-tower-9_2__1.png', 32, 20);
INSERT INTO `products` VALUES (158, 1, 7, 'S-ULTT10', 'Loa Karaoke Sony ULT Tower 10', 'Loa karaoke Sony ULT Tower 10 là chất xúc tác cho mọi bữa tiệc trở nên thăng hoa với công nghệ âm thanh 360 độ và bộ loa X-Balanced tạo nên âm trầm ấn tượng. Kích cỡ của loa Sony này khá to và trọng lượng khá nặng nhưng vẫn có tính linh động cao nhờ thiết kế tay cầm và bánh xe. Loa có hệ thống đèn LED rực rỡ với nhiều dải màu sinh động. Người dùng có thể yên tâm vui đùa mà không cần quá bận tâm đến khả năng chống nước của loa.\nÂm thanh 360 độ kết hợp chất âm trầm lắng đọng\nKhối trụ gọn gàng, to lớn nhưng rất linh động\nThêm phần hứng khởi khi trông thấy ánh sáng hòa cùng âm thanh\nAn tâm hơn với chất liệu chống nước', 5.0, 0, 1, '2025-12-27 21:52:42', 20690000.00, 25990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-karaoke-sony-ult-tower_4__1.png', 32, 20);
INSERT INTO `products` VALUES (159, 1, 6, 'S-SRS-XB100EB', 'Loa Bluetooth Sony SRS-XB100 Extra Bass', 'Loa Bluetooth Sony SRS-XB100 với thiết kế nhỏ gọn, năng động cùng với âm bass mạnh mẽ sẽ là một lựa chọn không thể bỏ qua. Với công nghệ hiện đại đặc trưng của hãng, sản phẩm loa Sony này sẽ mang lại cho bạn trải nghiệm âm thanh sôi động và hấp dẫn, cùng với tính di động tiện lợi.\nÂm thanh sống động mạnh mẽ\nThiết kế nhỏ gọn', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 32, 20);
INSERT INTO `products` VALUES (160, 1, 6, 'S-SRS-XB13', 'Loa Bluetooth Sony SRS-XB13', 'Sở hữu loa Sony SRS-XB13, bạn đừng để bị lừa bởi kích thước nhỏ của nó. Bởi chiếc loa nhỏ này, điểm nhấn chính là âm thanh mở rộng nhờ vào sự khuếch đại của bộ xử lý âm thanh.\nÂm thanh phá vỡ giới hạn trong chiếc loa mini\nVỏ ngoài bền bỉ\nKết nối chỉ qua một lần chạm', 5.0, 0, 1, '2025-12-27 21:52:42', 0.00, 0.00, NULL, 32, 20);
INSERT INTO `products` VALUES (161, 1, 6, 'S-SRS-XB23EB', 'Loa Sony SRS-XB23 Extra Bass', 'Loa Sony SRS-XB23 Extra Bass được người dùng đánh giá cao về chất lượng trải nghiệm và thẩm mỹ. Chất lượng ở đó được thể hiện ở thời lượng pin lên đến 12 giờ, chuẩn chống bụi và chống nước IP67 cùng với tính năng chống va đập, đây chắc chắc là sản phẩm dành cho các buổi dã ngoại.\nThiết kế siêu di động, hoàn thiện nhựa nhám bền bỉ\nKết nối bluetooth 5.0, chống bụi, chống nước tiêu chuẩn IP67\nÂm thanh đỉnh cao với bộ loa X kèm công nghệ Clear Audio+, Extra bass TM\nThời lượng nghe nhạc đến 12 giờ, điều khiển nhạc với ứng dụng', 5.0, 0, 1, '2025-12-27 21:52:42', 2490000.00, 2490000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-srs-xb23-green-2-600x600.jpg', 32, 20);
INSERT INTO `products` VALUES (162, 1, 6, 'S-SRS-XB33EB', 'Loa Sony SRS-XB33 Extra Bass', 'Bạn là một người yêu âm nhạc, luôn muốn thưởng thức những âm thanh sống động và chất lượng. Chiếc điện thoại không thể đáp ứng những nhu cầu này của bạn. Đừng lo lắng loa Sony SRS-XB33 Extra Bass chính là vị cứu tinh của bạn, loa âm thanh nhỏ gọn màu sắc trẻ trung sản phẩm hứa hẹn sẽ cho bạn không gian âm nhạc tuyệt vời. Bên cạnh đó, bạn cũng có thể tham khảo nhanh Sony SRS-XB43 đang sở hữu giá tốt và được ưa chuộng tại Cellphones.\nKích thước nhỏ gọn, chống nước chuẩn IP67\nÂm thanh sống động với thiết kế X-Balanced , ứng dụng Sony | Music Center giúp bạn làm chủ cuộc vui\nKết nối nhanh chóng với công nghệ NFC và Bluetooth®, thời lượng pin lên tới 24 giờ', 5.0, 0, 1, '2025-12-27 21:52:42', 3690000.00, 3690000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/b/xb33_black_2_1.jpg', 32, 20);
INSERT INTO `products` VALUES (163, 1, 6, 'S-SRS-XB43EB', 'Loa Sony SRS-XB43 Extra Bass', 'Chẳng mấy khi bạn có được những bữa tiệc hội họp bạn bè, thông thường nhạc là điều giúp cho một buổi tiệc trở nên sinh động hơn. Nhưng hiện tại bạn đang không có thiết bị phát nhạc di động để giúp cho buổi tiệc mình vui hơn. Vậy những phụ kiện âm thanh từ Sony như loa bluetooth Sony SRS-XB43 Extra Bass sẽ là một sự lựa chọn hoàn hảo. Ngoài ra, Sony SRS-XB13 mới nhất sắp được ra mắt trong thời gian sắp tới, bạn có thể tham khảo thêm.\nMang chất liệu nhựa bền bỉ cùng khả năng chống nước, chống bụi tiêu chuẩn IP67\nCông nghệ X-Balanced chuyển đổi âm thanh thông minh cùng dải đèn nhiều màu\nKhả năng chơi nhạc liên tục lên đến 24 và 14 giờ cùng công nghệ extra bass mạnh mẽ\nỨng dụng Music Center tiện lợi cùng ứng dụng chỉnh đèn riêng biệt thuận tiện\nKết nối thông qua chuẩn Bluetooth cùng chuẩn kết nối NFC thông minh\nThiết kế đứng và nằm linh hoạt cùng cổng sạc và cổng tiếp nối đa dạng', 5.0, 0, 1, '2025-12-27 21:52:42', 4990000.00, 4990000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/b/xb43_taupe_2_1.jpg', 32, 20);
INSERT INTO `products` VALUES (164, 1, 6, 'S-SRS-XG300', 'Loa Bluetooth Sony SRS-XG300', 'Loa Sony SRS-XG300 với công nghệ âm thanh tiên tiến cùng đa dạng các tính năng thú vị hứa hẹn sẽ mang đến cho bạn những trải nghiệm tuyệt vời nhất. Dù là các buổi tiệc ngoài trời, hay những chuyến picnic trên biển, dòng loa Sony này sẽ làm hài lòng ngay cả những người dùng khó tính nhất.\nThiết kế đèn LED cùng tay cầm tiện lợi, độ bền cao\nX-Balanced Speaker Unit mang đến áp suất âm thanh cao \nAmbient Illumination - Đồng bộ sánh sáng với nhịp điệu nhạc\nPin 25 giờ sử dụng, sạc nhanh 10 phút', 5.0, 0, 1, '2025-12-27 21:52:42', 6690000.00, 6690000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/2/_/2_122_1_.png', 32, 20);
INSERT INTO `products` VALUES (165, 1, 6, 'S-SRS-XE200', 'Loa Bluetooth Sony SRS-XE200', 'Loa bluetooth Sony SRX-XE200 nằm trong bộ sưu tập mới nhất của X-series với thiết kế và tính năng cải tiến. Kiểu dáng loa Sony này khá gọn nhẹ nên bạn có thể mang đến bất cứ đâu để tận hưởng âm nhạc.\nBộ khuếch đại dạng đường thẳng cho âm thanh truyền xa hơn\nKích thước nhỏ gọn, dây đeo tiện dụng\nX-Balanced Speaker Unit mới có màng loa không tròn, cho âm thanh chất lượng cao\nPin lên đến 16 giờ sử dụng và tích hợp cảm biến chống tiếng ồn xung quanh\nChống nước, chống bụi vượt trội đạt chuẩn IP67\nCuộc gọi cải thiện với Echo Cancelling', 5.0, 0, 1, '2025-12-27 21:52:42', 1150000.00, 2070000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/_/0/_0000_srs-xe200_1__1_1.jpg', 32, 20);
INSERT INTO `products` VALUES (166, 1, 6, 'S-SRS-XE300', 'Loa Bluetooth Sony SRS-XE300', 'Loa Sony SRS-XE300 sở hữu khả năng giữ trọn vẻ đẹp âm thanh và khuếch tản rộng ra xung quanh. Điều này giúp bạn có thể thưởng thức âm thanh trong diện tích lớn không bị ảnh hưởng quá nhiều.\nBộ khuếch tán dạng đường thẳng, giúp âm nhạc truyền xa hơn\nX-Balanced Speaker Unit mang đến âm thanh chất lượng cao kết hợp bộ tản âm thụ động kép\nPin 24 giờ và chức năng cảm biến tiếng ồn xung quanh\nSạc nhanh 10 phút cho thời gian phát nhạc lên đến 70 phút\nChống bụi, chống nước IP67', 5.0, 0, 1, '2025-12-27 21:52:42', 1690000.00, 3040000.00, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/_/0/_0000_srs-xe300_1__1.jpg', 32, 20);
INSERT INTO `products` VALUES (167, 1, 7, 'S-MHC-V13', 'Loa Karaoke Sony MHC-V13', 'Loa bluetooth Sony MHC-V13 là mẫu loa bluetooth công suất lớn thích hợp sử dụng cho những bữa tiệc. Loa âm thanh sở hữu một thiết kế nhỏ gọn, dễ dàng di chuyển. Nếu bạn đang tìm mẫu loa chất lượng cho các bữa tiệc âm nhạc vậy không thể bỏ qua sản phẩm loa Sony không dây này.\nNhiều công nghệ âm thanh vượt trội, công suất loa lớn\nThiết kế tiện dụng với quai xách, độ bền cao\nĐiều khiển tiện dụng qua ứng dụng Music Center', 5.0, 0, 1, '2025-12-27 21:52:42', 4290000.00, 5490000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-sony-mhc-v13-2_1_1.png', 32, 20);
INSERT INTO `products` VALUES (168, 1, 6, 'S-MHC-V21D', 'Loa Bluetooth Sony MHC-V21D', 'Nhắc đến loa bluetooth không thể nào không nhắc đến Sony – một hãng lớn đi đầu trong lĩnh vực âm thanh. Loa bluetooth Sony MHC-V21D là sản phẩm nổi bật với thiết kế hiện đại, loa tweeter và hiệu ứng DJ đem lại cho gia đình, bạn bè bữa tiệc âm thanh sống động là lựa chọn không thể nào không phù hợp hơn.\nThiết kế gọn nhẹ cùng dạng hộp tay cầm, dễ dàng di chuyển cùng hệ thống đèn LED màu đồng bộ với giai điệu\nKhám phá tài năng ngôi sao ca nhạc của bạn và nâng cao kết nối với bluetooth, NFC\nTận hưởng âm thanh công suất 430W cùng công nghệ giảm nhiễu DSEE', 5.0, 0, 1, '2025-12-27 21:52:42', 4790000.00, 4790000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/8/184367272sony-mhc-v21d-01.jpg', 32, 20);
INSERT INTO `products` VALUES (169, 1, 7, 'S-MHC-V43D', 'Loa Karaoke Sony MHC-V43D', 'Loa bluetooth Sony MHC-V43D là mẫu loa bluetooth mang lại trải nghiệm âm thanh vượt trội với âm bass mạnh mẽ, thích hợp sử dụng cho những bữa tiệc âm thanh sống động. Vậy cụ thể mẫu loa âm thanh chất lượng này hãy cùng tìm hiểu chi tiết ngay sau đây.\nCông suất vượt trội, âm bass mạnh mẽ\nThiết kế từ nhựa cứng chắc chắn, dễ dàng vận chuyển', 5.0, 0, 1, '2025-12-27 21:52:42', 6990000.00, 8990000.00, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-sony-mhc-v13-1_2.png?_gl=1*rffre8*_gcl_au*MTI1ODQyODgyMC4xNzY0MDU3NTM3*_ga*MjI3MzQzMjQ0LjE3NjQwNTc1Mzc.*_ga_QLK8WFHNK9*czE3NjU2NDQ0MTkkbzgkZzEkdDE3NjU2NDY3MzgkajI0JGwwJGgxNjg3MTc4NjQ', 32, 20);
INSERT INTO `products` VALUES (170, 1, 3, 'SON-100', 'Sony WH-1000XM4', 'Tai nghe chống ồn đỉnh cao từ Sony.', 5.0, 0, 1, '2026-01-26 23:22:55', 7500000.00, 8490000.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500', 89, 214);
INSERT INTO `products` VALUES (171, 2, 3, 'JBL-101', 'JBL Tune 510BT', 'Âm bass mạnh mẽ, pin trâu 40h.', 5.0, 0, 1, '2026-01-26 23:22:55', 1290000.00, 1490000.00, 'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=500', 45, 120);
INSERT INTO `products` VALUES (172, 8, 3, 'MAR-102', 'Marshall Major IV', 'Thiết kế cổ điển, sạc không dây tiện lợi.', 5.0, 0, 1, '2026-01-26 23:22:55', 4290000.00, 4990000.00, 'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=500', 92, 250);
INSERT INTO `products` VALUES (173, 12, 3, 'RAZ-106', 'Razer BlackShark V2', 'Tai nghe gaming chuyên nghiệp cho game thủ.', 5.0, 0, 1, '2026-01-26 23:22:55', 2490000.00, 2990000.00, 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500', 33, 110);
INSERT INTO `products` VALUES (174, 4, 3, 'BAS-107', 'Baseus Bowie H1', 'Chống ồn chủ động giá rẻ, thiết kế sang trọng.', 5.0, 0, 1, '2026-01-26 23:22:55', 890000.00, 1290000.00, 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500', 66, 180);
INSERT INTO `products` VALUES (175, 1, 3, 'SON-114', 'Sony WH-CH520', 'Tai nghe on-ear nhỏ gọn, pin 50h.', 5.0, 0, 1, '2026-01-26 23:22:55', 1290000.00, 1490000.00, 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500', 23, 95);
INSERT INTO `products` VALUES (176, 7, 4, 'APP-103', 'Apple AirPods Pro 2', 'Chống ồn ANC cực tốt, tích hợp MagSafe.', 5.0, 0, 1, '2026-01-26 23:22:55', 5990000.00, 6990000.00, 'https://images.unsplash.com/photo-1588423770186-80f3ef9ad82e?w=500', 99, 310);
INSERT INTO `products` VALUES (177, 13, 4, 'SAM-104', 'Galaxy Buds 2 Pro', 'Âm thanh 24bit chân thực từ Samsung.', 5.0, 0, 1, '2026-01-26 23:22:55', 3490000.00, 4990000.00, 'https://images.unsplash.com/photo-1590658006244-857178d2169b?w=500', 54, 140);
INSERT INTO `products` VALUES (178, 9, 4, 'XIA-105', 'Xiaomi Redmi Buds 4 Pro', 'Pin bền, chống ồn tốt trong tầm giá.', 5.0, 0, 1, '2026-01-26 23:22:55', 1690000.00, 1990000.00, 'https://images.unsplash.com/photo-1572536147748-ae51cff53f00?w=500', 40, 135);
INSERT INTO `products` VALUES (179, 1, 4, 'SON-108', 'Sony WF-C500', 'Thiết kế nhỏ gọn, âm thanh chuẩn Sony.', 5.0, 0, 1, '2026-01-26 23:22:55', 1590000.00, 2290000.00, 'https://images.unsplash.com/photo-1590658006244-857178d2169b?w=500', 33, 88);
INSERT INTO `products` VALUES (180, 10, 4, 'HUA-110', 'Huawei FreeBuds Pro 2', 'Chất âm tinh chỉnh bởi Devialet.', 5.0, 0, 1, '2026-01-26 23:22:55', 3990000.00, 4990000.00, 'https://images.unsplash.com/photo-1588423770186-80f3ef9ad82e?w=500', 25, 105);
INSERT INTO `products` VALUES (181, 1, 7, 'SONY-V43D', 'Sony MHC-V43D', 'Hệ thống âm thanh tiệc tùng với âm thanh lan tỏa.', 5.0, 0, 1, '2026-01-26 23:23:09', 8490000.00, 9900000.00, 'https://images.unsplash.com/photo-1589003077984-894e133dabab?w=500', 87, 210);
INSERT INTO `products` VALUES (182, 2, 7, 'JBL-ENCORE', 'JBL PartyBox Encore', 'Loa Karaoke di động kèm 2 micro không dây.', 5.0, 0, 1, '2026-01-26 23:23:09', 10900000.00, 12900000.00, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 120, 350);
INSERT INTO `products` VALUES (183, 5, 7, 'LG-ON9', 'LG XBOOM ON9', 'Âm thanh cực khủng, chế độ Karaoke chuyên nghiệp.', 5.0, 0, 1, '2026-01-26 23:23:09', 6500000.00, 8990000.00, 'https://images.unsplash.com/photo-1545453330-14cc24aa0131?w=500', 45, 120);
INSERT INTO `products` VALUES (184, 13, 7, 'SAM-ST40B', 'Samsung MX-ST40B', 'Loa tháp Sound Tower công suất 160W.', 5.0, 0, 1, '2026-01-26 23:23:09', 4290000.00, 5990000.00, 'https://images.unsplash.com/photo-1558537348-c0f8e0732427?w=500', 30, 85);
INSERT INTO `products` VALUES (185, 1, 7, 'SONY-V13', 'Sony MHC-V13', 'Loa tiệc tùng nhỏ gọn, âm thanh mạnh mẽ.', 5.0, 0, 1, '2026-01-26 23:23:09', 3990000.00, 4490000.00, 'https://images.unsplash.com/photo-1589003077984-894e133dabab?w=500', 57, 150);
INSERT INTO `products` VALUES (186, 2, 7, 'JBL-PB110', 'JBL PartyBox 110', 'Âm thanh JBL Original Pro mạnh mẽ.', 5.0, 0, 1, '2026-01-26 23:23:09', 9900000.00, 11900000.00, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 78, 240);
INSERT INTO `products` VALUES (187, 5, 7, 'LG-RN5', 'LG XBOOM RN5', 'Loa All-in-one cho mọi bữa tiệc.', 5.0, 0, 1, '2026-01-26 23:23:09', 3500000.00, 4990000.00, 'https://images.unsplash.com/photo-1545453330-14cc24aa0131?w=500', 15, 60);
INSERT INTO `products` VALUES (188, 1, 7, 'SONY-V73D', 'Sony MHC-V73D', 'Âm thanh 360 độ và ánh sáng tiệc tùng 360 độ.', 5.0, 0, 1, '2026-01-26 23:23:09', 12490000.00, 14900000.00, 'https://images.unsplash.com/photo-1589003077984-894e133dabab?w=500', 42, 110);
INSERT INTO `products` VALUES (189, 2, 7, 'JBL-PB310', 'JBL PartyBox 310', 'Loa tiệc di động công suất lớn 240W.', 5.0, 0, 1, '2026-01-26 23:23:09', 14200000.00, 15900000.00, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 95, 290);
INSERT INTO `products` VALUES (190, 13, 7, 'SAM-ST50B', 'Samsung MX-ST50B', 'Loa tháp công suất lớn 240W, kháng nước IPX5.', 5.0, 0, 1, '2026-01-26 23:23:09', 5490000.00, 7990000.00, 'https://images.unsplash.com/photo-1558537348-c0f8e0732427?w=500', 20, 75);
INSERT INTO `products` VALUES (191, 1, 6, 'SONY-XB13', 'Sony SRS-XB13', 'Loa di động Extra Bass nhỏ gọn, kháng nước.', 5.0, 0, 1, '2026-01-26 23:23:57', 1090000.00, 1290000.00, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 42, 150);
INSERT INTO `products` VALUES (192, 2, 6, 'JBL-FLIP6', 'JBL Flip 6', 'Âm thanh lớn hơn, thiết kế chống nước IP67.', 5.0, 0, 1, '2026-01-26 23:23:57', 2890000.00, 3290000.00, 'https://images.unsplash.com/photo-1545453330-14cc24aa0131?w=500', 110, 402);
INSERT INTO `products` VALUES (193, 8, 6, 'MAR-WILLEN', 'Marshall Willen', 'Loa Marshall nhỏ nhất, âm thanh cực chất.', 5.0, 0, 1, '2026-01-26 23:23:57', 2490000.00, 2990000.00, 'https://images.unsplash.com/photo-1589003077984-894e133dabab?w=500', 80, 300);
INSERT INTO `products` VALUES (194, 9, 6, 'XIA-PORT', 'Xiaomi Mi Portable Bluetooth Speaker', 'Loa 16W, kháng nước IPX7.', 5.0, 0, 1, '2026-01-26 23:23:57', 990000.00, 1290000.00, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 35, 120);
INSERT INTO `products` VALUES (195, 5, 6, 'LG-PL7', 'LG XBOOM Go PL7', 'Công nghệ Meridian, pin 24h, đèn LED đa sắc.', 5.0, 0, 1, '2026-01-26 23:23:57', 1990000.00, 3590000.00, 'https://images.unsplash.com/photo-1545453330-14cc24aa0131?w=500', 28, 90);
INSERT INTO `products` VALUES (196, 1, 6, 'SONY-XE300', 'Sony SRS-XE300', 'Bộ khuếch đại dạng thẳng, âm thanh rộng hơn.', 5.0, 0, 1, '2026-01-26 23:23:57', 3990000.00, 4690000.00, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 34, 115);
INSERT INTO `products` VALUES (197, 2, 6, 'JBL-CHARGE5', 'JBL Charge 5', 'Loa tích hợp sạc dự phòng, âm thanh cực đại.', 5.0, 0, 1, '2026-01-26 23:23:57', 3490000.00, 3990000.00, 'https://images.unsplash.com/photo-1545453330-14cc24aa0131?w=500', 88, 320);
INSERT INTO `products` VALUES (198, 8, 6, 'MAR-EMB2', 'Marshall Emberton II', 'Âm thanh 360 độ huyền thoại từ Marshall.', 5.0, 0, 1, '2026-01-26 23:23:57', 4490000.00, 4990000.00, 'https://images.unsplash.com/photo-1589003077984-894e133dabab?w=500', 105, 380);
INSERT INTO `products` VALUES (199, 1, 6, 'SONY-XG300', 'Sony SRS-XG300', 'Loa tiệc di động, âm thanh bùng nổ, đèn LED đồng bộ.', 5.0, 0, 1, '2026-01-26 23:23:57', 6490000.00, 7990000.00, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 24, 95);
INSERT INTO `products` VALUES (200, 2, 6, 'JBL-BOOMBOX3', 'JBL Boombox 3', 'Âm trầm sâu nhất, âm thanh mạnh mẽ nhất.', 5.0, 0, 1, '2026-01-26 23:23:57', 9900000.00, 11900000.00, 'https://images.unsplash.com/photo-1545453330-14cc24aa0131?w=500', 65, 220);
INSERT INTO `products` VALUES (201, 12, 3, 'RAZ-BSV2X', 'Razer BlackShark V2 X', 'Tai nghe Gaming siêu nhẹ, âm thanh 7.1 surround.', 5.0, 0, 1, '2026-01-26 23:25:05', 1290000.00, 1590000.00, 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500', 75, 180);
INSERT INTO `products` VALUES (202, 1, 3, 'SONY-IZH3', 'Sony INZONE H3', 'Tai nghe chơi game có dây với âm thanh không gian 360.', 5.0, 0, 1, '2026-01-26 23:25:05', 1690000.00, 2290000.00, 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500', 47, 130);
INSERT INTO `products` VALUES (203, 2, 3, 'JBL-Q400', 'JBL Quantum 400', 'Âm thanh chuẩn xác, vòng đệm tai bằng da êm ái.', 5.0, 0, 1, '2026-01-26 23:25:05', 2190000.00, 2490000.00, 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500', 30, 95);
INSERT INTO `products` VALUES (204, 12, 3, 'RAZ-KRV3', 'Razer Kraken V3', 'Hỗ trợ Razer Chroma RGB, âm thanh sống động.', 5.0, 0, 1, '2026-01-26 23:25:05', 2490000.00, 2990000.00, 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500', 60, 210);
INSERT INTO `products` VALUES (205, 1, 3, 'SONY-IZH7', 'Sony INZONE H7', 'Kết nối không dây kép, pin lên đến 40 giờ.', 5.0, 0, 1, '2026-01-26 23:25:05', 4490000.00, 5290000.00, 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500', 24, 115);
INSERT INTO `products` VALUES (206, 2, 3, 'JBL-Q610', 'JBL Quantum 610', 'Âm thanh QuantumSURROUND không dây 2.4GHz.', 5.0, 0, 1, '2026-01-26 23:25:05', 3590000.00, 3990000.00, 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500', 18, 80);
INSERT INTO `products` VALUES (207, 12, 3, 'RAZ-BARX', 'Razer Barracuda X', 'Kết nối đa nền tảng 4 trong 1, thiết kế công thái học.', 5.0, 0, 1, '2026-01-26 23:25:05', 2290000.00, 2590000.00, 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500', 52, 190);
INSERT INTO `products` VALUES (208, 6, 3, 'HAV-H2002D', 'HAVIT H2002D', 'Tai nghe gaming giá rẻ, chất âm vượt tầm giá.', 5.0, 0, 1, '2026-01-26 23:25:05', 550000.00, 750000.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500', 105, 401);
INSERT INTO `products` VALUES (209, 1, 3, 'SONY-IZH9', 'Sony INZONE H9', 'Chống ồn chủ động đỉnh cao cho game thủ chuyên nghiệp.', 5.0, 0, 1, '2026-01-26 23:25:05', 6490000.00, 7490000.00, 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500', 40, 160);
INSERT INTO `products` VALUES (210, 12, 3, 'RAZ-KKT', 'Razer Kraken Kitty V2', 'Thiết kế tai mèo dễ thương, ánh sáng RGB Stream Reactive.', 5.0, 0, 1, '2026-01-26 23:25:05', 2890000.00, 3290000.00, 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500', 150, 500);
INSERT INTO `products` VALUES (211, 1, 5, 'SONY-FLOAT', 'Sony Float Run WI-OE610', 'Thiết kế off-ear độc đáo, thoải mái khi chạy bộ.', 5.0, 0, 1, '2026-01-26 23:25:25', 2690000.00, 3290000.00, 'https://images.unsplash.com/photo-1572536147748-ae51cff53f00?w=500', 92, 280);
INSERT INTO `products` VALUES (212, 10, 5, 'HUA-CLIP', 'Huawei FreeClip', 'Thiết kế C-bridge sáng tạo, nghe nhạc không bí tai.', 5.0, 0, 1, '2026-01-26 23:25:25', 4290000.00, 4990000.00, 'https://images.unsplash.com/photo-1588423770186-80f3ef9ad82e?w=500', 140, 451);
INSERT INTO `products` VALUES (213, 2, 4, 'JBL-RFP', 'JBL Reflect Flow Pro', 'Chống nước IP68, vây tai bám chắc khi tập luyện.', 5.0, 0, 1, '2026-01-26 23:25:25', 3990000.00, 4590000.00, 'https://images.unsplash.com/photo-1590658006244-857178d2169b?w=500', 65, 180);
INSERT INTO `products` VALUES (214, 4, 5, 'BAS-ELI', 'Baseus Eli Sport 1', 'Thiết kế open-ear móc tai, an toàn khi tập ngoài trời.', 5.0, 0, 1, '2026-01-26 23:25:25', 1490000.00, 1890000.00, 'https://images.unsplash.com/photo-1572536147748-ae51cff53f00?w=500', 88, 220);
INSERT INTO `products` VALUES (215, 1, 5, 'SONY-LINK', 'Sony LinkBuds WF-L900', 'Thiết kế vòng hở, giữ kết nối với môi trường xung quanh.', 5.0, 0, 1, '2026-01-26 23:25:25', 3290000.00, 4490000.00, 'https://images.unsplash.com/photo-1590658006244-857178d2169b?w=500', 72, 240);
INSERT INTO `products` VALUES (216, 2, 5, 'JBL-EPEAK3', 'JBL Endurance Peak 3', 'Thiết kế móc tai PowerHook, chống nước cực mạnh.', 5.0, 0, 1, '2026-01-26 23:25:25', 2490000.00, 2990000.00, 'https://images.unsplash.com/photo-1572536147748-ae51cff53f00?w=500', 55, 170);
INSERT INTO `products` VALUES (217, 10, 4, 'HUA-5I', 'Huawei FreeBuds 5i', 'Nhẹ nhàng, đạt chuẩn Hi-Res, chống nước IP54.', 5.0, 0, 1, '2026-01-26 23:25:25', 1490000.00, 1890000.00, 'https://images.unsplash.com/photo-1588423770186-80f3ef9ad82e?w=500', 42, 110);
INSERT INTO `products` VALUES (218, 4, 4, 'BAS-WM02', 'Baseus Bowie WM02', 'Siêu nhỏ gọn, phù hợp tập gym và vận động nhẹ.', 5.0, 0, 1, '2026-01-26 23:25:25', 390000.00, 590000.00, 'https://images.unsplash.com/photo-1590658006244-857178d2169b?w=500', 110, 320);
INSERT INTO `products` VALUES (219, 1, 4, 'SONY-SP800', 'Sony WF-SP800N', 'Chống nước IP55, pin lâu, hỗ trợ Extra Bass.', 5.0, 0, 1, '2026-01-26 23:25:25', 3490000.00, 4290000.00, 'https://images.unsplash.com/photo-1572536147748-ae51cff53f00?w=500', 37, 125);
INSERT INTO `products` VALUES (220, 2, 5, 'JBL-ERUN2', 'JBL Endurance Run 2 Wired', 'Thiết kế FlipHook linh hoạt, đeo nhét tai hoặc móc tai.', 5.0, 0, 1, '2026-01-26 23:25:25', 450000.00, 550000.00, 'https://images.unsplash.com/photo-1590658006244-857178d2169b?w=500', 50, 140);

-- ----------------------------
-- Table structure for productspecs
-- ----------------------------
DROP TABLE IF EXISTS `productspecs`;
CREATE TABLE `productspecs`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `products_id` int NOT NULL,
  `spec_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `spec_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_spec_per_product`(`products_id` ASC, `spec_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11873 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of productspecs
-- ----------------------------
INSERT INTO `productspecs` VALUES (1, 1, 'Thời lượng sử dụng Pin', 'Tắt chống ồn ANC: Dùng 40 giờ\r\nBật chống ồn ANC: Dùng 30 giờ');
INSERT INTO `productspecs` VALUES (2, 1, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (3, 1, 'Trọng lượng', '250g');
INSERT INTO `productspecs` VALUES (4, 1, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (5, 1, 'Công nghệ âm thanh', 'SENSE ENGINE đột phá\r\nBộ xử lý tích hợp V1\r\nDSEE Extreme (Cơ chế tăng cường âm thanh kỹ thuật số)\r\nHi-Res Audio\r\ncodec SBC\r\nActive Noise Cancelling\r\nChống ồn HD QN1\r\ncodec LDAC\r\nAmbient Sound\r\ncodec AAC\r\n360 Reality Audio\r\nAdaptiv');
INSERT INTO `productspecs` VALUES (6, 1, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (7, 2, 'Trọng lượng', '0.55 g');
INSERT INTO `productspecs` VALUES (8, 2, 'Kích thước', '17.8 x 6.8 x 7.2 cm');
INSERT INTO `productspecs` VALUES (9, 2, 'Công nghệ âm thanh', 'Party Boost (kết nối 2 loa cùng lúc)');
INSERT INTO `productspecs` VALUES (10, 2, 'Công suất', '30 W');
INSERT INTO `productspecs` VALUES (11, 2, 'Thời lượng pin', '12 giờ');
INSERT INTO `productspecs` VALUES (12, 2, 'Số loa kết nối cùng lúc', '3 loa');
INSERT INTO `productspecs` VALUES (13, 2, 'Cấu tạo', '1 loa subwoofer dạng racetrack + 1 tweeter + 2 loa bass thụ động Party Boost');
INSERT INTO `productspecs` VALUES (14, 2, 'Chống nước', 'IP67');
INSERT INTO `productspecs` VALUES (15, 3, 'Thời lượng pin tai nghe', 'Dùng Khoảng 5 giờ (âm lượng 80%) - Sạc Khoảng 1 giờ');
INSERT INTO `productspecs` VALUES (16, 3, 'Thời lượng pin hộp sạc', 'Dùng 19 giờ - Sạc Khoảng 2 giờ');
INSERT INTO `productspecs` VALUES (17, 3, 'Cổng sạc', 'Type-C');
INSERT INTO `productspecs` VALUES (18, 3, 'Công nghệ âm thanh', 'Driver 13 mm');
INSERT INTO `productspecs` VALUES (19, 3, 'Tương thích', 'macOS, Android, iOS, Windows');
INSERT INTO `productspecs` VALUES (20, 3, 'Tiện ích', 'Có mic thoại, Chống ồn chủ động ANC');
INSERT INTO `productspecs` VALUES (21, 3, 'Khối lượng', '3.5 g');
INSERT INTO `productspecs` VALUES (22, 3, 'Công nghệ kết nối', 'Bluetooth 5.4');
INSERT INTO `productspecs` VALUES (23, 3, 'Điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (24, 4, 'Thời lượng pin tai nghe', 'Dùng 4 giờ - Sạc 1 giờ');
INSERT INTO `productspecs` VALUES (25, 4, 'Thời lượng pin hộp sạc', 'Dùng 16 giờ - Sạc 1 giờ');
INSERT INTO `productspecs` VALUES (26, 4, 'Cổng sạc', 'Type-C');
INSERT INTO `productspecs` VALUES (27, 4, 'Công nghệ âm thanh', 'Driver 13 mm');
INSERT INTO `productspecs` VALUES (28, 4, 'Tương thích', 'macOS, Android, iOS, Windows');
INSERT INTO `productspecs` VALUES (29, 4, 'Tiện ích', 'Có mic thoạiTương thích trợ lý ảo');
INSERT INTO `productspecs` VALUES (30, 4, 'Khối lượng', '4 g');
INSERT INTO `productspecs` VALUES (31, 4, 'Công nghệ kết nối', 'Bluetooth 5.4');
INSERT INTO `productspecs` VALUES (32, 4, 'Điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (33, 5, 'Thời lượng pin tai nghe', 'Dùng 4 giờ - Sạc 2 giờ');
INSERT INTO `productspecs` VALUES (34, 5, 'Thời lượng pin hộp sạc', 'Dùng 16 giờ - Sạc 2 giờ');
INSERT INTO `productspecs` VALUES (35, 5, 'Cổng sạc', 'Type-C');
INSERT INTO `productspecs` VALUES (36, 5, 'Công nghệ âm thanh', 'Driver 10 mm, Active Noise Cancellation, Công nghệ ENC');
INSERT INTO `productspecs` VALUES (37, 5, 'Tương thích', 'macOS, Android, iOS, Windows');
INSERT INTO `productspecs` VALUES (38, 5, 'Tiện ích', 'Có mic thoạiTương thích trợ lý ảo');
INSERT INTO `productspecs` VALUES (39, 5, 'Khối lượng', '4 g');
INSERT INTO `productspecs` VALUES (40, 5, 'Công nghệ kết nối', 'Bluetooth 5.4');
INSERT INTO `productspecs` VALUES (41, 5, 'Điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (42, 6, 'Thời lượng pin tai nghe', 'Dùng 5 giờ - Sạc Khoảng 1.5 giờ');
INSERT INTO `productspecs` VALUES (43, 6, 'Thời lượng pin hộp sạc', 'Dùng 20 giờ - Sạc Khoảng 1.5 giờ');
INSERT INTO `productspecs` VALUES (44, 6, 'Cổng sạc', 'Type-C');
INSERT INTO `productspecs` VALUES (45, 6, 'Công nghệ âm thanh', 'Active Noise Cancellation, Driver 13 mm');
INSERT INTO `productspecs` VALUES (46, 6, 'Tương thích', 'macOS, Android, iOS, Windows');
INSERT INTO `productspecs` VALUES (47, 6, 'Tiện ích', 'Game Mode\nCó mic thoại\nMàn hình cảm ứng đa tiện ích\nTương thích trợ lý ảo');
INSERT INTO `productspecs` VALUES (48, 6, 'Khối lượng', '4 g');
INSERT INTO `productspecs` VALUES (49, 6, 'Công nghệ kết nối', 'Bluetooth 5.4');
INSERT INTO `productspecs` VALUES (50, 6, 'Điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (51, 7, 'Trọng lượng', 'Tai nghe: 8.8g');
INSERT INTO `productspecs` VALUES (52, 7, 'Công nghệ âm thanh', 'Spatial Audio');
INSERT INTO `productspecs` VALUES (53, 7, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (54, 7, 'Thời lượng sử dụng Pin', 'Tai nghe: 11 giờ\nHộp sạc: 36 giờ');
INSERT INTO `productspecs` VALUES (55, 7, 'Tính năng khác', 'Chống ồn môi trường ENC');
INSERT INTO `productspecs` VALUES (56, 8, 'Công nghệ âm thanh', 'Hi-Res Audio');
INSERT INTO `productspecs` VALUES (57, 8, 'Micro', 'Có (4 micro)');
INSERT INTO `productspecs` VALUES (58, 8, 'Thời lượng sử dụng Pin', 'Tai nghe: 7 giờ\nHộp sạc: 45 giờ');
INSERT INTO `productspecs` VALUES (59, 8, 'Tính năng khác', 'Chống ồn môi trường ENC\nĐộ trễ thấp: 0.06s\nKháng nước, bụi: IP57');
INSERT INTO `productspecs` VALUES (60, 9, 'Công nghệ âm thanh', 'True Wireless Stereo (TWS)');
INSERT INTO `productspecs` VALUES (61, 9, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (62, 9, 'Thời lượng sử dụng Pin', 'Tai nghe: 6 giờ\nHộp sạc: 25 giờ');
INSERT INTO `productspecs` VALUES (63, 9, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (64, 10, 'Trọng lượng', 'Tai nghe: 3.5g');
INSERT INTO `productspecs` VALUES (65, 10, 'Công nghệ âm thanh', 'Khử ồn ENC');
INSERT INTO `productspecs` VALUES (66, 10, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (67, 10, 'Thời lượng sử dụng Pin', 'Tai nghe có thể sử dụng liên tục lên đến 7.5 giờ và khi kết hợp với hộp sạc, thời gian sử dụng có thể lên đến 30 giờ.');
INSERT INTO `productspecs` VALUES (68, 10, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (69, 10, 'Tính năng khác', 'Chống ồn đàm thoại ENC');
INSERT INTO `productspecs` VALUES (70, 11, 'Công nghệ âm thanh', 'Chống ồn chủ động ANC');
INSERT INTO `productspecs` VALUES (71, 11, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (72, 11, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (73, 11, 'Thời lượng sử dụng Pin', 'Sạc một lần và nghe trong một tuần\nThời gian phát nhạc liên tục 40 giờ sau khi sạc đầy, nghe nhạc cả tuần và 5 giờ mỗi ngày.');
INSERT INTO `productspecs` VALUES (74, 11, 'Phương thức điều khiển', 'Nút bấm');
INSERT INTO `productspecs` VALUES (75, 12, 'Kích thước', 'Dài 20 cm - Rộng 16.9 cm - Cao 8 cm');
INSERT INTO `productspecs` VALUES (76, 12, 'Trọng lượng', '238.8 g');
INSERT INTO `productspecs` VALUES (77, 12, 'Công nghệ âm thanh', 'Surround Sound\nPassive Noise Cancellation\nCông nghệ ENC\nDynamic Bass Boost');
INSERT INTO `productspecs` VALUES (78, 12, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (79, 12, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (80, 12, 'Thời lượng sử dụng Pin', '50 giờ');
INSERT INTO `productspecs` VALUES (81, 12, 'Phương thức điều khiển', 'Phím nhấn');
INSERT INTO `productspecs` VALUES (82, 13, 'Trọng lượng', '235 g');
INSERT INTO `productspecs` VALUES (83, 13, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (84, 13, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (85, 13, 'Thời lượng sử dụng Pin', '80 giờ');
INSERT INTO `productspecs` VALUES (86, 13, 'Phương thức điều khiển', 'Nút bấm vật lý');
INSERT INTO `productspecs` VALUES (87, 13, 'Tính năng khác', 'Chống ồn môi trường ENC\nĐộ trễ: 38 ms');
INSERT INTO `productspecs` VALUES (88, 14, 'Kích thước', 'Hộp sạc: 44 x 44 x 30.5mm\nTai nghe: 24.3 x 24.3 mm');
INSERT INTO `productspecs` VALUES (89, 14, 'Trọng lượng', 'Tai nghe: 3.8g\nHộp sạc: 33g');
INSERT INTO `productspecs` VALUES (90, 14, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (91, 14, 'Cổng kết nối', 'Type C');
INSERT INTO `productspecs` VALUES (92, 14, 'Thời lượng sử dụng Pin', 'Tai nghe: Dùng 5 giờ\nHộp sạc: Dùng 25 giờ');
INSERT INTO `productspecs` VALUES (93, 14, 'Phương thức điều khiển', 'Nút bấm vật lý');
INSERT INTO `productspecs` VALUES (94, 15, 'Kích thước', 'Tai nghe: 35.40mm\nHộp sạc: 53.34mm x 53.39mm');
INSERT INTO `productspecs` VALUES (95, 15, 'Trọng lượng', 'Tai nghe: 3.2g\nHộp sạc: 30g');
INSERT INTO `productspecs` VALUES (96, 15, 'Công nghệ âm thanh', 'Khử ồn ENC');
INSERT INTO `productspecs` VALUES (97, 15, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (98, 15, 'Cổng kết nối', 'Type C');
INSERT INTO `productspecs` VALUES (99, 15, 'Thời lượng sử dụng Pin', 'Tai nghe: 6 giờ\nHộp sạc: 30 giờ');
INSERT INTO `productspecs` VALUES (100, 15, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (101, 15, 'Tính năng khác', 'Sạc nhanh\nKháng nước chuẩn IPX4');
INSERT INTO `productspecs` VALUES (102, 16, 'Kích thước', 'Tai nghe: 52 x 62 mm\nHộp sạc: 29 x 21 mm');
INSERT INTO `productspecs` VALUES (103, 16, 'Công nghệ âm thanh', 'Beasus Tech-Pack\nCodec LHDC 5.0\nGame Mode\nChống ồn chủ động');
INSERT INTO `productspecs` VALUES (104, 16, 'Micro', '4 Micro ENC');
INSERT INTO `productspecs` VALUES (105, 16, 'Thời lượng sử dụng Pin', 'Tai nghe: 7 giờ\nHộp sạc: 25 giờ');
INSERT INTO `productspecs` VALUES (106, 16, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (107, 16, 'Tính năng khác', 'Chống ồn lên đến 52 dB');
INSERT INTO `productspecs` VALUES (108, 17, 'Kích thước', 'Rộng 175mm x Cao 185mm');
INSERT INTO `productspecs` VALUES (109, 17, 'Trọng lượng', '226g');
INSERT INTO `productspecs` VALUES (110, 17, 'Công nghệ âm thanh', 'Hi-Res Audio Wireless\nHi-Res Audio');
INSERT INTO `productspecs` VALUES (111, 17, 'Micro', 'Có\n4 micro');
INSERT INTO `productspecs` VALUES (112, 17, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (113, 17, 'Thời lượng sử dụng Pin', 'Thời lượng pin lên đến 30 giờ, tai nghe sẽ đồng hành cùng bạn trong suốt cả ngày dài\nThời gian sạc đầy pin nhanh chóng, chỉ khoảng 2 giờ, giúp bạn sẵn sàng sử dụng lại trong thời gian ngắn');
INSERT INTO `productspecs` VALUES (114, 17, 'Phương thức điều khiển', 'Nút bấm');
INSERT INTO `productspecs` VALUES (115, 17, 'Tính năng khác', 'Chống ồn ANC');
INSERT INTO `productspecs` VALUES (116, 18, 'Trọng lượng', '258g');
INSERT INTO `productspecs` VALUES (117, 18, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (118, 18, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (119, 18, 'Tính năng khác', 'Micro có thể tháo rời');
INSERT INTO `productspecs` VALUES (120, 19, 'Kết nối', 'Bluetooth 5.2');
INSERT INTO `productspecs` VALUES (121, 19, 'Thời gian sử dụng tai nghe', 'Dùng 8 giờ - Sạc 1 giờ');
INSERT INTO `productspecs` VALUES (122, 19, 'Thời gian sử dụng hộp sạc', 'Dùng 22 giờ - Sạc 2 giờ');
INSERT INTO `productspecs` VALUES (123, 19, 'Cổng sạc', 'Type-C');
INSERT INTO `productspecs` VALUES (124, 19, 'Công nghệ âm thanh', 'Active Noise Cancellation, Meridian');
INSERT INTO `productspecs` VALUES (125, 19, 'Tương thích', 'Android, iOS (iPhone, iPad), Windows');
INSERT INTO `productspecs` VALUES (126, 19, 'Ứng dụng kết nối', 'TONE Free');
INSERT INTO `productspecs` VALUES (127, 19, 'Tiện ích', 'Chống nước IPX4, Chống ồn, Sạc nhanh');
INSERT INTO `productspecs` VALUES (128, 19, 'Kết nối cùng lúc', 'Nhiều thiết bị');
INSERT INTO `productspecs` VALUES (129, 19, 'Điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (130, 19, 'Phím điều khiển', 'Chuyển bài hát, Nghe/nhận cuộc gọi, Tăng/giảm âm lượng');
INSERT INTO `productspecs` VALUES (131, 19, 'Kích thước', 'Dài 2.12 cm - Rộng 2.32 cm - Cao 2.83 cm');
INSERT INTO `productspecs` VALUES (132, 19, 'Trọng lượng', '5.2 g');
INSERT INTO `productspecs` VALUES (133, 21, 'Công nghệ âm thanh', 'Meridian\nXuyên âm\nXử lý Tín hiệu Số (DSP)');
INSERT INTO `productspecs` VALUES (134, 21, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (135, 21, 'Dung lượng pin', 'Tai nghe: 6 giờ -\nHộp sạc: 12 giờ');
INSERT INTO `productspecs` VALUES (136, 21, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (137, 21, 'Tính năng khác', 'Sử dụng độc lập 1 bên tai\nTự động kết nối khi mở hộp\nTắt nhạc khi tháo tai\nDiệt khuẩn UVnano');
INSERT INTO `productspecs` VALUES (138, 20, 'Công nghệ âm thanh', 'Meridian\nXuyên âm\nXử lý Tín hiệu Số (DSP)');
INSERT INTO `productspecs` VALUES (139, 20, 'Micro', 'Mic đàm thoại');
INSERT INTO `productspecs` VALUES (140, 20, 'Dung lượng pin', 'Tai nghe : 6 giờ - Hộp sạc : 12 giờ');
INSERT INTO `productspecs` VALUES (141, 20, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (142, 20, 'Tính năng khác', 'Sử dụng độc lập 1 bên tai\nTự động kết nối khi mở hộp\nTắt nhạc khi tháo tai\nDiệt khuẩn nano UV');
INSERT INTO `productspecs` VALUES (143, 20, 'Pin', 'Case Sạc:390 mAh\nTai nghe:55 mAh');
INSERT INTO `productspecs` VALUES (146, 22, 'Kích thước', 'Tai nghe: 21.2 x 28.3 x 23.2 mm\nHộp sạc: 54.5 x 54.5 x 30 mm');
INSERT INTO `productspecs` VALUES (147, 22, 'Trọng lượng', 'Tai nghe: 5.2 g\nHộp sạc: 36.7 g');
INSERT INTO `productspecs` VALUES (148, 22, 'Công nghệ âm thanh', 'Meridian\nXuyên âm\nXử lý Tín hiệu Số (DSP)');
INSERT INTO `productspecs` VALUES (149, 22, 'Micro', 'Có\n3 micro');
INSERT INTO `productspecs` VALUES (150, 22, 'Thời lượng sử dụng Pin', 'Tai nghe: 10 giờ\nHộp sạc: 24 giờ');
INSERT INTO `productspecs` VALUES (151, 22, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (152, 22, 'Tính năng khác', 'Tự động kết nối khi mở hộp\nTắt nhạc khi tháo tai\nDiệt khuẩn UVnano\nChống nước IPX4');
INSERT INTO `productspecs` VALUES (153, 23, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (154, 83, 'Trọng lượng', '16.5 kg');
INSERT INTO `productspecs` VALUES (155, 83, 'Kích thước', '33.5 x 67 x 38.5 cm');
INSERT INTO `productspecs` VALUES (156, 83, 'Công nghệ âm thanh	\n', 'JBL Pro Sound');
INSERT INTO `productspecs` VALUES (157, 83, 'Công suất	\n', '240W');
INSERT INTO `productspecs` VALUES (158, 83, 'Thời lượng pin	\n', '18 giờ');
INSERT INTO `productspecs` VALUES (159, 83, 'Tính năng khác', 'JBL-PS320');
INSERT INTO `productspecs` VALUES (160, 83, 'Cấu tạo', 'Bass 16.5cm (6.5 inch) x2 + Loa Treble 2.5cm x2');
INSERT INTO `productspecs` VALUES (161, 83, 'Chống nước	\n', 'IPX4');
INSERT INTO `productspecs` VALUES (162, 83, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (163, 85, 'Trọng lượng', '5.89 kg');
INSERT INTO `productspecs` VALUES (164, 85, 'Kích thước', '51 x 26 x 21 cm');
INSERT INTO `productspecs` VALUES (165, 85, 'Công nghệ âm thanh	\n', 'AI Sound Boost\nJBL PartyBoost\nJBL Pro Sound');
INSERT INTO `productspecs` VALUES (166, 85, 'Công suất	\n', 'Chế độ AC: 2 loa trầm RMS 65W, 2 loa tweeter RMS 40W\nChế độ pin: 2 loa trầm RMS 60W, 2 loa tweeter RMS 40W');
INSERT INTO `productspecs` VALUES (167, 85, 'Thời lượng pin	\n', '28 giờ + 6 giờ với JBL Playtime Boost');
INSERT INTO `productspecs` VALUES (168, 85, 'Tính năng khác', 'JBL Playtime Boost');
INSERT INTO `productspecs` VALUES (169, 85, 'Cấu tạo', '2 loa trầm 5 inch / 2 loa trầm 123mm, 2 loa tweeter 0,75 inch / 2 loa trầm 20mm, 2 loa tròn + 1 loa tản nhiệt thụ động racetrack');
INSERT INTO `productspecs` VALUES (170, 85, 'Chống nước	\n', 'IP68');
INSERT INTO `productspecs` VALUES (171, 85, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (172, 86, 'Trọng lượng', '7.8 kg');
INSERT INTO `productspecs` VALUES (173, 86, 'Kích thước', '447 x 24 x 255 mm');
INSERT INTO `productspecs` VALUES (174, 86, 'Công nghệ âm thanh	\n', 'Dolby Atmos®');
INSERT INTO `productspecs` VALUES (175, 86, 'Công suất	\n', '270W');
INSERT INTO `productspecs` VALUES (176, 86, 'Thời lượng pin	\n', '16 giờ');
INSERT INTO `productspecs` VALUES (177, 86, 'Tính năng khác', 'Tích hợp WiFi');
INSERT INTO `productspecs` VALUES (178, 86, 'Cấu tạo', '3x loa tweeter màn nhôm 25mm + 3x loa midrange 2.75\" + loa subwoofer 6.5”');
INSERT INTO `productspecs` VALUES (179, 86, 'Chống nước	\n', 'Không');
INSERT INTO `productspecs` VALUES (180, 86, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (181, 88, 'Trọng lượng', '5.9 kg');
INSERT INTO `productspecs` VALUES (182, 88, 'Kích thước', '27.6 x 32.7 x 29.3 cm');
INSERT INTO `productspecs` VALUES (183, 88, 'Công nghệ âm thanh	\n', 'JBL Original Sound');
INSERT INTO `productspecs` VALUES (184, 88, 'Công suất	\n', '100 W');
INSERT INTO `productspecs` VALUES (185, 88, 'Thời lượng pin	\n', '6 giờ');
INSERT INTO `productspecs` VALUES (186, 88, 'Tính năng khác', 'Đèn LED RGB thay đổi theo nhịp nhạc');
INSERT INTO `productspecs` VALUES (187, 88, 'Cấu tạo', '1 củ loa subwoofer, 2 củ loa tweeter');
INSERT INTO `productspecs` VALUES (188, 88, 'Chống nước	\n', 'IPX4');
INSERT INTO `productspecs` VALUES (189, 88, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (190, 89, 'Trọng lượng', '1.4kg');
INSERT INTO `productspecs` VALUES (191, 89, 'Kích thước', '178 x 162 x 75.7 mm');
INSERT INTO `productspecs` VALUES (192, 89, 'Công nghệ âm thanh	\n', 'JBL Stereo Sound');
INSERT INTO `productspecs` VALUES (193, 89, 'Công suất	\n', '10W');
INSERT INTO `productspecs` VALUES (194, 89, 'Thời lượng pin	\n', '8 giờ');
INSERT INTO `productspecs` VALUES (195, 89, 'Tính năng khác', 'Báo thức\nHiển thị thời gian\nNghe radio');
INSERT INTO `productspecs` VALUES (196, 89, 'Cấu tạo', '2x 5.0” ');
INSERT INTO `productspecs` VALUES (197, 89, 'Chống nước	\n', 'Không');
INSERT INTO `productspecs` VALUES (198, 89, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (199, 90, 'Trọng lượng', '0.81kg');
INSERT INTO `productspecs` VALUES (200, 90, 'Kích thước', '209 x 210 x 83 mm');
INSERT INTO `productspecs` VALUES (201, 90, 'Công nghệ âm thanh	\n', 'JBL Pro Sound');
INSERT INTO `productspecs` VALUES (202, 90, 'Công suất	\n', '2 x 4W RMS');
INSERT INTO `productspecs` VALUES (203, 90, 'Thời lượng pin	\n', '8 giờ');
INSERT INTO `productspecs` VALUES (204, 90, 'Tính năng khác', 'Màn hình LCD hiển thị thời gian\nBáo thức');
INSERT INTO `productspecs` VALUES (205, 90, 'Cấu tạo', '2x 5.0” ');
INSERT INTO `productspecs` VALUES (206, 90, 'Chống nước	\n', 'Không');
INSERT INTO `productspecs` VALUES (207, 90, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (208, 91, 'Trọng lượng', '0.78kg');
INSERT INTO `productspecs` VALUES (209, 91, 'Kích thước', '209 x 137 x 83 mm');
INSERT INTO `productspecs` VALUES (210, 91, 'Công nghệ âm thanh	\n', 'JBL Pro Sound');
INSERT INTO `productspecs` VALUES (211, 91, 'Công suất	\n', '10W');
INSERT INTO `productspecs` VALUES (212, 91, 'Thời lượng pin	\n', '10 giờ');
INSERT INTO `productspecs` VALUES (213, 91, 'Tính năng khác', 'Báo thức\nĐèn ngủ tích hợp với nhiều hiệu ứng ánh sáng\nChế độ ngủ thư giãn tùy chỉnh\nMàn hình hiển thị đồng hồ\nKết nối Radio FM');
INSERT INTO `productspecs` VALUES (214, 91, 'Cấu tạo', '2x 1.5” (toàn dải)');
INSERT INTO `productspecs` VALUES (215, 91, 'Chống nước	\n', 'Không');
INSERT INTO `productspecs` VALUES (216, 91, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (217, 92, 'Trọng lượng', '0.56 kg');
INSERT INTO `productspecs` VALUES (218, 92, 'Kích thước', '18.25 x 6.95 x 7.15 cm');
INSERT INTO `productspecs` VALUES (219, 92, 'Công nghệ âm thanh	\n', 'AI Sound Boos');
INSERT INTO `productspecs` VALUES (220, 92, 'Công suất	\n', 'Woofer: 25W RMS\nTweeter: 10W RMS');
INSERT INTO `productspecs` VALUES (221, 92, 'Thời lượng pin	\n', '14 giờ');
INSERT INTO `productspecs` VALUES (222, 92, 'Tính năng khác', 'Auracast™');
INSERT INTO `productspecs` VALUES (223, 92, 'Cấu tạo', 'Woofer: 45 x 80 mm, Tweeter: 16 mm');
INSERT INTO `productspecs` VALUES (224, 92, 'Chống nước	\n', 'IP68');
INSERT INTO `productspecs` VALUES (225, 92, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (226, 93, 'Trọng lượng', '0.32kg');
INSERT INTO `productspecs` VALUES (227, 93, 'Kích thước', '86 x 71.2 x 31.6 mm');
INSERT INTO `productspecs` VALUES (228, 93, 'Công nghệ âm thanh	\n', 'JBL Original Pro Sound');
INSERT INTO `productspecs` VALUES (229, 93, 'Công suất	\n', '3.1W');
INSERT INTO `productspecs` VALUES (230, 93, 'Thời lượng pin	\n', '5 giờ');
INSERT INTO `productspecs` VALUES (231, 93, 'Tính năng khác', 'Không');
INSERT INTO `productspecs` VALUES (232, 93, 'Cấu tạo', '2x 1.5” (toàn dải)');
INSERT INTO `productspecs` VALUES (233, 93, 'Chống nước	\n', 'IPX7');
INSERT INTO `productspecs` VALUES (234, 93, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (235, 94, 'Trọng lượng', '0.18kg');
INSERT INTO `productspecs` VALUES (236, 94, 'Kích thước', '86 x 71.2 x 31.6 mm');
INSERT INTO `productspecs` VALUES (237, 94, 'Công nghệ âm thanh	\n', 'JBL Rich Original Pro Sound');
INSERT INTO `productspecs` VALUES (238, 94, 'Công suất	\n', '3.1W');
INSERT INTO `productspecs` VALUES (239, 94, 'Thời lượng pin	\n', '5 giờ');
INSERT INTO `productspecs` VALUES (240, 94, 'Tính năng khác', 'Không');
INSERT INTO `productspecs` VALUES (241, 94, 'Cấu tạo', 'Woofer: 45 x 80 mm, Tweeter: 16 mm');
INSERT INTO `productspecs` VALUES (242, 94, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (243, 94, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (244, 95, 'Trọng lượng', '0.209kg');
INSERT INTO `productspecs` VALUES (245, 95, 'Kích thước', '86 x 71.2 x 31.6 mm');
INSERT INTO `productspecs` VALUES (246, 95, 'Công nghệ âm thanh	\n', 'JBL Pro Sound');
INSERT INTO `productspecs` VALUES (247, 95, 'Công suất	\n', '4.2 W');
INSERT INTO `productspecs` VALUES (248, 95, 'Thời lượng pin	\n', '5 giờ');
INSERT INTO `productspecs` VALUES (249, 95, 'Tính năng khác', 'Không');
INSERT INTO `productspecs` VALUES (250, 95, 'Cấu tạo', '2x 1.5” (toàn dải)');
INSERT INTO `productspecs` VALUES (251, 95, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (252, 95, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (253, 96, 'Trọng lượng', '0.19kg');
INSERT INTO `productspecs` VALUES (254, 96, 'Kích thước', '9.4 x 7.8 x 4.2 cm');
INSERT INTO `productspecs` VALUES (255, 96, 'Công nghệ âm thanh	\n', 'JBL Sound Pro\nJBL PartyBoost');
INSERT INTO `productspecs` VALUES (256, 96, 'Công suất	\n', '4.2W');
INSERT INTO `productspecs` VALUES (257, 96, 'Thời lượng pin	\n', '7 giờ');
INSERT INTO `productspecs` VALUES (258, 96, 'Tính năng khác', 'Kết nối nhiều loa Auracast');
INSERT INTO `productspecs` VALUES (259, 96, 'Cấu tạo', 'Woofer: 45 x 80 mm, Tweeter: 16 mm');
INSERT INTO `productspecs` VALUES (260, 96, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (261, 96, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (262, 97, 'Trọng lượng', '0.2kg');
INSERT INTO `productspecs` VALUES (263, 97, 'Kích thước', '86 x 71.2 x 31.6 mm');
INSERT INTO `productspecs` VALUES (264, 97, 'Công nghệ âm thanh	\n', 'SoundClear Echo');
INSERT INTO `productspecs` VALUES (265, 97, 'Công suất	\n', '3.3W');
INSERT INTO `productspecs` VALUES (266, 97, 'Thời lượng pin	\n', '10 giờ');
INSERT INTO `productspecs` VALUES (267, 97, 'Tính năng khác', 'Tích hợp Mic đàm thoại');
INSERT INTO `productspecs` VALUES (268, 97, 'Cấu tạo', '2x 1.5” (toàn dải)');
INSERT INTO `productspecs` VALUES (269, 97, 'Chống nước	\n', 'IPX7 (Dùng ở bãi biển,hồ bơi)');
INSERT INTO `productspecs` VALUES (270, 97, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (271, 98, 'Trọng lượng', '0,239 kg');
INSERT INTO `productspecs` VALUES (272, 98, 'Kích thước', '9.4 x 7.8 x 4.2 cm');
INSERT INTO `productspecs` VALUES (273, 98, 'Công nghệ âm thanh	\n', 'JBL Original Pro Sound');
INSERT INTO `productspecs` VALUES (274, 98, 'Công suất	\n', '5 W');
INSERT INTO `productspecs` VALUES (275, 98, 'Thời lượng pin	\n', '10 giờ');
INSERT INTO `productspecs` VALUES (276, 98, 'Tính năng khác', 'Không');
INSERT INTO `productspecs` VALUES (277, 98, 'Cấu tạo', 'Woofer: 45 x 80 mm, Tweeter: 16 mm');
INSERT INTO `productspecs` VALUES (278, 98, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (279, 98, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (280, 99, 'Trọng lượng', '0,285 kg');
INSERT INTO `productspecs` VALUES (281, 99, 'Kích thước', '86 x 71.2 x 31.6 mm');
INSERT INTO `productspecs` VALUES (282, 99, 'Công nghệ âm thanh	\n', 'JBL Pro Sound');
INSERT INTO `productspecs` VALUES (283, 99, 'Công suất	\n', '7W');
INSERT INTO `productspecs` VALUES (284, 99, 'Thời lượng pin	\n', '12 giờ');
INSERT INTO `productspecs` VALUES (285, 99, 'Tính năng khác', 'Kết nối nhiều loa Auracast™');
INSERT INTO `productspecs` VALUES (286, 99, 'Cấu tạo', '2x 1.5” (toàn dải)');
INSERT INTO `productspecs` VALUES (287, 99, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (288, 99, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (289, 100, 'Trọng lượng', '1.5kg');
INSERT INTO `productspecs` VALUES (290, 100, 'Kích thước', 'Ngang 25 cm - Sâu 9.7 cm - Cao 9.7 cm');
INSERT INTO `productspecs` VALUES (291, 100, 'Công nghệ âm thanh	\n', 'Âm thanh Hi-Fi');
INSERT INTO `productspecs` VALUES (292, 100, 'Công suất	\n', '30 W');
INSERT INTO `productspecs` VALUES (293, 100, 'Thời lượng pin	\n', '20 giờ');
INSERT INTO `productspecs` VALUES (294, 100, 'Tính năng khác', '100 loa (Các loa có hỗ trợ JBL Connect+)');
INSERT INTO `productspecs` VALUES (295, 100, 'Cấu tạo', 'Woofer: 45 x 80 mm, Tweeter: 16 mm');
INSERT INTO `productspecs` VALUES (296, 100, 'Chống nước	\n', 'IPX7');
INSERT INTO `productspecs` VALUES (297, 100, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (298, 101, 'Trọng lượng', '0.96 kg');
INSERT INTO `productspecs` VALUES (299, 101, 'Kích thước', 'Ngang 21 cm - Sâu 9.7 cm - Cao 9.7 cm');
INSERT INTO `productspecs` VALUES (300, 101, 'Công nghệ âm thanh	\n', 'JBL Original Pro Sound');
INSERT INTO `productspecs` VALUES (301, 101, 'Công suất	\n', '40 W');
INSERT INTO `productspecs` VALUES (302, 101, 'Thời lượng pin	\n', '20 giờ');
INSERT INTO `productspecs` VALUES (303, 101, 'Tính năng khác', 'Sạc cho thiết bị khác qua cổng USB');
INSERT INTO `productspecs` VALUES (304, 101, 'Cấu tạo', '2 loa');
INSERT INTO `productspecs` VALUES (305, 101, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (306, 101, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (307, 102, 'Trọng lượng', 'Có dây đeo: 0.99 kg\nKhông dây đeo: 0.96 kg');
INSERT INTO `productspecs` VALUES (308, 102, 'Kích thước', '22.88 x 9.85 x 9.4 cm');
INSERT INTO `productspecs` VALUES (309, 102, 'Công nghệ âm thanh	\n', 'AI Sound Boost');
INSERT INTO `productspecs` VALUES (310, 102, 'Công suất	\n', '4.2W');
INSERT INTO `productspecs` VALUES (311, 102, 'Thời lượng pin	\n', '28 giờ');
INSERT INTO `productspecs` VALUES (312, 102, 'Tính năng khác', 'Kết nối nhiều loa Auracast');
INSERT INTO `productspecs` VALUES (313, 102, 'Cấu tạo', 'Woofer: 30W RMS\nTweeter: 10W RMS\nTổng công suất tối đa: 45W');
INSERT INTO `productspecs` VALUES (314, 102, 'Chống nước	\n', 'IP68');
INSERT INTO `productspecs` VALUES (315, 102, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (316, 103, 'Trọng lượng', '0.209kg');
INSERT INTO `productspecs` VALUES (317, 103, 'Kích thước', '86 x 71.2 x 31.6 mm');
INSERT INTO `productspecs` VALUES (318, 103, 'Công nghệ âm thanh	\n', 'JBL Pro Sound');
INSERT INTO `productspecs` VALUES (319, 103, 'Công suất	\n', '20 W');
INSERT INTO `productspecs` VALUES (320, 103, 'Thời lượng pin	\n', '12 giờ');
INSERT INTO `productspecs` VALUES (321, 103, 'Tính năng khác', '100 loa (các loa có PartyBoost)');
INSERT INTO `productspecs` VALUES (322, 103, 'Cấu tạo', 'Đèn LED 360 độ');
INSERT INTO `productspecs` VALUES (323, 103, 'Chống nước	\n', 'IPX7');
INSERT INTO `productspecs` VALUES (324, 103, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (325, 104, 'Trọng lượng', '1.47 kg');
INSERT INTO `productspecs` VALUES (326, 104, 'Kích thước', '10.7 x 21.4 x 13.2 cm');
INSERT INTO `productspecs` VALUES (327, 104, 'Công nghệ âm thanh	\n', 'JBL Original Pro');
INSERT INTO `productspecs` VALUES (328, 104, 'Công suất	\n', '30 W RMS cho loa trầm\n10 W RMS cho loa tweeter');
INSERT INTO `productspecs` VALUES (329, 104, 'Thời lượng pin	\n', '12 giờ');
INSERT INTO `productspecs` VALUES (330, 104, 'Tính năng khác', 'JBL PartyBoost\nĐèn LED');
INSERT INTO `productspecs` VALUES (331, 104, 'Cấu tạo', 'Woofer: 45 x 80 mm, Tweeter: 16 mm');
INSERT INTO `productspecs` VALUES (332, 104, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (333, 104, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (334, 105, 'Trọng lượng', '2.3 kg');
INSERT INTO `productspecs` VALUES (335, 105, 'Kích thước', '86 x 71.2 x 31.6 mm');
INSERT INTO `productspecs` VALUES (336, 105, 'Công nghệ âm thanh	\n', 'JBL Pro Sound');
INSERT INTO `productspecs` VALUES (337, 105, 'Công suất	\n', '2 x 25 W RMS woofer + 2 x 25 W RMS tweeter');
INSERT INTO `productspecs` VALUES (338, 105, 'Thời lượng pin	\n', '15 giờ');
INSERT INTO `productspecs` VALUES (339, 105, 'Tính năng khác', 'Sạc ngược cho thiết bị khác');
INSERT INTO `productspecs` VALUES (340, 105, 'Cấu tạo', '2 loa');
INSERT INTO `productspecs` VALUES (341, 105, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (342, 105, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (343, 106, 'Trọng lượng', '2.1 kg');
INSERT INTO `productspecs` VALUES (344, 106, 'Kích thước', '29.7 x 14.9 x 14.1 cm');
INSERT INTO `productspecs` VALUES (345, 106, 'Công nghệ âm thanh	\n', 'AI Sound Boost');
INSERT INTO `productspecs` VALUES (346, 106, 'Công suất	\n', '2 loa trầm 30 W RMS + 2 loa tweeter 20 W RMS (chế độ CA) 2 loa trầm 20 W RMS + 2 loa tweeter 15 W RMS (chế độ pin)');
INSERT INTO `productspecs` VALUES (347, 106, 'Thời lượng pin	\n', '24 giờ');
INSERT INTO `productspecs` VALUES (348, 106, 'Tính năng khác', 'Sạc nhanh\nKết nối Auracast™');
INSERT INTO `productspecs` VALUES (349, 106, 'Cấu tạo', 'Woofer: 45 x 80 mm, Tweeter: 16 mm');
INSERT INTO `productspecs` VALUES (350, 106, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (351, 106, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (352, 107, 'Trọng lượng', '5.9 kg');
INSERT INTO `productspecs` VALUES (353, 107, 'Kích thước', '48.5 x 20.1 x 25.7 cm');
INSERT INTO `productspecs` VALUES (354, 107, 'Công nghệ âm thanh	\n', 'JBL Pro Sound');
INSERT INTO `productspecs` VALUES (355, 107, 'Công suất	\n', '2 x 40 W RMS-woofer + 2 x 40 W RMS-tweeter');
INSERT INTO `productspecs` VALUES (356, 107, 'Thời lượng pin	\n', '24 giờ');
INSERT INTO `productspecs` VALUES (357, 107, 'Tính năng khác', '100 loa (Các loa có Partyboost)');
INSERT INTO `productspecs` VALUES (358, 107, 'Cấu tạo', '2 loa');
INSERT INTO `productspecs` VALUES (359, 107, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (360, 107, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (361, 108, 'Trọng lượng', '6.7 kg');
INSERT INTO `productspecs` VALUES (362, 108, 'Kích thước', '48.2 cm x 25.7 cm x 20.0 cm');
INSERT INTO `productspecs` VALUES (363, 108, 'Công nghệ âm thanh	\n', 'JBL Original Pro Sound');
INSERT INTO `productspecs` VALUES (364, 108, 'Công suất	\n', '180W');
INSERT INTO `productspecs` VALUES (365, 108, 'Thời lượng pin	\n', '24 giờ');
INSERT INTO `productspecs` VALUES (366, 108, 'Tính năng khác', 'Sạc nhanh\nKết nối Auracast™');
INSERT INTO `productspecs` VALUES (367, 108, 'Cấu tạo', '2 loa');
INSERT INTO `productspecs` VALUES (368, 108, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (369, 108, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (379, 109, 'Trọng lượng', '27.8 kg');
INSERT INTO `productspecs` VALUES (380, 109, 'Kích thước', '39.9 x 90.5 x 43.6 cm');
INSERT INTO `productspecs` VALUES (381, 109, 'Công nghệ âm thanh	\n', 'True Wireless Stereo\nJBL Original Pro Sound');
INSERT INTO `productspecs` VALUES (382, 109, 'Công suất	\n', '800 W');
INSERT INTO `productspecs` VALUES (383, 109, 'Thời lượng pin	\n', '24 giờ');
INSERT INTO `productspecs` VALUES (384, 109, 'Tính năng khác', 'Đèn LED RGB thay đổi theo nhịp nhạc');
INSERT INTO `productspecs` VALUES (385, 109, 'Cấu tạo', '2 củ loa trầm: 8 inch + 2 củ loa tweeter: 2.75 inch');
INSERT INTO `productspecs` VALUES (386, 109, 'Chống nước	\n', 'IPX4');
INSERT INTO `productspecs` VALUES (387, 109, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (388, 111, 'Trọng lượng', '4.9 kg');
INSERT INTO `productspecs` VALUES (389, 111, 'Kích thước', '342 x 195.6 x 180.3 mm');
INSERT INTO `productspecs` VALUES (390, 111, 'Công nghệ âm thanh	\n', 'lưới tản nhiệt Quadrex');
INSERT INTO `productspecs` VALUES (391, 111, 'Công suất	\n', '100W');
INSERT INTO `productspecs` VALUES (392, 111, 'Thời lượng pin	\n', '8 giờ');
INSERT INTO `productspecs` VALUES (393, 111, 'Tính năng khác', 'Trợ lý giọng nói\nTích hợp WiFi');
INSERT INTO `productspecs` VALUES (394, 111, 'Cấu tạo', '2x tweeter 25mm + loa woofer 5.25');
INSERT INTO `productspecs` VALUES (395, 111, 'Chống nước	\n', 'Không');
INSERT INTO `productspecs` VALUES (396, 111, 'Hãng sản xuất	\n', 'JBL');
INSERT INTO `productspecs` VALUES (397, 26, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (398, 26, 'Thời lượng sử dụng Pin', 'Tai nghe: 5.5 giờ\nHộp sạc: 30 giờ');
INSERT INTO `productspecs` VALUES (399, 26, 'Tính năng khác', 'Công nghệ Clear Calls\nĐộ trễ thấp');
INSERT INTO `productspecs` VALUES (400, 26, 'Hãng sản xuất', 'Havit');
INSERT INTO `productspecs` VALUES (401, 27, 'Kích thước', '168 x 190 x 85 mm');
INSERT INTO `productspecs` VALUES (402, 27, 'Trọng lượng', '190g');
INSERT INTO `productspecs` VALUES (403, 27, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (404, 27, 'Thời lượng sử dụng Pin', '20 giờ');
INSERT INTO `productspecs` VALUES (405, 27, 'Phương thức điều khiển', 'Nút bấm vật lý');
INSERT INTO `productspecs` VALUES (406, 27, 'Tính năng khác', 'Chống ồn môi trường (ENC)');
INSERT INTO `productspecs` VALUES (407, 27, 'Hãng sản xuất', 'Havit');
INSERT INTO `productspecs` VALUES (408, 28, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (409, 28, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (410, 28, 'Hãng sản xuất', 'Havit');
INSERT INTO `productspecs` VALUES (411, 29, 'Kích thước', 'Dài 2.5 cm - Rộng 1.7 cm - Cao 2.3 cm');
INSERT INTO `productspecs` VALUES (412, 29, 'Trọng lượng', '4.6 g');
INSERT INTO `productspecs` VALUES (413, 29, 'Công nghệ âm thanh', '360 Reality Audio\nDSEE\nEqualizer');
INSERT INTO `productspecs` VALUES (414, 29, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (415, 29, 'Thời lượng sử dụng Pin', 'Tai nghe: 11 giờ\nHộp sạc: 11 giờ');
INSERT INTO `productspecs` VALUES (416, 29, 'Phương thức điều khiển', 'Nút bấm vật lý');
INSERT INTO `productspecs` VALUES (417, 29, 'Tính năng khác', 'Xuyên âm\nDual Connect\nFast Pair\nMicro giảm ồn\nChống nước IPX4');
INSERT INTO `productspecs` VALUES (418, 29, 'Hãng sản xuất', 'Sony');
INSERT INTO `productspecs` VALUES (419, 30, 'Trọng lượng', '299 g');
INSERT INTO `productspecs` VALUES (420, 30, 'Công nghệ âm thanh', '360 Spatial Sound');
INSERT INTO `productspecs` VALUES (421, 30, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (422, 30, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (423, 30, 'Phương thức điều khiển', 'Nút bấm vật lý');
INSERT INTO `productspecs` VALUES (424, 30, 'Tính năng khác', 'Micro boom');
INSERT INTO `productspecs` VALUES (425, 30, 'Hãng sản xuất', 'Sony');
INSERT INTO `productspecs` VALUES (426, 31, 'Kích thước', 'Dài 26 cm - Rộng 20.8 cm - Cao 5.5 cm');
INSERT INTO `productspecs` VALUES (427, 31, 'Trọng lượng', '192g');
INSERT INTO `productspecs` VALUES (428, 31, 'Công nghệ âm thanh', 'Bộ xử lý tích hợp V1 codec SBC Chống ồn kỹ thuật số Công nghệ ENC Công nghệ lọc tiếng ồn Ambient Sound codec AAC 360 Reality Audio DSEE Adaptive Sound Control Equalizer');
INSERT INTO `productspecs` VALUES (429, 31, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (430, 31, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (431, 31, 'Thời lượng sử dụng Pin', 'Bật ANC: 35 giờ\nTắt ANC: 50 giờ');
INSERT INTO `productspecs` VALUES (432, 31, 'Phương thức điều khiển', 'Nút bấm vật lý');
INSERT INTO `productspecs` VALUES (433, 31, 'Tính năng khác', 'Tương thích trợ lý ảo');
INSERT INTO `productspecs` VALUES (434, 31, 'Hãng sản xuất', 'Sony');
INSERT INTO `productspecs` VALUES (435, 32, 'Công nghệ âm thanh', '360 Reality Audio\nÂm thanh kỹ thuật số (DSEE)\n360 Spatial Sound Personalizer');
INSERT INTO `productspecs` VALUES (436, 32, 'Micro', 'Micro kép');
INSERT INTO `productspecs` VALUES (437, 32, 'Thời lượng sử dụng Pin', 'Tai nghe: 8 giờ\nHộp sạc: 21.5 giờ');
INSERT INTO `productspecs` VALUES (438, 32, 'Phương thức điều khiển', 'Cảm ứng');
INSERT INTO `productspecs` VALUES (439, 32, 'Tính năng khác', 'Chống nước IPX4\nSử dụng độc lập 1 bên tai');
INSERT INTO `productspecs` VALUES (440, 32, 'Hãng sản xuất', 'Sony');
INSERT INTO `productspecs` VALUES (441, 33, 'Kích thước', '47.2 x 47.2 x 32.6 mm');
INSERT INTO `productspecs` VALUES (442, 33, 'Trọng lượng', 'xấp xỉ 4.9 g (x2 tai bao gồm miếng đệm tai)');
INSERT INTO `productspecs` VALUES (443, 33, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (444, 33, 'Thời lượng sử dụng Pin', 'Phát nhạc liên tục: 5h (bật chống ồn) - 8h (tắt chống ồn)\nGiao tiếp liên tục: tối đa 4h\nThời gian chờ: 6.5 giờ (bật chống ồn) - 14 giờ (tắt chống ồn)');
INSERT INTO `productspecs` VALUES (445, 33, 'Tính năng khác', 'Chống nước IPX4');
INSERT INTO `productspecs` VALUES (446, 33, 'Hãng sản xuất', 'Sony');
INSERT INTO `productspecs` VALUES (447, 34, 'Trọng lượng', 'Xấp xỉ 6,5 g x 2');
INSERT INTO `productspecs` VALUES (448, 34, 'Công nghệ âm thanh', 'Chống ồn\n360 Spatial Sound');
INSERT INTO `productspecs` VALUES (449, 34, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (450, 34, 'Thời lượng sử dụng Pin', 'Tai nghe: 12 giờ\nHộp sạc: 24 giờ (Tắt chống ồn)');
INSERT INTO `productspecs` VALUES (451, 34, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (452, 34, 'Tính năng khác', 'Chống nước IPX4');
INSERT INTO `productspecs` VALUES (453, 34, 'Hãng sản xuất', 'Sony');
INSERT INTO `productspecs` VALUES (454, 35, 'Trọng lượng', '260g');
INSERT INTO `productspecs` VALUES (455, 35, 'Công nghệ âm thanh', '360 Spatial Sound');
INSERT INTO `productspecs` VALUES (456, 35, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (457, 35, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (458, 35, 'Thời lượng sử dụng Pin', '28 giờ');
INSERT INTO `productspecs` VALUES (459, 35, 'Phương thức điều khiển', 'Nút bấm vật lý');
INSERT INTO `productspecs` VALUES (460, 35, 'Tính năng khác', 'Chống ồn đàm thoại');
INSERT INTO `productspecs` VALUES (461, 35, 'Hãng sản xuất', 'Sony');
INSERT INTO `productspecs` VALUES (462, 36, 'Kích thước', 'Dài 20.15 cm - Rộng 7 cm - Cao 25.4 cm');
INSERT INTO `productspecs` VALUES (463, 36, 'Trọng lượng', '255g');
INSERT INTO `productspecs` VALUES (464, 36, 'Công nghệ âm thanh', 'Chống ồn chủ động ANC\n360 Reality Audio + Headtracking\nDSEE');
INSERT INTO `productspecs` VALUES (465, 36, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (466, 36, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (467, 36, 'Thời lượng sử dụng Pin', 'Phát nhạc liên tục: Tối đa 30 giờ (Bật chống ồn), Tối đa 50 giờ (Tắt chống ồn)\nGiao tiếp liên tục: Tối đa 30 giờ (Bật chống ồn), Tối đa 40 giờ (Tắt chống ồn');
INSERT INTO `productspecs` VALUES (468, 36, 'Tính năng khác', 'Công nghệ nhận diện giọng nói + Beamforming\nChế độ âm thanh xung quanh');
INSERT INTO `productspecs` VALUES (469, 36, 'Hãng sản xuất', 'Sony');
INSERT INTO `productspecs` VALUES (470, 37, 'Kích thước', '10 x 7.2 x 5.1 cm');
INSERT INTO `productspecs` VALUES (471, 37, 'Trọng lượng', '254 g');
INSERT INTO `productspecs` VALUES (472, 37, 'Công nghệ âm thanh', 'DSEE Extreme (Cơ chế tăng cường âm thanh kỹ thuật số)\nHi-Res Audio\nChống ồn HD QN1');
INSERT INTO `productspecs` VALUES (473, 37, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (474, 37, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (475, 37, 'Thời lượng sử dụng Pin', 'Bật chống ồn: 30 giờ\nTắt chống ồn: 38 giờ');
INSERT INTO `productspecs` VALUES (476, 37, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (477, 37, 'Tính năng khác', 'Chống ồn tự động\nTối ưu hóa áp suất khí quyển\nKết nối 1 chạm Fast Pair');
INSERT INTO `productspecs` VALUES (478, 37, 'Hãng sản xuất', 'Sony');
INSERT INTO `productspecs` VALUES (479, 38, 'Trọng lượng', '260g');
INSERT INTO `productspecs` VALUES (480, 38, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (481, 38, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (482, 38, 'Thời lượng sử dụng Pin', '30 giờ');
INSERT INTO `productspecs` VALUES (483, 38, 'Phương thức điều khiển', 'Nút bấm vật lý');
INSERT INTO `productspecs` VALUES (484, 38, 'Tính năng khác', 'Kết nối Bluetooth hoặc không dây 2.4GHz');
INSERT INTO `productspecs` VALUES (485, 38, 'Hãng sản xuất', 'Sony');
INSERT INTO `productspecs` VALUES (486, 39, 'Công nghệ âm thanh', 'Spatial studio, Âm thanh 3D, Dolby Atmos');
INSERT INTO `productspecs` VALUES (487, 39, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (488, 39, 'Phương thức điều khiển', 'Cảm biến lực');
INSERT INTO `productspecs` VALUES (489, 39, 'Chipset', 'Apple H1');
INSERT INTO `productspecs` VALUES (490, 39, 'Hãng sản xuất', 'Apple Chính hãng');
INSERT INTO `productspecs` VALUES (491, 40, 'Công nghệ âm thanh', 'Spatial studio, Âm thanh 3D, Dolby Atmos');
INSERT INTO `productspecs` VALUES (492, 40, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (493, 40, 'Phương thức điều khiển', 'Cảm biến lực');
INSERT INTO `productspecs` VALUES (494, 40, 'Chipset', 'Apple H1');
INSERT INTO `productspecs` VALUES (495, 40, 'Hãng sản xuất', 'Apple Chính hãng');
INSERT INTO `productspecs` VALUES (496, 40, 'Phạm vi kết nối', '10 m');
INSERT INTO `productspecs` VALUES (497, 41, 'Kích thước', 'Tai nghe: 30.2 x 18.3 x 18.1 mm\nHộp sạc: 46.2 x 50.1 x 21.2 mm');
INSERT INTO `productspecs` VALUES (498, 41, 'Trọng lượng', 'Tai nghe: 4.3g\nHộp sạc: 34.7g');
INSERT INTO `productspecs` VALUES (499, 41, 'Công nghệ âm thanh', 'Trình điều khiển Apple với độ lệch tương phản cao có thể tùy chỉnh\nBộ khuếch đại với độ lệch tương phản cao có thể tùy chỉnh\nChủ động khử tiếng ồn\nChế độ xuyên âm\nNhận Biết Cuộc Hội Thoại\nTách Lời Nói\nChế độ Âm Thanh Không Gian Cá N');
INSERT INTO `productspecs` VALUES (500, 41, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (501, 41, 'Thời lượng sử dụng Pin', 'Thời gian nghe lên đến 4 giờ với một lần sạc khi bật tính năng Chủ Động Khử Tiếng Ồn\nThời gian nghe lên đến 5 giờ với một lần sạc khi tắt kiểm soát tiếng ồn\nThời gian đàm thoại lên đến 4,5 giờ với một lần sạc');
INSERT INTO `productspecs` VALUES (502, 41, 'Phương thức điều khiển', 'Cảm biến lực');
INSERT INTO `productspecs` VALUES (503, 41, 'Chipset', 'Chip tai nghe H2');
INSERT INTO `productspecs` VALUES (504, 41, 'Hãng sản xuất', 'Apple Chính hãng');
INSERT INTO `productspecs` VALUES (505, 42, 'Kích thước', 'Tai nghe: 30.2 x 18.3 x 18.1 mm\nHộp sạc: 46.2 x 50.1 x 21.2 mm');
INSERT INTO `productspecs` VALUES (506, 42, 'Trọng lượng', 'Tai nghe: 4.3g\nHộp sạc: 34.7g');
INSERT INTO `productspecs` VALUES (507, 42, 'Công nghệ âm thanh', 'Trình điều khiển Apple với độ lệch tương phản cao có thể tùy chỉnh\nBộ khuếch đại với độ lệch tương phản cao có thể tùy chỉnh\nChủ động khử tiếng ồn\nChế độ xuyên âm\nNhận Biết Cuộc Hội Thoại\nTách Lời Nói\nChế độ Âm Thanh Không Gian Cá N');
INSERT INTO `productspecs` VALUES (508, 42, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (509, 42, 'Thời lượng sử dụng Pin', 'Thời gian nghe lên đến 4 giờ với một lần sạc khi bật tính năng Chủ Động Khử Tiếng Ồn\nThời gian nghe lên đến 5 giờ với một lần sạc khi tắt kiểm soát tiếng ồn\nThời gian đàm thoại lên đến 4,5 giờ với một lần sạc');
INSERT INTO `productspecs` VALUES (510, 42, 'Phương thức điều khiển', 'Cảm biến lực');
INSERT INTO `productspecs` VALUES (511, 42, 'Chipset', 'Chip tai nghe H2');
INSERT INTO `productspecs` VALUES (512, 42, 'Hãng sản xuất', 'Apple Chính hãng');
INSERT INTO `productspecs` VALUES (513, 43, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (514, 43, 'Phương thức điều khiển', 'Chạm 2 lần');
INSERT INTO `productspecs` VALUES (515, 43, 'Hãng sản xuất', 'Apple Chính hãng');
INSERT INTO `productspecs` VALUES (516, 43, 'Phạm vi kết nối', '10 m');
INSERT INTO `productspecs` VALUES (517, 44, 'Công nghệ âm thanh', 'Active Noise Cancellation\nChip Apple H2\nAdaptive EQ');
INSERT INTO `productspecs` VALUES (518, 44, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (519, 44, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (520, 44, 'Hãng sản xuất', 'Apple Chính hãng');
INSERT INTO `productspecs` VALUES (521, 45, 'Kích thước', 'Tai Nghe: 30,9 x 19,2 x 27,0 mm\nHộp Sạc: 47,2 mm x 62,2 x 21,8 mm');
INSERT INTO `productspecs` VALUES (522, 45, 'Trọng lượng', 'Tai Nghe: 5,55 gram\nHộp Sạc + Tai Nghe: 43,99 gram');
INSERT INTO `productspecs` VALUES (523, 45, 'Công nghệ âm thanh', 'Trình điều khiển Apple với độ lệch tương phản cao có thể tùy chỉnh\nBộ khuếch đại với độ lệch tương phản cao có thể tùy chỉnh\nChủ Động Khử Tiếng Ồn tai bạn chưa từng nghe\nÂm Thanh Thích Ứng\nChế độ Xuyên Âm\nNhận Biết Cuộc Hội Thoại');
INSERT INTO `productspecs` VALUES (524, 45, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (525, 45, 'Cổng kết nối', 'Type C');
INSERT INTO `productspecs` VALUES (526, 45, 'Thời lượng sử dụng Pin', 'Tai nghe: lên đến 8 giờ\nTai nghe + hộp sạc: lên đến 24 giờ');
INSERT INTO `productspecs` VALUES (527, 45, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (528, 45, 'Tính năng khác', 'Kiểm tra thính giác\nThiết bị trợ thính\nGiảm âm thanh lớn\nCảm biến theo dõi nhịp tim khi tập luyện\nChống bụi, chống mồ hôi và chống nước (IP57)');
INSERT INTO `productspecs` VALUES (529, 45, 'Chipset', 'Chip Apple H2');
INSERT INTO `productspecs` VALUES (530, 45, 'Hãng sản xuất', 'Apple Chính hãng');
INSERT INTO `productspecs` VALUES (531, 46, 'Công nghệ âm thanh', 'Trình điều khiển động do Apple thiết kế\nTính năng Chủ Động Khử Tiếng Ồn đẳng cấp Pro\nChế độ Xuyên Âm\nChế độ Âm Thanh Không Gian Cá Nhân Hóa với tính năng theo dõi chuyển động đầu chủ động\nEQ Thích Ứng');
INSERT INTO `productspecs` VALUES (532, 46, 'Micro', 'Tám micrô dành cho tính năng Chủ Động Khử Tiếng Ồn\nBa micrô dành cho tính năng nhận diện giọng nói (hai micrô dùng chung với tính năng Chủ Động Khử Tiếng Ồn và một micrô bổ sung)');
INSERT INTO `productspecs` VALUES (533, 46, 'Tính năng khác', 'Sạc nhanh');
INSERT INTO `productspecs` VALUES (534, 46, 'Chipset', 'Chip tai nghe Apple H1');
INSERT INTO `productspecs` VALUES (535, 46, 'Hãng sản xuất', 'Apple Chính hãng');
INSERT INTO `productspecs` VALUES (536, 46, 'Cảm biến', 'Cảm biến quang học (mỗi bên củ tai)\nCảm biến vị trí (mỗi bên củ tai)\nCảm biến phát hiện hộp (mỗi bên củ tai)\nGia tốc kế (mỗi bên củ tai)\nCon quay hồi chuyển (củ tai bên trái)');
INSERT INTO `productspecs` VALUES (537, 47, 'Tính năng', 'Chống ồn, Có mic đàm thoại');
INSERT INTO `productspecs` VALUES (538, 47, 'Dung lượng pin', '20 giờ');
INSERT INTO `productspecs` VALUES (539, 47, 'Thời gian sạc', '3 giờ');
INSERT INTO `productspecs` VALUES (540, 47, 'Kích thước', '187.3 x 168.6 x 83.4 mm');
INSERT INTO `productspecs` VALUES (541, 47, 'Tính năng khác', 'Sạc nhanh');
INSERT INTO `productspecs` VALUES (542, 47, 'Hãng sản xuất', 'Apple Chính hãng');
INSERT INTO `productspecs` VALUES (543, 48, 'Kích thước', 'Dài 3.2 cm - Rộng 1.8 cm - Cao 1.2 cm');
INSERT INTO `productspecs` VALUES (544, 48, 'Trọng lượng', 'Tai nghe: 7.39 g\nHộp sạc: 39.41 g');
INSERT INTO `productspecs` VALUES (545, 48, 'Công nghệ âm thanh', 'Marshall Signature Sound');
INSERT INTO `productspecs` VALUES (546, 48, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (547, 48, 'Thời lượng sử dụng Pin', 'Tai nghe: 7 giờ\nHộp sạc: 30 giờ');
INSERT INTO `productspecs` VALUES (548, 48, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (549, 48, 'Tính năng khác', 'Sạc nhanh');
INSERT INTO `productspecs` VALUES (550, 48, 'Hãng sản xuất', 'Marshall');
INSERT INTO `productspecs` VALUES (551, 49, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (552, 49, 'Dung lượng pin', 'Tai nghe: Dùng 5 giờ\nHộp sạc: Dùng 25 giờ');
INSERT INTO `productspecs` VALUES (553, 49, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (554, 49, 'Phạm vi kết nối', '10 m');
INSERT INTO `productspecs` VALUES (555, 49, 'Trọng lượng', 'Tai nghe: 4 g\nHộp sạc: 40 g');
INSERT INTO `productspecs` VALUES (556, 50, 'Kích thước', 'Dài 7 cm - Rộng 6.6 cm - Cao 4 cm');
INSERT INTO `productspecs` VALUES (557, 50, 'Trọng lượng', '186g');
INSERT INTO `productspecs` VALUES (558, 50, 'Công nghệ âm thanh', 'Âm thanh Marshall');
INSERT INTO `productspecs` VALUES (559, 50, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (560, 50, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (561, 50, 'Thời lượng sử dụng Pin', '100 giờ');
INSERT INTO `productspecs` VALUES (562, 50, 'Phương thức điều khiển', 'Phím nhấn');
INSERT INTO `productspecs` VALUES (563, 51, 'Kích thước', 'Dài 16 cm - Rộng 16 cm - Cao 8.6 cm');
INSERT INTO `productspecs` VALUES (564, 51, 'Trọng lượng', '165 g');
INSERT INTO `productspecs` VALUES (565, 51, 'Công nghệ âm thanh', 'Marshall Signature Sound');
INSERT INTO `productspecs` VALUES (566, 51, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (567, 51, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (568, 51, 'Thời lượng sử dụng Pin', '80 giờ');
INSERT INTO `productspecs` VALUES (569, 51, 'Phương thức điều khiển', 'Núm điều khiển');
INSERT INTO `productspecs` VALUES (570, 51, 'Tính năng khác', 'Sạc nhanh');
INSERT INTO `productspecs` VALUES (571, 52, 'Trọng lượng', 'Tai nghe: 4.25 g');
INSERT INTO `productspecs` VALUES (572, 52, 'Công nghệ âm thanh', 'Chống ồn chủ động ANC');
INSERT INTO `productspecs` VALUES (573, 52, 'Micro', 'Có\n4 micro');
INSERT INTO `productspecs` VALUES (574, 52, 'Thời lượng sử dụng Pin', 'Tai nghe: Dùng 6 giờ\nHộp sạc: Dùng 26 giờ ( Tắt ANC)');
INSERT INTO `productspecs` VALUES (575, 52, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (576, 52, 'Tính năng khác', 'Chống nước IPX5 đối với tai nghe\nChống nước IPX4 cho hộp sạc di động');
INSERT INTO `productspecs` VALUES (577, 53, 'Kích thước', 'Dài 3 cm - Rộng 2 cm - Cao 1 cm');
INSERT INTO `productspecs` VALUES (578, 53, 'Trọng lượng', 'Tai nghe: 4.25 g');
INSERT INTO `productspecs` VALUES (579, 53, 'Công nghệ âm thanh', 'Chống ồn chủ động ANC\nMarshall Signature Sound\nActive Noise Cancelling');
INSERT INTO `productspecs` VALUES (580, 53, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (581, 53, 'Thời lượng sử dụng Pin', 'Tai nghe: 9 giờ\nHộp sạc: 43 giờ');
INSERT INTO `productspecs` VALUES (582, 53, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (583, 53, 'Tính năng khác', 'Chống nước IPX5');
INSERT INTO `productspecs` VALUES (584, 54, 'Kích thước', 'Dài 20.5 cm - Rộng 14.5 cm - Cao 7.3 cm');
INSERT INTO `productspecs` VALUES (585, 54, 'Trọng lượng', '320g');
INSERT INTO `productspecs` VALUES (586, 54, 'Công nghệ âm thanh', 'Chống ồn chủ động ANC\nMarshall Signature Sound\nActive Noise Cancelling');
INSERT INTO `productspecs` VALUES (587, 54, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (588, 54, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (589, 54, 'Thời lượng sử dụng Pin', 'Bật ANC: 30 giờ\nTắt ANC: 45 giờ');
INSERT INTO `productspecs` VALUES (590, 54, 'Tính năng khác', 'Sạc nhanh');
INSERT INTO `productspecs` VALUES (591, 55, 'Kích thước', 'Dài 10 cm - Rộng 8 cm - Cao 4.7 cm');
INSERT INTO `productspecs` VALUES (592, 55, 'Trọng lượng', '250 g');
INSERT INTO `productspecs` VALUES (593, 55, 'Công nghệ âm thanh', 'Marshall Signature Sound\nCông nghệ Soundstage\nAdaptive Loudness\nActive Noise Cancelling\nTransparency Mode');
INSERT INTO `productspecs` VALUES (594, 55, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (595, 55, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (596, 55, 'Thời lượng sử dụng Pin', '70 giờ bật ANC - 100h tắt ANC');
INSERT INTO `productspecs` VALUES (597, 56, 'Kích thước', 'Tai nghe: 32 x 17.8 x 18.5mm\nHộp sạc:49 x 48.6 x 23mm');
INSERT INTO `productspecs` VALUES (598, 56, 'Trọng lượng', '4g');
INSERT INTO `productspecs` VALUES (599, 56, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (600, 56, 'Thời lượng sử dụng Pin', 'Tai nghe: 6 giờ\nHộp sạc:30 giờ');
INSERT INTO `productspecs` VALUES (601, 56, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (602, 56, 'Tính năng khác', 'Chống ồn môi trường ENC\nChống nước IPX4');
INSERT INTO `productspecs` VALUES (603, 57, 'Kích thước', 'Tai nghe 31.13x21.34x23.5 mm\nHộp sạc 61.01x51.71x24.80 mm');
INSERT INTO `productspecs` VALUES (604, 57, 'Micro', '2 Micro chống ồn với khả năng chống gió tới 9m/s');
INSERT INTO `productspecs` VALUES (605, 57, 'Thời lượng sử dụng Pin', 'Tai nghe: 10 giờ(tắt ANC)\nHộp sạc: 42 giờ(tắt ANC)');
INSERT INTO `productspecs` VALUES (606, 57, 'Tính năng khác', 'Chống ồn: Hybrid Active (49db/2kHz)\n3 chế độ chống ồn chủ động');
INSERT INTO `productspecs` VALUES (607, 58, 'Kích thước', 'Tai nghe: 30.6x21.4x24.5 mm\nHộp sạc: 61.05x48.28x25.17 mm');
INSERT INTO `productspecs` VALUES (608, 58, 'Trọng lượng', 'Khoảng 5.2g(tai nghe)/ 46.5g(tổng)');
INSERT INTO `productspecs` VALUES (609, 58, 'Công nghệ âm thanh', 'Đạt chuẩn Hi-Res Audio và hỗ trợ codec âm thanh LDAC.');
INSERT INTO `productspecs` VALUES (610, 58, 'Micro', '3 Micro AI cho khả năng gọi điện rõ ràng, chống tạp âm gió 12m/s');
INSERT INTO `productspecs` VALUES (611, 58, 'Thời lượng sử dụng Pin', 'Tai nghe: 9 giờ (tắt ANC)\nHộp sạc: 36 giờ (tắt ANC)');
INSERT INTO `productspecs` VALUES (612, 58, 'Tính năng khác', 'Chống ồn chủ động 55dB/4kHz với 20 chế độ chống ồn');
INSERT INTO `productspecs` VALUES (613, 59, 'Kích thước', 'Tai nghe: 32.24 × 18.22 × 19.63 mm\nHộp sạc: 55.6 × 47.3 × 22.2 mm');
INSERT INTO `productspecs` VALUES (614, 59, 'Trọng lượng', 'Tai nghe: 3.92 g\nHộp sạc: 26.7 g');
INSERT INTO `productspecs` VALUES (615, 59, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (616, 59, 'Thời lượng sử dụng Pin', 'Tai nghe: 5 giờ\nHộp sạc: 20 giờ');
INSERT INTO `productspecs` VALUES (617, 59, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (618, 59, 'Tính năng khác', 'Khử tiếng ồn đàm thoại AI\nHỗ trợ Google Fast Pair\nChống nước IP54');
INSERT INTO `productspecs` VALUES (619, 60, 'Kích thước', 'Tai nghe: 54,24 × 39,3 × 13,79 mm\nCase sạc: 105,8 × 55,4 × 26,1 mm');
INSERT INTO `productspecs` VALUES (620, 60, 'Trọng lượng', 'Tai nghe: 9,6 g\nCase sạc: 68,78 g');
INSERT INTO `productspecs` VALUES (621, 60, 'Công nghệ âm thanh', 'Hi-Res');
INSERT INTO `productspecs` VALUES (622, 60, 'Micro', 'Mic kép, chống ồn AI');
INSERT INTO `productspecs` VALUES (623, 60, 'Thời lượng sử dụng Pin', 'Tai nghe: 7.5 giờ\nHộp sạc: 38.5 giờ');
INSERT INTO `productspecs` VALUES (624, 60, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (625, 61, 'Kích thước', 'Tai nghe: 50.8 x 34.9 x 16.7 mm\nHộp sạc: 68 x 68 x 26.3 mm');
INSERT INTO `productspecs` VALUES (626, 61, 'Trọng lượng', 'Tai nghe: 9.7 g\nHộp sạc + tai nghe: 72 g');
INSERT INTO `productspecs` VALUES (627, 61, 'Công nghệ âm thanh', 'Hi-Res Audio Wireless\n5 thiết lập EQ');
INSERT INTO `productspecs` VALUES (628, 61, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (629, 61, 'Thời lượng sử dụng Pin', 'Tai nghe: 8.5 giờ\nHộp sạc: 45 giờ');
INSERT INTO `productspecs` VALUES (630, 61, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (631, 61, 'Tính năng khác', 'Earbuds Recording 2.0\nPhiên dịch AI + ghi âm kết hợp với điện thoại Xiaomi');
INSERT INTO `productspecs` VALUES (632, 62, 'Kích thước', 'Tai nghe: 25.78 × 31.39 × 21.24 mm\nHộp sạc: 60.5 × 48.45 × 26.79 mm');
INSERT INTO `productspecs` VALUES (633, 62, 'Trọng lượng', 'Tai nghe: 5.6g (±0.1g)\nHộp sạc: 41.8g (±0.5g)');
INSERT INTO `productspecs` VALUES (634, 62, 'Công nghệ âm thanh', 'Hi-Res Audio\nQualcomm® aptX™ Lossless\nHarman AudioEFX');
INSERT INTO `productspecs` VALUES (635, 62, 'Micro', '3 micro');
INSERT INTO `productspecs` VALUES (636, 62, 'Thời lượng sử dụng Pin', 'Tai nghe: 8 giờ\nHộp sạc: 40 giờ');
INSERT INTO `productspecs` VALUES (637, 62, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (638, 62, 'Tính năng khác', 'Điều khiển cử chỉ AI để phiên âm và dịch thuật\nChống bụi & nước IP54');
INSERT INTO `productspecs` VALUES (639, 63, 'Kích thước', 'Tai nghe: 25.78 × 31.39 × 21.24 mm\nHộp sạc: 60.5 × 48.45 × 26.79 mm');
INSERT INTO `productspecs` VALUES (640, 63, 'Trọng lượng', 'Tai nghe: 5.6g (±0.1g)\nHộp sạc: 41.8g (±0.5g)');
INSERT INTO `productspecs` VALUES (641, 63, 'Công nghệ âm thanh', 'Hi-Res Audio\nQualcomm® aptX™ Lossless\nHarman AudioEFX');
INSERT INTO `productspecs` VALUES (642, 63, 'Micro', '3 micro');
INSERT INTO `productspecs` VALUES (643, 63, 'Thời lượng sử dụng Pin', 'Tai nghe: 8 giờ\nHộp sạc: 40 giờ');
INSERT INTO `productspecs` VALUES (644, 63, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (645, 63, 'Tính năng khác', 'Điều khiển cử chỉ AI để phiên âm và dịch thuật\nChống bụi & nước IP54');
INSERT INTO `productspecs` VALUES (646, 81, 'Trọng lượng', '278g');
INSERT INTO `productspecs` VALUES (647, 81, 'Công nghệ âm thanh', 'JBL Personi-Fi 3.0\nSuperior Crystal-Clear Calls\nSeamless SmartTalk');
INSERT INTO `productspecs` VALUES (648, 81, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (649, 81, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (650, 81, 'Thời lượng sử dụng Pin', 'Tắt ANC 70 giờ\nBật ANC 40 giờ');
INSERT INTO `productspecs` VALUES (651, 81, 'Phương thức điều khiển', 'Nút bấm vật lý');
INSERT INTO `productspecs` VALUES (652, 81, 'Tính năng khác', 'Kết nối nhiều thiết bị Auracast™');
INSERT INTO `productspecs` VALUES (653, 81, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (654, 80, 'Kích thước', '10,2 mm x 5,1 mm x 2,8 mm');
INSERT INTO `productspecs` VALUES (655, 80, 'Trọng lượng', 'Trọng lượng hộp sạc: 71,8 gram\nTrọng lượng tai nghe: 5,6 gram');
INSERT INTO `productspecs` VALUES (656, 80, 'Công nghệ âm thanh', 'Hi-Res JBL Pro Sound');
INSERT INTO `productspecs` VALUES (657, 80, 'Micro', '6 mic');
INSERT INTO `productspecs` VALUES (658, 80, 'Thời lượng sử dụng Pin', 'Thời gian phát nhạc với Bluetooth và tắt ANC: lên đến 11 giờ\nThời gian phát nhạc với Bluetooth và bật ANC: lên đến 8 giờ\nThời gian phát nhạc với Bluetooth và bật True Adaptive ANC: lên đến 7 giờ\nThời gian đàm thoại với ANC tắt: lên đến 5.5 giờ');
INSERT INTO `productspecs` VALUES (659, 80, 'Tính năng khác', 'Kháng nước IP55');
INSERT INTO `productspecs` VALUES (660, 80, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (661, 79, 'Kích thước', 'Dài 9.2 cm - Rộng 7.5 cm - Cao 5.6 cm');
INSERT INTO `productspecs` VALUES (662, 79, 'Trọng lượng', '256g');
INSERT INTO `productspecs` VALUES (663, 79, 'Công nghệ âm thanh', 'JBL Signature Sound\nChống ồn chủ động ANC\nHi-Res Audio\nActive Noise Cancelling\nAmbient Aware\nTalkThru\n360 Reality Audio\nJBL Spatial Sound');
INSERT INTO `productspecs` VALUES (664, 79, 'Micro', 'Có\n4 micro');
INSERT INTO `productspecs` VALUES (665, 79, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (666, 79, 'Thời lượng sử dụng Pin', 'Thời gian phát nhạc tối đa khi tắt ANC 65 giờ\nThời gian đàm thoại tối đa 33 giờ');
INSERT INTO `productspecs` VALUES (667, 79, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (668, 79, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (669, 78, 'Trọng lượng', 'Tai nghe: 12.2 g\nHộp sạc: 73 g');
INSERT INTO `productspecs` VALUES (670, 78, 'Công nghệ âm thanh', 'Chống ồn ANC\nXuyên âm');
INSERT INTO `productspecs` VALUES (671, 78, 'Micro', 'Có (6 micro)');
INSERT INTO `productspecs` VALUES (672, 78, 'Thời lượng sử dụng Pin', 'Thời gian phát nhạc tối đa khi tắt ANC:10 giờ\nThời gian phát nhạc tối đa khi bật ANC: 8 giờ\nThời gian chơi tối đa: 40 giờ');
INSERT INTO `productspecs` VALUES (673, 78, 'Tính năng khác', 'Chống nước IPX5');
INSERT INTO `productspecs` VALUES (674, 78, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (675, 77, 'Kích thước', 'Tai nghe: 22.51 x 31.04 x 23.74mm\nHộp sạc: 61 x 51 x 30.25mm');
INSERT INTO `productspecs` VALUES (676, 77, 'Trọng lượng', 'Tai nghe: 5g mỗi bên (10g cả hai)\nHộp sạc: 72g');
INSERT INTO `productspecs` VALUES (677, 77, 'Công nghệ âm thanh', 'Chống ồn chủ động ANC\nJBL Spatial Sound');
INSERT INTO `productspecs` VALUES (678, 77, 'Micro', 'Có (6 mic)');
INSERT INTO `productspecs` VALUES (679, 77, 'Thời lượng sử dụng Pin', 'Tai nghe: 12 giờ\nHộp sạc: 36 giờ (Tắt ANC)');
INSERT INTO `productspecs` VALUES (680, 77, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (681, 77, 'Tính năng khác', 'Màn hình LED 1.45 inch\nSạc nhanh');
INSERT INTO `productspecs` VALUES (682, 77, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (683, 76, 'Kích thước', 'Dài 18 cm - Rộng 16 cm - Cao 6.5 cm');
INSERT INTO `productspecs` VALUES (684, 76, 'Trọng lượng', '219g');
INSERT INTO `productspecs` VALUES (685, 76, 'Công nghệ âm thanh', 'Chống ồn ANC');
INSERT INTO `productspecs` VALUES (686, 76, 'Micro', 'Có (2 Micro)');
INSERT INTO `productspecs` VALUES (687, 76, 'Cổng kết nối', '3.5mm');
INSERT INTO `productspecs` VALUES (688, 76, 'Thời lượng sử dụng Pin', 'ANC Tắt: 65 giờ\nANC bật ANC: 50 giờ');
INSERT INTO `productspecs` VALUES (689, 76, 'Phương thức điều khiển', 'Nút bấm và Ứng dụng');
INSERT INTO `productspecs` VALUES (690, 76, 'Tính năng khác', 'Gọi Alexa hoặc Hey Google');
INSERT INTO `productspecs` VALUES (691, 76, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (692, 75, 'Trọng lượng', 'Tai nghe: 19 g\nHộp sạc: 64.5 g');
INSERT INTO `productspecs` VALUES (693, 75, 'Công nghệ âm thanh', 'Công nghệ JBL OpenSound');
INSERT INTO `productspecs` VALUES (694, 75, 'Micro', 'Có (4 micro)');
INSERT INTO `productspecs` VALUES (695, 75, 'Thời lượng sử dụng Pin', 'Tai nghe: 8 giờ\nHộp sạc: 24 giờ');
INSERT INTO `productspecs` VALUES (696, 75, 'Phương thức điều khiển', 'Cảm ứng chạm\nĐiều khiển qua ứng dụng');
INSERT INTO `productspecs` VALUES (697, 75, 'Tính năng khác', 'Kháng nước, bụi: IP54\nKết nối đa điểm');
INSERT INTO `productspecs` VALUES (698, 75, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (699, 82, 'Trọng lượng', 'Tai nghe: 5.5 g mỗi chiếc (tổng cộng 11 g)\nHộp sạc: 42.6 g');
INSERT INTO `productspecs` VALUES (700, 82, 'Công nghệ âm thanh', 'JBL Pure Bass\nPersoni-Fi 3.0\nAmbient Aware\nJBL Spatial Sound');
INSERT INTO `productspecs` VALUES (701, 82, 'Micro', 'Có (6 micro)');
INSERT INTO `productspecs` VALUES (702, 82, 'Thời lượng sử dụng Pin', 'Tai nghe: 12 giờ (Tắt ANC)\nHộp sạc: 36 giờ');
INSERT INTO `productspecs` VALUES (703, 82, 'Phương thức điều khiển', 'Cảm ứng chạm\nĐiều khiển qua ứng dụng');
INSERT INTO `productspecs` VALUES (704, 82, 'Tính năng khác', 'Kháng nước, bụi: IP54\nKết nối đa điểm');
INSERT INTO `productspecs` VALUES (705, 82, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (706, 74, 'Kích thước', 'Tai nghe: 21.6 x 15.8 x 20.4mm\nHộp sạc: 68.9 x 26.7 x 37mm');
INSERT INTO `productspecs` VALUES (707, 74, 'Trọng lượng', 'Tai nghe: 4,5 g (mỗi bên)\nHộp sạc: 35g');
INSERT INTO `productspecs` VALUES (708, 74, 'Công nghệ âm thanh', 'JBL Pure Bass Sound');
INSERT INTO `productspecs` VALUES (709, 74, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (710, 74, 'Thời lượng sử dụng Pin', 'Thời gian phát lại lên đến 40 giờ\nTận hưởng 10 giờ phát nhạc, cộng thêm ba lần sạc đầy 30 giờ trong hộp sạc');
INSERT INTO `productspecs` VALUES (711, 74, 'Tính năng khác', 'Chống nước và bụi IP54');
INSERT INTO `productspecs` VALUES (712, 74, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (713, 73, 'Kích thước', 'Dài 3.4 cm - Rộng 2.5 cm - Cao 1.3 cm');
INSERT INTO `productspecs` VALUES (714, 73, 'Trọng lượng', 'Tai nghe: 5g\nHộp sạc: 50.3 g');
INSERT INTO `productspecs` VALUES (715, 73, 'Công nghệ âm thanh', 'JBL Pure Bass\nChống ồn chủ động ANC');
INSERT INTO `productspecs` VALUES (716, 73, 'Micro', 'Có (4 mic)');
INSERT INTO `productspecs` VALUES (717, 73, 'Thời lượng sử dụng Pin', 'Tai nghe: 12 giờ\nHộp sạc: 36 giờ (Tắt ANC)');
INSERT INTO `productspecs` VALUES (718, 73, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (719, 73, 'Tính năng khác', 'Chống ồn đàm thoại\nChống nước IP54');
INSERT INTO `productspecs` VALUES (720, 73, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (721, 72, 'Trọng lượng', 'Tai nghe: 9.6g\nHộp sạc: 38.6g');
INSERT INTO `productspecs` VALUES (722, 72, 'Micro', '4 Micro');
INSERT INTO `productspecs` VALUES (723, 72, 'Thời lượng sử dụng Pin', 'Tai nghe: 8 giờ\nHộp sạc: 24 giờ');
INSERT INTO `productspecs` VALUES (724, 72, 'Phương thức điều khiển', 'Chạm cảm ứng');
INSERT INTO `productspecs` VALUES (725, 72, 'Tính năng khác', 'Chống nước IPX4');
INSERT INTO `productspecs` VALUES (726, 72, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (727, 71, 'Kích thước', 'Dài 7.34 cm - Rộng 7.34 cm - Cao 1.78 cm');
INSERT INTO `productspecs` VALUES (728, 71, 'Trọng lượng', '157g');
INSERT INTO `productspecs` VALUES (729, 71, 'Công nghệ âm thanh', 'JBL Pure Bass');
INSERT INTO `productspecs` VALUES (730, 71, 'Micro', 'Có (1 mic)');
INSERT INTO `productspecs` VALUES (731, 71, 'Cổng kết nối', 'Type C');
INSERT INTO `productspecs` VALUES (732, 71, 'Thời lượng sử dụng Pin', '57 giờ');
INSERT INTO `productspecs` VALUES (733, 71, 'Phương thức điều khiển', 'Nút nhấn vật lý');
INSERT INTO `productspecs` VALUES (734, 71, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (735, 70, 'Kích thước', 'Kích thước tai nghe (Cao x Rộng x Dài): 33.4 x 22.6 x 25 mm\nKích thước hộp sạc (Cao x Rộng x Dài): 61.5 x 29.15 x 47 mm');
INSERT INTO `productspecs` VALUES (736, 70, 'Trọng lượng', 'Trọng lượng tai nghe: 5.2 g mỗi bên (10.4 g cả hai) /0.0115 lbs mỗi bên (0.0229 lbs cả hai)\nTrọng lượng hộp sạc: 42 g / 0.0926 lbs');
INSERT INTO `productspecs` VALUES (737, 70, 'Công nghệ âm thanh', 'JBL Pure Bass\nJBL Spatial Sound');
INSERT INTO `productspecs` VALUES (738, 70, 'Micro', '2 micro');
INSERT INTO `productspecs` VALUES (739, 70, 'Thời lượng sử dụng Pin', 'Thời gian phát nhạc khi bật BT và tắt ANC: lên tới 12 giờ\nThời gian phát nhạc khi bật BT và bật ANC: lên tới 10 giờ\nThời gian đàm thoại khi bật ANC: lên tới 6 giờ\nThời gian đàm thoại khi tắt ANC: lên tới 5 giờ');
INSERT INTO `productspecs` VALUES (740, 70, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (741, 70, 'Tính năng khác', 'Kháng nước IP54');
INSERT INTO `productspecs` VALUES (742, 70, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (743, 112, 'Trọng lượng', '0.4kg');
INSERT INTO `productspecs` VALUES (744, 112, 'Kích thước', '100.5 x 100.5 x 43.4 mm');
INSERT INTO `productspecs` VALUES (745, 112, 'Công nghệ âm thanh	\n', 'Điều chỉnh EQ\nChế độ Stack Mode');
INSERT INTO `productspecs` VALUES (746, 112, 'Công suất	\n', '10 W');
INSERT INTO `productspecs` VALUES (747, 112, 'Thời lượng pin	\n', '15 giờ');
INSERT INTO `productspecs` VALUES (748, 112, 'Tính năng khác', 'Sạc nhanh\nĐèn báo tín hiệu pin');
INSERT INTO `productspecs` VALUES (749, 112, 'Cấu tạo', '1 loa');
INSERT INTO `productspecs` VALUES (750, 112, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (751, 112, 'Hãng sản xuất	\n', 'Marshall');
INSERT INTO `productspecs` VALUES (752, 113, 'Trọng lượng', '0.36kg');
INSERT INTO `productspecs` VALUES (753, 113, 'Kích thước', '100.5 x 100.5 x 43.4 mm');
INSERT INTO `productspecs` VALUES (754, 113, 'Công nghệ âm thanh	\n', 'Marshall');
INSERT INTO `productspecs` VALUES (755, 113, 'Công suất	\n', '38W');
INSERT INTO `productspecs` VALUES (756, 113, 'Thời lượng pin	\n', '17 giờ');
INSERT INTO `productspecs` VALUES (757, 113, 'Tính năng khác', 'Sạc nhanh');
INSERT INTO `productspecs` VALUES (758, 113, 'Cấu tạo', 'Một bộ tản nhiệt thụ động toàn dải 1” 10W');
INSERT INTO `productspecs` VALUES (759, 113, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (760, 113, 'Hãng sản xuất	\n', 'Marshall');
INSERT INTO `productspecs` VALUES (761, 114, 'Trọng lượng', '0.7 kg');
INSERT INTO `productspecs` VALUES (762, 114, 'Kích thước', '68 x 160 x 76 mm');
INSERT INTO `productspecs` VALUES (763, 114, 'Công nghệ âm thanh	\n', 'Âm thanh 360°\nÂm thanh nổi');
INSERT INTO `productspecs` VALUES (764, 114, 'Công suất	\n', '20 W');
INSERT INTO `productspecs` VALUES (765, 114, 'Thời lượng pin	\n', '30 giờ');
INSERT INTO `productspecs` VALUES (766, 114, 'Tính năng khác', 'Sạc nhanh\nĐèn báo tín hiệu pin');
INSERT INTO `productspecs` VALUES (767, 114, 'Cấu tạo', '2 bộ driver công suất 10 W');
INSERT INTO `productspecs` VALUES (768, 114, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (769, 114, 'Hãng sản xuất	\n', 'Marshall');
INSERT INTO `productspecs` VALUES (770, 115, 'Trọng lượng', '0.67 kg');
INSERT INTO `productspecs` VALUES (771, 115, 'Kích thước', '160 x 68 x 76.9 mm');
INSERT INTO `productspecs` VALUES (772, 115, 'Công nghệ âm thanh	\n', 'Marshall\nCông nghệ True Stereophonic');
INSERT INTO `productspecs` VALUES (773, 115, 'Công suất	\n', '2 x 38W');
INSERT INTO `productspecs` VALUES (774, 115, 'Thời lượng pin	\n', '32 giờ');
INSERT INTO `productspecs` VALUES (775, 115, 'Tính năng khác', 'Sạc nhanh');
INSERT INTO `productspecs` VALUES (776, 115, 'Cấu tạo', 'Hai bộ tản nhiệt thụ động toàn dải 1” 10W');
INSERT INTO `productspecs` VALUES (777, 115, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (778, 115, 'Hãng sản xuất	\n', 'Marshall');
INSERT INTO `productspecs` VALUES (779, 116, 'Trọng lượng', '1.38kg');
INSERT INTO `productspecs` VALUES (780, 116, 'Kích thước', '180 x 161 x 70 mm');
INSERT INTO `productspecs` VALUES (781, 116, 'Công nghệ âm thanh	\n', 'Âm thanh đa hướng\nÂm thanh nổi');
INSERT INTO `productspecs` VALUES (782, 116, 'Công suất	\n', '20 W');
INSERT INTO `productspecs` VALUES (783, 116, 'Thời lượng pin	\n', '20 giờ');
INSERT INTO `productspecs` VALUES (784, 116, 'Tính năng khác', 'Sạc nhanh\nĐèn báo tín hiệu pin');
INSERT INTO `productspecs` VALUES (785, 116, 'Cấu tạo', '1 loa');
INSERT INTO `productspecs` VALUES (786, 116, 'Chống nước	\n', 'IPX4');
INSERT INTO `productspecs` VALUES (787, 116, 'Hãng sản xuất	\n', 'Marshall');
INSERT INTO `productspecs` VALUES (788, 118, 'Trọng lượng', '2.5 kg');
INSERT INTO `productspecs` VALUES (789, 118, 'Kích thước', '243 x 162 x 140 mm');
INSERT INTO `productspecs` VALUES (790, 118, 'Công nghệ âm thanh	\n', 'Âm thanh nổi\nHi-Res Audio');
INSERT INTO `productspecs` VALUES (791, 118, 'Công suất	\n', '36 W');
INSERT INTO `productspecs` VALUES (792, 118, 'Thời lượng pin	\n', '20 giờ');
INSERT INTO `productspecs` VALUES (793, 118, 'Tính năng khác', 'Sạc nhanh\nĐèn LED báo tín hiệu pin');
INSERT INTO `productspecs` VALUES (794, 118, 'Cấu tạo', 'hệ thống loa 2 kênh stereo ');
INSERT INTO `productspecs` VALUES (795, 118, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (796, 118, 'Hãng sản xuất	\n', 'Marshall');
INSERT INTO `productspecs` VALUES (797, 119, 'Trọng lượng', '2.8 kg');
INSERT INTO `productspecs` VALUES (798, 119, 'Kích thước', '273 × 150 × 169 mm');
INSERT INTO `productspecs` VALUES (799, 119, 'Công nghệ âm thanh	\n', 'Âm thanh 360°\nDynamic loudness');
INSERT INTO `productspecs` VALUES (800, 119, 'Công suất	\n', '50 W');
INSERT INTO `productspecs` VALUES (801, 119, 'Thời lượng pin	\n', '50 giờ');
INSERT INTO `productspecs` VALUES (802, 119, 'Tính năng khác', 'Tích hợp pin sạc dự phòng');
INSERT INTO `productspecs` VALUES (803, 119, 'Cấu tạo', 'Loa trầm (x1): 4 inch\nLoa toàn dải (x2): 2 inch');
INSERT INTO `productspecs` VALUES (804, 119, 'Chống nước	\n', 'IP54');
INSERT INTO `productspecs` VALUES (805, 119, 'Hãng sản xuất	\n', 'Marshall');
INSERT INTO `productspecs` VALUES (806, 120, 'Trọng lượng', '7.62 kg');
INSERT INTO `productspecs` VALUES (807, 120, 'Kích thước', '282 x 282 x 302.5 mm');
INSERT INTO `productspecs` VALUES (808, 120, 'Công nghệ âm thanh	\n', 'Âm thanh 360°\nÂm thanh nổi');
INSERT INTO `productspecs` VALUES (809, 120, 'Công suất	\n', '236 W');
INSERT INTO `productspecs` VALUES (810, 120, 'Thời lượng pin	\n', '25 giờ');
INSERT INTO `productspecs` VALUES (811, 120, 'Tính năng khác', 'Sạc nhanh\nĐèn báo tín hiệu pin');
INSERT INTO `productspecs` VALUES (812, 120, 'Cấu tạo', '2 củ Bass 13.33 cm');
INSERT INTO `productspecs` VALUES (813, 120, 'Chống nước	\n', 'IP67');
INSERT INTO `productspecs` VALUES (814, 120, 'Hãng sản xuất	\n', 'Marshall');
INSERT INTO `productspecs` VALUES (815, 121, 'Trọng lượng', '4.9 kg');
INSERT INTO `productspecs` VALUES (816, 121, 'Kích thước', '229 x 163 x 350 mm');
INSERT INTO `productspecs` VALUES (817, 121, 'Công nghệ âm thanh	\n', 'Âm thanh nổi\nHi-Res Audio');
INSERT INTO `productspecs` VALUES (818, 121, 'Công suất	\n', '80 W');
INSERT INTO `productspecs` VALUES (819, 121, 'Thời lượng pin	\n', '20 giờ');
INSERT INTO `productspecs` VALUES (820, 121, 'Tính năng khác', 'Sạc nhanh\nĐèn báo tín hiệu pin');
INSERT INTO `productspecs` VALUES (821, 121, 'Cấu tạo', 'Thiết kế theo những chiêc Amply cổ điển của hãng');
INSERT INTO `productspecs` VALUES (822, 121, 'Chống nước	\n', 'IPX2');
INSERT INTO `productspecs` VALUES (823, 121, 'Hãng sản xuất	\n', 'Marshall');
INSERT INTO `productspecs` VALUES (824, 69, 'Trọng lượng', 'Tai nghe: 10 g\nHộp sạc: 67.30 g');
INSERT INTO `productspecs` VALUES (825, 69, 'Công nghệ âm thanh', 'Công nghệ âm thanh mở JBL OpenSound');
INSERT INTO `productspecs` VALUES (826, 69, 'Micro', 'Có');
INSERT INTO `productspecs` VALUES (827, 69, 'Thời lượng sử dụng Pin', 'Tai nghe: 8 giờ\nHộp sạc: 24 giờ');
INSERT INTO `productspecs` VALUES (828, 69, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (829, 69, 'Tính năng khác', 'Kết nối đa điểm');
INSERT INTO `productspecs` VALUES (830, 69, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (831, 68, 'Trọng lượng', 'Tai nghe: 4.8g\nHộp sạc: 48.4g');
INSERT INTO `productspecs` VALUES (832, 68, 'Công nghệ âm thanh', 'JBL Signature sound\nChống ồn chủ động');
INSERT INTO `productspecs` VALUES (833, 68, 'Micro', 'Có\n6 micro');
INSERT INTO `productspecs` VALUES (834, 68, 'Thời lượng sử dụng Pin', 'Tai nghe: Dùng 10 giờ\nHộp sạc: Dùng 30 giờ');
INSERT INTO `productspecs` VALUES (835, 68, 'Phương thức điều khiển', 'Cảm ứng');
INSERT INTO `productspecs` VALUES (836, 68, 'Tính năng khác', 'Kháng nước IPX5');
INSERT INTO `productspecs` VALUES (837, 68, 'Hãng sản xuất', 'JBL');
INSERT INTO `productspecs` VALUES (838, 67, 'Kích thước', 'Tai nghe: 18.1 x 19.8 x 33.2mm\nHộp sạc:58.9 x 48.7 x 24.4mm');
INSERT INTO `productspecs` VALUES (839, 67, 'Trọng lượng', 'Tai nghe: 5.4g\nHộp sạc: 46.5g');
INSERT INTO `productspecs` VALUES (840, 67, 'Công nghệ âm thanh', 'Chống ồn chủ động ANC\nÂm thanh Hi-Fi 24 bit\nÂm thanh vòm 360\nÂm thanh xung quanh\nHệ thống âm thanh kép\nHệ thống loa 2 chiều');
INSERT INTO `productspecs` VALUES (841, 67, 'Micro', 'Có\n6 micro');
INSERT INTO `productspecs` VALUES (842, 67, 'Thời lượng sử dụng Pin', 'Tai nghe: 7 giờ (Tắt ANC) / 6 giờ (Bật ANC)\nHộp sạc: 30 giờ (Tắt ANC) / 26 giờ (Bật ANC)');
INSERT INTO `productspecs` VALUES (843, 67, 'Phương thức điều khiển', 'Cảm ứng chạm\nNhấn thanh bar');
INSERT INTO `productspecs` VALUES (844, 67, 'Tính năng khác', 'Tự động chuyển đổi kết nối giữa các thiết bị Galaxy\nPhiên dịch viên hỗ trợ nghe bản dịch trực tiếp\nTự động tinh chỉnh ANC\nThanh ánh sáng Blade Lights');
INSERT INTO `productspecs` VALUES (845, 67, 'Hãng sản xuất', 'Samsung Chính hãng');
INSERT INTO `productspecs` VALUES (846, 66, 'Kích thước', 'Tai nghe: 18.1 x 20.4 x 31.9mm\nHộp sạc: 58.9 x 48.7 x 24.4mm');
INSERT INTO `productspecs` VALUES (847, 66, 'Trọng lượng', 'Tai nghe: 4.7g\nHộp sạc: 46.5g');
INSERT INTO `productspecs` VALUES (848, 66, 'Công nghệ âm thanh', 'Chống ồn chủ động ANC\nÂm thanh Hi-Fi 24 bit\nÂm thanh vòm 360');
INSERT INTO `productspecs` VALUES (849, 66, 'Micro', 'Có\n6 micro');
INSERT INTO `productspecs` VALUES (850, 66, 'Thời lượng sử dụng Pin', 'Tai nghe:6 giờ (Tắt ANC) / 5 giờ (Bật ANC)\nHộp sạc: 30 giờ (Tắt ANC) / 24 giờ (Bật ANC)');
INSERT INTO `productspecs` VALUES (851, 66, 'Phương thức điều khiển', 'Cảm ứng chạm\nNhấn thanh bar');
INSERT INTO `productspecs` VALUES (852, 66, 'Tính năng khác', 'Tự động chuyển đổi kết nối giữa các thiết bị Galaxy\nPhiên dịch viên hỗ trợ nghe bản dịch trực tiếp\nKháng bụi và nước IP57');
INSERT INTO `productspecs` VALUES (853, 66, 'Hãng sản xuất', 'Samsung Chính hãng');
INSERT INTO `productspecs` VALUES (854, 65, 'Kích thước', 'Tai nghe: 19.2 x 17.1 x 22.2 mm\nHộp sạc: 50.0 x 50.0 x 27.7 mm');
INSERT INTO `productspecs` VALUES (855, 65, 'Trọng lượng', 'Tai nghe: 5.3 g\nHộp sạc: 31.2 g');
INSERT INTO `productspecs` VALUES (856, 65, 'Công nghệ âm thanh', 'Active Noise Cancelling\nCông nghệ ENC\nAmbient Sound');
INSERT INTO `productspecs` VALUES (857, 65, 'Micro', '3 micro (mỗi tai)');
INSERT INTO `productspecs` VALUES (858, 65, 'Cổng kết nối', 'Type C');
INSERT INTO `productspecs` VALUES (859, 65, 'Thời lượng sử dụng Pin', 'Tai nghe: 8.5 giờ (khi tắt ANC)\nHộp sạc: 35 giờ');
INSERT INTO `productspecs` VALUES (860, 65, 'Phương thức điều khiển', 'Cảm ứng chạm');
INSERT INTO `productspecs` VALUES (861, 65, 'Tính năng khác', 'Kháng nước IP54\n3 Micro chống ồn\nTự động chuyển đổi kết nối linh hoạt (Auto Switch)\nTrợ lý ảo Bixby\nCông nghệ tự điều chỉnh theo hướng giọng nói (Beamforming)\nChế độ thất lạc (Lost Mode)\nChống ồn chủ động ANC');
INSERT INTO `productspecs` VALUES (862, 65, 'Hãng sản xuất', 'Samsung Chính hãng');
INSERT INTO `productspecs` VALUES (863, 64, 'Kích thước', 'Tai nghe: 19.2 x 17.1 x 22.2 mm\nHộp sạc: 50.0 x 50.0 x 27.7 mm');
INSERT INTO `productspecs` VALUES (864, 64, 'Trọng lượng', 'Tai nghe: 5.6g\nHộp sạc: 40g');
INSERT INTO `productspecs` VALUES (865, 64, 'Công nghệ âm thanh', 'Chống ồn chủ động ANC');
INSERT INTO `productspecs` VALUES (866, 64, 'Micro', 'Có\n6 micro');
INSERT INTO `productspecs` VALUES (867, 64, 'Thời lượng sử dụng Pin', 'Tai nghe + Hộp sạc: 30 giờ');
INSERT INTO `productspecs` VALUES (868, 64, 'Tính năng khác', 'Tự điều chỉnh theo hướng giọng nói (Beamforming)');
INSERT INTO `productspecs` VALUES (869, 64, 'Hãng sản xuất', 'Samsung Chính hãng');

-- ----------------------------
-- Table structure for productvariants
-- ----------------------------
DROP TABLE IF EXISTS `productvariants`;
CREATE TABLE `productvariants`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `products_id` int NOT NULL,
  `variant_sku` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `color_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `main_image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `market_price` decimal(10, 2) NOT NULL,
  `sell_price` decimal(10, 2) NOT NULL,
  `stock_quantity` int NULL DEFAULT 0,
  `sold_quantity` int NULL DEFAULT 0,
  `is_default` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `variant_sku`(`variant_sku` ASC) USING BTREE,
  INDEX `products_id`(`products_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 362 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of productvariants
-- ----------------------------
INSERT INTO `productvariants` VALUES (2, 1, 'SN-XM5-SLV', 'Bạc', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-1000xm5-2-removebg-preview_1.png', 8500000.00, 8000000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (3, 1, 'SN-XM5-PNK', 'Hồng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-1000xm5-hong-khoi.jpg', 8500000.00, 5790000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (4, 2, 'JBL-F6-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/j/b/jbl_flip_6_9.png', 3000000.00, 2500000.00, 100, 0, 0);
INSERT INTO `productvariants` VALUES (5, 2, 'JBL-F6-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/j/b/jbl_flip_6_8.png', 3000000.00, 2500000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (6, 2, 'JBL-F6-PNK', 'hồng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/j/b/jbl_flip_6_7.png', 3000000.00, 2500000.00, 20, 0, 1);
INSERT INTO `productvariants` VALUES (7, 2, 'JBL-F6-RED', 'đỏ', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/j/b/jbl_flip_6_5.png', 3000000.00, 2500000.00, 32, 0, 0);
INSERT INTO `productvariants` VALUES (8, 2, 'JBL-F6-BLU', 'xanh dương', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/j/b/jbl_flip_6_6.png', 3000000.00, 2500000.00, 41, 0, 0);
INSERT INTO `productvariants` VALUES (9, 3, 'RZO-PANC-PNK', 'hồng', 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/344793/tai-nghe-bluetooth-true-wireless-rezo-wave-pro-anc-hong-3-638974184003070569-750x500.jpg', 590000.00, 590000.00, 12, 0, 0);
INSERT INTO `productvariants` VALUES (10, 3, 'RZO-PANC-VAR', 'be', 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/344793/tai-nghe-bluetooth-true-wireless-rezo-wave-pro-anc-be-1-638974184671372423-750x500.jpg', 590000.00, 590000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (11, 3, 'RZO-PANC-BLU', 'xanh dương', 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/344793/tai-nghe-bluetooth-true-wireless-rezo-wave-pro-anc-xanh-duong-2-638974188630567986-750x500.jpg', 590000.00, 590000.00, 2, 0, 0);
INSERT INTO `productvariants` VALUES (12, 4, 'RZO-K50-BLK', 'đen', 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/329299/tai-nghe-bluetooth-true-wireless-rezo-k50-den-2-638627076799209187-750x500.jpg', 550000.00, 470000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (13, 5, 'RZO-RZ09-WHT', 'trắng', 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330249/tai-nghe-bluetooth-true-wireless-rezo-rz09-anc-trang-1-638635681929043024-750x500.jpg', 690000.00, 570000.00, 30, 0, 0);
INSERT INTO `productvariants` VALUES (14, 5, 'RZO-RZ09-BLK', 'đen', 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330249/tai-nghe-bluetooth-true-wireless-rezo-rz09-anc-den-2-638635680823309047-750x500.jpg', 690000.00, 560000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (15, 6, 'RZO-AIR5-WHT', 'trắng', 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330711/tai-nghe-bluetooth-true-wireless-rezo-air-5-deluxe-anc-trang-3-638642418928950008-750x500.jpg', 890000.00, 710000.00, 2, 0, 0);
INSERT INTO `productvariants` VALUES (16, 7, 'BU-E2F-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-2i-fit_1_.png', 690000.00, 560000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (17, 7, 'BU-E2F-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/m/image_1042_2.png', 690000.00, 560000.00, 19, 0, 0);
INSERT INTO `productvariants` VALUES (18, 8, 'BU-ES2-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-sport-2-open-ear_8_.jpg', 1190000.00, 990000.00, 2, 0, 0);
INSERT INTO `productvariants` VALUES (19, 8, 'BU-ES2-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-the-thao-baseus-eli-sport-2-open-ear_1_.png', 1190000.00, 1190000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (20, 9, 'BU-BE17-BLK', 'Đen', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769425842/rjzxckrk20s09n0tibop.png', 700000.00, 290000.00, 11, 0, 0);
INSERT INTO `productvariants` VALUES (21, 9, 'BU-BE17-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e17_7_.png', 290000.00, 290000.00, 21, 0, 0);
INSERT INTO `productvariants` VALUES (22, 10, 'BU-BE11-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e11_5_.png', 419000.00, 260000.00, 50, 0, 0);
INSERT INTO `productvariants` VALUES (23, 10, 'BU-BE11-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e11_2_.png', 419000.00, 250000.00, 30, 0, 0);
INSERT INTO `productvariants` VALUES (24, 10, 'BU-BE11-PNK', 'hồng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e11_4_.png', 419000.00, 270000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (25, 11, 'BU-D02P-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-encok-d02-pro_15_.png', 510000.00, 390000.00, 22, 0, 0);
INSERT INTO `productvariants` VALUES (26, 11, 'BU-D02P-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-encok-d02-pro_18_.png', 510000.00, 390000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (27, 12, 'BU-B35M-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bass-35-max_3_.png', 990000.00, 550000.00, 21, 0, 0);
INSERT INTO `productvariants` VALUES (28, 12, 'BU-B35M-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bass-35-max_4_.png', 990000.00, 550000.00, 19, 0, 0);
INSERT INTO `productvariants` VALUES (29, 13, 'BU- BBH1-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-bluetooth-baseus-bass-bh1_8_.jpg', 890000.00, 690000.00, 29, 0, 0);
INSERT INTO `productvariants` VALUES (30, 13, 'BU- BBH1-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-bluetooth-baseus-bass-bh1_5_.jpg', 890000.00, 690000.00, 35, 0, 0);
INSERT INTO `productvariants` VALUES (31, 14, 'BU-WM02-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-wm02_1__1.png', 560000.00, 350000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (32, 14, 'BU-WM02-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-wm02_2__1.png', 560000.00, 350000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (33, 14, 'BU-WM02-BLU', 'XANH dương', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-wm02_3__1.png', 560000.00, 350000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (34, 15, 'BU-E16-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e16_3_.png', 490000.00, 320000.00, 50, 0, 0);
INSERT INTO `productvariants` VALUES (35, 15, 'BU-E16-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-baseus-bowie-e16_2_.png', 490000.00, 320000.00, 30, 0, 0);
INSERT INTO `productvariants` VALUES (36, 16, 'BU-M2SU-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-baseus-bowie-m2s-ultra_2_.png', 2390000.00, 1690000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (37, 16, 'BU-M2SU-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-baseus-bowie-m2s-ultra_9_.png', 2390000.00, 1690000.00, 12, 0, 0);
INSERT INTO `productvariants` VALUES (38, 17, 'BU-BH1I-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bowie-h1i_2__1.png', 1190000.00, 710000.00, 50, 0, 0);
INSERT INTO `productvariants` VALUES (39, 17, 'BU-BH1I-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-baseus-bowie-h1i_3__1.png', 1190000.00, 710000.00, 50, 0, 0);
INSERT INTO `productvariants` VALUES (40, 18, 'BU-GP1M-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/_/3_629_4.png', 890000.00, 710000.00, 12, 0, 1);
INSERT INTO `productvariants` VALUES (41, 19, 'LG-FP5-BLK', 'đen', 'https://www.lg.com/content/dam/channel/wcms/vn/images/tai-nghe-khong-day/tone-fp5_cvnmllk_eavh_vn_c/gallery/DZ-01.jpg?w=800', 1980000.00, 990000.00, 5, 0, 0);
INSERT INTO `productvariants` VALUES (42, 21, 'LG-FN6-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/6/1600_6_1.jpg', 3490000.00, 3490000.00, 25, 0, 0);
INSERT INTO `productvariants` VALUES (43, 21, 'LG-FN6-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/2/0/2087224-removebg-preview.png', 3490000.00, 3490000.00, 25, 0, 0);
INSERT INTO `productvariants` VALUES (44, 20, 'LG-FP9-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/_/0/_0001_dz-13_1.jpg', 3220000.00, 1790000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (45, 20, 'LG-FP9-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-lg-tone-free-fp9.jpg', 3220000.00, 1990000.00, 30, 0, 0);
INSERT INTO `productvariants` VALUES (46, 22, 'LG-FP8-BLK', 'đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/_/0/_0004_dz-06_1.jpg', 2320000.00, 1290000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (47, 22, 'LG-FP8-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-lg-tone-free-fp8-3_2.jpg', 2320000.00, 1290000.00, 11, 0, 0);
INSERT INTO `productvariants` VALUES (48, 23, 'HV-931-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-havit-tw-931-den.png', 390000.00, 219000.00, 22, 0, 0);
INSERT INTO `productvariants` VALUES (49, 23, 'HV-931-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-havit-tw-931_1_.png', 390000.00, 219000.00, 21, 0, 0);
INSERT INTO `productvariants` VALUES (50, 23, 'HV-931-BLU', 'XANH dương', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-khong-day-havit-tw-931_2_.png', 390000.00, 219000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (51, 24, 'HV-H360-BLK', 'đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/5/_/5_179.jpg', 470000.00, 390000.00, 30, 0, 0);
INSERT INTO `productvariants` VALUES (52, 24, 'HV-H360-WHT', 'trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/e/beigi.png', 470000.00, 390000.00, 30, 0, 0);
INSERT INTO `productvariants` VALUES (53, 24, 'HV-H360-VAR', 'be', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/u/butter.png', 470000.00, 390000.00, 30, 0, 0);
INSERT INTO `productvariants` VALUES (54, 83, 'JBL-PS320-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/j/b/jbl-partybox-stage-320.jpg', 15610000.00, 14900000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (55, 83, 'JBL-PS320-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-partybox-stage-320_1__1.png', 15610000.00, 14900000.00, 15, 0, 0);
INSERT INTO `productvariants` VALUES (56, 84, 'JBL-P310-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_partybox_310_1.png', 14900000.00, 10990000.00, 2, 0, 0);
INSERT INTO `productvariants` VALUES (57, 85, 'JBL-B4-WHT', 'Trấng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/b/bb6_1.png?_gl=1*co4z0n*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4Mzc5MTUkajMkbDAkaDI5MDAxNDM1Mg..', 13900000.00, 13900000.00, 5, 0, 0);
INSERT INTO `productvariants` VALUES (58, 85, 'JBL-B4-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-boombox-4_14__1.png?_gl=1*1e1t748*_gcl_au*NTM3NzU4NzMzLjE3NjIwMDc4NTE.*_ga*OTk1Nzk1MTcyLjE3NjIwMDc4NTI.*_ga_QLK8WFHNK9*czE3NjQ4MzUxMDEkbzMkZzEkdDE3NjQ4Mzc5MTUkajMkbDAkaDI5MDAx', 13900000.00, 13900000.00, 3, 0, 0);
INSERT INTO `productvariants` VALUES (59, 86, 'JBL-A500-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-authentics-500_9_.png', 16900000.00, 13490000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (60, 87, 'JBL-PEE2-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/e/_/e_4.png', 9900000.00, 9900000.00, 7, 0, 0);
INSERT INTO `productvariants` VALUES (61, 88, 'JBL-PEE-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/3/_/3_121_1.png', 5490000.00, 5490000.00, 4, 0, 0);
INSERT INTO `productvariants` VALUES (62, 89, 'JBL-H-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/f/r/frame_11.png', 2490000.00, 1350000.00, 2, 0, 0);
INSERT INTO `productvariants` VALUES (63, 89, 'JBL-H-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-jbl-horizon-01.png', 2490000.00, 1350000.00, 5, 0, 0);
INSERT INTO `productvariants` VALUES (64, 90, 'JBL-H2-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_horizon2_front_black_v2_0254_x5.jpg', 2990000.00, 2690000.00, 12, 0, 0);
INSERT INTO `productvariants` VALUES (65, 90, 'JBL-H2-GRY', 'Xám', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-2-4_1.jpg', 2990000.00, 2990000.00, 18, 0, 0);
INSERT INTO `productvariants` VALUES (66, 91, 'JBL-H3-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-xam_10_.png', 4990000.00, 3490000.00, 1, 0, 0);
INSERT INTO `productvariants` VALUES (67, 91, 'JBL-H3-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-horizon-3-den_3__1.png', 4990000.00, 3490000.00, 4, 0, 0);
INSERT INTO `productvariants` VALUES (68, 92, 'JBL-F7-BLK', 'Đen ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-flip-7_23__1.png', 3520000.00, 3520000.00, 15, 0, 0);
INSERT INTO `productvariants` VALUES (69, 92, 'JBL-F7-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-flip-7_11__1.png', 3520000.00, 3520000.00, 23, 0, 0);
INSERT INTO `productvariants` VALUES (70, 92, 'JBL-F7-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-flip-7_47__1.png', 3520000.00, 3520000.00, 8, 0, 0);
INSERT INTO `productvariants` VALUES (71, 93, 'JBL-GE-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/_/2_jbl_go_essential_front_black_31581_x1.png', 790000.00, 690000.00, 2, 0, 0);
INSERT INTO `productvariants` VALUES (72, 94, 'JBL-GE2-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-essential-2_10_.png', 970000.00, 890000.00, 12, 0, 0);
INSERT INTO `productvariants` VALUES (73, 95, 'JBL-G3-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_go_3_11.png', 1090000.00, 790000.00, 2, 0, 0);
INSERT INTO `productvariants` VALUES (74, 95, 'JBL-G3-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_go_3_14.png', 1090000.00, 790000.00, 17, 0, 0);
INSERT INTO `productvariants` VALUES (75, 96, 'JBL-G4-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-jbl-go-4_5_.png', 1070000.00, 1070000.00, 180, 0, 0);
INSERT INTO `productvariants` VALUES (76, 96, 'JBL-G4-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-go-4_2__1.png', 1070000.00, 1070000.00, 50, 0, 0);
INSERT INTO `productvariants` VALUES (77, 96, 'JBL-G4-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-go-4_1__1.png?_gl=1*1js7q1b*_gcl_au*MTI1ODQyODgyMC4xNzY0MDU3NTM3*_ga*MjI3MzQzMjQ0LjE3NjQwNTc1Mzc.*_ga_QLK8WFHNK9*czE3NjQ5NDQzNjckbzMkZzEkdDE3NjQ5NDg2MTkkajYwJGwwJGgxMDIzNjcyMD', 1070000.00, 1070000.00, 60, 0, 0);
INSERT INTO `productvariants` VALUES (78, 97, 'JBL-C3-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/1/_/1_17_25_2.jpg', 1480000.00, 1480000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (79, 97, 'JBL-C3-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/5/_/5_7_2_2.jpg', 1480000.00, 1480000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (80, 98, 'JBL-C4-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-clip-4-den_1.jpg', 1590000.00, 1590000.00, 82, 0, 0);
INSERT INTO `productvariants` VALUES (81, 98, 'JBL-C4-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/1/1/11259_loa_jbl_clip_4_white_chinh_hang_5.jpg', 1590000.00, 1590000.00, 50, 0, 0);
INSERT INTO `productvariants` VALUES (82, 98, 'JBL-C4-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-clip-4-xanh-duong_1.jpg', 1590000.00, 1590000.00, 17, 0, 0);
INSERT INTO `productvariants` VALUES (83, 99, 'JBL-C5-BLK', 'Đen cam', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/c/l/clip-5-xanh-cam.jpg', 1490000.00, 1490000.00, 58, 0, 0);
INSERT INTO `productvariants` VALUES (84, 99, 'JBL-C5-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-clip-5_1_2.png', 1490000.00, 1490000.00, 22, 0, 0);
INSERT INTO `productvariants` VALUES (85, 100, 'JBL-Ch4-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/j/b/jbl_charge4_front_midnight_black_1605x1605px_1.jpg', 3490000.00, 2490000.00, 52, 0, 0);
INSERT INTO `productvariants` VALUES (86, 100, 'JBL-Ch4-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/j/b/jbl_charge4_front_oceanblue-1605x1605px_1.jpg', 3490000.00, 2490000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (87, 101, 'JBL-Ch5-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-jbl-charge-5-den-black-4_1.jpg', 3990000.00, 3490000.00, 70, 0, 0);
INSERT INTO `productvariants` VALUES (88, 101, 'JBL-Ch5-GRY', 'Xám', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-jbl-charge-5-xam-grey-4_1_1.jpg', 3990000.00, 3490000.00, 87, 0, 0);
INSERT INTO `productvariants` VALUES (89, 101, 'JBL-Ch5-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-jbl-charge-5-xanh-duong-blue-4_3.jpg', 3990000.00, 3490000.00, 33, 0, 0);
INSERT INTO `productvariants` VALUES (90, 102, 'JBL-Ch6-BLK', 'Đen cam', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/l/bluetooth-jbl-charge-6-den-cam.png', 4505000.00, 4500000.00, 43, 0, 0);
INSERT INTO `productvariants` VALUES (91, 102, 'JBL-Ch6-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-charge-6_2__1.png', 4505000.00, 4500000.00, 32, 0, 0);
INSERT INTO `productvariants` VALUES (92, 102, 'JBL-Ch6-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-charge-6_27__1.png', 4505000.00, 4500000.00, 92, 0, 0);
INSERT INTO `productvariants` VALUES (93, 103, 'JBL-P4-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/j/b/jbl_pulse_4_4.png', 4990000.00, 4990000.00, 94, 0, 0);
INSERT INTO `productvariants` VALUES (94, 103, 'JBL-P4-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/_/p/_pulse4_front_view_mid.jpg', 4990000.00, 4990000.00, 79, 0, 0);
INSERT INTO `productvariants` VALUES (95, 104, 'JBL-P5-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/_/1_jbl_pulse_5_hero_34364_x2_1.png', 6690000.00, 6350000.00, 85, 0, 0);
INSERT INTO `productvariants` VALUES (96, 105, 'JBL-X3-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/_/t_i_xu_ng_82__4_3.png', 6590000.00, 5090000.00, 34, 0, 0);
INSERT INTO `productvariants` VALUES (97, 105, 'JBL-X3-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/_/t_i_xu_ng_61__7.png', 6590000.00, 5090000.00, 78, 0, 0);
INSERT INTO `productvariants` VALUES (98, 106, 'JBL-X4-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/o/a/oa-bluetooth-jbl-xtreme-4-den.jpg', 7840000.00, 7790000.00, 48, 0, 0);
INSERT INTO `productvariants` VALUES (99, 106, 'JBL-X4-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-jbl-xtreme-4_13__1.png', 7840000.00, 7790000.00, 78, 0, 0);
INSERT INTO `productvariants` VALUES (100, 107, 'JBL-B2-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-di-dong-jbl-boombox-2-3.jpg', 9690000.00, 9690000.00, 56, 0, 0);
INSERT INTO `productvariants` VALUES (101, 107, 'JBL-B2-RED', 'Quân đội', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/j/b/jbl_boombox_2_front_camo_13043_x1-1024x1024.png', 9690000.00, 9690000.00, 8, 0, 0);
INSERT INTO `productvariants` VALUES (102, 108, 'JBL-B3-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/u/n/untitled-1_copy_17_2.jpg', 11770000.00, 10490000.00, 48, 0, 0);
INSERT INTO `productvariants` VALUES (103, 85, 'JBL-B4-RED', 'Quân đội', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/j/b/jbl_boombox3_front_camo.png', 11770000.00, 10490000.00, 96, 0, 0);
INSERT INTO `productvariants` VALUES (104, 109, 'JBL-P710-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/3/23_2_10.jpg', 21500000.00, 18990000.00, 78, 0, 0);
INSERT INTO `productvariants` VALUES (105, 111, 'JBL-A300-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-jbl-authentics-300_10__1.png', 11900000.00, 9990000.00, 88, 0, 0);
INSERT INTO `productvariants` VALUES (106, 26, 'HV-TW888-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-havit-life-04t-tw888-_4_.png', 280000.00, 280000.00, 42, 0, 0);
INSERT INTO `productvariants` VALUES (107, 26, 'HV-TW888-BLK', 'Đen ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-havit-life-04t-tw888_2__1.png', 280000.00, 280000.00, 44, 0, 0);
INSERT INTO `productvariants` VALUES (108, 26, 'HV-TW888-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-havit-life-04t-tw888-.png', 280000.00, 280000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (109, 27, 'HV-H619-VAR', 'Be', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-havit-h619bt-_1__1.png', 390000.00, 240000.00, 42, 0, 0);
INSERT INTO `productvariants` VALUES (110, 27, 'HV-H619-BLK', 'đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-havit-h619bt-_2__1.png', 390000.00, 200000.00, 51, 0, 0);
INSERT INTO `productvariants` VALUES (111, 28, 'HV-H02E-BLK', 'Đen ', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-co-day-havit-h2002e_4_.png', 880000.00, 590000.00, 23, 0, 0);
INSERT INTO `productvariants` VALUES (112, 28, 'HV-H02E-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-co-day-havit-h2002e_12_.png', 880000.00, 590000.00, 25, 0, 0);
INSERT INTO `productvariants` VALUES (113, 29, 'SN-C510-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-sony-wf-c510_22_.png', 1690000.00, 1069000.00, 33, 0, 0);
INSERT INTO `productvariants` VALUES (114, 29, 'SN-C510-YEL', 'Vàng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-sony-wf-c510_25_.png', 1690000.00, 1069000.00, 12, 0, 0);
INSERT INTO `productvariants` VALUES (115, 29, 'SN-C510-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-bluetooth-sony-wf-c510_12_.png', 1690000.00, 1069000.00, 21, 0, 0);
INSERT INTO `productvariants` VALUES (116, 29, 'SN-C510-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-bluetooth-sony-wf-c510_19_.png', 1690000.00, 1069000.00, 12, 0, 0);
INSERT INTO `productvariants` VALUES (117, 30, 'SN-H3-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-gaming-sony-inzone-h3-0.png', 1550000.00, 1190000.00, 15, 0, 0);
INSERT INTO `productvariants` VALUES (118, 30, 'SN-H3-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-gaming-sony-inzone-h3-den_4__1.jpg', 1550000.00, 1190000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (119, 31, 'SN-CH720N-PNK', 'Hồng ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/w/h/wh-ch720_black01_m_1__1.png', 2990000.00, 1845000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (120, 31, 'SN-CH720N-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/w/h/wh-ch720_blue01_m_1__1.png', 2990000.00, 1845000.00, 22, 0, 0);
INSERT INTO `productvariants` VALUES (121, 31, 'SN-CH720N-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/w/h/wh-ch720_black01_m_1__1.png', 2990000.00, 1845000.00, 3, 0, 0);
INSERT INTO `productvariants` VALUES (122, 32, 'SN-C710N-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/o/sony-wf-c710n-11.jpg', 2490000.00, 1850000.00, 6, 0, 0);
INSERT INTO `productvariants` VALUES (123, 32, 'SN-C710N-PNK', 'Hồng ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/o/sony-wf-c710n-10.jpg', 2490000.00, 1850000.00, 23, 0, 0);
INSERT INTO `productvariants` VALUES (124, 32, 'SN-C710N-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-sony-wf-c710n-den_1.png', 2490000.00, 1850000.00, 22, 0, 0);
INSERT INTO `productvariants` VALUES (125, 32, 'SN-C710N-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-sony-wf-c710n_1.png', 2490000.00, 1850000.00, 3, 0, 0);
INSERT INTO `productvariants` VALUES (126, 33, 'SN-LBF-PNK', 'Hồng ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/n/sn1.png', 5390000.00, 3450000.00, 3, 0, 0);
INSERT INTO `productvariants` VALUES (127, 33, 'SN-LBF-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-sony-linkbuds-fit_9__1.jpg', 5390000.00, 3450000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (128, 33, 'SN-LBF-GRE', 'Xanh lá', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-sony-linkbuds-fit_10__1.jpg', 5390000.00, 3450000.00, 15, 0, 0);
INSERT INTO `productvariants` VALUES (129, 33, 'SN-LBF-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-sony-linkbuds-fit_11__1.jpg', 5390000.00, 3450000.00, 23, 0, 0);
INSERT INTO `productvariants` VALUES (130, 34, 'SN-INZ-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-sony-inzone-buds_1__1.png', 4790000.00, 3650000.00, 22, 0, 0);
INSERT INTO `productvariants` VALUES (131, 34, 'SN-INZ-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-khong-day-sony-inzone-buds_15_.png', 4790000.00, 3650000.00, 22, 0, 0);
INSERT INTO `productvariants` VALUES (132, 35, 'SN-INZ5-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-inzone-h5_9_.png', 3790000.00, 2540000.00, 12, 0, 0);
INSERT INTO `productvariants` VALUES (133, 35, 'SN-INZ5-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-inzone-h5_8_.png', 3790000.00, 2540000.00, 14, 0, 0);
INSERT INTO `productvariants` VALUES (134, 36, 'SN-WH900N-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-ult900n_13__1.png', 4490000.00, 3650000.00, 18, 0, 0);
INSERT INTO `productvariants` VALUES (135, 36, 'SN-WH900N-GRY', 'Xám', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-ult900n_18__1.png', 4490000.00, 3650000.00, 25, 0, 0);
INSERT INTO `productvariants` VALUES (136, 36, 'SN-WH900N-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-chup-tai-sony-wh-ult900n_22_.png', 4490000.00, 3650000.00, 14, 0, 0);
INSERT INTO `productvariants` VALUES (137, 37, 'SN-XM4-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/6/4/6428314_sd.jpg', 6690000.00, 4790000.00, 22, 0, 0);
INSERT INTO `productvariants` VALUES (138, 37, 'SN-XM4-SLV', 'Bạc', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/o/sony_wh1000xm4_s_wh_1000xm4_wireless_noise_canceling_over_ear_1582976_1.jpg', 6690000.00, 4790000.00, 15, 0, 0);
INSERT INTO `productvariants` VALUES (139, 37, 'SN-XM4-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/e/tempsnip.jpg', 6690000.00, 4790000.00, 37, 0, 0);
INSERT INTO `productvariants` VALUES (140, 38, 'SN-H9II-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-gaming-khong-day-sony-inzone-h9-ii_8__1.png', 0.00, 7590000.00, 2, 0, 0);
INSERT INTO `productvariants` VALUES (141, 38, 'SN-H9II-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/a/tai-nghe-gaming-khong-day-sony-inzone-h9-ii_7_.png', 0.00, 7590000.00, 2, 0, 1);
INSERT INTO `productvariants` VALUES (142, 39, 'AAP3-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods3_1_1.png', 4490000.00, 2590000.00, 2, 0, 0);
INSERT INTO `productvariants` VALUES (143, 40, 'AAP3-MS-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods3.png', 4790000.00, 2890000.00, 72, 0, 0);
INSERT INTO `productvariants` VALUES (144, 41, 'AAP4-ANC-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods-4-chong-on-2.png', 4990000.00, 4690000.00, 67, 0, 0);
INSERT INTO `productvariants` VALUES (145, 42, 'AAP4-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/i/airpods-4-chong-on-2.png', 4990000.00, 4690000.00, 26, 0, 0);
INSERT INTO `productvariants` VALUES (146, 43, 'APP2-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/m/image_2019-03-29_09-12-07_2.jpg', 3990000.00, 2290000.00, 42, 0, 0);
INSERT INTO `productvariants` VALUES (147, 44, 'APP2-PRO-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-pro-2-usb-c_8__1.png', 6190000.00, 5190000.00, 85, 0, 0);
INSERT INTO `productvariants` VALUES (148, 45, 'APP3-PRO-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/app3.png', 0.00, 6790000.00, 5, 0, 0);
INSERT INTO `productvariants` VALUES (149, 46, 'APP-MAX2024-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-max_5__1.png', 14990000.00, 13590000.00, 40, 0, 0);
INSERT INTO `productvariants` VALUES (150, 46, 'APP-MAX2024-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-max_2__1.png', 14990000.00, 13590000.00, 25, 0, 0);
INSERT INTO `productvariants` VALUES (151, 46, 'APP-MAX2024-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-max_4__1.png', 14990000.00, 13590000.00, 4, 0, 0);
INSERT INTO `productvariants` VALUES (152, 46, 'APP-MAX2024-PUR', 'Tím', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-max_1__1.png', 14990000.00, 13590000.00, 22, 0, 0);
INSERT INTO `productvariants` VALUES (153, 46, 'APP-MAX2024-ORG', 'Cam', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-max_3__1.png', 14990000.00, 13590000.00, 31, 0, 0);
INSERT INTO `productvariants` VALUES (154, 47, 'APP-MAX2021-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-max-2021_1__1.jpg', 13190000.00, 9490000.00, 24, 0, 0);
INSERT INTO `productvariants` VALUES (155, 47, 'APP-MAX2021-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-max-2021_2__1.png', 13190000.00, 9490000.00, 4, 0, 0);
INSERT INTO `productvariants` VALUES (156, 47, 'APP-MAX2021-GRE', 'Xanh lá', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-max-2021_3__1.jpg', 13190000.00, 9490000.00, 64, 0, 0);
INSERT INTO `productvariants` VALUES (157, 47, 'APP-MAX2021-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/f/r/frame_203.png', 13190000.00, 9490000.00, 27, 0, 0);
INSERT INTO `productvariants` VALUES (158, 47, 'APP-MAX2021-PNK', 'Hồng ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/p/apple-airpods-max-2021_9__1.jpg', 13190000.00, 9490000.00, 11, 0, 0);
INSERT INTO `productvariants` VALUES (159, 48, 'MS-MN4-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/g/r/group_1160_1.png', 3630000.00, 3430000.00, 58, 0, 0);
INSERT INTO `productvariants` VALUES (160, 48, 'MS-MN4-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-marshall-minor-4_1.png', 3630000.00, 3430000.00, 51, 0, 0);
INSERT INTO `productvariants` VALUES (161, 49, 'MS-MN3-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-marshall-minor-3-2_1.jpg', 3990000.00, 2250000.00, 11, 0, 0);
INSERT INTO `productvariants` VALUES (162, 50, 'MS-MJ5-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-06-17_14-31-24.jpg', 4220000.00, 3800000.00, 29, 0, 0);
INSERT INTO `productvariants` VALUES (163, 50, 'MS-MJ5-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/g/r/group_297_2_4.png', 4220000.00, 3800000.00, 70, 0, 0);
INSERT INTO `productvariants` VALUES (164, 50, 'MS-MJ5-BLU', 'Xanh Dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/major-5.png', 4220000.00, 3800000.00, 77, 0, 0);
INSERT INTO `productvariants` VALUES (165, 51, 'MS-MJ4-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-major-4_16_.png', 4290000.00, 3190000.00, 93, 0, 0);
INSERT INTO `productvariants` VALUES (166, 51, 'MS-MJ4-BRN', 'Nâu', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-marshall-major-4_17_.png', 4290000.00, 3190000.00, 96, 0, 0);
INSERT INTO `productvariants` VALUES (167, 52, 'MS-MT-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-marshall-motif-anc-5_1.jpg', 5990000.00, 4110000.00, 75, 0, 0);
INSERT INTO `productvariants` VALUES (168, 53, 'MS-MT2-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/e/text_ng_n_-_2023-05-29t223851.134.png', 5400000.00, 4860000.00, 57, 0, 0);
INSERT INTO `productvariants` VALUES (169, 54, 'MS-MN2ANC-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/h/mh-monitor-ii-anc-large-1_1__1.png', 7850000.00, 6550000.00, 34, 0, 0);
INSERT INTO `productvariants` VALUES (170, 55, 'MS-MN3ANC-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/o/monitor-iii-den.jpg', 0.00, 9810000.00, 85, 0, 0);
INSERT INTO `productvariants` VALUES (171, 56, 'XM-RB6A-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-xiaomi-redmi-buds-6-active_1__1.png', 590000.00, 580000.00, 56, 0, 0);
INSERT INTO `productvariants` VALUES (172, 56, 'XM-RB6A-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-xiaomi-redmi-buds-6-active_2__1.png', 590000.00, 580000.00, 36, 0, 0);
INSERT INTO `productvariants` VALUES (173, 56, 'XM-RB6A-BLU', 'Xanh Dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-08-15_13-34-34.jpg', 590000.00, 580000.00, 60, 0, 0);
INSERT INTO `productvariants` VALUES (174, 56, 'XM-RB6A-PNK', 'Hồng ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-08-15_13-34-29.jpg', 590000.00, 580000.00, 45, 0, 0);
INSERT INTO `productvariants` VALUES (175, 57, 'XM-RB6-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6_13__1.png', 1490000.00, 1390000.00, 77, 0, 0);
INSERT INTO `productvariants` VALUES (176, 57, 'XM-RB6-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6_4__1.png', 1490000.00, 1390000.00, 83, 0, 0);
INSERT INTO `productvariants` VALUES (177, 57, 'XM-RB6-GRE', 'Xanh lá', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi_1_.png', 1490000.00, 1390000.00, 16, 0, 0);
INSERT INTO `productvariants` VALUES (178, 58, 'XM-RB6PRO-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6-pro_17__1.png', 2490000.00, 1720000.00, 76, 0, 0);
INSERT INTO `productvariants` VALUES (179, 58, 'XM-RB6PRO-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi-buds-6-pro_5__1.png', 2490000.00, 1720000.00, 67, 0, 0);
INSERT INTO `productvariants` VALUES (180, 58, 'XM-RB6PRO-PUR', 'Tím', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-xiaomi-redmi_1.png', 2490000.00, 1720000.00, 96, 0, 0);
INSERT INTO `productvariants` VALUES (181, 59, 'XM-RB4LITE-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/_/t_i_xu_ng_22__4_5.png', 550000.00, 390000.00, 40, 0, 0);
INSERT INTO `productvariants` VALUES (182, 59, 'XM-RB4LITE-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/_/t_i_xu_ng_21__6_5.png', 550000.00, 390000.00, 14, 0, 0);
INSERT INTO `productvariants` VALUES (183, 59, 'XM-RB4LITE-ORG', 'Cam', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/_/t_i_xu_ng_20__4_5.png', 550000.00, 390000.00, 27, 0, 0);
INSERT INTO `productvariants` VALUES (184, 60, 'XM-OS-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/m/image_1323.png', 2990000.00, 2050000.00, 65, 0, 0);
INSERT INTO `productvariants` VALUES (185, 60, 'XM-OS-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/m/image_1322.png', 2990000.00, 2050000.00, 44, 0, 0);
INSERT INTO `productvariants` VALUES (186, 61, 'XM-OSPRO-YEL', 'Vàng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/f/r/frame_293_1.png', 4990000.00, 4690000.00, 41, 0, 0);
INSERT INTO `productvariants` VALUES (187, 61, 'XM-OSPRO-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/f/r/frame_296_1.png', 4990000.00, 4690000.00, 43, 0, 0);
INSERT INTO `productvariants` VALUES (188, 61, 'XM-OSPRO-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/f/r/frame_289_1_3.png', 4990000.00, 4690000.00, 50, 0, 0);
INSERT INTO `productvariants` VALUES (189, 62, 'XM-B5P-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/i/xiaomi-buds-5-pro.png', 5190000.00, 5090000.00, 14, 0, 0);
INSERT INTO `productvariants` VALUES (190, 62, 'XM-B5P-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/1/2/12_47_5.png', 5190000.00, 5090000.00, 19, 0, 0);
INSERT INTO `productvariants` VALUES (191, 63, 'XM-B5PWF-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/m/image_1262702217.png', 5880000.00, 5690000.00, 9, 0, 0);
INSERT INTO `productvariants` VALUES (192, 112, 'M-W-BLK', 'Đen vàng', 'https://tse1.mm.bing.net/th/id/OIP.PG7A8LgALRV5WcESw5_bTwHaHa?rs=1&pid=ImgDetMain&o=7&rm=3', 2790000.00, 2185000.00, 88, 0, 0);
INSERT INTO `productvariants` VALUES (193, 112, 'M-W-VAR', 'Kem', 'https://th.bing.com/th/id/OIP.Y98j4C8PLoK0SiIBHpC8SwHaHa?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3', 2790000.00, 2185000.00, 22, 0, 0);
INSERT INTO `productvariants` VALUES (194, 113, 'M-WII-BLK', 'Đen vàng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-marshall-willen-ii-den.jpg', 2990000.00, 2700000.00, 12, 0, 0);
INSERT INTO `productvariants` VALUES (195, 113, 'M-WII-VAR', 'Kem', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-marshall-willen-ii-vang.jpg', 2990000.00, 2700000.00, 14, 0, 0);
INSERT INTO `productvariants` VALUES (196, 114, 'M-EII-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-marshall-emberton-ii-xam_1.png', 4990000.00, 3280000.00, 18, 0, 0);
INSERT INTO `productvariants` VALUES (197, 114, 'M-EII-GRY', 'Xám', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/marshall_emberton_ii_2.png', 4990000.00, 3280000.00, 25, 0, 0);
INSERT INTO `productvariants` VALUES (198, 115, 'M-EIII-BLK', 'Đen vàng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/marshall_emberton-iii_black_prod.jpg', 5300000.00, 4520000.00, 14, 0, 0);
INSERT INTO `productvariants` VALUES (199, 115, 'M-EIII-VAR', 'Xanh bóng đêm', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/e/m/emiii.png', 5300000.00, 4520000.00, 22, 0, 0);
INSERT INTO `productvariants` VALUES (200, 115, 'M-EIII-YEL', 'Vàng kem', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/marshall_emberton-iii_cream_prod.jpg', 5300000.00, 4520000.00, 15, 0, 0);
INSERT INTO `productvariants` VALUES (201, 116, 'M-S2-BLK', 'Đen vang', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-marshall-stockwell-2.jpg', 6570000.00, 5920000.00, 2, 0, 0);
INSERT INTO `productvariants` VALUES (202, 118, 'M-KII-BLK', 'Đen vàng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/marshall-kilburn-ii-black-brass-01.png', 7060000.00, 7060000.00, 72, 0, 0);
INSERT INTO `productvariants` VALUES (203, 119, 'M-KIII-BLK', 'Đenn vàng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-marshall-kilburn-iii_14__1.png', 10490000.00, 10490000.00, 67, 0, 0);
INSERT INTO `productvariants` VALUES (204, 119, 'M-KIII-VAR', 'Kem', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/k/i/kilburn3-kem.png', 10490000.00, 10490000.00, 26, 0, 0);
INSERT INTO `productvariants` VALUES (205, 120, 'M-HS200-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-marshall-heston-sub-200_6__1.png', 13900000.00, 13900000.00, 42, 0, 0);
INSERT INTO `productvariants` VALUES (206, 121, 'M-T-BLK', 'Đen vàng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/marshall-tufton-black-brass-01.png', 12760000.00, 11490000.00, 5, 0, 0);
INSERT INTO `productvariants` VALUES (207, 81, 'JBL-TOM3-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tour-one-m3-0-_8_.png', 0.00, 9805000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (208, 80, 'JBL-TP3-VAR', 'Latte', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-3-latte.jpg?_gl=1*1i8i86w*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTU5Mzg5JGo1OCRsMC', 0.00, 5880000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (209, 80, 'JBL-TP3-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-3_6__1.png?_gl=1*1ameru3*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYwNDEwJGo2MCRsMCR', 0.00, 5880000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (210, 79, 'JBL-L770NC-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-07-29_15-35-34.jpg?_gl=1*1trszsf*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYxNDMxJGo2MCRsMCRoMTc5NTY3NDcy', 4490000.00, 4090000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (211, 79, 'JBL-L770NC-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-07-29_15-35-24.jpg?_gl=1*5ozmos*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYxNDMxJGo2MCRsMCRoMTc5NTY3NDcyM', 4490000.00, 4090000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (212, 78, 'JBL-TP2-YEL', 'Vàng ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tour-pro-2-vang_1.png?_gl=1*18p2p5h*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyMDE3JGo1MSRsM', 5990000.00, 3999000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (213, 78, 'JBL-TP2-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-08-01_11-15-31.jpg?_gl=1*augb7s*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyMjgxJGo2MCRsMCRoMTc5NTY3NDcyM', 5990000.00, 3999000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (214, 77, 'JBL-LB3-PUR', 'Tím ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-08-03_10-14-57.jpg?_gl=1*158376c*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjI0JGo0MiRsMCRoMTc5NTY3NDcy', 0.00, 3915000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (215, 77, 'JBL-LB3-SLV', 'Bạc', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-live-beam-3-_19__1.png?_gl=1*1gvuq91*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjMwJGozNiRs', 0.00, 3915000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (216, 77, 'JBL-LB3-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-08-03_10-15-05.jpg?_gl=1*67qh7v*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjM1JGozMSRsMCRoMTc5NTY3NDcyM', 0.00, 3915000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (217, 77, 'JBL-LB3-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/p/h/photo_2024-08-03_10-15-15.jpg?_gl=1*7ngoui*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYyNjQyJGoyNCRsMCRoMTc5NTY3NDcyM', 0.00, 3915000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (218, 76, 'JBL-L670NC-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-live-670nc_7_.png?_gl=1*uq2uqc*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzMzY1JGo2MCRsMCRoMTc', 2990000.00, 2690000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (219, 76, 'JBL-L670NC-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-live-670nc_6_.png?_gl=1*dflx5l*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzMzc3JGo0OCRsMCRoMTc', 2990000.00, 2690000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (220, 76, 'JBL-L670NC-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-live-670nc_1_.png?_gl=1*1j4edka*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzMzg3JGozOCRsMCRoMT', 2990000.00, 2690000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (221, 75, 'JBL-SL-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-the-thao-jbl-sence-lite_19__2.png?_gl=1*1ninkpl*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzAwJGo2MCRsMCR', 0.00, 2590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (222, 75, 'JBL-SL-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/e/a/ear-b_1.png?_gl=1*2qcj4e*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzE1JGo0NSRsMCRoMTc5NTY3NDcyMw..', 0.00, 2590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (223, 75, 'JBL-SL-VAR', 'Xanh ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/l/bl_1_3.png?_gl=1*c82np0*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzI5JGozMSRsMCRoMTc5NTY3NDcyMw..', 0.00, 2590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (224, 75, 'JBL-SL-PUR', 'Tím ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-the-thao-jbl-sence-lite_10__1_1.png?_gl=1*c82np0*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzNzI5JGozMSRsMC', 0.00, 2590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (225, 82, 'JBL-TB2-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/u/tune-bl.png?_gl=1*2txrjl*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTYzODU1JGo0NCRsMCRoMTc5NTY3NDcyMw..', 2690000.00, 2590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (226, 82, 'JBL-TB2-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/u/tune-w.png?_gl=1*15d6cct*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0MjEyJGo1NyRsMCRoMTc5NTY3NDcyMw..', 2690000.00, 2590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (227, 82, 'JBL-TB2-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/u/tune-b.png?_gl=1*15yviic*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0MjExJGo1OCRsMCRoMTc5NTY3NDcyMw..', 2690000.00, 2590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (228, 74, 'JBL-WB2-PNK', 'Hồng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/w/a/wave.png?_gl=1*1ezpwto*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NTQ2JGo1MyRsMCRoMTc5NTY3NDcyMw..', 1690000.00, 1590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (229, 74, 'JBL-WB2-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/u/buds2-black.png?_gl=1*1y1sw3l*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NjM4JGo2MCRsMCRoMTc5NTY3NDcyMw..', 1690000.00, 1590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (230, 74, 'JBL-WB2-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/u/buds2-white.png?_gl=1*crusmj*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NjUwJGo0OCRsMCRoMTc5NTY3NDcyMw..', 1690000.00, 1590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (231, 74, 'JBL-WB2-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/u/buds2-blue.png?_gl=1*1yko8xd*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY0NjU1JGo0MyRsMCRoMTc5NTY3NDcyMw..', 1690000.00, 1590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (232, 73, 'JBL-TB-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tune-beam-den.png?_gl=1*jybdqx*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MDExJGo2MCRsMCRoMT', 2490000.00, 1750000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (233, 73, 'JBL-TB-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tune-beam-blue.png?_gl=1*jybdqx*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MDExJGo2MCRsMCRoM', 2490000.00, 1750000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (234, 73, 'JBL-TB-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tune-beam-trang.png?_gl=1*vkmxgd*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MDE5JGo1MiRsMCRo', 2490000.00, 1750000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (235, 73, 'JBL-TB-PUR', 'Tím ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-bluetooth-jbl-tune-beam-tim.png?_gl=1*122o2xc*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MDI0JGo0NyRsMCRoM', 2490000.00, 1750000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (236, 72, 'JBL-TF-VAR', 'Xanh ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/_/t_i_xu_ng_-_2023-02-11t211953.503_1.png?_gl=1*kcbslm*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1MzUzJGo2MCRsMCRoMTc', 1990000.00, 1890000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (237, 72, 'JBL-TF-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/_/t_i_xu_ng_-_2023-02-11t211941.802_1.png?_gl=1*17pd1os*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1ODQyJGo2MCRsMCRoMT', 1990000.00, 1890000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (238, 72, 'JBL-TF-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/_/t_i_xu_ng_-_2023-02-11t195647.477_1.png?_gl=1*1uf2bpi*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjQ5NTc5OTYkbzM4JGcxJHQxNzY0OTY1ODQ3JGo1NSRsMCRoMT', 1990000.00, 1890000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (239, 71, 'JBL-T520BT-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tune-520bt_4__1.png?_gl=1*1yafa1*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwNjY1JGoxOSRsMCRoM', 1360000.00, 990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (240, 71, 'JBL-T520BT-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tune-520bt_10__1.png?_gl=1*9f3j5y*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwNzc3JGo2MCRsMCRo', 1360000.00, 990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (241, 71, 'JBL-T520BT-PUR', 'Tím ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tune-520bt_2__1.png?_gl=1*1wzhl8*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwNzgzJGo1NCRsMCRoM', 1360000.00, 990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (242, 71, 'JBL-T520BT-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-chup-tai-jbl-tune-520bt_3__1.png?_gl=1*th056t*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwNzg4JGo0OSRsMCRoM', 1360000.00, 990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (243, 70, 'JBL-TB2G-WHT', 'Trắng xuyến thấu', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/g/h/ghost.png?_gl=1*1302p2v*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQwOTYwJGozNCRsMCRoMTMyNzAwMDEyNg..', 1109000.00, 890000.00, 91, 0, 0);
INSERT INTO `productvariants` VALUES (244, 70, 'JBL-TB2G-PUR', 'Tím ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-tune-beam-2-ghost-tim.jpg?_gl=1*mj8zvb*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQxNTExJGo2MC', 0.00, 0.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (245, 70, 'JBL-TB2G-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-khong-day-jbl-tune-beam-2-ghost-den.jpg?_gl=1*jqyujr*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUwNDAyMjMkbzM5JGcxJHQxNzY1MDQxNTg4JGo2MC', 0.00, 0.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (246, 69, 'JBL-EZ-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/j/b/jbl_endurance_zone_1.png?_gl=1*16smani*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEwMTE5JGoyNSRsMCRoMTUwNzM1MDM4MA..', 0.00, 3490000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (247, 68, 'JBL-LP2-PNK', 'Hồng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/7/_/7_60_1_2.png?_gl=1*1torzzp*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyMDk1JGo1MyRsMCRoMTUwNzM1MDM4MA..', 3990000.00, 2150000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (248, 68, 'JBL-LP2-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/2/b2_1.jpg?_gl=1*16epmc*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyNDc1JGo2MCRsMCRoMTUwNzM1MDM4MA..', 3990000.00, 2150000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (249, 68, 'JBL-LP2-SLV', 'Bạc', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/4/_/4_115_1_1.png?_gl=1*9r0t32*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyNDgxJGo1NCRsMCRoMTUwNzM1MDM4MA..', 3990000.00, 2150000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (250, 68, 'JBL-LP2-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/l/bl2_2.jpg?_gl=1*6tr59i*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyNDg2JGo0OSRsMCRoMTUwNzM1MDM4MA..', 3990000.00, 2150000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (251, 67, 'SS-GB3P-GRY', 'Xám', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-samsung-galaxy-buds-3-pro_9__1.png?_gl=1*924016*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEyNjQwJGo2JGwwJGg', 5400000.00, 3990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (252, 67, 'SS-GB3P-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/a/tai-nghe-samsung-galaxy-buds-3-pro_20__1.png?_gl=1*7kj9nu*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEzMDQxJGo2MCRsMC', 5400000.00, 3990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (253, 66, 'SS-GB3-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/a/samsung-galaxy-buds-3-6_1.png?_gl=1*17426mw*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjEzMjM3JGo0NyRsMCRoMTUwNzM1MDM4', 3920000.00, 3500000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (254, 66, 'SS-GB3-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/a/samsung-galaxy-buds-3-12.png?_gl=1*fxd0c8*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0MTc5JGo0NSRsMCRoMTUwNzM1MDM4MA', 3920000.00, 3290000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (255, 65, 'SS-GBC-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/c/_/c_4_1.png?_gl=1*40bgvw*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0Mzg2JGo2MCRsMCRoMTUwNzM1MDM4MA..', 0.00, 1190000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (256, 65, 'SS-GBC-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/c/1/c1_1_1.png?_gl=1*13tiswd*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NTE3JGo2MCRsMCRoMTUwNzM1MDM4MA..', 0.00, 1190000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (257, 64, 'SS-GBF-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/a/samsung-galaxy-buds-fe-trang.png?_gl=1*ww1qqe*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NzI4JGo1NCRsMCRoMTUwNzM1MD', 1990000.00, 950000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (258, 64, 'SS-GBF-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/a/samsung-galaxy-buds-fe-den.png?_gl=1*ww1qqe*_gcl_au*MTA3NTE2OTI3OS4xNzU3NTk1NTcy*_ga*ODE5NjkxMzY4LjE2NTU3MzU5MDI.*_ga_QLK8WFHNK9*czE3NjUyMTAwMDUkbzQwJGcxJHQxNzY1MjE0NzI4JGo1NCRsMCRoMTUwNzM1MDM4', 1990000.00, 950000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (259, 1, 'SN-XM5-BLK', 'Đen', '', 8000000.00, 7900000.00, 50, 0, 1);
INSERT INTO `productvariants` VALUES (260, 145, 'M-SII-BRN', 'Nâu', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-marshall-stanmore-ii-brown-nau.png', 11190000.00, 11190000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (261, 145, 'M-SII-WHT', 'Trắng ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/1/_/1_62_1.jpg', 11190000.00, 11190000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (262, 145, 'M-SII-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-khong-day-marshall-stanmore-ii-3_1.jpg', 11190000.00, 11190000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (263, 146, 'M-SIII-BRN', 'Nâu', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/t/stan3.png', 11780000.00, 10590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (264, 146, 'M-SIII-VAR', 'Kem', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/marshall_stanmore_iii_6_1.png', 11780000.00, 10590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (265, 146, 'M-SIII-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/marshall_stanmore_iii_5_1.png', 11780000.00, 10590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (266, 147, 'M-WoIII-BRN', 'Nâu', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/m/a/marshall-woburn-iii-2.jpg', 17670000.00, 15990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (267, 147, 'M-WoIII-VAR', 'Kem', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-marshall-woburn-iii-kem.png', 17670000.00, 15990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (268, 147, 'M-WoIII-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/t/_/t_i_xu_ng_99__2.png', 17670000.00, 15990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (269, 149, 'S-SRS-XP500-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-srs-xp500_1.png', 9990000.00, 6590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (270, 150, 'S-SRS-XV900-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-srs-xv900-3_1.png', 23490000.00, 15990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (271, 151, 'S-SRS-XV800-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-srs-xv800-1_1.png', 14990000.00, 11350000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (272, 152, 'S-SRS-XV500-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/m/image_1191.png', 9990000.00, 6590000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (273, 153, 'S-ULTF1-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-1_1_.png', 2990000.00, 2075000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (274, 153, 'S-ULTF1-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-1_10__1.png', 2990000.00, 2075000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (275, 153, 'S-ULTF1-VAR', 'Xanh', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-1_9__1.png', 2990000.00, 2075000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (276, 154, 'S-ULTF3-WHT', 'Trắng ngà', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-3_3__1.png', 4990000.00, 3790000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (277, 154, 'S-ULTF3-GRY', 'Xám lục', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-3_4__1.png', 4990000.00, 3790000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (278, 154, 'S-ULTF3-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-3_2__1.png', 4990000.00, 3790000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (279, 155, 'S-ULTF5-WHT', 'Trắng ngà', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-5_3__1.png', 8190000.00, 6540000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (280, 155, 'S-ULTF5-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-5_2__1.png', 8190000.00, 6540000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (281, 156, 'S-ULTF7-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-field-7_3__1.png', 11990000.00, 8990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (282, 157, 'S-ULTT9-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-ult-tower-9_2__1.png', 27990000.00, 24290000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (283, 158, 'S-ULTT10-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-karaoke-sony-ult-tower_4__1.png', 25990000.00, 20690000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (284, 161, 'S-SRS-XB23EB-GRE', 'Xanh lá', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-bluetooth-sony-srs-xb23-green-2-600x600.jpg', 2490000.00, 2490000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (285, 161, 'S-SRS-XB23EB-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/2/9/2968_1_1.jpg', 2490000.00, 2490000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (286, 161, 'S-SRS-XB23EB-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/2/3/2370_loa_di_dong_sony_srs_xb23_blue_1.jpg', 2490000.00, 2490000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (287, 162, 'S-SRS-XB33EB-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/b/xb33_black_2_1.jpg', 3690000.00, 3690000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (288, 162, 'S-SRS-XB33EB-YEL', 'Vàng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/l/o/loa-di-dong-sony-srs-xb33-nau-sam.jpg', 3690000.00, 3690000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (289, 162, 'S-SRS-XB33EB-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/b/xb33_blue_2_1.jpg', 3690000.00, 3690000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (290, 163, 'S-SRS-XB43EB-WHT', 'Trắng', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/b/xb43_taupe_2_1.jpg', 4990000.00, 4990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (291, 163, 'S-SRS-XB43EB-BLU', 'Xanh dương ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/b/xb43_blue_2_1.jpg', 4990000.00, 4990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (292, 163, 'S-SRS-XB43EB-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/b/xb43_black_2_1.jpg', 4990000.00, 4990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (293, 164, 'S-SRS-XG300-GRY', 'Xám', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/2/_/2_122_1_.png', 6690000.00, 6690000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (294, 164, 'S-SRS-XG300-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/2/_/2_122_1_.png', 6690000.00, 6690000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (295, 165, 'S-SRS-XE200-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/_/0/_0000_srs-xe200_1__1_1.jpg', 2070000.00, 1150000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (296, 165, 'S-SRS-XE200-GRY', 'Xám', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/e/xe200_xam_1.jpg', 2070000.00, 1150000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (297, 165, 'S-SRS-XE200-BLU', 'Xanh dương', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/e/xe200_ba.jpg', 2070000.00, 1150000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (298, 166, 'S-SRS-XE300-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/_/0/_0000_srs-xe300_1__1.jpg', 3040000.00, 1690000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (299, 166, 'S-SRS-XE300-BLU', 'Xanh dương ', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/e/xe300_xa.jpg', 3040000.00, 1690000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (300, 166, 'S-SRS-XE300-GRY', 'Xám', 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/e/xe300_ba_2.jpg', 3040000.00, 1690000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (301, 167, 'S-MHC-V13-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-sony-mhc-v13-2_1_1.png', 5490000.00, 4290000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (302, 168, 'S-MHC-V21D-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/8/184367272sony-mhc-v21d-01.jpg', 4790000.00, 4790000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (303, 169, 'S-MHC-V43D-BLK', 'Đen', 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/o/loa-bluetooth-sony-mhc-v13-1_2.png?_gl=1*rffre8*_gcl_au*MTI1ODQyODgyMC4xNzY0MDU3NTM3*_ga*MjI3MzQzMjQ0LjE3NjQwNTc1Mzc.*_ga_QLK8WFHNK9*czE3NjU2NDQ0MTkkbzgkZzEkdDE3NjU2NDY3MzgkajI0JGwwJGgxNjg3MTc4NjQ', 8990000.00, 6990000.00, 0, 0, 0);
INSERT INTO `productvariants` VALUES (304, 25, 'HV-T981-BLK', 'Đen', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769428908/uoy3njkfhnuchgaad9ik.png', 890000.00, 800000.00, 90, 0, 1);
INSERT INTO `productvariants` VALUES (305, 110, 'JBL-520-VAR', 'Xanh navy', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769429051/cx1wgdpv4dfjnuk3d2re.jpg', 330000.00, 330000.00, 10, 0, 0);
INSERT INTO `productvariants` VALUES (306, 126, 'HW-7i-GRE', 'Xanh lá', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769429523/vkbb4xomdz3zctbxgn7a.jpg', 990000.00, 330000.00, 123, 0, 0);
INSERT INTO `productvariants` VALUES (307, 117, 'M--M-VAR', 'Xanh navy', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769429923/wwv3sc6nkto3d8afrorv.png', 2000000.00, 2000000.00, 20, 0, 0);
INSERT INTO `productvariants` VALUES (308, 122, 'XM-B5-VAR', 'Xanh navy', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769430432/uz6byfsejkal1ayx7o61.jpg', 900000.00, 300000.00, 1, 0, 0);
INSERT INTO `productvariants` VALUES (309, 124, 'XM-B3TPRO-GRE', 'Xanh lá', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769430569/pcurzvcwxwvalxxgla48.jpg', 62000.00, 60000.00, 1111, 0, 1);
INSERT INTO `productvariants` VALUES (310, 123, 'XM-B3-WHT', 'trắng', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769430806/gw9adexrsucsmtubtivl.jpg', 569000.00, 560000.00, 12, 0, 1);
INSERT INTO `productvariants` VALUES (311, 130, 'HW-SE-BLK', 'đen', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769430879/ecn0is7xgnwqeajdaxaf.jpg', 3200000.00, 2500000.00, 89, 0, 0);
INSERT INTO `productvariants` VALUES (312, 130, 'HW-SE-PNK', 'hong', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769431748/penmzred01ymoyqrjc4t.jpg', 123000.00, 100000.00, 12, 0, 0);
INSERT INTO `productvariants` VALUES (313, 129, 'HW-SE2-GRE', 'Xanh lá', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769431901/kzwfeqdv6ne39fcj0e2r.jpg', 330000.00, 290000.00, 70, 0, 0);
INSERT INTO `productvariants` VALUES (314, 132, 'HW-FA-BLK', 'đen', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769432195/b3dkotb8trlk7o6tqhmr.jpg', 200000.00, 200000.00, 70, 0, 0);
INSERT INTO `productvariants` VALUES (315, 128, 'HW-5i-PNK', 'Hồng', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769432297/rwlxpvnng3c9fwae0kwt.jpg', 9800000.00, 9000000.00, 84, 0, 0);
INSERT INTO `productvariants` VALUES (316, 125, 'HW-FE-BLK', 'Đen', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769432515/lhnrxdtafs03maff9oiv.jpg', 890000.00, 890000.00, 84, 0, 0);
INSERT INTO `productvariants` VALUES (317, 127, 'HW-6i-PNK', 'Hồng', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769432914/odjv0tqawxrcsnkvsnoh.jpg', 1101000.00, 1100000.00, 81, 0, 1);
INSERT INTO `productvariants` VALUES (318, 131, 'HW-SE4-VAR', 'Xanh navy', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769435701/oglibmuffjqoejwd0qpl.jpg', 1111111.00, 120000.00, 1, 0, 1);
INSERT INTO `productvariants` VALUES (319, 133, 'RM-BAP-BLK', 'Đen', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769435910/dkedvvx4g08ld0pfuy2m.jpg', 120000.00, 120000.00, 12, 0, 1);
INSERT INTO `productvariants` VALUES (320, 181, 'SONY-V43D-BLK', 'Đen', 'https://images.unsplash.com/photo-1589003077984-894e133dabab?w=500', 9900000.00, 8490000.00, 50, 0, 1);
INSERT INTO `productvariants` VALUES (321, 182, 'JBL-ENCORE-BLK', 'Đen', 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 12900000.00, 10900000.00, 30, 0, 1);
INSERT INTO `productvariants` VALUES (322, 183, 'LG-ON9-BLK', 'Đen', 'https://images.unsplash.com/photo-1545453330-14cc24aa0131?w=500', 8990000.00, 6500000.00, 20, 0, 1);
INSERT INTO `productvariants` VALUES (323, 184, 'SAM-ST40B-BLK', 'Đen', 'https://images.unsplash.com/photo-1558537348-c0f8e0732427?w=500', 5990000.00, 4290000.00, 40, 0, 1);
INSERT INTO `productvariants` VALUES (324, 185, 'SONY-V13-BLK', 'Đen', 'https://images.unsplash.com/photo-1589003077984-894e133dabab?w=500', 4490000.00, 3990000.00, 100, 0, 1);
INSERT INTO `productvariants` VALUES (325, 186, 'JBL-PB110-BLK', 'Đen', 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 11900000.00, 9900000.00, 25, 0, 1);
INSERT INTO `productvariants` VALUES (326, 187, 'LG-RN5-BLK', 'Đen', 'https://images.unsplash.com/photo-1545453330-14cc24aa0131?w=500', 4990000.00, 3500000.00, 60, 0, 1);
INSERT INTO `productvariants` VALUES (327, 188, 'SONY-V73D-BLK', 'Đen', 'https://images.unsplash.com/photo-1589003077984-894e133dabab?w=500', 14900000.00, 12490000.00, 10, 0, 1);
INSERT INTO `productvariants` VALUES (328, 189, 'JBL-PB310-BLK', 'Đen', 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 15900000.00, 14200000.00, 15, 0, 1);
INSERT INTO `productvariants` VALUES (329, 190, 'SAM-ST50B-BLK', 'Đen', 'https://images.unsplash.com/photo-1558537348-c0f8e0732427?w=500', 7990000.00, 5490000.00, 35, 0, 1);
INSERT INTO `productvariants` VALUES (330, 191, 'SONY-XB13-BLK', 'Đen', 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 1290000.00, 1090000.00, 200, 0, 1);
INSERT INTO `productvariants` VALUES (331, 192, 'JBL-FLIP6-BLK', 'Đen', 'https://images.unsplash.com/photo-1545453330-14cc24aa0131?w=500', 3290000.00, 2890000.00, 150, 0, 1);
INSERT INTO `productvariants` VALUES (332, 193, 'MAR-WILLEN-VAR', 'Brass', 'https://images.unsplash.com/photo-1589003077984-894e133dabab?w=500', 2990000.00, 2490000.00, 50, 0, 1);
INSERT INTO `productvariants` VALUES (333, 194, 'XIA-PORT-BLK', 'Đen', 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 1290000.00, 990000.00, 300, 0, 1);
INSERT INTO `productvariants` VALUES (334, 195, 'LG-PL7-BLK', 'Đen', 'https://images.unsplash.com/photo-1545453330-14cc24aa0131?w=500', 3590000.00, 1990000.00, 80, 0, 1);
INSERT INTO `productvariants` VALUES (335, 196, 'SONY-XE300-BLK', 'Đen', 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 4690000.00, 3990000.00, 45, 0, 1);
INSERT INTO `productvariants` VALUES (336, 197, 'JBL-CHARGE-BLK', 'Đen', 'https://images.unsplash.com/photo-1545453330-14cc24aa0131?w=500', 3990000.00, 3490000.00, 120, 0, 1);
INSERT INTO `productvariants` VALUES (337, 198, 'MAR-EMB2-VAR', 'Brass', 'https://images.unsplash.com/photo-1589003077984-894e133dabab?w=500', 4990000.00, 4490000.00, 40, 0, 1);
INSERT INTO `productvariants` VALUES (338, 199, 'SONY-XG300-BLK', 'Đen', 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 7990000.00, 6490000.00, 15, 0, 1);
INSERT INTO `productvariants` VALUES (339, 200, 'JBL-BOOMBO-BLK', 'Đen', 'https://images.unsplash.com/photo-1545453330-14cc24aa0131?w=500', 11900000.00, 9900000.00, 10, 0, 1);
INSERT INTO `productvariants` VALUES (340, 201, 'RAZ-BSV2X-VAR', 'Black', 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500', 1590000.00, 1290000.00, 100, 0, 1);
INSERT INTO `productvariants` VALUES (341, 202, 'SONY-IZH3-VAR', 'White', 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500', 2290000.00, 1690000.00, 50, 0, 1);
INSERT INTO `productvariants` VALUES (342, 203, 'JBL-Q400-VAR', 'Black', 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500', 2490000.00, 2190000.00, 40, 0, 1);
INSERT INTO `productvariants` VALUES (343, 204, 'RAZ-KRV3-VAR', 'Black', 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500', 2990000.00, 2490000.00, 60, 0, 1);
INSERT INTO `productvariants` VALUES (344, 205, 'SONY-IZH7-VAR', 'White', 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500', 5290000.00, 4490000.00, 25, 0, 1);
INSERT INTO `productvariants` VALUES (345, 206, 'JBL-Q610-VAR', 'Black', 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500', 3990000.00, 3590000.00, 35, 0, 1);
INSERT INTO `productvariants` VALUES (346, 207, 'RAZ-BARX-VAR', 'Black', 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500', 2590000.00, 2290000.00, 80, 0, 1);
INSERT INTO `productvariants` VALUES (347, 208, 'HAV-H2002D-VAR', 'Grey', 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500', 750000.00, 550000.00, 200, 0, 1);
INSERT INTO `productvariants` VALUES (348, 209, 'SONY-IZH9-VAR', 'White', 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500', 7490000.00, 6490000.00, 15, 0, 1);
INSERT INTO `productvariants` VALUES (349, 210, 'RAZ-KKT-VAR', 'Quartz Pink', 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500', 3290000.00, 2890000.00, 30, 0, 1);
INSERT INTO `productvariants` VALUES (350, 211, 'SONY-FLOAT-VAR', 'Black', 'https://images.unsplash.com/photo-1572536147748-ae51cff53f00?w=500', 3290000.00, 2690000.00, 100, 0, 1);
INSERT INTO `productvariants` VALUES (351, 212, 'HUA-CLIP-VAR', 'Purple', 'https://images.unsplash.com/photo-1588423770186-80f3ef9ad82e?w=500', 4990000.00, 4290000.00, 40, 0, 1);
INSERT INTO `productvariants` VALUES (352, 213, 'JBL-RFP-VAR', 'Black', 'https://images.unsplash.com/photo-1590658006244-857178d2169b?w=500', 4590000.00, 3990000.00, 70, 0, 1);
INSERT INTO `productvariants` VALUES (353, 214, 'BAS-ELI-VAR', 'Fluorescent Green', 'https://images.unsplash.com/photo-1572536147748-ae51cff53f00?w=500', 1890000.00, 1490000.00, 120, 0, 1);
INSERT INTO `productvariants` VALUES (354, 215, 'SONY-LINK-VAR', 'Grey', 'https://images.unsplash.com/photo-1590658006244-857178d2169b?w=500', 4490000.00, 3290000.00, 30, 0, 1);
INSERT INTO `productvariants` VALUES (355, 216, 'JBL-EPEAK3-VAR', 'Black', 'https://images.unsplash.com/photo-1572536147748-ae51cff53f00?w=500', 2990000.00, 2490000.00, 85, 0, 1);
INSERT INTO `productvariants` VALUES (356, 217, 'HUA-5I-VAR', 'Isle Blue', 'https://images.unsplash.com/photo-1588423770186-80f3ef9ad82e?w=500', 1890000.00, 1490000.00, 150, 0, 1);
INSERT INTO `productvariants` VALUES (357, 218, 'BAS-WM02-VAR', 'Purple', 'https://images.unsplash.com/photo-1590658006244-857178d2169b?w=500', 590000.00, 390000.00, 500, 0, 1);
INSERT INTO `productvariants` VALUES (358, 219, 'SONY-SP800-VAR', 'Blue', 'https://images.unsplash.com/photo-1572536147748-ae51cff53f00?w=500', 4290000.00, 3490000.00, 20, 0, 1);
INSERT INTO `productvariants` VALUES (359, 220, 'JBL-ERUN2-VAR', 'Black', 'https://images.unsplash.com/photo-1590658006244-857178d2169b?w=500', 550000.00, 450000.00, 300, 0, 1);
INSERT INTO `productvariants` VALUES (360, 136, 'RM-BQ-BLK', 'Đen tuyền', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769444841/h08xntm0vcuk8trbmbei.jpg', 220000.00, 219000.00, 78, 0, 1);
INSERT INTO `productvariants` VALUES (361, 1, 'SN-XM5-GRE', 'Xanh lá', 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769493203/h28wkwwe7qsfdllirqoq.jpg', 10111.00, 1111.00, 111, 0, 0);

-- ----------------------------
-- Table structure for reviewgalleries
-- ----------------------------
DROP TABLE IF EXISTS `reviewgalleries`;
CREATE TABLE `reviewgalleries`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `reviews_id` int NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `reviews_id`(`reviews_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reviewgalleries
-- ----------------------------
INSERT INTO `reviewgalleries` VALUES (1, 1, 'https://res.cloudinary.com/dyqqjmuei/image/upload/v1769451743/dsl8qwlgx3oitpunagon.jpg');
INSERT INTO `reviewgalleries` VALUES (2, 2, 'aaa');

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `products_id` int NOT NULL,
  `users_id` int NOT NULL,
  `rating` int NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `is_visible` tinyint(1) NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `products_id`(`products_id` ASC) USING BTREE,
  INDEX `users_id`(`users_id` ASC) USING BTREE,
  CONSTRAINT `reviews_chk_1` CHECK (`rating` between 1 and 5)
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reviews
-- ----------------------------
INSERT INTO `reviews` VALUES (1, 124, 1, 2, 'ổn', 1, '2026-01-27 01:22:23');
INSERT INTO `reviews` VALUES (2, 5, 4, 5, 'vui lắm', 1, '2026-01-28 05:17:20');

-- ----------------------------
-- Table structure for useraddresses
-- ----------------------------
DROP TABLE IF EXISTS `useraddresses`;
CREATE TABLE `useraddresses`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `users_id` int NOT NULL,
  `recipient_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_default` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `users_id`(`users_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of useraddresses
-- ----------------------------
INSERT INTO `useraddresses` VALUES (1, 13, 'Demo Google User', '0328005624', '', '', 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `role` tinyint NULL DEFAULT 0 COMMENT '0:Customer, 1:Admin',
  `is_locked` tinyint(1) NULL DEFAULT 0,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '23130327@st.hcmuaf.edu.vn', '7c04cac87083d4263942f9b10927bad7', 'Nguyễn Hoài Thương', NULL, NULL, 0, 0, '2025-12-26 17:43:42');
INSERT INTO `users` VALUES (2, 'nhthuong.1305@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b', 'Thuong Nguyen', NULL, NULL, 0, 0, '2025-12-26 18:45:55');
INSERT INTO `users` VALUES (3, 'nhbao@gmail.com', '698d51a19d8a121ce581499d7b701668', 'Nguyễn Hoài Bảo', NULL, NULL, 0, 0, '2025-12-27 13:16:59');
INSERT INTO `users` VALUES (4, 'admin@gmail.com', '202cb962ac59075b964b07152d234b70', 'Administrator', NULL, NULL, 1, 0, '2025-12-27 13:23:01');
INSERT INTO `users` VALUES (5, 'vtkt@gmail.com', '202cb962ac59075b964b07152d234b70', 'Võ Thị Kiều Tiên', NULL, NULL, 0, 0, '2025-12-27 14:20:30');
INSERT INTO `users` VALUES (6, 'abc@gmail.com', 'b59c67bf196a4758191e42f76670ceba', 'Thuong Nguyen', NULL, NULL, 0, 0, '2025-12-27 14:22:53');
INSERT INTO `users` VALUES (7, 'nguyenhoaiphong@gmail.com', 'ab03c2961229e5dc0149ca372fbe6192', 'Nguyen Hoai Phong', NULL, NULL, 0, 0, '2025-12-27 14:57:32');
INSERT INTO `users` VALUES (8, 'nhbnghi@gmail.com', '698d51a19d8a121ce581499d7b701668', 'Nguyen Hoai Bao Nghi', NULL, NULL, 0, 0, '2025-12-27 15:01:49');
INSERT INTO `users` VALUES (9, 'nhbnga@gmail.com', '0f38a6d29c7e4c2053e30bd0e03c1c7f', 'Nguyen Hoai Bao Nga', NULL, NULL, 0, 0, '2025-12-27 15:16:09');
INSERT INTO `users` VALUES (10, 'thuonga@gmail.com', '202cb962ac59075b964b07152d234b70', 'Thuong Nguyen a', NULL, NULL, 0, 0, '2025-12-27 15:20:40');
INSERT INTO `users` VALUES (11, 'btttrang@gmail.com', '202cb962ac59075b964b07152d234b70', 'Bui Thi Thuy Trang', NULL, NULL, 0, 0, '2026-01-17 17:29:51');
INSERT INTO `users` VALUES (12, 'chk.1305@gmail.com', '202cb962ac59075b964b07152d234b70', 'Hoàng Khôi', NULL, NULL, 0, 0, '2026-01-25 01:01:20');
INSERT INTO `users` VALUES (13, 'google_demo@gmail.com', 'GOOGLE_DEMO', 'Demo Google User', '0328005624', NULL, 0, 0, '2026-01-28 08:20:40');
INSERT INTO `users` VALUES (14, 'test_aurasound@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'Thuong Test', NULL, NULL, 0, 0, '2026-03-21 14:00:32');

-- ----------------------------
-- Table structure for vouchers
-- ----------------------------
DROP TABLE IF EXISTS `vouchers`;
CREATE TABLE `vouchers`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_amount` decimal(10, 2) NOT NULL,
  `min_order_value` decimal(10, 2) NULL DEFAULT 0.00,
  `usage_limit` int NULL DEFAULT NULL,
  `end_date` datetime NOT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vouchers
-- ----------------------------

-- ----------------------------
-- Triggers structure for table productvariants
-- ----------------------------
DROP TRIGGER IF EXISTS `trger_taoskuVar`;
delimiter ;;
CREATE TRIGGER `trger_taoskuVar` BEFORE INSERT ON `productvariants` FOR EACH ROW BEGIN
    DECLARE parent_sku VARCHAR(10);
    DECLARE color_code CHAR(3);
    
    SELECT sku INTO parent_sku 
    FROM products 
    WHERE id = NEW.products_id;
    
    SET color_code = (
        CASE 
            WHEN NEW.color_name LIKE '%Trắng%' THEN 'WHT'
            WHEN NEW.color_name LIKE '%Đen%' THEN 'BLK'
            WHEN NEW.color_name LIKE '%Đỏ%' THEN 'RED'
            WHEN NEW.color_name LIKE '%Xanh dương%' THEN 'BLU'
            WHEN NEW.color_name LIKE '%Xanh lá%' THEN 'GRE'
            WHEN NEW.color_name LIKE '%Vàng%' THEN 'YEL'
            WHEN NEW.color_name LIKE '%Xám%' THEN 'GRY'
            WHEN NEW.color_name LIKE '%Bạc%' THEN 'SLV'
            WHEN NEW.color_name LIKE '%Hồng%' THEN 'PNK'
            WHEN NEW.color_name LIKE '%Cam%' THEN 'ORG'
            WHEN NEW.color_name LIKE '%Tím%' THEN 'PUR'
            WHEN NEW.color_name LIKE '%Nâu%' THEN 'BRN'
            ELSE 'VAR' 
        END
    );
    
    SET NEW.variant_sku = CONCAT(parent_sku, '-', color_code);
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
