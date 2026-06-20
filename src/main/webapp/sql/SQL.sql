-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: rsd_vibe
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,2,1,1,799),(2,2,2,1,899),(3,2,3,1,1499),(4,3,1,2,799),(5,3,4,1,1299),(6,4,3,1,1499);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `total_amount` double DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'Dharaneesh Subburaj','+91 93614 17185','chennai',799,'2026-06-19 18:28:55'),(2,'Mithilesh K','9842232455','Chennai',3197,'2026-06-19 18:35:15'),(3,'ram','9456323487','Sattur',2897,'2026-06-19 18:36:09'),(4,'gokul','4321657890','chennai',1499,'2026-06-19 20:34:53');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) DEFAULT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `description` text,
  `stock` int DEFAULT NULL,
  `discount_percentage` double DEFAULT '0',
  `rating` double DEFAULT '0',
  `reviews_count` int DEFAULT '0',
  `original_price` double DEFAULT '0',
  `sizes` varchar(100) DEFAULT 'S,M,L,XL,XXL',
  `colors` varchar(200) DEFAULT '',
  `image_url_2` varchar(500) DEFAULT '',
  `image_url_3` varchar(500) DEFAULT '',
  `image_url_4` varchar(500) DEFAULT '',
  `is_new_arrival` tinyint(1) DEFAULT '0',
  `is_best_seller` tinyint(1) DEFAULT '0',
  `is_trending` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Classic Black T-Shirt','RSD',799.00,'T-Shirt','https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600&q=80','Premium cotton black t-shirt',50,0,0,0,0,'S,M,L,XL,XXL','','','','',0,0,0,'2026-06-20 07:14:13'),(2,'Oversized White T-Shirt','RSD',899.00,'T-Shirt','https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600&q=80','Oversized fit white t-shirt',40,0,0,0,0,'S,M,L,XL,XXL','','','','',0,0,0,'2026-06-20 07:14:13'),(3,'Slim Fit Jeans','RSD',1499.00,'Jeans','https://images.unsplash.com/photo-1542272604-787c3835535d?w=600&q=80','Blue slim fit denim jeans',30,0,0,0,0,'S,M,L,XL,XXL','','','','',0,0,0,'2026-06-20 07:14:13'),(4,'Formal White Shirt','RSD',1299.00,'Shirt','https://images.unsplash.com/photo-1596755094514-f87e32f85e23?w=600&q=80','Formal white shirt for office wear',25,0,0,0,0,'S,M,L,XL,XXL','','','','',0,0,0,'2026-06-20 07:14:13'),(5,'Blue Denim Jacket','RSD',1999.00,'Jacket','https://images.unsplash.com/photo-1551028719-00167b16eac5?w=600&q=80','Stylish blue denim jacket',20,0,0,0,0,'S,M,L,XL,XXL','','','','',0,0,0,'2026-06-20 07:14:13');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `address` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `profile_photo` varchar(500) DEFAULT '',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Dharaneesh','dharaneeshsubburaj@gmail.com','+91 93614 17185','3130','Banglore','2026-06-18 11:51:02','');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-21  0:10:25
