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
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` varchar(200) NOT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices_manager`
--

DROP TABLE IF EXISTS `devices_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices_manager` (
  `id` int(11) NOT NULL,
  `device_name` varchar(200) NOT NULL,
  `pin` int(11) NOT NULL,
  `type` varchar(200) NOT NULL,
  `kondisi` varchar(200) NOT NULL,
  `update_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices_manager`
--

LOCK TABLES `devices_manager` WRITE;
/*!40000 ALTER TABLE `devices_manager` DISABLE KEYS */;
INSERT INTO `devices_manager` VALUES
(1,'DHT',19,'dht11','active','2024-09-19 16:48:30'),
(2,'soil1',34,'moisture','active','2024-09-19 16:48:30'),
(3,'soil2',0,'moisture','inactive','2024-09-19 16:48:30'),
(4,'soil3',0,'moisture','inactive','2024-09-19 16:48:30'),
(5,'soil4',0,'moisture','inactive','2024-09-19 16:48:30'),
(6,'soil5',0,'moisture','inactive','2024-09-19 16:48:30'),
(7,'soil6',0,'moisture','inactive','2024-09-19 16:48:30'),
(8,'soil7',0,'moisture','inactive','2024-09-19 16:48:30'),
(9,'soil8',0,'moisture','inactive','2024-09-19 16:48:30'),
(10,'soil9',0,'moisture','inactive','2024-09-19 16:48:30'),
(11,'soil10',0,'moisture','inactive','2024-09-19 16:48:30');
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
  `device_name` varchar(255) DEFAULT NULL,
  `device_type` enum('pump','fan') DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices_relay`
--

LOCK TABLES `devices_relay` WRITE;
/*!40000 ALTER TABLE `devices_relay` DISABLE KEYS */;
INSERT INTO `devices_relay` VALUES
(1,'pump1','pump',1,'2024-09-21 04:18:45'),
(2,'pump1','pump',1,'2024-09-21 04:23:30'),
(3,'fan1','fan',1,'2024-09-21 04:23:32'),
(4,'pump1','pump',0,'2024-09-21 04:23:43'),
(5,'pump1','pump',1,'2024-09-21 04:32:05'),
(6,'pump1','pump',0,'2024-09-21 04:32:09'),
(7,'fan1','fan',1,'2024-09-21 04:32:45'),
(8,'pump1','pump',1,'2024-09-21 04:32:46'),
(9,'pump1','pump',0,'2024-09-21 04:34:08'),
(10,'pump1','pump',1,'2024-09-21 04:35:05'),
(11,'fan1','fan',0,'2024-09-21 04:35:08'),
(12,'pump1','pump',0,'2024-09-21 04:35:13'),
(13,'pump1','pump',1,'2024-09-21 05:15:40'),
(14,'fan1','fan',1,'2024-09-21 05:16:14');
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farm_operation`
--

LOCK TABLES `farm_operation` WRITE;
/*!40000 ALTER TABLE `farm_operation` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smart_farm_data`
--

LOCK TABLES `smart_farm_data` WRITE;
/*!40000 ALTER TABLE `smart_farm_data` DISABLE KEYS */;
INSERT INTO `smart_farm_data` VALUES
(1,28.9,20.4,68,0,0,0,0,0,0,0,0,0,'2024-09-19 17:40:08');
/*!40000 ALTER TABLE `smart_farm_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2024-09-22  7:32:54
