-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 01, 2024 at 05:08 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce-online-shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Toyota', 'toyota', 1, '2024-06-04 06:07:03', '2024-06-04 06:07:03'),
(2, 'Hyundai', 'hyundai', 1, '2024-06-04 06:07:19', '2024-06-04 06:07:19'),
(3, 'HP', 'hp', 1, '2024-06-04 06:07:48', '2024-06-04 06:07:48'),
(4, 'Android', 'android', 1, '2024-06-04 06:08:12', '2024-06-04 06:08:12');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL DEFAULT 'NULL',
  `status` int(11) NOT NULL DEFAULT 1,
  `showhome` enum('Yes','No') NOT NULL DEFAULT 'No',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `image`, `status`, `showhome`, `created_at`, `updated_at`) VALUES
(1, 'Laptop', 'laptop', '1-1717455647.jfif', 1, 'Yes', '2024-06-04 05:57:54', '2024-06-04 06:00:47'),
(2, 'Car', 'car', '2.jfif', 1, 'Yes', '2024-06-04 05:58:28', '2024-06-04 05:59:28'),
(3, 'Mobile', 'mobile', '3.jfif', 1, 'Yes', '2024-06-04 05:59:14', '2024-06-25 09:34:55');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(15, '2014_10_12_000000_create_users_table', 1),
(16, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(17, '2019_08_19_000000_create_failed_jobs_table', 1),
(18, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(19, '2024_04_22_043332_create_categories_table', 1),
(20, '2024_04_23_195712_create_temp_images_table', 1),
(21, '2024_04_24_194129_create_sub_categories_table', 1),
(22, '2024_04_25_102614_create_brands_table', 1),
(23, '2024_04_26_000010_create_products_table', 1),
(24, '2024_04_26_000026_create_product_images_table', 1),
(25, '2024_05_01_185528_alter_categories_table', 1),
(26, '2024_05_01_203808_alter_products_table', 1),
(27, '2024_05_06_080312_alter_sub_categories_table', 1),
(28, '2024_06_29_195641_alter_products_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `short_description` text DEFAULT NULL,
  `shipping_return` text DEFAULT NULL,
  `related_products` text DEFAULT NULL,
  `price` double(10,2) NOT NULL,
  `compare_price` double(10,2) DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `sub_category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_featured` enum('Yes','No') NOT NULL DEFAULT 'No',
  `sku` varchar(255) NOT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `track_qty` enum('Yes','No') NOT NULL DEFAULT 'Yes',
  `qty` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `slug`, `description`, `short_description`, `shipping_return`, `related_products`, `price`, `compare_price`, `category_id`, `sub_category_id`, `brand_id`, `is_featured`, `sku`, `barcode`, `track_qty`, `qty`, `status`, `created_at`, `updated_at`) VALUES
(3, 'Corola-15', 'corola-15', '<p>ghjkjkj</p>', 'Lorem ipsum dolor sit amet consectetur adipisicing elit.', '<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. <span style=\"background-color: rgb(255, 255, 0);\"><b>No Return</b></span><br></p>', '3', 500.00, 400.00, 2, 1, 1, 'Yes', 'UGG-BB-PUR-06', '676787', 'Yes', 5, 1, '2024-06-04 06:11:38', '2024-07-01 07:13:43'),
(4, 'Civic-17', 'civic-17', NULL, NULL, NULL, '3', 700.00, 600.00, 2, 2, 2, 'Yes', 'UGG-BB-PUR-07', '67898', 'Yes', 2, 1, '2024-06-04 06:13:26', '2024-06-30 21:37:22'),
(5, 'Fortuner-44', 'fortuner-44', '<p>Good Car&nbsp;<span style=\"font-weight: bolder;\">!!</span><br></p>', NULL, NULL, '4,7', 1199.00, 1100.00, 2, 3, 2, 'Yes', 'UGG-BB-PUR-08', '676889', 'Yes', 2, 1, '2024-06-04 06:16:52', '2024-06-30 22:36:37'),
(6, 'HP-4350', 'hp-4350', NULL, NULL, NULL, NULL, 400.00, 350.00, 1, 4, 3, 'Yes', 'UGG-BB-PUR-09', '36567', 'Yes', 3, 1, '2024-06-04 06:19:56', '2024-06-04 06:20:10'),
(7, 'Lenovo-E7250', 'lenovo-e7250', '<p>Good Laptop&nbsp;<span style=\"font-weight: bolder;\">!!</span><br></p>', NULL, NULL, NULL, 399.00, 299.00, 1, 5, 3, 'Yes', 'UGG-BB-PUR-10', '5638', 'Yes', 5, 1, '2024-06-04 06:22:22', '2024-06-04 06:22:22'),
(8, 'Vivo v51', 'vivo-v51', NULL, NULL, NULL, NULL, 200.00, 150.00, 3, 6, 4, 'Yes', 'UGG-BB-PUR-11', '35687', 'Yes', 2, 1, '2024-06-04 06:24:13', '2024-06-04 06:25:00'),
(9, 'Infinix-20', 'infinix-20', NULL, NULL, NULL, NULL, 340.00, 300.00, 3, 7, 4, 'Yes', 'UGG-BB-PUR-12', '189856', 'Yes', 6, 1, '2024-06-04 06:26:44', '2024-06-30 02:49:11'),
(11, 'Qui velit est anim p', 'qui-velit-est-anim-p', NULL, NULL, NULL, NULL, 527.00, 170.00, 1, 4, 3, 'Yes', 'Laboriosam iusto ad', 'Tenetur recusandae', 'Yes', 404, 1, '2024-06-04 06:52:42', '2024-06-26 08:31:54'),
(12, 'Dr. Cordelia Kub I', 'dr-cordelia-kub-i', NULL, NULL, NULL, NULL, 708.00, NULL, 2, 2, 3, 'Yes', '6489', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(13, 'Wilmer Fadel', 'wilmer-fadel', NULL, NULL, NULL, NULL, 717.00, NULL, 2, 3, 2, 'Yes', '2295', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(14, 'Modesta Bauch IV', 'modesta-bauch-iv', NULL, NULL, NULL, NULL, 701.00, NULL, 2, 3, 4, 'Yes', '8361', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(15, 'Bettye King', 'bettye-king', NULL, NULL, NULL, NULL, 750.00, NULL, 2, 1, 1, 'Yes', '3530', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(16, 'Madilyn Turner', 'madilyn-turner', NULL, NULL, NULL, NULL, 674.00, NULL, 2, 3, 3, 'Yes', '8082', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(17, 'Sherman Osinski', 'sherman-osinski', NULL, NULL, NULL, NULL, 907.00, NULL, 2, 1, 1, 'Yes', '5682', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(18, 'Loraine Klein', 'loraine-klein', NULL, NULL, NULL, NULL, 480.00, NULL, 2, 2, 2, 'Yes', '4854', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(19, 'Deonte Sauer', 'deonte-sauer', NULL, NULL, NULL, NULL, 314.00, NULL, 2, 1, 2, 'Yes', '8037', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(20, 'London Marvin', 'london-marvin', NULL, NULL, NULL, NULL, 488.00, NULL, 2, 3, 1, 'Yes', '9284', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(21, 'Dr. Candace Osinski I', 'dr-candace-osinski-i', NULL, NULL, NULL, NULL, 526.00, NULL, 2, 1, 2, 'Yes', '7326', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(22, 'Oda Gutkowski', 'oda-gutkowski', NULL, NULL, NULL, NULL, 773.00, NULL, 2, 3, 3, 'Yes', '3135', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(23, 'Miss Dana Hansen III', 'miss-dana-hansen-iii', NULL, NULL, NULL, NULL, 990.00, NULL, 2, 3, 2, 'Yes', '3939', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(24, 'Prof. Humberto Gislason', 'prof-humberto-gislason', NULL, NULL, NULL, NULL, 225.00, NULL, 2, 3, 2, 'Yes', '9310', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(25, 'Wayne Prohaska', 'wayne-prohaska', NULL, NULL, NULL, NULL, 39.00, NULL, 2, 2, 1, 'Yes', '7413', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(26, 'Dion Cruickshank', 'dion-cruickshank', NULL, NULL, NULL, NULL, 427.00, NULL, 2, 3, 1, 'Yes', '1557', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(27, 'Prof. Paula Gusikowski III', 'prof-paula-gusikowski-iii', NULL, NULL, NULL, NULL, 749.00, NULL, 2, 3, 3, 'Yes', '9037', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(28, 'Jamaal Borer DVM', 'jamaal-borer-dvm', NULL, NULL, NULL, NULL, 207.00, NULL, 2, 3, 3, 'Yes', '6853', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(29, 'Eldred Walsh', 'eldred-walsh', NULL, NULL, NULL, NULL, 325.00, NULL, 2, 1, 3, 'Yes', '4715', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(30, 'Danielle Will', 'danielle-will', NULL, NULL, NULL, NULL, 952.00, NULL, 2, 3, 1, 'Yes', '4853', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(31, 'Matilde Reinger', 'matilde-reinger', NULL, NULL, NULL, NULL, 766.00, NULL, 2, 2, 1, 'Yes', '5559', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(32, 'Trycia Maggio Jr.', 'trycia-maggio-jr', NULL, NULL, NULL, NULL, 740.00, NULL, 2, 2, 1, 'Yes', '2668', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(33, 'Leo Nicolas', 'leo-nicolas', NULL, NULL, NULL, NULL, 974.00, NULL, 2, 3, 3, 'Yes', '2864', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(34, 'Darren Hills', 'darren-hills', NULL, NULL, NULL, NULL, 715.00, NULL, 2, 1, 1, 'Yes', '7822', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(35, 'Myra O\'Conner', 'myra-oconner', NULL, NULL, NULL, NULL, 966.00, NULL, 2, 1, 3, 'Yes', '5494', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(36, 'Catherine Wisoky', 'catherine-wisoky', NULL, NULL, NULL, NULL, 771.00, NULL, 2, 3, 2, 'Yes', '1338', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(37, 'Winfield Mosciski', 'winfield-mosciski', NULL, NULL, NULL, NULL, 74.00, NULL, 2, 2, 4, 'Yes', '7559', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(38, 'Lisa Ledner', 'lisa-ledner', NULL, NULL, NULL, NULL, 472.00, NULL, 2, 3, 4, 'Yes', '8415', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(39, 'Peggie Jakubowski', 'peggie-jakubowski', NULL, NULL, NULL, NULL, 499.00, NULL, 2, 1, 1, 'Yes', '3864', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(40, 'Bianka Kuhn DVM', 'bianka-kuhn-dvm', NULL, NULL, NULL, NULL, 602.00, NULL, 2, 2, 3, 'Yes', '4756', NULL, 'Yes', 10, 1, '2024-06-04 06:52:42', '2024-06-04 06:52:42'),
(41, 'Rahul Blick', 'rahul-blick', NULL, NULL, NULL, NULL, 943.00, NULL, 2, 3, 1, 'Yes', '9043', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(42, 'Ms. Sheila Leffler II', 'ms-sheila-leffler-ii', NULL, NULL, NULL, NULL, 123.00, NULL, 2, 1, 2, 'Yes', '7377', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(43, 'April Gutmann PhD', 'april-gutmann-phd', NULL, NULL, NULL, NULL, 910.00, NULL, 2, 1, 4, 'Yes', '6952', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(44, 'Mafalda Greenholt', 'mafalda-greenholt', NULL, NULL, NULL, NULL, 337.00, NULL, 2, 2, 4, 'Yes', '4356', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(45, 'Emmanuelle Funk Sr.', 'emmanuelle-funk-sr', NULL, NULL, NULL, NULL, 646.00, NULL, 2, 3, 3, 'Yes', '7336', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(46, 'Travon Abshire', 'travon-abshire', NULL, NULL, NULL, NULL, 15.00, NULL, 2, 2, 3, 'Yes', '6374', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(47, 'Tanner Cremin', 'tanner-cremin', NULL, NULL, NULL, NULL, 345.00, NULL, 2, 3, 4, 'Yes', '3396', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(48, 'Liliana Klein', 'liliana-klein', NULL, NULL, NULL, NULL, 873.00, NULL, 2, 2, 1, 'Yes', '6887', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(49, 'Pat Halvorson', 'pat-halvorson', NULL, NULL, NULL, NULL, 91.00, NULL, 2, 3, 2, 'Yes', '4539', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(50, 'Winston Conn V', 'winston-conn-v', NULL, NULL, NULL, NULL, 965.00, NULL, 2, 2, 1, 'Yes', '8551', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(51, 'Dr. Stuart Borer Sr.', 'dr-stuart-borer-sr', NULL, NULL, NULL, NULL, 632.00, NULL, 2, 1, 4, 'Yes', '7352', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(52, 'Reginald Smitham', 'reginald-smitham', NULL, NULL, NULL, NULL, 159.00, NULL, 2, 3, 2, 'Yes', '5584', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(53, 'Kari Kuphal', 'kari-kuphal', NULL, NULL, NULL, NULL, 162.00, NULL, 2, 3, 2, 'Yes', '3079', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(54, 'Prof. Domenica Schroeder', 'prof-domenica-schroeder', NULL, NULL, NULL, NULL, 717.00, NULL, 2, 3, 3, 'Yes', '6024', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(55, 'Prof. Tony Ernser', 'prof-tony-ernser', NULL, NULL, NULL, NULL, 938.00, NULL, 2, 1, 3, 'Yes', '7998', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(56, 'Theresia Blick', 'theresia-blick', NULL, NULL, NULL, NULL, 616.00, NULL, 2, 2, 1, 'Yes', '2227', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(57, 'Chadd Schultz', 'chadd-schultz', NULL, NULL, NULL, NULL, 575.00, NULL, 2, 1, 4, 'Yes', '9064', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(58, 'Mr. Sydney Adams', 'mr-sydney-adams', NULL, NULL, NULL, NULL, 888.00, NULL, 2, 1, 1, 'Yes', '2800', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(59, 'Christy Greenfelder MD', 'christy-greenfelder-md', NULL, NULL, NULL, NULL, 698.00, NULL, 2, 2, 2, 'Yes', '1608', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(60, 'Amiya Marks', 'amiya-marks', NULL, NULL, NULL, NULL, 544.00, NULL, 2, 2, 1, 'Yes', '3675', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(61, 'Stevie Gorczany', 'stevie-gorczany', NULL, NULL, NULL, NULL, 226.00, NULL, 2, 2, 2, 'Yes', '6472', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(62, 'Jamel McLaughlin', 'jamel-mclaughlin', NULL, NULL, NULL, NULL, 904.00, NULL, 2, 3, 4, 'Yes', '8354', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(63, 'Alisha Kassulke', 'alisha-kassulke', NULL, NULL, NULL, NULL, 26.00, NULL, 2, 1, 4, 'Yes', '2655', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(64, 'Shanelle Stracke V', 'shanelle-stracke-v', NULL, NULL, NULL, NULL, 649.00, NULL, 2, 3, 2, 'Yes', '9807', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(65, 'Karianne Nikolaus', 'karianne-nikolaus', NULL, NULL, NULL, NULL, 502.00, NULL, 2, 3, 2, 'Yes', '3704', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(66, 'Mr. Braxton Considine', 'mr-braxton-considine', NULL, NULL, NULL, NULL, 367.00, NULL, 2, 1, 4, 'Yes', '6116', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(67, 'America Botsford V', 'america-botsford-v', NULL, NULL, NULL, NULL, 142.00, NULL, 2, 2, 3, 'Yes', '7495', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(68, 'Shane Weber', 'shane-weber', NULL, NULL, NULL, NULL, 835.00, NULL, 2, 2, 4, 'Yes', '1530', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(69, 'Ms. Evelyn O\'Reilly PhD', 'ms-evelyn-oreilly-phd', NULL, NULL, NULL, NULL, 41.00, NULL, 2, 3, 2, 'Yes', '9218', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(70, 'Diego Klocko', 'diego-klocko', NULL, NULL, NULL, NULL, 566.00, NULL, 2, 1, 3, 'Yes', '9880', NULL, 'Yes', 10, 1, '2024-06-04 06:55:39', '2024-06-04 06:55:39'),
(71, 'Felicity Jenkins DVM', 'felicity-jenkins-dvm', NULL, NULL, NULL, NULL, 149.00, NULL, 1, 4, 1, 'Yes', '2352', NULL, 'Yes', 10, 1, '2024-06-04 07:00:42', '2024-06-04 07:00:42'),
(72, 'Amber Brekke Jr.', 'amber-brekke-jr', NULL, NULL, NULL, NULL, 302.00, NULL, 1, 4, 3, 'Yes', '2386', NULL, 'Yes', 10, 1, '2024-06-04 07:00:42', '2024-06-04 07:00:42'),
(73, 'Emelie Rice', 'emelie-rice', NULL, NULL, NULL, NULL, 361.00, NULL, 1, 4, 3, 'Yes', '5246', NULL, 'Yes', 10, 1, '2024-06-04 07:00:42', '2024-06-04 07:00:42'),
(74, 'Mr. Geo Wisoky', 'mr-geo-wisoky', NULL, NULL, NULL, NULL, 543.00, NULL, 1, 4, 1, 'Yes', '9485', NULL, 'Yes', 10, 1, '2024-06-04 07:00:42', '2024-06-04 07:00:42'),
(75, 'Colton Swift', 'colton-swift', NULL, NULL, NULL, NULL, 631.00, NULL, 1, 4, 1, 'Yes', '7888', NULL, 'Yes', 10, 1, '2024-06-04 07:00:42', '2024-06-04 07:00:42'),
(76, 'Pat Von III', 'pat-von-iii', NULL, NULL, NULL, NULL, 164.00, NULL, 1, 4, 4, 'Yes', '3049', NULL, 'Yes', 10, 1, '2024-06-04 07:00:42', '2024-06-04 07:00:42'),
(77, 'Dr. Rosella Lynch II', 'dr-rosella-lynch-ii', NULL, NULL, NULL, NULL, 823.00, NULL, 1, 5, 4, 'Yes', '1169', NULL, 'Yes', 10, 1, '2024-06-04 07:00:42', '2024-06-04 07:00:42'),
(78, 'Melyna Langosh', 'melyna-langosh', NULL, NULL, NULL, NULL, 839.00, NULL, 1, 4, 1, 'Yes', '1982', NULL, 'Yes', 10, 1, '2024-06-04 07:00:42', '2024-06-04 07:00:42'),
(79, 'Merlin Moore', 'merlin-moore', NULL, NULL, NULL, NULL, 394.00, NULL, 1, 5, 4, 'Yes', '7717', NULL, 'Yes', 10, 1, '2024-06-04 07:00:42', '2024-06-04 07:00:42'),
(80, 'Elsa Parisian', 'elsa-parisian', NULL, NULL, NULL, NULL, 578.00, NULL, 1, 5, 1, 'Yes', '2100', NULL, 'Yes', 10, 1, '2024-06-04 07:00:42', '2024-06-04 07:00:42'),
(81, 'Stacey Kuphal', 'stacey-kuphal', NULL, NULL, NULL, NULL, 732.00, NULL, 1, 4, 2, 'Yes', '6905', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(82, 'Alvis Farrell', 'alvis-farrell', NULL, NULL, NULL, NULL, 603.00, NULL, 1, 4, 1, 'Yes', '4077', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(83, 'Miss Carrie Kertzmann', 'miss-carrie-kertzmann', NULL, NULL, NULL, NULL, 596.00, NULL, 1, 5, 1, 'Yes', '8336', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(84, 'Gregory Senger DDS', 'gregory-senger-dds', NULL, NULL, NULL, NULL, 975.00, NULL, 1, 5, 4, 'Yes', '7762', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(85, 'Keyshawn Kassulke DVM', 'keyshawn-kassulke-dvm', NULL, NULL, NULL, NULL, 283.00, NULL, 1, 5, 1, 'Yes', '6388', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(86, 'Eda Stark', 'eda-stark', NULL, NULL, NULL, '', 352.00, NULL, 1, 4, 2, 'Yes', '7262', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-30 09:01:01'),
(87, 'Mrs. Shyann Fadel III', 'mrs-shyann-fadel-iii', NULL, NULL, NULL, NULL, 549.00, NULL, 1, 5, 3, 'Yes', '6237', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(88, 'Ms. Destany Glover', 'ms-destany-glover', NULL, NULL, NULL, NULL, 209.00, NULL, 1, 4, 4, 'Yes', '4396', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(89, 'Trent Bechtelar', 'trent-bechtelar', NULL, NULL, NULL, NULL, 542.00, NULL, 1, 4, 4, 'Yes', '1199', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(90, 'Arvid Jacobson', 'arvid-jacobson', NULL, NULL, NULL, NULL, 930.00, NULL, 1, 4, 2, 'Yes', '6159', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(91, 'June Hermann', 'june-hermann', NULL, NULL, NULL, NULL, 607.00, NULL, 1, 4, 4, 'Yes', '4112', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(92, 'Ms. Claudie Murphy', 'ms-claudie-murphy', NULL, NULL, NULL, NULL, 683.00, NULL, 1, 5, 1, 'Yes', '4318', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(93, 'Dee Williamson', 'dee-williamson', NULL, NULL, NULL, NULL, 201.00, NULL, 1, 4, 1, 'Yes', '1829', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(94, 'Ila Maggio Jr.', 'ila-maggio-jr', NULL, NULL, NULL, NULL, 300.00, NULL, 1, 5, 1, 'Yes', '5224', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(95, 'Berry Roob', 'berry-roob', NULL, NULL, NULL, NULL, 40.00, NULL, 1, 5, 4, 'Yes', '2588', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(96, 'Prof. Maverick Kutch PhD', 'prof-maverick-kutch-phd', NULL, NULL, NULL, NULL, 382.00, NULL, 1, 4, 1, 'Yes', '2252', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(97, 'Peggie Collier', 'peggie-collier', NULL, NULL, NULL, NULL, 956.00, NULL, 1, 4, 2, 'Yes', '7116', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(98, 'Lemuel Batz MD', 'lemuel-batz-md', NULL, NULL, NULL, NULL, 197.00, NULL, 1, 5, 1, 'Yes', '4610', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(99, 'Elnora Upton', 'elnora-upton', NULL, NULL, NULL, NULL, 744.00, NULL, 1, 5, 2, 'Yes', '3150', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(100, 'Duane Krajcik', 'duane-krajcik', NULL, NULL, NULL, NULL, 488.00, NULL, 1, 5, 4, 'Yes', '3486', NULL, 'Yes', 10, 1, '2024-06-04 07:00:43', '2024-06-04 07:00:43'),
(102, 'Dolor veniam quis a', 'dolor-veniam-quis-a', NULL, NULL, NULL, '3,7,8', 782.00, 80.00, 2, NULL, NULL, 'No', 'Sint commodo beatae', 'Quia officia delenit', 'No', 216, 1, '2024-06-30 21:53:07', '2024-06-30 21:53:50');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, 3, '3-1-1717456298.jfif', NULL, '2024-06-04 06:11:38', '2024-06-04 06:11:38'),
(2, 3, '3-2-1717456299.jpg', NULL, '2024-06-04 06:11:39', '2024-06-04 06:11:39'),
(3, 4, '4-3-1717456406.jfif', NULL, '2024-06-04 06:13:26', '2024-06-04 06:13:26'),
(4, 4, '4-4-1717456406.jfif', NULL, '2024-06-04 06:13:26', '2024-06-04 06:13:26'),
(5, 5, '5-5-1717456612.jfif', NULL, '2024-06-04 06:16:52', '2024-06-04 06:16:52'),
(6, 5, '5-6-1717456613.jfif', NULL, '2024-06-04 06:16:53', '2024-06-04 06:16:53'),
(7, 6, '6-7-1717456796.jfif', NULL, '2024-06-04 06:19:56', '2024-06-04 06:19:56'),
(8, 6, '6-8-1717456796.jfif', NULL, '2024-06-04 06:19:56', '2024-06-04 06:19:56'),
(9, 7, '7-9-1717456942.jfif', NULL, '2024-06-04 06:22:22', '2024-06-04 06:22:22'),
(10, 7, '7-10-1717456943.jfif', NULL, '2024-06-04 06:22:23', '2024-06-04 06:22:23'),
(12, 8, '8-12-1717457053.jfif', NULL, '2024-06-04 06:24:13', '2024-06-04 06:24:13'),
(13, 9, '9-13-1717457204.jfif', NULL, '2024-06-04 06:26:44', '2024-06-04 06:26:44'),
(20, 11, '11-20-1719366014.jpg', NULL, '2024-06-26 08:40:14', '2024-06-26 08:40:14'),
(21, 9, '9-21-1719690541.jpg', NULL, '2024-06-30 02:49:01', '2024-06-30 02:49:01');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `showhome` enum('Yes','No') NOT NULL DEFAULT 'No',
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `name`, `slug`, `status`, `showhome`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 'Corola', 'corola', 1, 'Yes', 2, '2024-06-04 06:01:34', '2024-06-04 06:04:18'),
(2, 'Civic', 'civic', 1, 'Yes', 2, '2024-06-04 06:04:02', '2024-06-04 06:04:02'),
(3, 'Fortuner', 'fortuner', 1, 'Yes', 2, '2024-06-04 06:04:56', '2024-06-04 06:04:56'),
(4, 'Hp', 'hp', 1, 'Yes', 1, '2024-06-04 06:05:14', '2024-06-04 06:05:14'),
(5, 'Lenovo', 'lenovo', 1, 'Yes', 1, '2024-06-04 06:05:36', '2024-06-04 06:05:36'),
(6, 'Vivo', 'vivo', 1, 'Yes', 3, '2024-06-04 06:05:54', '2024-06-04 06:05:54'),
(7, 'Infinix', 'infinix', 1, 'Yes', 3, '2024-06-04 06:06:14', '2024-06-04 06:06:14');

-- --------------------------------------------------------

--
-- Table structure for table `temp_images`
--

CREATE TABLE `temp_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `temp_images`
--

INSERT INTO `temp_images` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, '1717455467.jfif', '2024-06-04 05:57:47', '2024-06-04 05:57:47'),
(2, '1717455505.jfif', '2024-06-04 05:58:25', '2024-06-04 05:58:25'),
(3, '1717455539.jfif', '2024-06-04 05:58:59', '2024-06-04 05:58:59'),
(4, '1717455599.jfif', '2024-06-04 05:59:59', '2024-06-04 05:59:59'),
(5, '1717455645.jfif', '2024-06-04 06:00:45', '2024-06-04 06:00:45'),
(6, '1717456230.jfif', '2024-06-04 06:10:30', '2024-06-04 06:10:30'),
(7, '1717456232.jpg', '2024-06-04 06:10:32', '2024-06-04 06:10:32'),
(8, '1717456359.jfif', '2024-06-04 06:12:39', '2024-06-04 06:12:39'),
(9, '1717456361.jfif', '2024-06-04 06:12:41', '2024-06-04 06:12:41'),
(10, '1717456582.jfif', '2024-06-04 06:16:22', '2024-06-04 06:16:22'),
(11, '1717456583.jfif', '2024-06-04 06:16:23', '2024-06-04 06:16:23'),
(12, '1717456765.jfif', '2024-06-04 06:19:25', '2024-06-04 06:19:25'),
(13, '1717456766.jfif', '2024-06-04 06:19:26', '2024-06-04 06:19:26'),
(14, '1717456902.jfif', '2024-06-04 06:21:42', '2024-06-04 06:21:42'),
(15, '1717456903.jfif', '2024-06-04 06:21:43', '2024-06-04 06:21:43'),
(16, '1717457026.jfif', '2024-06-04 06:23:46', '2024-06-04 06:23:46'),
(17, '1717457028.jfif', '2024-06-04 06:23:48', '2024-06-04 06:23:48'),
(18, '1717457186.jfif', '2024-06-04 06:26:26', '2024-06-04 06:26:26'),
(19, '1719254780.jpg', '2024-06-25 01:46:20', '2024-06-25 01:46:20'),
(20, '1719257001.jpg', '2024-06-25 02:23:21', '2024-06-25 02:23:21'),
(22, '1719277150.jpg', '2024-06-25 07:59:10', '2024-06-25 07:59:10'),
(23, '1719758758.jpg', '2024-06-30 21:45:58', '2024-06-30 21:45:58'),
(24, '1719758765.jpg', '2024-06-30 21:46:05', '2024-06-30 21:46:05');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` int(11) NOT NULL DEFAULT 1,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `role`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@gmail.com', 2, NULL, '$2y$10$3HpYNRg2WLb5VjsQNo6NduLEmteSdTAeEfPAkjers8vG1rrV8nINu', NULL, '2024-06-04 05:50:27', '2024-06-04 05:50:27'),
(2, 'Ahmad', 'ahmad@gmail.com', 1, NULL, '$2y$10$Fehp8LB3EhF.usi.5sZGnOzuHyhF8qMdnKEoqxMt8Vf8CWzT07lQ.', NULL, '2024-06-04 05:52:18', '2024-06-04 05:52:18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_sub_category_id_foreign` (`sub_category_id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_images_product_id_foreign` (`product_id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `temp_images`
--
ALTER TABLE `temp_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `temp_images`
--
ALTER TABLE `temp_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
