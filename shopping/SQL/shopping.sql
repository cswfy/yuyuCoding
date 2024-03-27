-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2023-06-04 15:31:42
-- 伺服器版本： 10.4.28-MariaDB
-- PHP 版本： 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `shopping`
--

-- --------------------------------------------------------

--
-- 資料表結構 `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `creationDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updationDate` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- 傾印資料表的資料 `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `creationDate`, `updationDate`) VALUES
(1, 'admin', '202cb962ac59075b964b07152d234b70', '2023-05-28 16:21:18', '02-06-2023 08:45:09 PM'),
(2, 'acs108802', 'e76ea4578839a49f6dfdf8509398a0d3', '2023-05-30 09:59:49', '30-05-2023 03:30:45 PM');

-- --------------------------------------------------------

--
-- 資料表結構 `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `categoryName` varchar(255) DEFAULT NULL,
  `categoryDescription` longtext DEFAULT NULL,
  `creationDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updationDate` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- 傾印資料表的資料 `category`
--

INSERT INTO `category` (`id`, `categoryName`, `categoryDescription`, `creationDate`, `updationDate`) VALUES
(9, '咖啡豆', '就是咖啡豆', '2023-06-02 14:36:19', NULL),
(10, '濾掛咖啡', '可以掛在杯子的那種', '2023-06-02 14:36:40', NULL),
(13, '咖啡糖', '就是咖啡口味的糖果', '2023-06-02 14:38:27', NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `productId` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `orderDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `paymentMethod` varchar(50) DEFAULT NULL,
  `orderStatus` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- 傾印資料表的資料 `orders`
--

INSERT INTO `orders` (`id`, `userId`, `productId`, `quantity`, `orderDate`, `paymentMethod`, `orderStatus`) VALUES
(7, 14, '24', 1, '2023-06-03 06:58:05', 'COD', NULL),
(8, 14, '23', 1, '2023-06-03 07:55:04', 'COD', NULL),
(9, 14, '24', 1, '2023-06-03 07:55:04', 'COD', NULL),
(10, 14, '23', 1, '2023-06-03 08:02:02', '貨到付款', NULL),
(11, 14, '24', 1, '2023-06-03 08:02:02', '貨到付款', '處理中!!璦玻珥會盡速為您處理!!'),
(15, 14, '23', 1, '2023-06-03 08:19:23', '網路銀行', NULL),
(16, 14, '28', 1, '2023-06-03 08:19:23', '網路銀行', NULL),
(17, 14, '23', 1, '2023-06-03 08:23:51', '網路銀行', NULL),
(18, 14, '28', 1, '2023-06-03 08:23:51', '網路銀行', '已寄出'),
(19, 14, '27', 1, '2023-06-03 08:31:55', '網路銀行', NULL),
(20, 14, '29', 1, '2023-06-03 08:31:55', '網路銀行', '已寄出'),
(21, 14, '24', 1, '2023-06-03 08:40:35', '信用卡 / 簽帳金融卡', NULL),
(22, 14, '29', 1, '2023-06-03 08:40:35', '信用卡 / 簽帳金融卡', NULL),
(23, 14, '31', 1, '2023-06-03 08:40:35', '信用卡 / 簽帳金融卡', '已寄出'),
(24, 14, '27', 1, '2023-06-03 08:46:33', '信用卡 / 簽帳金融卡', NULL),
(25, 14, '29', 1, '2023-06-03 08:46:33', '信用卡 / 簽帳金融卡', '已寄出'),
(26, 16, '27', 1, '2023-06-04 10:22:41', '貨到付款', NULL),
(27, 16, '29', 1, '2023-06-04 10:22:41', '貨到付款', NULL),
(28, 16, '30', 1, '2023-06-04 10:22:41', '貨到付款', '已寄出');

-- --------------------------------------------------------

--
-- 資料表結構 `ordertrackhistory`
--

