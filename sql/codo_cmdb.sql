-- MySQL dump 10.14  Distrib 5.5.60-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: codo_cmdb
-- ------------------------------------------------------
-- Server version	5.7.24

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
-- Current Database: `codo_cmdb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `codo_cmdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `codo_cmdb`;

--
-- Table structure for table `assets_adminuser`
--

DROP TABLE IF EXISTS `assets_adminuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_adminuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `private_key` longtext COLLATE utf8mb4_unicode_ci,
  `comment` longtext COLLATE utf8mb4_unicode_ci,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_adminuser`
--

LOCK TABLES `assets_adminuser` WRITE;
/*!40000 ALTER TABLE `assets_adminuser` DISABLE KEYS */;
INSERT INTO `assets_adminuser` VALUES (6,'demo','demo','demo_password','','demo','2019-01-17 10:43:08.730334','2019-01-17 10:43:08.730384');
/*!40000 ALTER TABLE `assets_adminuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_book`
--

DROP TABLE IF EXISTS `assets_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `publisher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assets_book_publisher_id_bccf8a29_fk_assets_publisher_id` (`publisher_id`),
  CONSTRAINT `assets_book_publisher_id_bccf8a29_fk_assets_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `assets_publisher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_book`
--

LOCK TABLES `assets_book` WRITE;
/*!40000 ALTER TABLE `assets_book` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_dbserver`
--

DROP TABLE IF EXISTS `assets_dbserver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_dbserver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `port` int(11) DEFAULT NULL,
  `username` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idc` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `db_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `db_version` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `region` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `host` (`host`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_dbserver`
--

LOCK TABLES `assets_dbserver` WRITE;
/*!40000 ALTER TABLE `assets_dbserver` DISABLE KEYS */;
INSERT INTO `assets_dbserver` VALUES (4,'demo',3306,NULL,NULL,'other','MySQL','5.7','','master',NULL);
/*!40000 ALTER TABLE `assets_dbserver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_dbserver_group`
--

DROP TABLE IF EXISTS `assets_dbserver_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_dbserver_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dbserver_id` int(11) NOT NULL,
  `servergroup_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_dbserver_group_dbserver_id_servergroup_id_8b889ea3_uniq` (`dbserver_id`,`servergroup_id`),
  KEY `assets_dbserver_grou_servergroup_id_bbfbd520_fk_assets_se` (`servergroup_id`),
  CONSTRAINT `assets_dbserver_grou_servergroup_id_bbfbd520_fk_assets_se` FOREIGN KEY (`servergroup_id`) REFERENCES `assets_servergroup` (`id`),
  CONSTRAINT `assets_dbserver_group_dbserver_id_e5b4966c_fk_assets_dbserver_id` FOREIGN KEY (`dbserver_id`) REFERENCES `assets_dbserver` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_dbserver_group`
--

LOCK TABLES `assets_dbserver_group` WRITE;
/*!40000 ALTER TABLE `assets_dbserver_group` DISABLE KEYS */;
INSERT INTO `assets_dbserver_group` VALUES (5,4,9);
/*!40000 ALTER TABLE `assets_dbserver_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_dbserver_tag`
--

DROP TABLE IF EXISTS `assets_dbserver_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_dbserver_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dbserver_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_dbserver_tag_dbserver_id_tag_id_82952c1d_uniq` (`dbserver_id`,`tag_id`),
  KEY `assets_dbserver_tag_tag_id_9d0a001a_fk_assets_tag_id` (`tag_id`),
  CONSTRAINT `assets_dbserver_tag_dbserver_id_408a0981_fk_assets_dbserver_id` FOREIGN KEY (`dbserver_id`) REFERENCES `assets_dbserver` (`id`),
  CONSTRAINT `assets_dbserver_tag_tag_id_9d0a001a_fk_assets_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `assets_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_dbserver_tag`
--

LOCK TABLES `assets_dbserver_tag` WRITE;
/*!40000 ALTER TABLE `assets_dbserver_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets_dbserver_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_log`
--

DROP TABLE IF EXISTS `assets_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `host` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remote_ip` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `login_type` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `record_name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_log`
--

LOCK TABLES `assets_log` WRITE;
/*!40000 ALTER TABLE `assets_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_publisher`
--

DROP TABLE IF EXISTS `assets_publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_publisher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operator_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `assets_publisher_operator_id_b7b68402_fk_auth_user_id` (`operator_id`),
  CONSTRAINT `assets_publisher_operator_id_b7b68402_fk_auth_user_id` FOREIGN KEY (`operator_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_publisher`
--

LOCK TABLES `assets_publisher` WRITE;
/*!40000 ALTER TABLE `assets_publisher` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets_publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_recorderlog`
--

DROP TABLE IF EXISTS `assets_recorderlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_recorderlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` longtext COLLATE utf8mb4_unicode_ci,
  `log_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assets_recorderlog_log_id_50a42485_fk_assets_log_id` (`log_id`),
  CONSTRAINT `assets_recorderlog_log_id_50a42485_fk_assets_log_id` FOREIGN KEY (`log_id`) REFERENCES `assets_log` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_recorderlog`
--

LOCK TABLES `assets_recorderlog` WRITE;
/*!40000 ALTER TABLE `assets_recorderlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets_recorderlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_server`
--

DROP TABLE IF EXISTS `assets_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `idc` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpu` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `memory` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os_platform` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `os_distribution` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os_version` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sn` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `admin_user_id` int(11) DEFAULT NULL,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `public_key` tinyint(1) DEFAULT NULL,
  `region` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  KEY `assets_server_admin_user_id_a5768e2c_fk_assets_adminuser_id` (`admin_user_id`),
  CONSTRAINT `assets_server_admin_user_id_a5768e2c_fk_assets_adminuser_id` FOREIGN KEY (`admin_user_id`) REFERENCES `assets_adminuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_server`
--

LOCK TABLES `assets_server` WRITE;
/*!40000 ALTER TABLE `assets_server` DISABLE KEYS */;
INSERT INTO `assets_server` VALUES (4,'demo','1.1.1.1',22,'aliyun','','','','Linux','','','','','2019-01-16 19:00:07.573978','2019-01-16 19:00:07.574062',NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `assets_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_server_group`
--

DROP TABLE IF EXISTS `assets_server_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_server_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) NOT NULL,
  `servergroup_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_server_group_server_id_servergroup_id_fa38c6b1_uniq` (`server_id`,`servergroup_id`),
  KEY `assets_server_group_servergroup_id_361d4db5_fk_assets_se` (`servergroup_id`),
  CONSTRAINT `assets_server_group_server_id_9b0d5fe6_fk_assets_server_id` FOREIGN KEY (`server_id`) REFERENCES `assets_server` (`id`),
  CONSTRAINT `assets_server_group_servergroup_id_361d4db5_fk_assets_se` FOREIGN KEY (`servergroup_id`) REFERENCES `assets_servergroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_server_group`
--

LOCK TABLES `assets_server_group` WRITE;
/*!40000 ALTER TABLE `assets_server_group` DISABLE KEYS */;
INSERT INTO `assets_server_group` VALUES (6,4,9);
/*!40000 ALTER TABLE `assets_server_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_server_tag`
--

DROP TABLE IF EXISTS `assets_server_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_server_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_server_tag_server_id_tag_id_f7f134a5_uniq` (`server_id`,`tag_id`),
  KEY `assets_server_tag_tag_id_e9e21798_fk_assets_tag_id` (`tag_id`),
  CONSTRAINT `assets_server_tag_server_id_d316a370_fk_assets_server_id` FOREIGN KEY (`server_id`) REFERENCES `assets_server` (`id`),
  CONSTRAINT `assets_server_tag_tag_id_e9e21798_fk_assets_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `assets_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_server_tag`
--

LOCK TABLES `assets_server_tag` WRITE;
/*!40000 ALTER TABLE `assets_server_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets_server_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_serverauthrule`
--

DROP TABLE IF EXISTS `assets_serverauthrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_serverauthrule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_serverauthrule`
--

LOCK TABLES `assets_serverauthrule` WRITE;
/*!40000 ALTER TABLE `assets_serverauthrule` DISABLE KEYS */;
INSERT INTO `assets_serverauthrule` VALUES (5,'demo','[\"admin\"]','');
/*!40000 ALTER TABLE `assets_serverauthrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_serverauthrule_server`
--

DROP TABLE IF EXISTS `assets_serverauthrule_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_serverauthrule_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverauthrule_id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_serverauthrule_se_serverauthrule_id_server_009ce2c3_uniq` (`serverauthrule_id`,`server_id`),
  KEY `assets_serverauthrul_server_id_503dd3df_fk_assets_se` (`server_id`),
  CONSTRAINT `assets_serverauthrul_server_id_503dd3df_fk_assets_se` FOREIGN KEY (`server_id`) REFERENCES `assets_server` (`id`),
  CONSTRAINT `assets_serverauthrul_serverauthrule_id_76b392b3_fk_assets_se` FOREIGN KEY (`serverauthrule_id`) REFERENCES `assets_serverauthrule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_serverauthrule_server`
--

LOCK TABLES `assets_serverauthrule_server` WRITE;
/*!40000 ALTER TABLE `assets_serverauthrule_server` DISABLE KEYS */;
INSERT INTO `assets_serverauthrule_server` VALUES (5,5,4);
/*!40000 ALTER TABLE `assets_serverauthrule_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_serverauthrule_servergroup`
--

DROP TABLE IF EXISTS `assets_serverauthrule_servergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_serverauthrule_servergroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverauthrule_id` int(11) NOT NULL,
  `servergroup_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_serverauthrule_se_serverauthrule_id_server_a8aabff8_uniq` (`serverauthrule_id`,`servergroup_id`),
  KEY `assets_serverauthrul_servergroup_id_45d69fa2_fk_assets_se` (`servergroup_id`),
  CONSTRAINT `assets_serverauthrul_serverauthrule_id_6d05e40e_fk_assets_se` FOREIGN KEY (`serverauthrule_id`) REFERENCES `assets_serverauthrule` (`id`),
  CONSTRAINT `assets_serverauthrul_servergroup_id_45d69fa2_fk_assets_se` FOREIGN KEY (`servergroup_id`) REFERENCES `assets_servergroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_serverauthrule_servergroup`
--

LOCK TABLES `assets_serverauthrule_servergroup` WRITE;
/*!40000 ALTER TABLE `assets_serverauthrule_servergroup` DISABLE KEYS */;
INSERT INTO `assets_serverauthrule_servergroup` VALUES (3,5,9);
/*!40000 ALTER TABLE `assets_serverauthrule_servergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_servergroup`
--

DROP TABLE IF EXISTS `assets_servergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_servergroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_servergroup`
--

LOCK TABLES `assets_servergroup` WRITE;
/*!40000 ALTER TABLE `assets_servergroup` DISABLE KEYS */;
INSERT INTO `assets_servergroup` VALUES (9,'demo','');
/*!40000 ALTER TABLE `assets_servergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_tag`
--

DROP TABLE IF EXISTS `assets_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_tag`
--

LOCK TABLES `assets_tag` WRITE;
/*!40000 ALTER TABLE `assets_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets_ttylog`
--

DROP TABLE IF EXISTS `assets_ttylog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_ttylog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` datetime(6) NOT NULL,
  `cmd` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `log_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assets_ttylog_log_id_d4ae7312_fk_assets_log_id` (`log_id`),
  CONSTRAINT `assets_ttylog_log_id_d4ae7312_fk_assets_log_id` FOREIGN KEY (`log_id`) REFERENCES `assets_log` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_ttylog`
--

LOCK TABLES `assets_ttylog` WRITE;
/*!40000 ALTER TABLE `assets_ttylog` DISABLE KEYS */;
INSERT INTO `assets_ttylog` VALUES (1,'2018-12-25 17:06:55.781456','ifconfig',NULL),(2,'2018-12-25 17:06:57.725969','up time',NULL),(3,'2018-12-25 17:06:59.653647','exit',NULL),(4,'2018-12-25 17:14:36.311791','ifconfig',NULL),(5,'2018-12-25 17:34:43.044686','i[K',NULL),(6,'2018-12-25 17:34:46.701543','hh[K[Kfree -m',NULL),(7,'2018-12-25 17:34:50.117877','iso[K[Kostats',NULL),(8,'2018-12-25 17:34:52.541843','ll',NULL),(9,'2018-12-25 17:34:53.717790','cd',NULL),(10,'2018-12-26 15:01:35.495007','\r\n]0;root@ip-10-1-2-251:~[root@ip-10-1-2-251 ~]# \r\n]0;root@ip-10-1-2-251:~[root@ip-10-1-2-251 ~]# cl',NULL),(11,'2018-12-26 15:01:36.176329','\r\n]0;root@ip-10-1-2-251:~[root@ip-10-1-2-251 ~]# ',NULL),(12,'2018-12-26 15:02:12.779308','cl',NULL),(13,'2018-12-26 15:02:13.470147','\r\n]0;root@ip-10-1-2-251:~[root@ip-10-1-2-251 ~]# \r\n]0;root@ip-10-1-2-251:~[root@ip-10-1-2-251 ~]# ',NULL),(14,'2018-12-26 15:02:21.542782','\r\n]0;root@ip-10-1-2-251:~[root@ip-10-1-2-251 ~]# \r\n]0;root@ip-10-1-2-251:~[root@ip-10-1-2-251 ~]# cd /data[K[K[K[Kvar/www',NULL),(15,'2018-12-26 15:02:22.108934','l',NULL),(16,'2018-12-26 16:46:53.332976','l',NULL),(17,'2018-12-26 16:47:40.682427','cd /da[K[K[K[K[K[Kcd /root/.ss',NULL),(18,'2018-12-26 16:47:40.988186','h/',NULL),(19,'2018-12-26 16:47:45.294545','cat auy[Kthorized_keys ',NULL),(20,'2018-12-26 17:56:27.346677','ls',NULL),(21,'2018-12-26 17:56:28.907122','sudo su -',NULL),(22,'2018-12-26 17:56:32.832218','^Csudo: 1 incorrect password attempt\r\n]0;demo@CODO-Demo:~[demo@CODO-Demo ~]$ sudo su -',NULL),(23,'2018-12-26 17:56:37.248966','clear',NULL),(24,'2018-12-26 17:56:38.284070','ls -al',NULL),(25,'2018-12-26 18:00:51.098472','ls -al',NULL),(26,'2018-12-26 18:00:52.402208','pwd',NULL),(27,'2018-12-28 09:50:15.201820','ifconfig',NULL),(28,'2018-12-28 09:50:16.944734','exit',NULL),(29,'2018-12-28 09:50:42.440191','sudo su -',NULL),(30,'2018-12-28 09:50:43.920052','^C',NULL),(31,'2018-12-28 09:50:47.255890','^C^C^Csudo: 1 incorrect password attempt\r\n]0;demo@CODO-Demo:~[demo@CODO-Demo ~]$ ls',NULL),(32,'2018-12-28 09:50:48.111903','ll',NULL),(33,'2018-12-28 09:50:49.175153','cd /tmp/',NULL),(34,'2018-12-28 09:50:50.879294','lsl[K[K[Kll',NULL),(35,'2018-12-28 09:51:00.191693','ex[K[Ke[Krm -rf id_rsa.pub ',NULL),(36,'2018-12-28 09:51:01.431889','ll',NULL),(37,'2018-12-28 09:51:03.727082','ll',NULL),(38,'2018-12-28 09:51:05.614897','exit',NULL),(39,'2018-12-28 14:10:59.608179','ls',NULL),(40,'2018-12-28 14:11:00.692722','pwd',NULL),(41,'2018-12-28 17:51:35.107381','pwd',NULL),(42,'2018-12-28 18:01:26.593275','ifconfig',NULL),(43,'2018-12-28 18:04:38.826592','ls',NULL),(44,'2018-12-28 18:04:40.003314','clear',NULL),(45,'2018-12-28 18:04:40.636510','pwd',NULL),(46,'2018-12-28 18:05:23.174040','ac',NULL),(47,'2018-12-28 18:05:24.724806','ll',NULL),(48,'2018-12-28 18:05:26.180558','cd /',NULL),(49,'2018-12-28 18:05:27.846480',';l[K[Kls',NULL),(50,'2018-12-28 18:06:08.881295','ls',NULL),(51,'2018-12-28 18:06:09.726367','pwd',NULL),(52,'2018-12-28 18:06:11.028526','ifcpnfig',NULL),(53,'2018-12-28 18:06:11.791682','cla[K[K[Kcls',NULL),(54,'2018-12-28 18:06:13.250359','ifconfig',NULL),(55,'2018-12-28 18:06:13.603176','e[Kclear',NULL),(56,'2018-12-28 18:06:14.684053','pwd',NULL),(57,'2018-12-28 18:06:15.258105','ll',NULL),(58,'2018-12-28 18:06:16.725980','ifconfig[K[K[K[K[K[K[K[Khostname',NULL),(59,'2018-12-28 18:06:17.234602','cd /.[K',NULL),(60,'2018-12-28 18:06:17.239267','oifc[K[K[K[Kifconfig',NULL),(61,'2018-12-28 18:06:18.290443','ls',NULL),(62,'2018-12-28 18:06:19.510280','hostname',NULL),(63,'2018-12-28 18:06:21.260489','pwd',NULL),(64,'2018-12-28 18:06:29.268216','curl p[Kwww.goog[K[K[K[Kbaidu.com',NULL),(65,'2018-12-28 18:06:31.010230','pa -aux[K[K[K[K[K[K[Kps -aux',NULL),(66,'2018-12-28 18:06:36.914067','netstat -antp',NULL),(67,'2018-12-28 18:06:44.066211','exit',NULL),(68,'2018-12-28 18:08:50.255813','ll[Ks',NULL),(69,'2018-12-28 18:08:52.195746','ifconfig',NULL),(70,'2018-12-28 18:08:58.231693','ifc\r\nifcfg     ifconfig  \r\n[demo@CODO-Demo ~]$ ifc\r\nifcfg     ifconfig  \r\n[demo@CODO-Demo ~]$ ifconfig ',NULL),(71,'2018-12-28 18:12:16.250688','pwd',NULL),(72,'2018-12-28 18:12:16.770961','ls',NULL),(73,'2018-12-28 18:12:17.876405','clear',NULL),(74,'2018-12-28 18:12:18.599544','lf',NULL),(75,'2018-12-28 18:12:21.308975','cs [K[K[K',NULL),(76,'2018-12-28 18:12:23.289167','cd ',NULL),(77,'2018-12-28 18:12:25.365937','curl ',NULL),(78,'2018-12-28 18:12:27.096715','curl ',NULL),(79,'2018-12-28 18:12:28.210971','curl ',NULL),(80,'2018-12-28 18:12:29.051360','curl ',NULL),(81,'2018-12-28 18:12:29.385789','curl ',NULL),(82,'2018-12-28 18:12:29.631893','curl ',NULL),(83,'2018-12-28 18:12:29.864149','curl ',NULL),(84,'2018-12-28 18:12:30.406309','ls',NULL),(85,'2018-12-28 18:12:30.849838','ls',NULL),(86,'2018-12-28 18:12:31.124006','ls',NULL),(87,'2018-12-28 18:12:31.381783','ls',NULL),(88,'2018-12-28 18:12:31.659167','ls',NULL),(89,'2018-12-28 18:12:32.015165','ls',NULL),(90,'2018-12-28 18:12:33.883207','cd /tmp/',NULL),(91,'2018-12-28 18:12:34.155883','ls',NULL),(92,'2018-12-28 18:12:37.588378','catr [K[K[K [Kt cvm_init.log ',NULL),(93,'2018-12-28 18:12:41.809169','cat cvm_init.log ',NULL),(94,'2018-12-28 18:12:42.992567','cat cvm_init.log ',NULL),(95,'2018-12-28 18:12:43.450872','cat cvm_init.log ',NULL),(96,'2018-12-28 18:12:43.935323','cat cvm_init.log ',NULL),(97,'2018-12-28 18:12:44.384160','cat cvm_init.log ',NULL),(98,'2018-12-28 18:12:44.799853','cat cvm_init.log ',NULL),(99,'2018-12-28 18:12:45.221583','cat cvm_init.log ',NULL),(100,'2018-12-28 18:12:45.665991','cat cvm_init.log ',NULL),(101,'2018-12-28 18:12:47.945081','ls',NULL),(102,'2018-12-28 18:12:51.489578','cat setRps.log ',NULL),(103,'2018-12-28 18:12:53.488845','pwd',NULL),(104,'2018-12-28 18:12:53.914654','ls',NULL),(105,'2018-12-28 18:12:55.344567','ifconfig',NULL),(106,'2018-12-28 18:13:55.428439','ls',NULL),(107,'2018-12-28 18:13:56.448287','pwd',NULL),(108,'2018-12-28 18:13:57.635493','clear',NULL),(109,'2018-12-28 18:13:58.237395','ls',NULL),(110,'2018-12-28 18:21:49.224644','ifconfig ',NULL),(111,'2018-12-28 20:48:55.480954','ls',NULL),(112,'2018-12-28 20:48:56.494142','clear',NULL),(113,'2018-12-28 20:48:57.791542','pwd',NULL),(114,'2018-12-28 20:48:58.594339','ls',NULL),(115,'2018-12-28 20:49:07.058839','zheshi [K[K[K[K[K[K[Kecho \"\"1[K',NULL),(116,'2018-12-28 20:49:08.941388','ls -al',NULL),(117,'2018-12-28 20:49:13.148151','cd .[K[K[K[Kclaer',NULL),(118,'2018-12-28 20:49:14.306690','clear',NULL),(119,'2018-12-28 20:49:17.698388','ks[K[Kcd /home/',NULL),(120,'2018-12-28 20:49:18.088361','ls',NULL),(121,'2018-12-28 20:49:20.808580','cdde[K[K demo/',NULL),(122,'2018-12-28 20:49:21.193478','ls',NULL),(123,'2018-12-28 20:49:22.886849','ls -al',NULL),(124,'2018-12-28 20:49:33.903749','cd .bash[K[K[K[K[K[K[K[Kcat .bash_history ',NULL),(125,'2018-12-28 20:49:38.626643','ls -al',NULL),(126,'2018-12-28 20:49:40.088467','claer',NULL),(127,'2018-12-28 20:49:41.392476','clear',NULL),(128,'2018-12-28 20:49:41.906276','ls',NULL),(129,'2018-12-28 20:49:42.637693','ls',NULL),(130,'2018-12-28 20:49:43.494792','ls',NULL),(131,'2018-12-28 20:49:44.342193','pwd',NULL),(132,'2018-12-28 20:49:44.667717','ls',NULL),(133,'2018-12-28 20:49:46.257075','pwdl',NULL),(134,'2018-12-28 20:49:54.250195','ceshi[Ki shifou hui kasi ',NULL),(135,'2018-12-28 20:49:58.432093','ceshi [K[K[K[K[K[Kceshi ...',NULL),(136,'2018-12-28 20:50:19.549256','curi l[K[K[Kl -I httP/[K[Kp;//www.google.c[K[K[K[K[K[K[K[K[K[K[K[K[K[K[KL//[K[K[K//[K[K://www.qq.com',NULL),(137,'2018-12-28 20:50:28.837412','c',NULL),(138,'2018-12-28 20:50:29.905177','clear',NULL),(139,'2018-12-28 20:50:34.619825','clear',NULL),(140,'2018-12-28 20:59:17.048880','clear',NULL),(141,'2018-12-28 20:59:17.645803','pwd',NULL),(142,'2018-12-28 20:59:17.975133','ls',NULL),(143,'2018-12-28 20:59:19.708449','lsdlslds',NULL),(144,'2018-12-28 20:59:20.294114','lddls',NULL),(145,'2018-12-28 20:59:21.251221','dlsldlsdlls',NULL),(146,'2018-12-28 20:59:21.495618','ls',NULL),(147,'2018-12-28 20:59:21.717596','ls',NULL),(148,'2018-12-28 20:59:21.931373','dl',NULL),(149,'2018-12-28 20:59:22.155701','ld',NULL),(150,'2018-12-28 20:59:22.394276','ld: no input files\r\n]0;demo@CODO-Demo:~[demo@CODO-Demo ~]$ sld',NULL),(151,'2018-12-28 20:59:50.534229','clear',NULL),(152,'2018-12-28 20:59:51.462926','ls',NULL),(153,'2018-12-28 20:59:57.048889','ls',NULL),(154,'2018-12-28 20:59:58.317935','pwd',NULL),(155,'2018-12-28 21:00:00.010004','history ',NULL),(156,'2018-12-28 21:00:02.007293','clear',NULL),(157,'2018-12-28 21:00:04.245322','tree',NULL),(158,'2018-12-28 21:00:06.550886','ps uax',NULL),(159,'2018-12-28 21:00:08.369473','clear',NULL),(160,'2018-12-28 21:00:09.778287','who',NULL),(161,'2018-12-28 21:00:12.046303','last ',NULL),(162,'2018-12-28 21:00:12.939456',' m',NULL),(163,'2018-12-28 21:00:20.919271','clear',NULL),(164,'2018-12-29 10:49:36.146583','cd /tmp/',NULL),(165,'2018-12-29 10:49:36.435467','ls',NULL),(166,'2018-12-29 10:49:38.640898','cd yanghongfei_publish_code/',NULL),(167,'2018-12-29 10:49:38.987201','ls',NULL),(168,'2018-12-29 10:49:40.640381','cd do_cron/',NULL),(169,'2018-12-29 10:49:40.915613','ls',NULL),(170,'2018-12-29 10:49:45.603013','ls -al',NULL),(171,'2018-12-29 10:49:49.188640','date',NULL),(172,'2018-12-29 10:51:15.802015','service nginx restart start ',NULL),(173,'2018-12-29 10:51:24.959108','\r\n]0;demo@CODO-Demo:~[demo@CODO-Demo ~]$ echoi [K[K $?',NULL),(174,'2018-12-29 10:51:27.203207','echo $?',NULL),(175,'2018-12-29 10:51:28.693136','echo $?service nginx restart start ',NULL),(176,'2018-12-29 10:51:34.116889','\r\n\\',NULL),(177,'2018-12-29 10:51:51.603814','\r\n]0;demo@CODO-Demo:~[demo@CODO-Demo ~]$ sudo ser[K[K[Kservice nginx restart start ',NULL),(178,'2018-12-29 10:52:12.501426','ls -al',NULL),(179,'2018-12-29 10:52:14.558751','s[Ks[K',NULL),(180,'2018-12-29 10:52:22.762119','rm -rf ^C\r\n]0;demo@CODO-Demo:~[demo@CODO-Demo ~]$ mkdir -p /va w[K[Kr/www/1111.x',NULL),(181,'2018-12-29 10:52:23.893509','mkdir -p /var/www/1111.x',NULL),(182,'2018-12-29 10:52:25.527475','mkdir -p /var/www/1111.x111',NULL),(183,'2018-12-29 10:52:26.404027','mkdir -p /var/www/1111.x111',NULL),(184,'2018-12-29 10:52:45.587292','service nginx restart start ',NULL),(185,'2018-12-29 10:52:53.606038','^C\r\n]0;demo@CODO-Demo:~[demo@CODO-Demo ~]$ service nginx restart start [C[K[K[K[K[K[K[K',NULL),(186,'2018-12-29 10:53:32.162814','tauil[K[K[K[K[Ktail;f[K[Kf /var/log/messages .[K',NULL),(187,'2018-12-30 22:29:41.000053','history ',NULL),(188,'2018-12-30 22:29:50.448007','yum install nginx',NULL),(189,'2018-12-30 22:29:59.448397','sudo su -',NULL),(190,'2018-12-31 16:57:52.262322','w',NULL),(191,'2019-01-03 17:08:12.234678','ifconfig',NULL),(192,'2019-01-03 17:08:13.060485','\r\n]0;demo@CODO-Demo:~[demo@CODO-Demo ~]$ \\',NULL),(193,'2019-01-03 17:08:16.882487','free -m',NULL),(194,'2019-01-03 17:08:55.832305','ifcofnig',NULL),(195,'2019-01-03 17:09:02.935363','id[Kfcofnig',NULL),(196,'2019-01-03 17:09:05.815635','ifconfig',NULL),(197,'2019-01-03 17:09:20.526444','oooooooooooooooooooooooooooooooooooooooooooo',NULL),(198,'2019-01-03 17:09:22.198048','jjj',NULL),(199,'2019-01-03 17:09:23.477514','klk;kl;k;',NULL),(200,'2019-01-03 17:09:25.606023','jkljkljkl',NULL),(201,'2019-01-03 17:09:29.542929','fsfsfsfsfsfssfsfsfsf',NULL),(202,'2019-01-03 17:09:31.390086','fsf',NULL),(203,'2019-01-03 17:09:32.301079','fsfsf',NULL),(204,'2019-01-03 17:09:33.965431','fsfsfs',NULL),(205,'2019-01-03 17:18:08.575109','ifconfig',NULL),(206,'2019-01-03 17:29:16.696383','ls[K[Kfree -m',NULL),(207,'2019-01-03 17:29:19.137280','df -h',NULL),(208,'2019-01-03 17:29:28.379577','l[Kdock[K[K[K[Kdock[K[K[K[K',NULL),(209,'2019-01-03 17:29:30.901823','[H[2J[demo@CODO-Demo ~]$ ',NULL),(210,'2019-01-03 17:29:36.207792','ls',NULL),(211,'2019-01-03 18:06:23.970474','ifconfig',NULL),(212,'2019-01-04 15:51:35.792892','ls -al',NULL),(213,'2019-01-04 15:51:41.950497','nbe[K[K[Kwh[K[Klst [K[K[K[Klast | more',NULL),(214,'2019-01-07 10:48:33.751981','date',NULL),(215,'2019-01-07 10:48:37.060227','df -h',NULL),(216,'2019-01-07 10:48:43.618805','more /etc/passwd',NULL),(217,'2019-01-08 11:15:13.200553','ls',NULL),(218,'2019-01-08 11:15:24.524879','reboot[K[K[K[K[K[Kcd[K[Kcd /',NULL),(219,'2019-01-08 11:15:25.462117','ls',NULL),(220,'2019-01-08 11:15:31.103729','cd [K[K[Kw',NULL),(221,'2019-01-08 17:42:42.962764','ifconfig',NULL),(222,'2019-01-08 17:42:47.673329','lsusb',NULL),(223,'2019-01-08 17:42:55.721592','ssh root@8.8.8.8',NULL),(224,'2019-01-09 22:47:09.022849','d[Kcd /',NULL),(225,'2019-01-09 22:47:09.803938','ls',NULL),(226,'2019-01-09 22:47:12.621824','cd var/',NULL),(227,'2019-01-09 22:47:13.301548','ls',NULL),(228,'2019-01-10 15:37:29.051576','ls',NULL),(229,'2019-01-11 09:21:41.773352','ls',NULL),(230,'2019-01-11 10:06:00.337628','df -h',NULL),(231,'2019-01-11 10:37:17.917061','ks[K[Kls',NULL),(232,'2019-01-11 10:37:21.546511','ls /',NULL),(233,'2019-01-11 10:37:23.569306','ls',NULL),(234,'2019-01-11 11:08:17.332851','ls',NULL),(235,'2019-01-11 11:08:18.445464','pwd',NULL),(236,'2019-01-11 11:08:20.167392','exit',NULL),(237,'2019-01-11 11:10:09.192435','rebooyt',NULL),(238,'2019-01-11 11:10:10.887494','rebooyt[K[Kt',NULL),(239,'2019-01-11 11:10:30.708745','ll',NULL),(240,'2019-01-11 11:10:32.324111','\r\n]0;demo@CODO-Demo:~[demo@CODO-Demo ~]$ \\',NULL),(241,'2019-01-11 11:11:00.312811','sudo us -[K[K[K[Ksu - root',NULL),(242,'2019-01-11 11:11:05.827524','sudo su - root',NULL),(243,'2019-01-11 11:11:16.200704','s[Ks[Ks[Ksudo su - root[K[K[K[K[K[K[K[K[K-i',NULL),(244,'2019-01-11 11:11:17.815678','\r\n',NULL),(245,'2019-01-11 14:59:05.263570','ls',NULL),(246,'2019-01-13 00:09:35.094175','ls',NULL),(247,'2019-01-13 00:09:36.591771','exit',NULL),(248,'2019-01-13 16:29:57.194129','pwd',NULL),(249,'2019-01-13 16:29:57.819075','ll',NULL),(250,'2019-01-13 16:30:06.424034','p[Kping bao[Kidu.com',NULL),(251,'2019-01-13 16:30:09.444001','c^C\r\n--- baidu.com ping statistics ---\r\n3 packets transmitted, 3 received, 0% packet loss, time 2009ms\r\nrtt min/avg/max/mdev = 2.649/2.670/2.681/0.044 ms\r\n]0;demo@CODO-Demo:~[demo@CODO-Demo ~]$ ',NULL),(252,'2019-01-13 16:30:18.433971','gr[K[Kfree -h',NULL),(253,'2019-01-14 09:58:32.035392','111',NULL),(254,'2019-01-14 09:58:33.739533','111',NULL),(255,'2019-01-15 10:50:00.247164','df -h',NULL),(256,'2019-01-16 15:09:54.725503','ifconfig',NULL);
/*!40000 ALTER TABLE `assets_ttylog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add 书',7,'add_book'),(26,'Can change 书',7,'change_book'),(27,'Can delete 书',7,'delete_book'),(28,'Can view 书',7,'view_book'),(29,'Can add 出版社',8,'add_publisher'),(30,'Can change 出版社',8,'change_publisher'),(31,'Can delete 出版社',8,'delete_publisher'),(32,'Can view 出版社',8,'view_publisher'),(33,'Can add 管理用户',9,'add_adminuser'),(34,'Can change 管理用户',9,'change_adminuser'),(35,'Can delete 管理用户',9,'delete_adminuser'),(36,'Can view 管理用户',9,'view_adminuser'),(37,'Can add 服务器',10,'add_server'),(38,'Can change 服务器',10,'change_server'),(39,'Can delete 服务器',10,'delete_server'),(40,'Can view 服务器',10,'view_server'),(41,'Can add 服务器组',11,'add_servergroup'),(42,'Can change 服务器组',11,'change_servergroup'),(43,'Can delete 服务器组',11,'delete_servergroup'),(44,'Can view 服务器组',11,'view_servergroup'),(45,'Can add 登录日志',12,'add_log'),(46,'Can change 登录日志',12,'change_log'),(47,'Can delete 登录日志',12,'delete_log'),(48,'Can view 登录日志',12,'view_log'),(49,'Can add 操作日志',13,'add_ttylog'),(50,'Can change 操作日志',13,'change_ttylog'),(51,'Can delete 操作日志',13,'delete_ttylog'),(52,'Can view 操作日志',13,'view_ttylog'),(53,'Can add Tag标签',14,'add_tag'),(54,'Can change Tag标签',14,'change_tag'),(55,'Can delete Tag标签',14,'delete_tag'),(56,'Can view Tag标签',14,'view_tag'),(57,'Can add 回放日志',15,'add_recorderlog'),(58,'Can change 回放日志',15,'change_recorderlog'),(59,'Can delete 回放日志',15,'delete_recorderlog'),(60,'Can view 回放日志',15,'view_recorderlog'),(61,'Can add 资产授权规则',16,'add_serverauthrule'),(62,'Can change 资产授权规则',16,'change_serverauthrule'),(63,'Can delete 资产授权规则',16,'delete_serverauthrule'),(64,'Can view 资产授权规则',16,'view_serverauthrule'),(65,'Can add 数据库',17,'add_dbserver'),(66,'Can change 数据库',17,'change_dbserver'),(67,'Can delete 数据库',17,'delete_dbserver'),(68,'Can view 数据库',17,'view_dbserver');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$120000$i5mizvWjM1oq$7T0udvVr5mIuyWSH3FNBw00wTZc9CkdXPaWMykps9jc=','2019-01-16 18:29:04.897314',1,'admin','','','',1,1,'2019-01-16 18:29:00.574420');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2019-01-16 18:29:32.510507','160','demo:[web]',3,'',12,1),(2,'2019-01-16 18:29:32.511657','159','demo:[web]',3,'',12,1),(3,'2019-01-16 18:29:32.515738','158','demo:[web]',3,'',12,1),(4,'2019-01-16 18:29:32.517105','157','demo:[web]',3,'',12,1),(5,'2019-01-16 18:29:32.518137','156','demo:[web]',3,'',12,1),(6,'2019-01-16 18:29:32.519130','155','demo:[web]',3,'',12,1),(7,'2019-01-16 18:29:32.519899','154','demo:[web]',3,'',12,1),(8,'2019-01-16 18:29:32.520650','153','demo:[web]',3,'',12,1),(9,'2019-01-16 18:29:32.521239','152','demo:[web]',3,'',12,1),(10,'2019-01-16 18:29:32.521936','151','demo:[web]',3,'',12,1),(11,'2019-01-16 18:29:32.522547','150','demo:[web]',3,'',12,1),(12,'2019-01-16 18:29:32.523413','149','demo:[web]',3,'',12,1),(13,'2019-01-16 18:29:32.524445','148','demo:[web]',3,'',12,1),(14,'2019-01-16 18:29:32.525142','147','demo:[web]',3,'',12,1),(15,'2019-01-16 18:29:32.525891','146','demo:[web]',3,'',12,1),(16,'2019-01-16 18:29:32.526729','145','demo:[web]',3,'',12,1),(17,'2019-01-16 18:29:32.527662','144','demo:[web]',3,'',12,1),(18,'2019-01-16 18:29:32.528431','143','demo:[web]',3,'',12,1),(19,'2019-01-16 18:29:32.529127','142','demo:[web]',3,'',12,1),(20,'2019-01-16 18:29:32.529845','141','demo:[web]',3,'',12,1),(21,'2019-01-16 18:29:32.530826','140','demo:[web]',3,'',12,1),(22,'2019-01-16 18:29:32.531580','139','demo:[web]',3,'',12,1),(23,'2019-01-16 18:29:32.532529','138','demo:[web]',3,'',12,1),(24,'2019-01-16 18:29:32.533791','137','demo:[web]',3,'',12,1),(25,'2019-01-16 18:29:32.534712','136','demo:[web]',3,'',12,1),(26,'2019-01-16 18:29:32.535628','135','demo:[web]',3,'',12,1),(27,'2019-01-16 18:29:32.536420','134','demo:[web]',3,'',12,1),(28,'2019-01-16 18:29:32.537081','133','demo:[web]',3,'',12,1),(29,'2019-01-16 18:29:32.537875','132','demo:[web]',3,'',12,1),(30,'2019-01-16 18:29:32.538513','131','demo:[web]',3,'',12,1),(31,'2019-01-16 18:29:32.539168','130','demo:[web]',3,'',12,1),(32,'2019-01-16 18:29:32.539899','129','demo:[web]',3,'',12,1),(33,'2019-01-16 18:29:32.540902','128','demo:[web]',3,'',12,1),(34,'2019-01-16 18:29:32.541847','127','demo:[web]',3,'',12,1),(35,'2019-01-16 18:29:32.542821','126','demo:[web]',3,'',12,1),(36,'2019-01-16 18:29:32.543756','125','demo:[web]',3,'',12,1),(37,'2019-01-16 18:29:32.544545','124','demo:[web]',3,'',12,1),(38,'2019-01-16 18:29:32.545338','123','demo:[web]',3,'',12,1),(39,'2019-01-16 18:29:32.546426','122','demo:[web]',3,'',12,1),(40,'2019-01-16 18:29:32.547420','121','demo:[web]',3,'',12,1),(41,'2019-01-16 18:29:32.548692','120','demo:[web]',3,'',12,1),(42,'2019-01-16 18:29:32.549958','119','demo:[web]',3,'',12,1),(43,'2019-01-16 18:29:32.551523','118','demo:[web]',3,'',12,1),(44,'2019-01-16 18:29:32.553071','117','demo:[web]',3,'',12,1),(45,'2019-01-16 18:29:32.553926','116','demo:[web]',3,'',12,1),(46,'2019-01-16 18:29:32.555439','115','demo:[web]',3,'',12,1),(47,'2019-01-16 18:29:32.557516','114','demo:[web]',3,'',12,1),(48,'2019-01-16 18:29:32.558741','113','demo:[web]',3,'',12,1),(49,'2019-01-16 18:29:32.559687','112','demo:[web]',3,'',12,1),(50,'2019-01-16 18:29:32.560761','111','demo:[web]',3,'',12,1),(51,'2019-01-16 18:29:32.562364','110','demo:[web]',3,'',12,1),(52,'2019-01-16 18:29:32.563329','109','demo:[web]',3,'',12,1),(53,'2019-01-16 18:29:32.564511','108','demo:[web]',3,'',12,1),(54,'2019-01-16 18:29:32.565324','107','demo:[web]',3,'',12,1),(55,'2019-01-16 18:29:32.566159','106','demo:[web]',3,'',12,1),(56,'2019-01-16 18:29:32.567354','105','demo:[web]',3,'',12,1),(57,'2019-01-16 18:29:32.568323','104','demo:[web]',3,'',12,1),(58,'2019-01-16 18:29:32.569299','103','demo:[web]',3,'',12,1),(59,'2019-01-16 18:29:32.570375','102','demo:[web]',3,'',12,1),(60,'2019-01-16 18:29:32.571608','101','demo:[web]',3,'',12,1),(61,'2019-01-16 18:29:32.572533','100','demo:[web]',3,'',12,1),(62,'2019-01-16 18:29:32.574013','99','demo:[web]',3,'',12,1),(63,'2019-01-16 18:29:32.575088','98','demo:[web]',3,'',12,1),(64,'2019-01-16 18:29:32.576590','97','demo:[web]',3,'',12,1),(65,'2019-01-16 18:29:32.577356','96','demo:[web]',3,'',12,1),(66,'2019-01-16 18:29:32.578058','95','demo:[web]',3,'',12,1),(67,'2019-01-16 18:29:32.578854','94','demo:[web]',3,'',12,1),(68,'2019-01-16 18:29:32.580960','93','demo:[web]',3,'',12,1),(69,'2019-01-16 18:29:32.582040','92','demo:[web]',3,'',12,1),(70,'2019-01-16 18:29:32.583110','91','demo:[web]',3,'',12,1),(71,'2019-01-16 18:29:32.583996','90','demo:[web]',3,'',12,1),(72,'2019-01-16 18:29:32.584802','89','demo:[web]',3,'',12,1),(73,'2019-01-16 18:29:32.585404','88','demo:[web]',3,'',12,1),(74,'2019-01-16 18:29:32.586248','87','demo:[web]',3,'',12,1),(75,'2019-01-16 18:29:32.586856','86','demo:[web]',3,'',12,1),(76,'2019-01-16 18:29:32.587452','85','demo:[web]',3,'',12,1),(77,'2019-01-16 18:29:32.587975','84','demo:[web]',3,'',12,1),(78,'2019-01-16 18:29:32.588472','83','demo:[web]',3,'',12,1),(79,'2019-01-16 18:29:32.588975','82','demo:[web]',3,'',12,1),(80,'2019-01-16 18:29:32.589459','81','demo:[web]',3,'',12,1),(81,'2019-01-16 18:29:32.590070','80','demo:[web]',3,'',12,1),(82,'2019-01-16 18:29:32.590868','79','demo:[web]',3,'',12,1),(83,'2019-01-16 18:29:32.591431','78','demo:[web]',3,'',12,1),(84,'2019-01-16 18:29:32.591939','77','demo:[web]',3,'',12,1),(85,'2019-01-16 18:29:32.592424','76','demo:[web]',3,'',12,1),(86,'2019-01-16 18:29:32.592968','75','demo:[web]',3,'',12,1),(87,'2019-01-16 18:29:32.593531','74','demo:[web]',3,'',12,1),(88,'2019-01-16 18:29:32.594128','73','demo:[web]',3,'',12,1),(89,'2019-01-16 18:29:32.594850','72','demo:[web]',3,'',12,1),(90,'2019-01-16 18:29:32.595445','71','demo:[web]',3,'',12,1),(91,'2019-01-16 18:29:32.596024','70','demo:[web]',3,'',12,1),(92,'2019-01-16 18:29:32.596584','69','demo:[web]',3,'',12,1),(93,'2019-01-16 18:29:32.597274','68','demo:[web]',3,'',12,1),(94,'2019-01-16 18:29:32.597874','67','demo:[web]',3,'',12,1),(95,'2019-01-16 18:29:32.598408','66','demo:[web]',3,'',12,1),(96,'2019-01-16 18:29:32.599395','65','demo:[web]',3,'',12,1),(97,'2019-01-16 18:29:32.600168','64','demo:[web]',3,'',12,1),(98,'2019-01-16 18:29:32.600873','63','demo:[web]',3,'',12,1),(99,'2019-01-16 18:29:32.601515','62','demo:[web]',3,'',12,1),(100,'2019-01-16 18:29:32.602259','61','demo:[web]',3,'',12,1),(101,'2019-01-16 18:29:43.578007','60','demo:[web]',3,'',12,1),(102,'2019-01-16 18:29:43.579388','59','demo:[web]',3,'',12,1),(103,'2019-01-16 18:29:43.580527','58','demo:[web]',3,'',12,1),(104,'2019-01-16 18:29:43.583369','57','demo:[web]',3,'',12,1),(105,'2019-01-16 18:29:43.584242','56','demo:[web]',3,'',12,1),(106,'2019-01-16 18:29:43.584960','55','demo:[web]',3,'',12,1),(107,'2019-01-16 18:29:43.585576','54','demo:[web]',3,'',12,1),(108,'2019-01-16 18:29:43.586227','53','demo:[web]',3,'',12,1),(109,'2019-01-16 18:29:43.586732','52','demo:[web]',3,'',12,1),(110,'2019-01-16 18:29:43.587283','51','demo:[web]',3,'',12,1),(111,'2019-01-16 18:29:43.591015','50','demo:[web]',3,'',12,1),(112,'2019-01-16 18:29:43.591919','49','codo-demo:[web]',3,'',12,1),(113,'2019-01-16 18:29:43.592504','48','codo-demo:[web]',3,'',12,1),(114,'2019-01-16 18:29:43.593867','47','codo-demo:[web]',3,'',12,1),(115,'2019-01-16 18:29:43.607768','46','codo-demo:[web]',3,'',12,1),(116,'2019-01-16 18:29:43.608491','45','codo-demo:[web]',3,'',12,1),(117,'2019-01-16 18:29:43.609178','44','codo-demo:[web]',3,'',12,1),(118,'2019-01-16 18:29:43.609832','43','codo-demo:[web]',3,'',12,1),(119,'2019-01-16 18:29:43.610395','42','codo-demo:[web]',3,'',12,1),(120,'2019-01-16 18:29:43.611038','41','codo-demo:[web]',3,'',12,1),(121,'2019-01-16 18:29:43.611708','40','codo-demo:[web]',3,'',12,1),(122,'2019-01-16 18:29:43.612354','39','codo-demo:[web]',3,'',12,1),(123,'2019-01-16 18:29:43.613033','38','codo-demo:[web]',3,'',12,1),(124,'2019-01-16 18:29:43.613842','37','codo-demo:[web]',3,'',12,1),(125,'2019-01-16 18:29:43.614582','36','codo-demo:[web]',3,'',12,1),(126,'2019-01-16 18:29:43.615451','35','codo-demo:[web]',3,'',12,1),(127,'2019-01-16 18:29:43.616303','34','codo-demo:[web]',3,'',12,1),(128,'2019-01-16 18:29:43.616980','33','codo-demo:[web]',3,'',12,1),(129,'2019-01-16 18:29:43.617763','32','codo-demo:[web]',3,'',12,1),(130,'2019-01-16 18:29:43.618444','31','codo-demo:[web]',3,'',12,1),(131,'2019-01-16 18:29:43.619186','30','codo-demo:[web]',3,'',12,1),(132,'2019-01-16 18:29:43.619897','29','codo-demo:[web]',3,'',12,1),(133,'2019-01-16 18:29:43.628443','28','codo-demo:[web]',3,'',12,1),(134,'2019-01-16 18:29:43.629332','27','codo-demo:[web]',3,'',12,1),(135,'2019-01-16 18:29:43.630277','26','codo-demo:[web]',3,'',12,1),(136,'2019-01-16 18:29:43.630865','25','codo-demo:[web]',3,'',12,1),(137,'2019-01-16 18:29:43.632038','24','codo-demo:[web]',3,'',12,1),(138,'2019-01-16 18:29:43.632846','23','codo-demo:[web]',3,'',12,1),(139,'2019-01-16 18:29:43.633625','22','codo-demo:[web]',3,'',12,1),(140,'2019-01-16 18:29:43.634254','21','codo-demo:[web]',3,'',12,1),(141,'2019-01-16 18:29:43.635491','20','codo-demo:[web]',3,'',12,1),(142,'2019-01-16 18:29:43.636147','19','codo-demo:[web]',3,'',12,1),(143,'2019-01-16 18:29:43.636697','18','codo-demo:[web]',3,'',12,1),(144,'2019-01-16 18:29:43.637364','17','codo-demo:[web]',3,'',12,1),(145,'2019-01-16 18:29:43.638135','16','codo-demo:[web]',3,'',12,1),(146,'2019-01-16 18:29:43.638708','15','codo-demo:[web]',3,'',12,1),(147,'2019-01-16 18:29:43.639663','14','codo-demo:[web]',3,'',12,1),(148,'2019-01-16 18:29:43.640393','13','codo-demo:[web]',3,'',12,1),(149,'2019-01-16 18:29:43.641238','12','codo-demo:[web]',3,'',12,1),(150,'2019-01-16 18:29:43.641825','11','codo-demo:[web]',3,'',12,1),(151,'2019-01-16 18:29:43.642689','10','codo-demo:[web]',3,'',12,1),(152,'2019-01-16 18:29:43.643417','9','codo-demo:[web]',3,'',12,1),(153,'2019-01-16 18:29:43.644197','8','codo-demo:[web]',3,'',12,1),(154,'2019-01-16 18:29:43.644752','7','codo-demo:[web]',3,'',12,1),(155,'2019-01-16 18:29:43.645386','6','codo-demo:[web]',3,'',12,1),(156,'2019-01-16 18:29:43.646231','5','codo-demo:[web]',3,'',12,1),(157,'2019-01-16 18:29:43.647092','4','codo-demo:[web]',3,'',12,1),(158,'2019-01-16 18:29:43.648149','3','codo-demo:[web]',3,'',12,1),(159,'2019-01-16 18:29:43.648951','2','codo-demo:[web]',3,'',12,1),(160,'2019-01-16 18:29:43.649885','1','codo-demo:[web]',3,'',12,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(9,'assets','adminuser'),(7,'assets','book'),(17,'assets','dbserver'),(12,'assets','log'),(8,'assets','publisher'),(15,'assets','recorderlog'),(10,'assets','server'),(16,'assets','serverauthrule'),(11,'assets','servergroup'),(14,'assets','tag'),(13,'assets','ttylog'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (30,'contenttypes','0001_initial','2018-12-25 11:16:01.986142'),(31,'auth','0001_initial','2018-12-25 11:16:01.990653'),(32,'admin','0001_initial','2018-12-25 11:16:01.995020'),(33,'admin','0002_logentry_remove_auto_add','2018-12-25 11:16:01.997920'),(34,'admin','0003_logentry_add_action_flag_choices','2018-12-25 11:16:02.000986'),(35,'assets','0001_initial','2018-12-25 11:16:02.004024'),(36,'contenttypes','0002_remove_content_type_name','2018-12-25 11:16:02.006933'),(37,'auth','0002_alter_permission_name_max_length','2018-12-25 11:16:02.009774'),(38,'auth','0003_alter_user_email_max_length','2018-12-25 11:16:02.012580'),(39,'auth','0004_alter_user_username_opts','2018-12-25 11:16:02.017662'),(40,'auth','0005_alter_user_last_login_null','2018-12-25 11:16:02.020469'),(41,'auth','0006_require_contenttypes_0002','2018-12-25 11:16:02.023298'),(42,'auth','0007_alter_validators_add_error_messages','2018-12-25 11:16:02.026081'),(43,'auth','0008_alter_user_username_max_length','2018-12-25 11:16:02.028870'),(44,'auth','0009_alter_user_last_name_max_length','2018-12-25 11:16:02.031852'),(45,'sessions','0001_initial','2018-12-25 11:16:02.034718'),(46,'assets','0002_dbserver','2018-12-28 15:28:32.212890'),(47,'assets','0003_dbserver_role','2019-01-02 16:40:17.197205'),(48,'assets','0004_auto_20190109_1028','2019-01-09 10:28:36.304579');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('yry0xswnovccayjvzva6nsd83hhrx6s8','MzQyZTYzNGUzNjdjYmFiM2JmNDRiNmEwMzI0Y2Q1MDYxNzQxMWNlNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzEwM2NlNmZiYTJkZDAzYjRmMDExODRmZDM2NWI5NzE0Y2UzZjFjIn0=','2019-01-30 18:29:04.901363');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-17 11:08:32
