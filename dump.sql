-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: cbb_db
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blood_banks`
--

DROP TABLE IF EXISTS `blood_banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_banks` (
  `name` varchar(60) NOT NULL,
  `hashed_password` varchar(128) NOT NULL,
  `city_id` varchar(60) NOT NULL,
  `id` varchar(60) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `blood_banks_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_banks`
--

LOCK TABLES `blood_banks` WRITE;
/*!40000 ALTER TABLE `blood_banks` DISABLE KEYS */;
INSERT INTO `blood_banks` VALUES ('Alex blood bank','$2b$12$ZFhqym27mmk4THGw4EqCWegMTW.00yDwiV5XO3VN97d1oK/bRx1l2','fafa5568-8a4a-40a6-8872-feef9ec1175e','4794be37-69c2-49ac-aa1d-8a17b3e15ff1','2024-08-01 00:16:13','2024-08-01 00:16:13'),('Cairo blood bank','$2b$12$gzWAr55dgXEJfYZl.frJ/.A7zHi/PycT.dZNhqNHBieQaVBuxKVde','a3f842e6-4ad5-4dd5-933b-f962118a62b8','4dacbd48-b0d5-4460-a596-5c693c70dfba','2024-08-01 00:16:13','2024-08-01 00:16:13');
/*!40000 ALTER TABLE `blood_banks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blood_donations`
--

DROP TABLE IF EXISTS `blood_donations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_donations` (
  `donor_id` varchar(60) NOT NULL,
  `blood_group_id` varchar(60) NOT NULL,
  `blood_bank_id` varchar(60) NOT NULL,
  `virus_test_result` tinyint(1) NOT NULL,
  `donation_date` datetime NOT NULL,
  `result` varchar(60) NOT NULL,
  `reason_for_rejection` varchar(60) DEFAULT NULL,
  `id` varchar(60) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `donor_id` (`donor_id`),
  KEY `blood_group_id` (`blood_group_id`),
  KEY `blood_bank_id` (`blood_bank_id`),
  CONSTRAINT `blood_donations_ibfk_1` FOREIGN KEY (`donor_id`) REFERENCES `donors` (`id`),
  CONSTRAINT `blood_donations_ibfk_2` FOREIGN KEY (`blood_group_id`) REFERENCES `blood_groups` (`id`),
  CONSTRAINT `blood_donations_ibfk_3` FOREIGN KEY (`blood_bank_id`) REFERENCES `blood_banks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_donations`
--

LOCK TABLES `blood_donations` WRITE;
/*!40000 ALTER TABLE `blood_donations` DISABLE KEYS */;
INSERT INTO `blood_donations` VALUES ('3d301414-454e-4f35-a698-aed2dd7a0ada','3f2ee63b-3175-4300-a928-ed0a025656f7','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2024-12-08 00:00:00','accepted','','009ff2a6-74a1-4f15-9e08-afd1e4ad762c','2024-08-01 00:32:02','2024-08-01 00:32:02'),('2abe3302-b51b-4ff8-99c0-d9ef25b0186c','1c963cef-490f-4aa6-914c-7b6a3ed65afd','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2025-01-15 00:00:00','accepted','','01bdb993-ed99-4f06-8ea5-6256881c8b02','2024-08-01 00:43:50','2024-08-01 00:43:50'),('2a27dca1-99a1-4739-9bfd-3b7201af6a3b','d6d6703a-e2fc-485f-aa28-bca021f3f769','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-01-01 00:00:00','accepted','','04b4d3d9-20be-4e99-8153-bf365348c358','2024-08-01 00:46:58','2024-08-01 00:46:58'),('3d301414-454e-4f35-a698-aed2dd7a0ada','3f2ee63b-3175-4300-a928-ed0a025656f7','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2025-05-09 00:00:00','accepted','','18ed8bdb-c14e-4595-8ef0-0aea4eb72ef1','2024-08-01 00:33:12','2024-08-01 00:33:12'),('5f423480-38dc-45d4-8fd2-905911a570ac','0e1aa518-9931-4ce7-b560-b60b24796986','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-04-04 00:00:00','accepted','','1b1cf7b1-20e4-452b-b81a-344c6cbe3785','2024-08-01 00:39:12','2024-08-01 00:39:12'),('4eae66f1-32be-4726-b55f-aea6125d3fd0','e2de5021-c92a-4ed5-bdf6-7af5fa7b5da0','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-12-01 00:00:00','accepted','','2d006856-65bf-4dde-b88a-b40912b3d9c1','2024-08-01 00:37:15','2024-08-01 00:37:15'),('b745773d-c0db-4bb3-b294-cc1e272f6ffc','4bae86c1-2f69-4469-9022-0c6a4cd6d9df','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-08-01 00:00:00','accepted','','2d2cf05b-8268-4e0e-a2df-d47cdd8358b9','2024-08-01 00:17:27','2024-08-01 00:17:27'),('b745773d-c0db-4bb3-b294-cc1e272f6ffc','4bae86c1-2f69-4469-9022-0c6a4cd6d9df','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-11-01 00:00:00','accepted','','2dcde50f-b623-4f0f-8a22-63f314c01a15','2024-08-01 00:21:04','2024-08-01 00:21:04'),('c1f750d5-13e4-4ee7-ad29-c45e22122d3b','9f2de63a-0eb3-493e-843f-5debb7a1494a','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2024-01-01 00:00:00','accepted','','31be241a-a01f-4944-88cd-c33d073f6747','2024-08-01 00:44:39','2024-08-01 00:44:39'),('b745773d-c0db-4bb3-b294-cc1e272f6ffc','4bae86c1-2f69-4469-9022-0c6a4cd6d9df','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2025-02-01 00:00:00','accepted','','40e3e01d-8b5f-4b80-bc25-e6a58898e8ed','2024-08-01 00:21:33','2024-08-01 00:21:33'),('3b305ad7-1007-4a5e-8f5b-3b5df5d58b5c','7fea1c22-ef66-4ddc-b9b1-6f9df8418b21','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2024-08-01 00:00:00','accepted','','508085c1-1373-4246-bf28-6409e33cf048','2024-08-01 00:25:53','2024-08-01 00:25:53'),('2abe3302-b51b-4ff8-99c0-d9ef25b0186c','1c963cef-490f-4aa6-914c-7b6a3ed65afd','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2024-07-07 00:00:00','accepted','','564002bd-bc23-441b-9ce1-889e6d586d9e','2024-08-01 00:42:47','2024-08-01 00:42:47'),('c1f750d5-13e4-4ee7-ad29-c45e22122d3b','9f2de63a-0eb3-493e-843f-5debb7a1494a','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2024-04-04 00:00:00','accepted','','6069c824-6427-446a-814a-113dbce01bf9','2024-08-01 00:44:57','2024-08-01 00:44:57'),('2abe3302-b51b-4ff8-99c0-d9ef25b0186c','1c963cef-490f-4aa6-914c-7b6a3ed65afd','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2024-10-10 00:00:00','accepted','','66915f7f-84ea-41ec-a42e-7499c26ce735','2024-08-01 00:43:08','2024-08-01 00:43:08'),('5f423480-38dc-45d4-8fd2-905911a570ac','0e1aa518-9931-4ce7-b560-b60b24796986','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-07-07 00:00:00','accepted','','7ce4a8d7-1af5-47ef-a075-27541ddf925a','2024-08-01 00:39:37','2024-08-01 00:39:37'),('b745773d-c0db-4bb3-b294-cc1e272f6ffc','4bae86c1-2f69-4469-9022-0c6a4cd6d9df','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2026-01-01 00:00:00','accepted','','7f807636-0ba0-4aec-8d3f-35ccaa63512b','2024-08-01 00:24:15','2024-08-01 00:24:15'),('3d301414-454e-4f35-a698-aed2dd7a0ada','3f2ee63b-3175-4300-a928-ed0a025656f7','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2024-08-01 00:00:00','accepted','','93238f45-f0b7-4ae4-9a5c-a734e4c77d97','2024-08-01 00:31:09','2024-08-01 00:31:09'),('3d301414-454e-4f35-a698-aed2dd7a0ada','3f2ee63b-3175-4300-a928-ed0a025656f7','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2025-08-15 00:00:00','accepted','','94b832d2-004f-4292-bbea-eb37f2a423fa','2024-08-01 00:33:47','2024-08-01 00:33:47'),('2a27dca1-99a1-4739-9bfd-3b7201af6a3b','d6d6703a-e2fc-485f-aa28-bca021f3f769','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2025-02-02 00:00:00','accepted','','9d3c6c62-3229-41b7-9254-16009d3b650c','2024-08-01 00:48:37','2024-08-01 00:48:37'),('b745773d-c0db-4bb3-b294-cc1e272f6ffc','4bae86c1-2f69-4469-9022-0c6a4cd6d9df','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2025-09-01 00:00:00','accepted','','a5ee6ea7-6495-473e-8ef0-00d7bffd74f4','2024-08-01 00:23:33','2024-08-01 00:23:33'),('c1f750d5-13e4-4ee7-ad29-c45e22122d3b','9f2de63a-0eb3-493e-843f-5debb7a1494a','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2024-10-10 00:00:00','accepted','','a63d7a33-b197-4c45-95c6-a5e26c5f6522','2024-08-01 00:45:47','2024-08-01 00:45:47'),('4eae66f1-32be-4726-b55f-aea6125d3fd0','e2de5021-c92a-4ed5-bdf6-7af5fa7b5da0','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-04-08 00:00:00','accepted','','acc61d60-cee2-4216-902a-50bfcaf581a2','2024-08-01 00:36:02','2024-08-01 00:36:02'),('2a27dca1-99a1-4739-9bfd-3b7201af6a3b','d6d6703a-e2fc-485f-aa28-bca021f3f769','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-10-10 00:00:00','accepted','','b0ca2c1f-065f-4acf-b6ed-bbadb38062b2','2024-08-01 00:47:48','2024-08-01 00:47:48'),('3b305ad7-1007-4a5e-8f5b-3b5df5d58b5c','7fea1c22-ef66-4ddc-b9b1-6f9df8418b21','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2025-02-02 00:00:00','accepted','','b7189707-4846-42df-b8b7-4ad26930192f','2024-08-01 00:27:48','2024-08-01 00:27:48'),('2abe3302-b51b-4ff8-99c0-d9ef25b0186c','1c963cef-490f-4aa6-914c-7b6a3ed65afd','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2024-04-04 00:00:00','accepted','','d5689055-c5e1-43de-bff8-b2da9d054299','2024-08-01 00:42:27','2024-08-01 00:42:27'),('5f423480-38dc-45d4-8fd2-905911a570ac','0e1aa518-9931-4ce7-b560-b60b24796986','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-10-10 00:00:00','accepted','','da750567-d569-4bc3-8a77-ac2b1e52c059','2024-08-01 00:40:06','2024-08-01 00:40:06'),('2a27dca1-99a1-4739-9bfd-3b7201af6a3b','d6d6703a-e2fc-485f-aa28-bca021f3f769','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-04-04 00:00:00','accepted','','dbc8928e-fd52-41a9-8ff1-0140f95dcf8a','2024-08-01 00:47:15','2024-08-01 00:47:15'),('3b305ad7-1007-4a5e-8f5b-3b5df5d58b5c','7fea1c22-ef66-4ddc-b9b1-6f9df8418b21','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2025-06-03 00:00:00','accepted','','e78d474f-fe74-4e7c-935f-25f33b045862','2024-08-01 00:29:51','2024-08-01 00:29:51'),('c1f750d5-13e4-4ee7-ad29-c45e22122d3b','9f2de63a-0eb3-493e-843f-5debb7a1494a','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2024-07-07 00:00:00','accepted','','e7973e44-4e55-40b9-9bc1-fe84e2b7fe36','2024-08-01 00:45:24','2024-08-01 00:45:24'),('2a27dca1-99a1-4739-9bfd-3b7201af6a3b','d6d6703a-e2fc-485f-aa28-bca021f3f769','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-07-07 00:00:00','accepted','','eb820142-eb55-4016-8dc8-2531ac82c5f8','2024-08-01 00:47:32','2024-08-01 00:47:32'),('5f423480-38dc-45d4-8fd2-905911a570ac','0e1aa518-9931-4ce7-b560-b60b24796986','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2025-01-15 00:00:00','accepted','','ed2863c0-55f8-4cec-bca5-a550bd82e948','2024-08-01 00:40:36','2024-08-01 00:40:36'),('5f423480-38dc-45d4-8fd2-905911a570ac','0e1aa518-9931-4ce7-b560-b60b24796986','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-01-01 00:00:00','accepted','','edf1dca7-81ff-45c9-9787-00af6f38eb91','2024-08-01 00:38:42','2024-08-01 00:38:42'),('4eae66f1-32be-4726-b55f-aea6125d3fd0','e2de5021-c92a-4ed5-bdf6-7af5fa7b5da0','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-01-08 00:00:00','accepted','','f5d91ada-3cfd-45ee-b14d-d2d196a66155','2024-08-01 00:35:19','2024-08-01 00:35:19'),('b745773d-c0db-4bb3-b294-cc1e272f6ffc','4bae86c1-2f69-4469-9022-0c6a4cd6d9df','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2025-06-01 00:00:00','accepted','','fadcb26f-c1da-4413-9d53-3f96e8184580','2024-08-01 00:22:13','2024-08-01 00:22:13'),('3b305ad7-1007-4a5e-8f5b-3b5df5d58b5c','7fea1c22-ef66-4ddc-b9b1-6f9df8418b21','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2024-11-02 00:00:00','accepted','','fb46057d-fa04-48a1-bfec-88f153061271','2024-08-01 00:27:09','2024-08-01 00:27:09'),('4eae66f1-32be-4726-b55f-aea6125d3fd0','e2de5021-c92a-4ed5-bdf6-7af5fa7b5da0','4dacbd48-b0d5-4460-a596-5c693c70dfba',0,'2024-08-09 00:00:00','accepted','','fb8f0528-3791-4609-a1a9-820a68d3286c','2024-08-01 00:36:41','2024-08-01 00:36:41'),('2abe3302-b51b-4ff8-99c0-d9ef25b0186c','1c963cef-490f-4aa6-914c-7b6a3ed65afd','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',0,'2024-01-01 00:00:00','accepted','','fe8aa567-7e01-422b-bac2-785e516bdd75','2024-08-01 00:42:01','2024-08-01 00:42:01');
/*!40000 ALTER TABLE `blood_donations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blood_groups`
--

DROP TABLE IF EXISTS `blood_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_groups` (
  `type` varchar(60) NOT NULL,
  `id` varchar(60) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_groups`