CREATE TABLE `ordertrackhistory` (
  `id` int(11) NOT NULL,
  `orderId` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `remark` longtext DEFAULT NULL,
  `postingDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- 傾印資料表的資料 `ordertrackhistory`
--

INSERT INTO `ordertrackhistory` (`id`, `orderId`, `status`, `remark`, `postingDate`) VALUES
(5, 11, 'Delivered', 'ok!', '2023-06-03 08:02:55'),
(6, 11, 'Delivered', 'ok!', '2023-06-03 08:07:13'),
(7, 11, 'Delivered', 'ok!', '2023-06-03 08:07:32'),
(8, 11, '已寄出', 'qqq', '2023-06-03 08:07:41'),
(9, 11, '已寄出', 'qqq', '2023-06-03 08:08:06'),
(12, 18, '處理中!!璦玻珥會盡速為您處理!!', '請稍等', '2023-06-03 08:24:37'),
(13, 18, '已寄出', '謝謝購物', '2023-06-03 08:25:08'),
(14, 20, '處理中!!璦玻珥會盡速為您處理!!', '請稍等', '2023-06-03 08:32:42'),
(15, 20, '已寄出', 'okok! 謝謝光臨', '2023-06-03 08:33:17'),
(16, 23, '處理中!!璦玻珥會盡速為您處理!!', '請稍等^^', '2023-06-03 08:41:19'),
(17, 23, '已寄出', 'okok thank you^^', '2023-06-03 08:42:05'),
(18, 25, '處理中!!璦玻珥會盡速為您處理!!', '請稍等', '2023-06-03 08:47:13'),
(19, 25, '已寄出', 'okok 謝謝光臨^^', '2023-06-03 08:47:44'),
(20, 28, '已寄出', '好了喔', '2023-06-04 10:26:35');

-- --------------------------------------------------------

--
-- 資料表結構 `productreviews`
--

CREATE TABLE `productreviews` (
  `id` int(11) NOT NULL,
  `productId` int(11) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `review` longtext DEFAULT NULL,
  `reviewDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- 傾印資料表的資料 `productreviews`
--

INSERT INTO `productreviews` (`id`, `productId`, `quality`, `price`, `value`, `name`, `summary`, `review`, `reviewDate`) VALUES
(5, 27, 5, 5, 5, 'happy', '略', '好喝到不行', '2023-06-03 12:25:22');

-- --------------------------------------------------------

--
-- 資料表結構 `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `subCategory` int(11) DEFAULT NULL,
  `productName` varchar(255) DEFAULT NULL,
  `productCompany` varchar(255) DEFAULT NULL,
  `productPrice` int(11) DEFAULT NULL,
  `productPriceBeforeDiscount` int(11) DEFAULT NULL,
  `productDescription` longtext DEFAULT NULL,
  `productImage1` varchar(255) DEFAULT NULL,
  `productImage2` varchar(255) DEFAULT NULL,
  `productImage3` varchar(255) DEFAULT NULL,
  `shippingCharge` int(11) DEFAULT NULL,
  `productAvailability` varchar(255) DEFAULT NULL,
  `postingDate` timestamp NULL DEFAULT current_timestamp(),
  `updationDate` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- 傾印資料表的資料 `products`
--

INSERT INTO `products` (`id`, `category`, `subCategory`, `productName`, `productCompany`, `productPrice`, `productPriceBeforeDiscount`, `productDescription`, `productImage1`, `productImage2`, `productImage3`, `shippingCharge`, `productAvailability`, `postingDate`, `updationDate`) VALUES
(24, 10, 15, 'ucc經典ucc', 'uccuccucc', 300, 400, 'uccucccccc', '下.jpg', '下載 (2).jpg', '', 20, 'Yes', '2023-06-03 02:18:23', NULL),
(27, 9, 14, '星巴克經典', '星巴克', 100, 150, '含淚賤賣', '20230309151928544.jpg', '7040140_R.jpg', '', 10, 'Yes', '2023-06-03 08:12:10', NULL),
(29, 10, 16, '西雅圖咖啡', '西雅圖', 290, 300, '經典不解釋', '000001_1646359534.jpg', 'images (7).jpg', '', 20, 'Yes', '2023-06-03 08:27:33', NULL),
(30, 13, 18, 'KOPIKO', 'KOPIKO', 80, 90, '就是糖果', '10402232_R2_m.webp', 'images (9).jpg', '', 10, 'Yes', '2023-06-03 08:28:16', NULL),
(31, 10, 19, '質感咖啡', '伯朗', 280, 300, '您的老朋友伯朗咖啡', '290397513001.jpg', '15916535021598.jpg', '', 30, 'Yes', '2023-06-03 08:38:22', NULL),
(32, 13, 17, '福伯咖啡糖', '福伯', 80, 90, '糖果不解釋', '下載 (2).jpg', '下載 (2).jpg', '', 10, 'Yes', '2023-06-03 08:44:13', NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `subcategory`
--

CREATE TABLE `subcategory` (
  `id` int(11) NOT NULL,
  `categoryid` int(11) DEFAULT NULL,
  `subcategory` varchar(255) DEFAULT NULL,
  `creationDate` timestamp NULL DEFAULT current_timestamp(),
  `updationDate` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- 傾印資料表的資料 `subcategory`
--

INSERT INTO `subcategory` (`id`, `categoryid`, `subcategory`, `creationDate`, `updationDate`) VALUES
(14, 9, '星巴克', '2023-06-02 16:18:16', NULL),
(15, 10, 'ucc', '2023-06-03 02:15:57', NULL),
(16, 10, '西雅圖', '2023-06-03 02:16:10', NULL),
(17, 13, '福伯', '2023-06-03 07:35:41', NULL),
(18, 13, 'KOPIKO', '2023-06-03 07:35:45', NULL),
(19, 10, '美味', '2023-06-03 08:37:15', NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `userlog`
--

CREATE TABLE `userlog` (
  `id` int(11) NOT NULL,
  `userEmail` varchar(255) DEFAULT NULL,
  `userip` binary(16) DEFAULT NULL,
  `loginTime` timestamp NULL DEFAULT current_timestamp(),
  `logout` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- 傾印資料表的資料 `userlog`
--

INSERT INTO `userlog` (`id`, `userEmail`, `userip`, `loginTime`, `logout`, `status`) VALUES
(24, 'w@gmail.com', 0x3a3a3100000000000000000000000000, '2023-06-02 03:57:32', NULL, 1),
(25, 'w@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-02 05:25:55', '02-06-2023 11:14:01 AM', 1),
(26, 'w@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-02 12:35:57', '02-06-2023 06:27:38 PM', 1),
(27, 'w@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-02 12:57:45', '02-06-2023 06:29:27 PM', 1),
(28, 'bella@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 02:38:00', '03-06-2023 08:11:00 AM', 1),
(31, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 06:32:54', '03-06-2023 12:09:20 PM', 1),
(32, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 06:41:57', '03-06-2023 12:34:22 PM', 1),
(33, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 07:07:54', '03-06-2023 12:44:03 PM', 1),
(34, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 07:16:18', '03-06-2023 12:51:32 PM', 1),
(35, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 07:24:41', '03-06-2023 01:03:44 PM', 1),
(36, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 07:54:33', '03-06-2023 01:26:13 PM', 1),
(37, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 08:01:42', '03-06-2023 01:40:51 PM', 1),
(38, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 08:15:15', '03-06-2023 01:48:11 PM', 1),
(39, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 08:19:04', '03-06-2023 01:50:41 PM', 1),
(40, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 08:23:28', '03-06-2023 01:59:59 PM', 1),
(41, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 08:31:30', '03-06-2023 02:08:31 PM', 1),
(42, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 08:40:13', '03-06-2023 02:14:26 PM', 1),
(43, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 08:46:08', NULL, 1),
(44, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-03 12:13:02', NULL, 1),
(45, 'happy@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-04 05:40:47', '04-06-2023 11:10:53 AM', 1),
(46, 'queen@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-04 10:13:00', '04-06-2023 03:45:11 PM', 1),
(47, 'queen@gmail.com', 0x3132372e302e302e3100000000000000, '2023-06-04 10:19:17', NULL, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contactno` bigint(11) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `shippingAddress` longtext DEFAULT NULL,
  `shippingState` varchar(255) DEFAULT NULL,
  `shippingCity` varchar(255) DEFAULT NULL,
  `shippingPincode` int(11) DEFAULT NULL,
  `billingAddress` longtext DEFAULT NULL,
  `billingState` varchar(255) DEFAULT NULL,
  `billingCity` varchar(255) DEFAULT NULL,
  `billingPincode` int(11) DEFAULT NULL,
  `regDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updationDate` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- 傾印資料表的資料 `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `contactno`, `password`, `shippingAddress`, `shippingState`, `shippingCity`, `shippingPincode`, `billingAddress`, `billingState`, `billingCity`, `billingPincode`, `regDate`, `updationDate`) VALUES
(8, '王曉明', 'w@gmail.com', 123, '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-02 03:52:09', NULL),
(9, '愛德華', 'qqq@gmail.com', 90001234, '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-02 03:53:22', NULL),
(11, 'bella', 'bella@gmail.com', 9001234, '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-03 02:37:42', NULL),
(14, 'happy', 'happy@gmail.com', 912345678, '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-03 06:32:01', NULL),
(15, 'wendy', 'wendy@gmail.com', 91234, '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-04 05:41:52', NULL),
(16, 'queen', 'queen@gmail.com', 912345678, '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-04 09:11:30', NULL),
(17, 'queen', 'queen@gmail.com', 912345678, '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-04 09:15:07', NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `postingDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- 傾印資料表的資料 `wishlist`
--

INSERT INTO `wishlist` (`id`, `userId`, `productId`, `postingDate`) VALUES
(3, 14, 27, '2023-06-03 12:13:32'),
(4, 14, 30, '2023-06-03 12:13:41');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `ordertrackhistory`
--
ALTER TABLE `ordertrackhistory`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `productreviews`
--
ALTER TABLE `productreviews`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `subcategory`
--
ALTER TABLE `subcategory`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `userlog`
--
ALTER TABLE `userlog`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `ordertrackhistory`
--
ALTER TABLE `ordertrackhistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `productreviews`
--
ALTER TABLE `productreviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `subcategory`
--
ALTER TABLE `subcategory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `userlog`
--
ALTER TABLE `userlog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
