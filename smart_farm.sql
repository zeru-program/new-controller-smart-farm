/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.5.2-MariaDB, for Android (aarch64)
--
-- Host: localhost    Database: smart_farm
-- ------------------------------------------------------
-- Server version	11.5.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role` varchar(200) NOT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES
(1,44,'user','bbbb','$2y$10$yjBdDvDLTasbsaI.FCEn1ekG7FyYgke1YY3OIFJqO5cwHeSncEAzW','2024-09-25 18:49:32'),
(2,43,'user','zeru','$2y$10$DFxV2yOQcuIrzpycmmk95OfwjTUSiCWVvyDhbbXpFkxVlHiX37OH2','2024-09-25 18:50:48');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(200) NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(200) NOT NULL,
  `created_by` varchar(200) NOT NULL DEFAULT 'admin',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
INSERT INTO `alert` VALUES
(1,'plant','Testing alert','Lorem ipsum dolor mit sintace dodkekfjfjrkrkdkkfnfnfjfff','active','admin','2024-09-22 11:34:11'),
(2,'plant','Testing alert2','Lorem ipsum dolor mit sintace dodkekfjfjrkrkdkkfnfnfjfff','active','admin','2024-09-22 11:41:06'),
(3,'sensor','Testing alert3','lorem ipsum dolor mit','active','admin','2024-09-22 12:07:38'),
(4,'sensor','Testing alert4','lorem ipsum dolor mit','notactive','admin','2024-09-22 12:08:20');
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices_manager`
--

DROP TABLE IF EXISTS `devices_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices_manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_name` varchar(200) NOT NULL,
  `pin` int(11) NOT NULL,
  `type` varchar(200) NOT NULL,
  `kondisi` varchar(200) NOT NULL,
  `update_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices_manager`
--

