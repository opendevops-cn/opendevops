-- MySQL dump 10.14  Distrib 5.5.60-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: codo_cmdb
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_adminuser`
--

LOCK TABLES `assets_adminuser` WRITE;
/*!40000 ALTER TABLE `assets_adminuser` DISABLE KEYS */;
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
-- Table structure for table `assets_configs`
--

DROP TABLE IF EXISTS `assets_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_rsa` longtext COLLATE utf8mb4_unicode_ci,
  `id_rsa_pub` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_configs`
--

LOCK TABLES `assets_configs` WRITE;
/*!40000 ALTER TABLE `assets_configs` DISABLE KEYS */;
INSERT INTO `assets_configs` VALUES (2,'cmdb','-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEAqYpyVpzWTLTwOd7wGbeUU5+4WB+cGmh+yQU3wiycc99ps/c+\nK2fJn81PWZDnCmIZVbeDhaaPZpmV9dCXXgv1k6O/IZmZnY3xsVo7uBqpGpX+Kx2u\n/e1H3UnUxApOgYP1sfpgDwOnSU2FEnzMQVILj09V7+01PbixNrrJVxzmUgalZd09\nZfhTCbCDNlsr9i2YJxoMKy2rRTlir+x5G2KWjju2/ZqI+Q85ifqRmakQEYY8ed7s\nwWcG9HfBMs9KgFx6zm2bDc7f5/1VoF829eWyZnyoFBymzZi53QIhAie0EQv32SRT\nf4sUmi9ptUmoXxpQOBKGX44IrJI5uGzvVafeqQIDAQABAoIBAF8xIeOpqdVl3l/P\n4eW+oqSVUE8CaIaXV2CM8nKu06VnspTeZGTAoH9+KmhyqJa239y17j3TeD62S3G6\njdK7SkZ8MSuvb4X8FdFrhY5oQbxwrUYOI5vlZ21DMBhmZQ/pRMGKf/bOKVZKFUZ9\nFb4zT9RGSk0tVbBzC+Vb2QJ1coho0o4xRTvwvII0qNUCoFm07FKahI4Zt0KQXG3v\n+gJdO29JtIlx7xzv2mJExovxDtK0LX7Oqtw7Fqu/C+Ln8fg9Q02HP1BkMsJbZx0a\n465+0GL7H0I0Ii6tAB0c8Sx7NekDQT1p5tr76A/aPTIS3xFVx2v7lDe1BVg0O+b5\n8mfJSVECgYEA3J0t235m9s6/MewZrFCPYbRNSwLaG5CkKeulKhdUnMxp60mqc/Mu\nWrN2VP3ssnO5NAgY5L4yLt10fiYU846bQ2qb5qb7MvS97GDiZhQvJDj3PfzRDOtD\nv1rMkrMDzfvRQhGx04XiPgG/y214hrPlocwrEwnnOGOVqqzRpdtG070CgYEAxLwb\nniwfiD+GtPPhYkkkejMqGL/7a2MwBiNNd08VyjHgWeXUrmSUGoy/2nPm+sA5fhwa\nU2Ee2nox6Whv+eYigeprzGDY3xmYE3FUAAxO03U7NVxngNjMqa4teEJZtYjpISZw\nORqqZXYA1xjOsg/MpY9Q0HI+XAmcQ9SucbZ2b10CgYB3A4hIoAE15kT4zpDvB6rC\nH72O2OQG+NnHD6vTcDCiQhhl6SC+WpNINQaCRVYa0xk3e6LKS9zQsYF1yF+HIQib\nrviZzr03ORb4XS/lt7/Sv7SJyUiRup2aroYsIczMo6u5A8i1/sUVhGYOfWkG6ifY\nSEd4huAo6HhGUeLrocas1QKBgFilUeRxiTvBNBdxFItO3craJwvD5au7o7YATjWG\nQxE6bBbVwoFZ/IoCBaiPNPKjjsROMWaEinxzNu4vCtWVZtMXJ7+Nm+rbA3UvSWRE\nJ3iMiENBAbpC9eU3AHIBo55ytGklgseYRlM1WqeRHAGLsPCgpQ9nisW55tmBiaDf\nUHpZAoGAOeUHjZVdtMM0Pf/zPwNOZmzLwuAGLQwN6sOm05nYOXcyLXM65qKv0OrW\nJODRG0UjaYMJXm/fr1mxBChcN+VxCyB9yC2RNSeySNFwx9NHs9tbN21m2f2Y2ZyO\nGGitSoH/320gfWsEmZ7d9cvRxTAWw+80LPSiRUd48KaktlPiUK8=\n-----END RSA PRIVATE KEY-----\n','ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpinJWnNZMtPA53vAZt5RTn7hYH5waaH7JBTfCLJxz32mz9z4rZ8mfzU9ZkOcKYhlVt4OFpo9mmZX10JdeC/WTo78hmZmdjfGxWju4Gqkalf4rHa797UfdSdTECk6Bg/Wx+mAPA6dJTYUSfMxBUguPT1Xv7TU9uLE2uslXHOZSBqVl3T1l+FMJsIM2Wyv2LZgnGgwrLatFOWKv7HkbYpaOO7b9moj5DzmJ+pGZqRARhjx53uzBZwb0d8Eyz0qAXHrObZsNzt/n/VWgXzb15bJmfKgUHKbNmLndAiECJ7QRC/fZJFN/ixSaL2m1SahfGlA4EoZfjgiskjm4bO9Vp96p root@cmdb-exec01\n');
/*!40000 ALTER TABLE `assets_configs` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_dbserver`
--

LOCK TABLES `assets_dbserver` WRITE;
/*!40000 ALTER TABLE `assets_dbserver` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_dbserver_group`
--

LOCK TABLES `assets_dbserver_group` WRITE;
/*!40000 ALTER TABLE `assets_dbserver_group` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `username` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `public_key` tinyint(1) DEFAULT NULL,
  `admin_user_id` int(11) DEFAULT NULL,
  `region` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  KEY `assets_server_admin_user_id_a5768e2c_fk_assets_adminuser_id` (`admin_user_id`),
  CONSTRAINT `assets_server_admin_user_id_a5768e2c_fk_assets_adminuser_id` FOREIGN KEY (`admin_user_id`) REFERENCES `assets_adminuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_server`
--

LOCK TABLES `assets_server` WRITE;
/*!40000 ALTER TABLE `assets_server` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_server_group`
--

LOCK TABLES `assets_server_group` WRITE;
/*!40000 ALTER TABLE `assets_server_group` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_serverauthrule`
--

LOCK TABLES `assets_serverauthrule` WRITE;
/*!40000 ALTER TABLE `assets_serverauthrule` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_serverauthrule_server`
--

LOCK TABLES `assets_serverauthrule_server` WRITE;
/*!40000 ALTER TABLE `assets_serverauthrule_server` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_serverauthrule_servergroup`
--

LOCK TABLES `assets_serverauthrule_servergroup` WRITE;
/*!40000 ALTER TABLE `assets_serverauthrule_servergroup` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_servergroup`
--

LOCK TABLES `assets_servergroup` WRITE;
/*!40000 ALTER TABLE `assets_servergroup` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets_ttylog`
--

LOCK TABLES `assets_ttylog` WRITE;
/*!40000 ALTER TABLE `assets_ttylog` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
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

-- Dump completed on 2019-04-12 16:56:44
