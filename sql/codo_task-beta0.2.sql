-- MySQL dump 10.14  Distrib 5.5.60-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: codo_task
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
-- Table structure for table `asset_db`
--

DROP TABLE IF EXISTS `asset_db`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_db` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `db_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `db_host` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `db_port` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `db_user` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `db_pwd` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `db_env` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `proxy_host` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `db_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `db_mark` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `db_detail` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `all_dbs` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_db`
--

LOCK TABLES `asset_db` WRITE;
/*!40000 ALTER TABLE `asset_db` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_db` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_db_tag`
--

DROP TABLE IF EXISTS `asset_db_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_db_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `db_id` int(11) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_db_tag`
--

LOCK TABLES `asset_db_tag` WRITE;
/*!40000 ALTER TABLE `asset_db_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_db_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_proxy_info`
--

DROP TABLE IF EXISTS `asset_proxy_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_proxy_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `proxy_host` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `inception` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salt` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `proxy_host` (`proxy_host`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_proxy_info`
--

LOCK TABLES `asset_proxy_info` WRITE;
/*!40000 ALTER TABLE `asset_proxy_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_proxy_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_server`
--

DROP TABLE IF EXISTS `asset_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_server`
--

LOCK TABLES `asset_server` WRITE;
/*!40000 ALTER TABLE `asset_server` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_server_tag`
--

DROP TABLE IF EXISTS `asset_server_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_server_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_server_tag`
--

LOCK TABLES `asset_server_tag` WRITE;
/*!40000 ALTER TABLE `asset_server_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_server_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_tag`
--

DROP TABLE IF EXISTS `asset_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(35) COLLATE utf8mb4_unicode_ci NOT NULL,
  `users` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proxy_host` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_name` (`tag_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_tag`
--

LOCK TABLES `asset_tag` WRITE;
/*!40000 ALTER TABLE `asset_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_args_list`
--

DROP TABLE IF EXISTS `scheduler_args_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_args_list` (
  `args_id` int(11) NOT NULL AUTO_INCREMENT,
  `args_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `args_self` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`args_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_args_list`
--

LOCK TABLES `scheduler_args_list` WRITE;
/*!40000 ALTER TABLE `scheduler_args_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_args_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_cmd_list`
--

DROP TABLE IF EXISTS `scheduler_cmd_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_cmd_list` (
  `command_id` int(11) NOT NULL AUTO_INCREMENT,
  `command_name` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `command` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `args` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `force_host` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`command_id`),
  UNIQUE KEY `command_name` (`command_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_cmd_list`
--

LOCK TABLES `scheduler_cmd_list` WRITE;
/*!40000 ALTER TABLE `scheduler_cmd_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_cmd_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_execute_user`
--

DROP TABLE IF EXISTS `scheduler_execute_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_execute_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alias_user` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exec_user` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ssh_port` int(11) DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_key` text COLLATE utf8mb4_unicode_ci,
  `remarks` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alias_user` (`alias_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_execute_user`
--

LOCK TABLES `scheduler_execute_user` WRITE;
/*!40000 ALTER TABLE `scheduler_execute_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_execute_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_info`
--

DROP TABLE IF EXISTS `scheduler_task_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_info` (
  `sched_id` int(11) NOT NULL AUTO_INCREMENT,
  `list_id` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_group` int(11) DEFAULT NULL,
  `task_level` int(11) DEFAULT NULL,
  `task_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_cmd` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_args` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trigger` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exec_user` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `force_host` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exec_ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_status` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sched_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_info`
--

LOCK TABLES `scheduler_task_info` WRITE;
/*!40000 ALTER TABLE `scheduler_task_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_task_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_list`
--

DROP TABLE IF EXISTS `scheduler_task_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_list` (
  `list_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hosts` text COLLATE utf8mb4_unicode_ci,
  `args` text COLLATE utf8mb4_unicode_ci,
  `details` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `associated_user` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `executor` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `schedule` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temp_id` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  PRIMARY KEY (`list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_list`
--

LOCK TABLES `scheduler_task_list` WRITE;
/*!40000 ALTER TABLE `scheduler_task_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_task_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_log`
--

DROP TABLE IF EXISTS `scheduler_task_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `log_key` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_level` int(11) DEFAULT NULL,
  `log_info` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `log_time` datetime DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_log`
--

LOCK TABLES `scheduler_task_log` WRITE;
/*!40000 ALTER TABLE `scheduler_task_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_task_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_temp_details`
--

DROP TABLE IF EXISTS `scheduler_temp_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_temp_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temp_id` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `command_name` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `command` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `args` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trigger` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exec_user` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `force_host` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_temp_details`
--

LOCK TABLES `scheduler_temp_details` WRITE;
/*!40000 ALTER TABLE `scheduler_temp_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_temp_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_temp_list`
--

DROP TABLE IF EXISTS `scheduler_temp_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_temp_list` (
  `temp_id` int(11) NOT NULL AUTO_INCREMENT,
  `temp_name` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`temp_id`),
  UNIQUE KEY `temp_name` (`temp_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_temp_list`
--

LOCK TABLES `scheduler_temp_list` WRITE;
/*!40000 ALTER TABLE `scheduler_temp_list` DISABLE KEYS */;
INSERT INTO `scheduler_temp_list` VALUES (9000,'数据库审核','admin','2018-12-29 17:35:01','2018-12-29 17:35:01'),(9001,'数据库优化','admin','2018-12-29 17:35:01','2018-12-29 17:35:01');
/*!40000 ALTER TABLE `scheduler_temp_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_temp_user`
--

DROP TABLE IF EXISTS `scheduler_temp_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_temp_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temp_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `nickname` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_temp_user`
--

LOCK TABLES `scheduler_temp_user` WRITE;
/*!40000 ALTER TABLE `scheduler_temp_user` DISABLE KEYS */;
INSERT INTO `scheduler_temp_user` VALUES (3,2,6,'沈英智'),(4,2,11,'杨红飞'),(21,1,5,'卞婷婷'),(22,1,6,'沈英智'),(23,1,11,'杨红飞'),(24,1,2,'沈硕'),(30,24,54,'yhftest'),(31,24,55,'yanghongfeitest'),(32,24,11,'杨红飞'),(34,28,2,'沈硕'),(35,28,11,'杨红飞'),(36,28,58,'demo'),(37,28,14,'杨铭威'),(38,28,19,'CMDB'),(39,28,56,'publish'),(40,28,6,'沈英智'),(41,29,2,'沈硕'),(42,29,11,'杨红飞'),(43,30,2,'沈硕'),(44,30,6,'沈英智'),(45,30,11,'杨红飞'),(46,30,58,'demo'),(47,26,59,'admin');
/*!40000 ALTER TABLE `scheduler_temp_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_code_repository`
--

DROP TABLE IF EXISTS `task_code_repository`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_code_repository` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repository` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_info` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_code_repository`
--

LOCK TABLES `task_code_repository` WRITE;
/*!40000 ALTER TABLE `task_code_repository` DISABLE KEYS */;
INSERT INTO `task_code_repository` VALUES (5,'demo','https://github.com/opendevops-cn/opendevops',NULL,'demo','2019-01-17 10:44:19');
/*!40000 ALTER TABLE `task_code_repository` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_docker_registry`
--

DROP TABLE IF EXISTS `task_docker_registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_docker_registry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registry_url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_name` (`project_name`),
  UNIQUE KEY `registry_url` (`registry_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_docker_registry`
--

LOCK TABLES `task_docker_registry` WRITE;
/*!40000 ALTER TABLE `task_docker_registry` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_docker_registry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_monitor`
--

DROP TABLE IF EXISTS `task_monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_monitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `list_id` int(11) DEFAULT NULL,
  `call_level` int(11) DEFAULT NULL,
  `call_info` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `call_status` int(11) DEFAULT NULL,
  `call_users` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_monitor`
--

LOCK TABLES `task_monitor` WRITE;
/*!40000 ALTER TABLE `task_monitor` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_monitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_publish_config`
--

DROP TABLE IF EXISTS `task_publish_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_publish_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publish_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repository` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `build_host` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exclude_file` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temp_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_type1` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_path` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_file` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_hosts` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_hosts_api` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag_name` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bucket_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bucket_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bucket_path` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SecretID` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SecretKey` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docker_registry` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `k8s_api` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `k8s_host` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `namespace` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_to` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `publish_name` (`publish_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_publish_config`
--

LOCK TABLES `task_publish_config` WRITE;
/*!40000 ALTER TABLE `task_publish_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_publish_config` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-12 16:57:12