LOCK TABLES `devices_manager` WRITE;
/*!40000 ALTER TABLE `devices_manager` DISABLE KEYS */;
INSERT INTO `devices_manager` VALUES
(1,'DHT',19,'dht11','active','2024-09-26 13:03:16'),
(2,'soil1',34,'moisture','active','2024-09-26 13:06:14'),
(3,'soil2',1,'moisture','inactive','2024-09-26 12:59:44'),
(4,'soil3',0,'moisture','inactive','2024-09-19 16:48:30'),
(5,'soil4',0,'moisture','inactive','2024-09-19 16:48:30'),
(6,'soil5',0,'moisture','inactive','2024-09-19 16:48:30'),
(7,'soil6',0,'moisture','inactive','2024-09-19 16:48:30'),
(8,'soil7',0,'moisture','inactive','2024-09-19 16:48:30'),
(9,'soil8',0,'moisture','inactive','2024-09-19 16:48:30'),
(10,'soil9',0,'moisture','inactive','2024-09-19 16:48:30'),
(11,'soil10',0,'moisture','inactive','2024-09-19 16:48:30'),
(12,'pump1',4,'pump','active','2024-09-21 14:21:28'),
(13,'pump2',0,'pump','inactive','2024-09-21 14:21:28'),
(14,'pump3',0,'pump','inactive','2024-09-21 14:21:28'),
(15,'pump4',0,'pump','inactive','2024-09-21 14:21:28'),
(16,'pump5',0,'pump','inactive','2024-09-21 14:21:28'),
(17,'pump6',0,'pump','inactive','2024-09-21 14:21:28'),
(18,'pump7',0,'pump','inactive','2024-09-21 14:21:28'),
(19,'pump8',0,'pump','inactive','2024-09-21 14:21:28'),
(20,'pump9',0,'pump','inactive','2024-09-21 14:21:28'),
(21,'pump10',0,'pump','inactive','2024-09-21 14:21:28'),
(22,'fan1',5,'fan','active','2024-09-21 14:22:55'),
(23,'fan2',0,'fan','inactive','2024-09-21 14:22:55'),
(24,'fan3',0,'fan','inactive','2024-09-21 14:22:55'),
(25,'fan4',0,'fan','inactive','2024-09-21 14:22:55'),
(26,'fan5',0,'fan','inactive','2024-09-21 14:22:55'),
(27,'fan6',0,'fan','inactive','2024-09-21 14:22:55'),
(28,'fan7',0,'fan','inactive','2024-09-21 14:22:55'),
(29,'fan8',0,'fan','inactive','2024-09-21 14:22:55'),
(30,'fan9',0,'fan','inactive','2024-09-21 14:22:55'),
(42,'fan10',0,'fan','inactive','2024-09-26 13:49:04');
/*!40000 ALTER TABLE `devices_manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices_relay`
--

DROP TABLE IF EXISTS `devices_relay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices_relay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_name` varchar(200) NOT NULL,
  `device_type` varchar(200) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `update_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices_relay`
--

LOCK TABLES `devices_relay` WRITE;
/*!40000 ALTER TABLE `devices_relay` DISABLE KEYS */;
INSERT INTO `devices_relay` VALUES
(1,'pump1','pump',0,'2024-09-26 13:27:23'),
(2,'fan1','fan',0,'2024-09-26 13:27:23');
/*!40000 ALTER TABLE `devices_relay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `farm_operation`
--

DROP TABLE IF EXISTS `farm_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `farm_operation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `system` varchar(200) NOT NULL,
  `updated_by` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farm_operation`
--

LOCK TABLES `farm_operation` WRITE;
/*!40000 ALTER TABLE `farm_operation` DISABLE KEYS */;
INSERT INTO `farm_operation` VALUES
(1,'manual','admin');
/*!40000 ALTER TABLE `farm_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otomatic_op`
--

DROP TABLE IF EXISTS `otomatic_op`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `otomatic_op` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temperature_mid` int(11) NOT NULL,
  `humidity_mid` int(11) NOT NULL,
  `moisture_mid` int(11) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otomatic_op`
--

LOCK TABLES `otomatic_op` WRITE;
/*!40000 ALTER TABLE `otomatic_op` DISABLE KEYS */;
/*!40000 ALTER TABLE `otomatic_op` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_op`
--

DROP TABLE IF EXISTS `schedule_op`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_op` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loops` int(11) NOT NULL DEFAULT 3,
  `duration_start` int(11) NOT NULL,
  `start1` int(11) NOT NULL,
  `start2` int(11) NOT NULL,
  `start3` int(11) NOT NULL,
  `updated_by` varchar(200) NOT NULL DEFAULT 'admin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_op`
--

LOCK TABLES `schedule_op` WRITE;
/*!40000 ALTER TABLE `schedule_op` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule_op` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smart_farm_data`
--

DROP TABLE IF EXISTS `smart_farm_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smart_farm_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temperature` float NOT NULL,
  `humidity` float NOT NULL,
  `moisture1` int(11) NOT NULL,
  `moisture2` int(11) NOT NULL,
  `moisture3` int(11) NOT NULL,
  `moisture4` int(11) NOT NULL,
  `moisture5` int(11) NOT NULL,
  `moisture6` int(11) NOT NULL,
  `moisture7` int(11) NOT NULL,
  `moisture8` int(11) NOT NULL,
  `moisture9` int(11) NOT NULL,
  `moisture10` int(11) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smart_farm_data`
--

LOCK TABLES `smart_farm_data` WRITE;
/*!40000 ALTER TABLE `smart_farm_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `smart_farm_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_esp`
--

DROP TABLE IF EXISTS `status_esp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status_esp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `esp_client` tinyint(1) NOT NULL,
  `esp_server` tinyint(1) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_esp`
--

LOCK TABLES `status_esp` WRITE;
/*!40000 ALTER TABLE `status_esp` DISABLE KEYS */;
INSERT INTO `status_esp` VALUES
(1,0,0,'2024-09-25 19:10:19'),
(2,1,1,'2024-09-25 19:17:51');
/*!40000 ALTER TABLE `status_esp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_server`
--

DROP TABLE IF EXISTS `status_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `update_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_server`
--

LOCK TABLES `status_server` WRITE;
/*!40000 ALTER TABLE `status_server` DISABLE KEYS */;
INSERT INTO `status_server` VALUES
(1,0,'2024-09-26 13:27:23');
/*!40000 ALTER TABLE `status_server` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2024-09-27 12:10:11