--

LOCK TABLES `blood_groups` WRITE;
/*!40000 ALTER TABLE `blood_groups` DISABLE KEYS */;
INSERT INTO `blood_groups` VALUES ('AB+','0e1aa518-9931-4ce7-b560-b60b24796986','2024-08-01 00:16:13','2024-08-01 00:16:13'),('AB-','1c963cef-490f-4aa6-914c-7b6a3ed65afd','2024-08-01 00:16:13','2024-08-01 00:16:13'),('B+','3f2ee63b-3175-4300-a928-ed0a025656f7','2024-08-01 00:16:13','2024-08-01 00:16:13'),('A+','4bae86c1-2f69-4469-9022-0c6a4cd6d9df','2024-08-01 00:16:13','2024-08-01 00:16:13'),('A-','7fea1c22-ef66-4ddc-b9b1-6f9df8418b21','2024-08-01 00:16:13','2024-08-01 00:16:13'),('O+','9f2de63a-0eb3-493e-843f-5debb7a1494a','2024-08-01 00:16:13','2024-08-01 00:16:13'),('O-','d6d6703a-e2fc-485f-aa28-bca021f3f769','2024-08-01 00:16:13','2024-08-01 00:16:13'),('B-','e2de5021-c92a-4ed5-bdf6-7af5fa7b5da0','2024-08-01 00:16:13','2024-08-01 00:16:13');
/*!40000 ALTER TABLE `blood_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blood_stock`
--

DROP TABLE IF EXISTS `blood_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_stock` (
  `blood_group_id` varchar(60) NOT NULL,
  `blood_bank_id` varchar(60) NOT NULL,
  `volume` int NOT NULL,
  `exp_date` datetime DEFAULT NULL,
  `id` varchar(60) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blood_group_id` (`blood_group_id`),
  KEY `blood_bank_id` (`blood_bank_id`),
  CONSTRAINT `blood_stock_ibfk_1` FOREIGN KEY (`blood_group_id`) REFERENCES `blood_groups` (`id`),
  CONSTRAINT `blood_stock_ibfk_2` FOREIGN KEY (`blood_bank_id`) REFERENCES `blood_banks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_stock`
--

LOCK TABLES `blood_stock` WRITE;
/*!40000 ALTER TABLE `blood_stock` DISABLE KEYS */;
INSERT INTO `blood_stock` VALUES ('e2de5021-c92a-4ed5-bdf6-7af5fa7b5da0','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-09-15 00:00:00','0894188f-7dd5-4eb8-ac1f-ba85bcc3197a','2024-08-01 00:36:59','2024-08-01 00:36:59'),('0e1aa518-9931-4ce7-b560-b60b24796986','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-02-15 00:00:00','0f56b270-1a83-4a5b-8892-08a061561645','2024-08-01 00:40:49','2024-08-01 00:40:49'),('d6d6703a-e2fc-485f-aa28-bca021f3f769','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-02-02 00:00:00','1d325791-726c-441d-9478-ac4645a64604','2024-08-01 00:47:03','2024-08-01 00:47:03'),('d6d6703a-e2fc-485f-aa28-bca021f3f769','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-08-08 00:00:00','1df70a23-4a52-4318-99e9-31110fbc21c0','2024-08-01 00:47:39','2024-08-01 00:47:39'),('4bae86c1-2f69-4469-9022-0c6a4cd6d9df','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-11-01 00:00:00','20518968-53c2-4f3c-9533-cf39ebe95fe9','2024-08-01 00:21:15','2024-08-01 00:21:15'),('1c963cef-490f-4aa6-914c-7b6a3ed65afd','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2024-08-08 00:00:00','2bb13e1e-48bc-49fe-b0c8-b3bf4385d382','2024-08-01 00:42:53','2024-08-01 00:42:53'),('1c963cef-490f-4aa6-914c-7b6a3ed65afd','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2024-05-05 00:00:00','2cd560e5-8892-48d7-b1ca-c3b095970371','2024-08-01 00:42:35','2024-08-01 00:42:35'),('7fea1c22-ef66-4ddc-b9b1-6f9df8418b21','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2024-12-07 00:00:00','3b6f2e32-8a8b-46f6-a901-738716e846f2','2024-08-01 00:27:25','2024-08-01 00:27:25'),('7fea1c22-ef66-4ddc-b9b1-6f9df8418b21','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2025-07-09 00:00:00','4187014f-34e1-4bb8-80ce-583de8d7b400','2024-08-01 00:30:12','2024-08-01 00:30:12'),('7fea1c22-ef66-4ddc-b9b1-6f9df8418b21','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2024-09-01 00:00:00','4187232c-8d24-4b24-bd70-2df720b9ce7c','2024-08-01 00:26:06','2024-08-01 00:26:06'),('9f2de63a-0eb3-493e-843f-5debb7a1494a','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2024-02-02 00:00:00','49838e13-641f-4f54-ade2-9a4695f463d5','2024-08-01 00:44:45','2024-08-01 00:44:45'),('9f2de63a-0eb3-493e-843f-5debb7a1494a','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2024-08-08 00:00:00','4b304774-74e3-42d1-9d68-0cd81fbf9330','2024-08-01 00:45:33','2024-08-01 00:45:33'),('3f2ee63b-3175-4300-a928-ed0a025656f7','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2025-06-15 00:00:00','4ca51676-7fe2-4a3d-9827-2071eac0e710','2024-08-01 00:33:25','2024-08-01 00:33:25'),('4bae86c1-2f69-4469-9022-0c6a4cd6d9df','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-09-01 00:00:00','5675e423-e32a-4b41-baa6-c8a83725f25d','2024-08-01 00:18:50','2024-08-01 00:18:50'),('d6d6703a-e2fc-485f-aa28-bca021f3f769','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-11-11 00:00:00','5cb317d2-bf23-42df-814f-05f12dd1a46f','2024-08-01 00:47:54','2024-08-01 00:47:54'),('4bae86c1-2f69-4469-9022-0c6a4cd6d9df','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2025-10-01 00:00:00','5df9f448-01af-4efa-b2ed-e67191cd3016','2024-08-01 00:23:44','2024-08-01 00:23:44'),('4bae86c1-2f69-4469-9022-0c6a4cd6d9df','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2025-06-01 00:00:00','883dae50-7233-47e6-b26a-4aa5360c3940','2024-08-01 00:22:28','2024-08-01 00:22:28'),('e2de5021-c92a-4ed5-bdf6-7af5fa7b5da0','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2025-01-01 00:00:00','89ff0168-f3cd-4b23-aa59-a1b6b11efe67','2024-08-01 00:37:25','2024-08-01 00:37:25'),('3f2ee63b-3175-4300-a928-ed0a025656f7','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2024-09-02 00:00:00','8c97fcab-4c90-4ca3-a201-21dcd4aa43c3','2024-08-01 00:31:19','2024-08-01 00:31:19'),('e2de5021-c92a-4ed5-bdf6-7af5fa7b5da0','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-05-08 00:00:00','a279fcd8-687c-4fa1-955d-9fa1a10fa1a7','2024-08-01 00:36:23','2024-08-01 00:36:23'),('0e1aa518-9931-4ce7-b560-b60b24796986','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-10-10 00:00:00','aafd583b-18ba-43ce-888c-f85a18eae9e6','2024-08-01 00:40:16','2024-08-01 00:40:16'),('1c963cef-490f-4aa6-914c-7b6a3ed65afd','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2024-02-02 00:00:00','af328377-340e-4d29-b527-ddf583c371f5','2024-08-01 00:42:14','2024-08-01 00:42:14'),('1c963cef-490f-4aa6-914c-7b6a3ed65afd','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2025-02-02 00:00:00','b1065572-2b46-41f5-aa1e-18a2bfdb6bf2','2024-08-01 00:43:59','2024-08-01 00:43:59'),('0e1aa518-9931-4ce7-b560-b60b24796986','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-01-01 00:00:00','b279b25b-f1b0-4b2c-872a-cd7c78a75ca4','2024-08-01 00:38:48','2024-08-01 00:38:48'),('9f2de63a-0eb3-493e-843f-5debb7a1494a','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2024-11-11 00:00:00','b3826133-a49b-4ac5-8d68-bfffb85cdfc0','2024-08-01 00:45:57','2024-08-01 00:45:57'),('d6d6703a-e2fc-485f-aa28-bca021f3f769','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2025-03-08 00:00:00','b8c64cdd-2e69-4b3b-8f81-1b606d1f9f65','2024-08-01 00:48:50','2024-08-01 00:48:50'),('d6d6703a-e2fc-485f-aa28-bca021f3f769','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-05-05 00:00:00','c2545bc4-57f5-4f2b-9dfc-6996d3484db7','2024-08-01 00:47:21','2024-08-01 00:47:21'),('4bae86c1-2f69-4469-9022-0c6a4cd6d9df','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2025-03-01 00:00:00','c3d96603-62f3-4853-8307-de35577be3aa','2024-08-01 00:21:44','2024-08-01 00:21:44'),('7fea1c22-ef66-4ddc-b9b1-6f9df8418b21','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2025-03-08 00:00:00','c423270e-8983-4f1c-883f-e1df92a43fcb','2024-08-01 00:28:06','2024-08-01 00:28:06'),('4bae86c1-2f69-4469-9022-0c6a4cd6d9df','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2026-02-01 00:00:00','c987b2e9-c129-42c4-8142-69df755cae3e','2024-08-01 00:24:31','2024-08-01 00:24:31'),('0e1aa518-9931-4ce7-b560-b60b24796986','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-01-01 00:00:00','c9c6b4e6-0719-415d-922d-a4adb8426a86','2024-08-01 00:39:19','2024-08-01 00:39:19'),('3f2ee63b-3175-4300-a928-ed0a025656f7','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2025-01-09 00:00:00','ca810c5c-c221-4940-a21f-354f78f43696','2024-08-01 00:32:28','2024-08-01 00:32:28'),('3f2ee63b-3175-4300-a928-ed0a025656f7','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2025-09-20 00:00:00','ced0724c-73f4-4da8-a3a6-8c6b9b160326','2024-08-01 00:34:10','2024-08-01 00:34:10'),('e2de5021-c92a-4ed5-bdf6-7af5fa7b5da0','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-02-07 00:00:00','dcb7d4a7-6c57-42bb-84fe-e2f1ec7be072','2024-08-01 00:35:45','2024-08-01 00:35:45'),('0e1aa518-9931-4ce7-b560-b60b24796986','4dacbd48-b0d5-4460-a596-5c693c70dfba',500,'2024-01-01 00:00:00','ebca5cc1-0f56-4f0f-b6e1-bb7182824a9b','2024-08-01 00:39:45','2024-08-01 00:39:45'),('9f2de63a-0eb3-493e-843f-5debb7a1494a','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2024-05-05 00:00:00','ffb343f2-ccc8-41e7-a84f-ac54d972b6d0','2024-08-01 00:45:10','2024-08-01 00:45:10'),('1c963cef-490f-4aa6-914c-7b6a3ed65afd','4794be37-69c2-49ac-aa1d-8a17b3e15ff1',500,'2024-11-11 00:00:00','ffe89ab5-3c52-434c-a684-c1cfd13e56d2','2024-08-01 00:43:15','2024-08-01 00:43:15');
/*!40000 ALTER TABLE `blood_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `name` varchar(60) NOT NULL,
  `id` varchar(60) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES ('Cairo','a3f842e6-4ad5-4dd5-933b-f962118a62b8','2024-08-01 00:16:12','2024-08-01 00:16:12'),('Alex','fafa5568-8a4a-40a6-8872-feef9ec1175e','2024-08-01 00:16:12','2024-08-01 00:16:12');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donors`
--

DROP TABLE IF EXISTS `donors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donors` (
  `name` varchar(60) NOT NULL,
  `national_id` varchar(60) NOT NULL,
  `blood_group_id` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `city_id` varchar(60) NOT NULL,
  `id` varchar(60) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `national_id` (`national_id`),
  UNIQUE KEY `email` (`email`),
  KEY `blood_group_id` (`blood_group_id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `donors_ibfk_1` FOREIGN KEY (`blood_group_id`) REFERENCES `blood_groups` (`id`),
  CONSTRAINT `donors_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donors`
--

LOCK TABLES `donors` WRITE;
/*!40000 ALTER TABLE `donors` DISABLE KEYS */;
INSERT INTO `donors` VALUES ('Amir','753','d6d6703a-e2fc-485f-aa28-bca021f3f769','r@r.com','a3f842e6-4ad5-4dd5-933b-f962118a62b8','2a27dca1-99a1-4739-9bfd-3b7201af6a3b','2024-08-01 00:46:44','2024-08-01 00:46:44'),('Aya','369','1c963cef-490f-4aa6-914c-7b6a3ed65afd','a@a.com','fafa5568-8a4a-40a6-8872-feef9ec1175e','2abe3302-b51b-4ff8-99c0-d9ef25b0186c','2024-08-01 00:41:46','2024-08-01 00:41:46'),('Ahmed Khaled','456','7fea1c22-ef66-4ddc-b9b1-6f9df8418b21','ak@ak.com','fafa5568-8a4a-40a6-8872-feef9ec1175e','3b305ad7-1007-4a5e-8f5b-3b5df5d58b5c','2024-08-01 00:25:44','2024-08-01 00:25:44'),('Mohamed Said','789','3f2ee63b-3175-4300-a928-ed0a025656f7','ms@ms.com','fafa5568-8a4a-40a6-8872-feef9ec1175e','3d301414-454e-4f35-a698-aed2dd7a0ada','2024-08-01 00:30:59','2024-08-01 00:30:59'),('Yasmin','147','e2de5021-c92a-4ed5-bdf6-7af5fa7b5da0','y@y.com','a3f842e6-4ad5-4dd5-933b-f962118a62b8','4eae66f1-32be-4726-b55f-aea6125d3fd0','2024-08-01 00:35:05','2024-08-01 00:35:05'),('Tamer','258','0e1aa518-9931-4ce7-b560-b60b24796986','t@t.com','a3f842e6-4ad5-4dd5-933b-f962118a62b8','5f423480-38dc-45d4-8fd2-905911a570ac','2024-08-01 00:38:33','2024-08-01 00:38:33'),('demo','123','4bae86c1-2f69-4469-9022-0c6a4cd6d9df','demo@demo.com','a3f842e6-4ad5-4dd5-933b-f962118a62b8','b745773d-c0db-4bb3-b294-cc1e272f6ffc','2024-08-01 00:17:20','2024-08-01 00:17:20'),('Omar','159','9f2de63a-0eb3-493e-843f-5debb7a1494a','o@o.com','fafa5568-8a4a-40a6-8872-feef9ec1175e','c1f750d5-13e4-4ee7-ad29-c45e22122d3b','2024-08-01 00:44:30','2024-08-01 00:44:30');
/*!40000 ALTER TABLE `donors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospitals`
--

DROP TABLE IF EXISTS `hospitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospitals` (
  `name` varchar(60) NOT NULL,
  `hashed_password` varchar(128) NOT NULL,
  `city_id` varchar(60) NOT NULL,
  `id` varchar(60) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `hospitals_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospitals`
--

LOCK TABLES `hospitals` WRITE;
/*!40000 ALTER TABLE `hospitals` DISABLE KEYS */;
INSERT INTO `hospitals` VALUES ('Cairo central hospital','$2b$12$q01l5JSl5d6bNhI8Ci1YsuJ/m..lKhiRFMmTH6nmeCykOQLk6V7eq','a3f842e6-4ad5-4dd5-933b-f962118a62b8','a2f8a606-a89c-4818-854e-f2c1ccd0028b','2024-08-01 00:16:13','2024-08-01 00:16:13'),('Alex central hospital','$2b$12$w9YjmDRMix7PqmcmC/uLE.XJqW77hDyEe/tekjzGdoQXQXyWRmzBq','fafa5568-8a4a-40a6-8872-feef9ec1175e','c9a1832f-b927-47e7-9dc3-aacba780dafc','2024-08-01 00:16:13','2024-08-01 00:16:13');
/*!40000 ALTER TABLE `hospitals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `name` varchar(60) NOT NULL,
  `hospital_id` varchar(60) NOT NULL,
  `blood_group_id` varchar(60) NOT NULL,
  `status` varchar(60) NOT NULL,
  `id` varchar(60) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hospital_id` (`hospital_id`),
  KEY `blood_group_id` (`blood_group_id`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`),
  CONSTRAINT `patients_ibfk_2` FOREIGN KEY (`blood_group_id`) REFERENCES `blood_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES ('Youssef','a2f8a606-a89c-4818-854e-f2c1ccd0028b','4bae86c1-2f69-4469-9022-0c6a4cd6d9df','Normal','06429e38-a9cf-46d3-910b-f352b0a8c7bd','2024-08-01 00:16:13','2024-08-01 00:16:13'),('Terry','a2f8a606-a89c-4818-854e-f2c1ccd0028b','d6d6703a-e2fc-485f-aa28-bca021f3f769','Normal','0dc5ad45-9ab9-4def-bd4c-d00920878933','2024-08-01 00:16:14','2024-08-01 00:16:14'),('Well','c9a1832f-b927-47e7-9dc3-aacba780dafc','1c963cef-490f-4aa6-914c-7b6a3ed65afd','Immediate','199aefe6-68ca-453e-923d-050dd4512372','2024-08-01 00:16:14','2024-08-01 00:16:14'),('Smith','c9a1832f-b927-47e7-9dc3-aacba780dafc','9f2de63a-0eb3-493e-843f-5debb7a1494a','Immediate','28eae27a-7705-4231-beb0-f0acdfbb1640','2024-08-01 00:16:14','2024-08-01 00:16:14'),('Yasser','c9a1832f-b927-47e7-9dc3-aacba780dafc','3f2ee63b-3175-4300-a928-ed0a025656f7','Immediate','3f8e101e-0041-4611-98e4-58c1b3e496f4','2024-08-01 00:16:13','2024-08-01 00:16:13'),('christian','a2f8a606-a89c-4818-854e-f2c1ccd0028b','e2de5021-c92a-4ed5-bdf6-7af5fa7b5da0','Normal','54807ec4-3ded-4120-a55c-cb8f49505b46','2024-08-01 00:16:13','2024-08-01 00:16:13'),('Yasser','a2f8a606-a89c-4818-854e-f2c1ccd0028b','3f2ee63b-3175-4300-a928-ed0a025656f7','Normal','693136b2-1f31-4e13-99ac-06d50bee2dfb','2024-08-01 00:16:13','2024-08-01 00:16:13'),('Tony','a2f8a606-a89c-4818-854e-f2c1ccd0028b','7fea1c22-ef66-4ddc-b9b1-6f9df8418b21','Normal','6bfbaaf2-c7ab-43d5-9a03-3bc757dd035f','2024-08-01 00:16:13','2024-08-01 00:16:13'),('Terry','c9a1832f-b927-47e7-9dc3-aacba780dafc','d6d6703a-e2fc-485f-aa28-bca021f3f769','Immediate','7316230c-4343-4486-8e90-c3dd71d63a02','2024-08-01 00:16:14','2024-08-01 00:16:14'),('christian','c9a1832f-b927-47e7-9dc3-aacba780dafc','e2de5021-c92a-4ed5-bdf6-7af5fa7b5da0','Immediate','943ff56c-f5a2-4496-85de-cfb40d0bfe43','2024-08-01 00:16:14','2024-08-01 00:16:14'),('Well','a2f8a606-a89c-4818-854e-f2c1ccd0028b','1c963cef-490f-4aa6-914c-7b6a3ed65afd','Normal','a386587a-5fd5-4faf-96c5-faebcf8b5d62','2024-08-01 00:16:14','2024-08-01 00:16:14'),('John','c9a1832f-b927-47e7-9dc3-aacba780dafc','0e1aa518-9931-4ce7-b560-b60b24796986','Immediate','adcd6101-c0dc-4c02-aa2e-3abc9ab70fa0','2024-08-01 00:16:13','2024-08-01 00:16:13'),('John','a2f8a606-a89c-4818-854e-f2c1ccd0028b','0e1aa518-9931-4ce7-b560-b60b24796986','Normal','b4ddfa38-176e-40d3-aab9-0050a56ec75e','2024-08-01 00:16:13','2024-08-01 00:16:13'),('Tony','c9a1832f-b927-47e7-9dc3-aacba780dafc','7fea1c22-ef66-4ddc-b9b1-6f9df8418b21','Immediate','b914c106-975a-437b-ab1d-1eca4a3819a5','2024-08-01 00:16:13','2024-08-01 00:16:13'),('Smith','a2f8a606-a89c-4818-854e-f2c1ccd0028b','9f2de63a-0eb3-493e-843f-5debb7a1494a','Normal','d1bbb590-0fb2-454e-ab3d-bc88b666bb96','2024-08-01 00:16:14','2024-08-01 00:16:14'),('Youssef','c9a1832f-b927-47e7-9dc3-aacba780dafc','4bae86c1-2f69-4469-9022-0c6a4cd6d9df','Immediate','d6fbb63f-b554-48bb-94f7-7a999f2e2ebd','2024-08-01 00:16:13','2024-08-01 00:16:13');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requests` (
  `quantity_required` int NOT NULL,
  `hospital_id` varchar(60) NOT NULL,
  `blood_group_id` varchar(60) NOT NULL,
  `patient_status` varchar(60) NOT NULL,
  `fulfilment_status` varchar(60) DEFAULT NULL,
  `request_date` datetime DEFAULT NULL,
  `id` varchar(60) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hospital_id` (`hospital_id`),
  KEY `blood_group_id` (`blood_group_id`),
  CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`),
  CONSTRAINT `requests_ibfk_2` FOREIGN KEY (`blood_group_id`) REFERENCES `blood_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-01  3:50:45
