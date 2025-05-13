-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: emventory_admin_db
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `org_id` varchar(255) NOT NULL,
  `store_id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `account_type` enum('CASH','BANK','OTHER') NOT NULL,
  `holder_name` varchar(255) DEFAULT NULL,
  `account_no` varchar(255) DEFAULT NULL,
  `pos_percentage` int DEFAULT NULL,
  `balance` decimal(15,2) DEFAULT NULL,
  `opening_bal` decimal(15,2) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  `date` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'ACC25001','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','STR25000','city','BANK','adf','456',1,123465.00,123465.00,'ACTIVE','2025-05-08 06:57:48','2025-05-08 07:15:52','2025-05-08 07:15:52'),(2,'ACC25002','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','STR25000','one bank','BANK','fahmida','4513',1,10000.00,10000.00,'ACTIVE','2025-05-08 08:05:55','2025-05-08 10:47:02','2025-05-08 10:47:02');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_heads`
--

DROP TABLE IF EXISTS `account_heads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_heads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_heads_id` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `account_type` enum('DEBIT','CREDIT') NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `description` text,
  `org_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_heads_id` (`account_heads_id`),
  UNIQUE KEY `code` (`code`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `account_heads_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_heads`
--

LOCK TABLES `account_heads` WRITE;
/*!40000 ALTER TABLE `account_heads` DISABLE KEYS */;
INSERT INTO `account_heads` VALUES (1,'AH-001','AST-001','DEBIT','Assets','Asset',NULL,'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','2025-05-05 10:36:52','2025-05-05 10:36:52'),(2,'AH-002','AST-002','DEBIT','Cash','Asset','asfadff','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','2025-05-05 10:36:52','2025-05-05 11:13:33'),(3,'AH-003','AST-003','CREDIT','Accounts Payable','Liability','hjkjn','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','2025-05-05 10:36:52','2025-05-05 12:14:54'),(4,'AH-004','EXP-001','DEBIT','Rent Expense','Expense','ghbj','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','2025-05-05 10:36:52','2025-05-05 12:12:01');
/*!40000 ALTER TABLE `account_heads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_transaction`
--

DROP TABLE IF EXISTS `account_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `trn_id` varchar(255) NOT NULL,
  `org_id` varchar(255) NOT NULL,
  `account_id` varchar(255) NOT NULL,
  `particularName` varchar(255) NOT NULL,
  `particularRef` varchar(255) NOT NULL,
  `debit` decimal(15,2) DEFAULT NULL,
  `credit` decimal(15,2) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  `date` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trn_id` (`trn_id`),
  KEY `account_id` (`account_id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `account_transaction_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE,
  CONSTRAINT `account_transaction_ibfk_2` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_transaction`
--

LOCK TABLES `account_transaction` WRITE;
/*!40000 ALTER TABLE `account_transaction` DISABLE KEYS */;
INSERT INTO `account_transaction` VALUES (1,'TRN25001','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','ACC25001','Opening Balance','ACC25001',0.00,123465.00,'ACTIVE','2025-05-08 06:57:48','2025-05-08 07:15:52','2025-05-08 07:15:52'),(2,'TRN25002','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','ACC25002','Opening Balance','ACC25002',0.00,10000.00,'ACTIVE','2025-05-08 08:05:55','2025-05-08 10:47:02','2025-05-08 10:47:02');
/*!40000 ALTER TABLE `account_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_transfer`
--

DROP TABLE IF EXISTS `account_transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_transfer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_transfer_id` varchar(255) NOT NULL,
  `org_id` varchar(255) NOT NULL,
  `from_account_id` varchar(255) NOT NULL,
  `to_account_id` varchar(255) NOT NULL,
  `transferBalance` decimal(15,2) NOT NULL,
  `date` datetime NOT NULL,
  `frm_ac_bal` decimal(15,2) DEFAULT NULL,
  `to_ac_bal` decimal(15,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_transfer_id` (`account_transfer_id`),
  KEY `from_account_id` (`from_account_id`),
  KEY `to_account_id` (`to_account_id`),
  CONSTRAINT `account_transfer_ibfk_1` FOREIGN KEY (`from_account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `account_transfer_ibfk_2` FOREIGN KEY (`to_account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_transfer`
--

LOCK TABLES `account_transfer` WRITE;
/*!40000 ALTER TABLE `account_transfer` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_id` varchar(255) DEFAULT NULL,
  `store_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `des` text,
  `event_id` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `admin_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_id` (`admin_id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute`
--

DROP TABLE IF EXISTS `attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attribute_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `org_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute_id` (`attribute_id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `attribute_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute`
--

LOCK TABLES `attribute` WRITE;
/*!40000 ALTER TABLE `attribute` DISABLE KEYS */;
INSERT INTO `attribute` VALUES (1,'498e8e8c-78e3-4bbb-97a7-31162f989c47','Pcs','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),(2,'3a6f0c64-0137-440b-93d6-fab8e5cd8991','Color','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e');
/*!40000 ALTER TABLE `attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_value`
--

DROP TABLE IF EXISTS `attribute_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_value` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attribute_value_id` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `attribute_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute_value_id` (`attribute_value_id`),
  KEY `attribute_id` (`attribute_id`),
  CONSTRAINT `attribute_value_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `attribute` (`attribute_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_value`
--

LOCK TABLES `attribute_value` WRITE;
/*!40000 ALTER TABLE `attribute_value` DISABLE KEYS */;
INSERT INTO `attribute_value` VALUES (5,'d1df898b-202d-45b8-ab65-e64f68056666','12','498e8e8c-78e3-4bbb-97a7-31162f989c47'),(6,'cbccee5c-6336-428c-9359-51bbf8d6babf','Red','3a6f0c64-0137-440b-93d6-fab8e5cd8991'),(7,'5adab852-95ce-422c-bbb3-c79dadf8f76c','Green','3a6f0c64-0137-440b-93d6-fab8e5cd8991');
/*!40000 ALTER TABLE `attribute_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL,
  `depth` int DEFAULT '1',
  `org_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'30e43d9f-98a0-45bb-9bf0-a3fef1461e08','Vegetable',NULL,NULL,1,'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),(2,'ef9b6af1-0a34-4b43-b08d-50a706448665','Fruits',NULL,NULL,1,'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),(3,'d37017ce-62df-4034-aa60-0125e7d03a42','Apple',NULL,'30e43d9f-98a0-45bb-9bf0-a3fef1461e08',2,'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),(4,'08a7a812-32cd-4d61-ab47-480cd8b9d0b5','Mango',NULL,'30e43d9f-98a0-45bb-9bf0-a3fef1461e08',2,'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),(5,'62f43f7c-017e-4506-ab76-769e2d10dcc2','Mango',NULL,'30e43d9f-98a0-45bb-9bf0-a3fef1461e08',2,'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),(6,'399d30ca-dbaf-41e2-b685-bc675208b872','Pome',NULL,'d37017ce-62df-4034-aa60-0125e7d03a42',3,'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `nid` varchar(100) DEFAULT NULL,
  `org_id` varchar(255) NOT NULL,
  `store_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `commissionRate` int DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization` (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_id` varchar(255) DEFAULT NULL,
  `user_type` enum('ecommerce','enterprise') DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  `plan` enum('Free','Premium') DEFAULT 'Free',
  `plan_expiary` date DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `org_id` (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (1,'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','ecommerce','ACTIVE','Free','2025-05-12','2025-04-28 17:33:32');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization_info`
--

DROP TABLE IF EXISTS `organization_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `owner_name` varchar(255) NOT NULL,
  `number` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `type` enum('Clothing','Electronics','Grocery','Jewellery','Others') NOT NULL,
  `category_length` varchar(255) NOT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `createDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `organization_info_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_info`
--

LOCK TABLES `organization_info` WRITE;
/*!40000 ALTER TABLE `organization_info` DISABLE KEYS */;
INSERT INTO `organization_info` VALUES (1,'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','mshop','fahmida','01717638616','','','gec','Grocery','3','BDT','2025-04-28 17:35:16',NULL);
/*!40000 ALTER TABLE `organization_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` varchar(255) NOT NULL,
  `org_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `brand` varchar(255) NOT NULL,
  `supplier` varchar(255) NOT NULL,
  `description` mediumtext,
  `unit` varchar(255) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `stock_alert_qty` int NOT NULL,
  `rack` varchar(255) NOT NULL,
  `total_stock` int NOT NULL,
  `buying_price` int DEFAULT NULL,
  `selling_price` int DEFAULT NULL,
  `createDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `variation_id` varchar(255) NOT NULL,
  `image_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`),
  KEY `org_id` (`org_id`),
  KEY `category` (`category`),
  KEY `brand` (`brand`),
  KEY `supplier` (`supplier`),
  KEY `unit` (`unit`),
  KEY `rack` (`rack`),
  KEY `fk_variation` (`variation_id`),
  KEY `fk_product_image` (`image_id`),
  CONSTRAINT `fk_product_image` FOREIGN KEY (`image_id`) REFERENCES `product_image` (`image_id`),
  CONSTRAINT `fk_variation` FOREIGN KEY (`variation_id`) REFERENCES `variation` (`variation_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE,
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`category`) REFERENCES `category` (`category_id`) ON DELETE CASCADE,
  CONSTRAINT `product_ibfk_3` FOREIGN KEY (`brand`) REFERENCES `product_brand` (`brand_id`),
  CONSTRAINT `product_ibfk_4` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`supplier_id`),
  CONSTRAINT `product_ibfk_5` FOREIGN KEY (`unit`) REFERENCES `product_unit` (`unit_id`),
  CONSTRAINT `product_ibfk_6` FOREIGN KEY (`rack`) REFERENCES `product_rack` (`rack_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_brand`
--

DROP TABLE IF EXISTS `product_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_brand` (
  `id` int NOT NULL AUTO_INCREMENT,
  `brand_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `org_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `brand_id` (`brand_id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `product_brand_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_brand`
--

LOCK TABLES `product_brand` WRITE;
/*!40000 ALTER TABLE `product_brand` DISABLE KEYS */;
INSERT INTO `product_brand` VALUES (1,'662a9d35-1505-45fb-ba12-1dbbcd440a67','test','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),(2,'5b6087b0-31c4-49ba-884c-c25f0d43abca','test2','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),(3,'780e2399-7e84-43dc-be55-f355c5024500','test3','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e');
/*!40000 ALTER TABLE `product_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_image`
--

DROP TABLE IF EXISTS `product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_id` varchar(255) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `image_1` text,
  `image_2` text,
  `image_3` text,
  `image_4` text,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `idx_image_id` (`image_id`),
  CONSTRAINT `product_image_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_image`
--

LOCK TABLES `product_image` WRITE;
/*!40000 ALTER TABLE `product_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_rack`
--

DROP TABLE IF EXISTS `product_rack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_rack` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rack_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `org_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rack_id` (`rack_id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `product_rack_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_rack`
--

LOCK TABLES `product_rack` WRITE;
/*!40000 ALTER TABLE `product_rack` DISABLE KEYS */;
INSERT INTO `product_rack` VALUES (1,'bf461abf-5c69-4d97-893f-a177ca4cfc89','A1','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),(2,'92139f45-94a8-409f-a4a8-b19039c95362','A2','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e'),(3,'f85c4d89-8ea5-4fb0-a2c8-00d1289c2337','B1','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e');
/*!40000 ALTER TABLE `product_rack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_unit`
--

DROP TABLE IF EXISTS `product_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_unit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unit_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `org_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unit_id` (`unit_id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `product_unit_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_unit`
--

LOCK TABLES `product_unit` WRITE;
/*!40000 ALTER TABLE `product_unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_id` varchar(255) DEFAULT NULL,
  `role_id` varchar(255) NOT NULL,
  `role_name` varchar(255) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `role_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,NULL,'1','ADMIN','2025-04-28 17:31:16'),(2,NULL,'2','MANAGER','2025-04-28 17:31:16'),(3,NULL,'3','ACCOUNTANT','2025-04-28 17:31:16'),(4,NULL,'4','SALESMAN','2025-04-28 17:31:16'),(5,NULL,'5','SUPPORT','2025-04-28 17:31:16');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_access`
--

DROP TABLE IF EXISTS `role_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_access` (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_id` varchar(255) NOT NULL,
  `role_id` varchar(255) NOT NULL,
  `create_permission` text,
  `read_permission` text,
  `delete_permission` text,
  `update_permission` text,
  PRIMARY KEY (`id`),
  KEY `org_id` (`org_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `role_access_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE,
  CONSTRAINT `role_access_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_access`
--

LOCK TABLES `role_access` WRITE;
/*!40000 ALTER TABLE `role_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specification`
--

DROP TABLE IF EXISTS `specification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `specification_id` varchar(255) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `spec_name` text NOT NULL,
  `spec_value` text NOT NULL,
  `createDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `specification_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specification`
--

LOCK TABLES `specification` WRITE;
/*!40000 ALTER TABLE `specification` DISABLE KEYS */;
/*!40000 ALTER TABLE `specification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store` (
  `id` int NOT NULL AUTO_INCREMENT,
  `store_id` varchar(255) NOT NULL,
  `org_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `manager` varchar(255) NOT NULL,
  `number` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `type` enum('MOTHER','BRANCH') NOT NULL,
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `store_id` (`store_id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `store_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
INSERT INTO `store` VALUES (1,'STR25000','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','mshop','fahmida','01717638616','gec','MOTHER','ACTIVE','2025-04-28 17:35:16','USR25001');
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_history`
--

DROP TABLE IF EXISTS `subscription_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_id` varchar(255) NOT NULL,
  `plan` enum('FREE','BASIC','PREMIUM') DEFAULT 'FREE',
  `plan_start` date NOT NULL,
  `plan_end` date NOT NULL,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `subscription_history_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_history`
--

LOCK TABLES `subscription_history` WRITE;
/*!40000 ALTER TABLE `subscription_history` DISABLE KEYS */;
INSERT INTO `subscription_history` VALUES (1,'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','FREE','2025-04-28','2025-05-12','2025-04-28 17:33:32');
/*!40000 ALTER TABLE `subscription_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_payment`
--

DROP TABLE IF EXISTS `subscription_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_id` varchar(255) NOT NULL,
  `payment_id` varchar(255) NOT NULL,
  `subscription_plan` enum('FREE','PREMIUM') NOT NULL,
  `paid_amount` float NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `subscription_payment_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_payment`
--

LOCK TABLES `subscription_payment` WRITE;
/*!40000 ALTER TABLE `subscription_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_id` varchar(255) NOT NULL,
  `supplier_id` varchar(255) NOT NULL,
  `supplier_name` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `supplier_id` (`supplier_id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `supplier_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','69b694e2-d279-4394-bb46-77d59d73994a','mina');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `isComplete` enum('YES','NO') DEFAULT 'NO',
  `role_id` varchar(255) NOT NULL,
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `org_id` varchar(255) DEFAULT NULL,
  `store_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `number` (`number`),
  KEY `role_id` (`role_id`),
  KEY `org_id` (`org_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`) ON DELETE CASCADE,
  CONSTRAINT `user_ibfk_3` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'USR25001','mariya','01717638616','$2b$10$Gsg9152HHZ5OQIHBuum1qOCOg0Dio43jLNRKbMotnT0S59cHq.xRC','abc@gmail.com',NULL,'YES','1','ACTIVE','2025-04-28 17:33:32','ORG_396fa57b-7ac0-4061-8d59-d972fe8ae90e','STR25000');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation`
--

DROP TABLE IF EXISTS `variation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `variation_id` varchar(255) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `stock` int NOT NULL,
  `org_id` varchar(255) NOT NULL,
  `store_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variation_id` (`variation_id`),
  KEY `product_id` (`product_id`),
  KEY `org_id` (`org_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `variation_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `variation_ibfk_2` FOREIGN KEY (`org_id`) REFERENCES `organization` (`org_id`),
  CONSTRAINT `variation_ibfk_3` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation`
--

LOCK TABLES `variation` WRITE;
/*!40000 ALTER TABLE `variation` DISABLE KEYS */;
/*!40000 ALTER TABLE `variation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation_attribute`
--

DROP TABLE IF EXISTS `variation_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variation_attribute` (
  `id` int NOT NULL AUTO_INCREMENT,
  `variation_attribute_id` varchar(255) NOT NULL,
  `variation_id` varchar(255) NOT NULL,
  `attribute_id` varchar(255) NOT NULL,
  `attribute_value_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `variation_id` (`variation_id`),
  KEY `attribute_id` (`attribute_id`),
  KEY `attribute_value_id` (`attribute_value_id`),
  CONSTRAINT `variation_attribute_ibfk_1` FOREIGN KEY (`variation_id`) REFERENCES `variation` (`variation_id`) ON DELETE CASCADE,
  CONSTRAINT `variation_attribute_ibfk_2` FOREIGN KEY (`attribute_id`) REFERENCES `attribute` (`attribute_id`),
  CONSTRAINT `variation_attribute_ibfk_3` FOREIGN KEY (`attribute_value_id`) REFERENCES `attribute_value` (`attribute_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation_attribute`
--

LOCK TABLES `variation_attribute` WRITE;
/*!40000 ALTER TABLE `variation_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `variation_attribute` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-13 10:23:00
