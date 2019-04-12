-- MySQL dump 10.14  Distrib 5.5.60-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: codo_tools
-- ------------------------------------------------------
-- Server version	5.7.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `itsm_event_record`
--

DROP TABLE IF EXISTS `itsm_event_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itsm_event_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_status` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_level` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_processing` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_start_time` datetime NOT NULL,
  `event_end_time` datetime NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itsm_event_record`
--

LOCK TABLES `itsm_event_record` WRITE;
/*!40000 ALTER TABLE `itsm_event_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `itsm_event_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itsm_fault_info`
--

DROP TABLE IF EXISTS `itsm_fault_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itsm_fault_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fault_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fault_level` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fault_state` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fault_penson` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `processing_penson` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fault_report` longtext COLLATE utf8mb4_unicode_ci,
  `fault_start_time` datetime NOT NULL,
  `fault_end_time` datetime NOT NULL,
  `fault_issue` longtext COLLATE utf8mb4_unicode_ci,
  `fault_summary` longtext COLLATE utf8mb4_unicode_ci,
  `create_at` datetime NOT NULL,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itsm_fault_info`
--

LOCK TABLES `itsm_fault_info` WRITE;
/*!40000 ALTER TABLE `itsm_fault_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `itsm_fault_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itsm_paid_mg`
--

DROP TABLE IF EXISTS `itsm_paid_mg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itsm_paid_mg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paid_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paid_start_time` datetime NOT NULL,
  `paid_end_time` datetime NOT NULL,
  `reminder_day` int(11) NOT NULL,
  `nicknames` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime NOT NULL,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itsm_paid_mg`
--

LOCK TABLES `itsm_paid_mg` WRITE;
/*!40000 ALTER TABLE `itsm_paid_mg` DISABLE KEYS */;
/*!40000 ALTER TABLE `itsm_paid_mg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itsm_project_mg`
--

DROP TABLE IF EXISTS `itsm_project_mg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itsm_project_mg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_status` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_requester` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_processing` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_start_time` datetime NOT NULL,
  `project_end_time` datetime NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itsm_project_mg`
--

LOCK TABLES `itsm_project_mg` WRITE;
/*!40000 ALTER TABLE `itsm_project_mg` DISABLE KEYS */;
/*!40000 ALTER TABLE `itsm_project_mg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prometheus_alert`
--

DROP TABLE IF EXISTS `prometheus_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prometheus_alert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nicknames` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keyword` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alert_level` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_file` text COLLATE utf8mb4_unicode_ci,
  `create_at` datetime NOT NULL,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `keyword` (`keyword`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prometheus_alert`
--

LOCK TABLES `prometheus_alert` WRITE;
/*!40000 ALTER TABLE `prometheus_alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `prometheus_alert` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-12 16:57:22
