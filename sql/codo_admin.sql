-- MySQL dump 10.14  Distrib 5.5.60-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: codo_admin
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
-- Current Database: `codo_admin`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `codo_admin` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `codo_admin`;

--
-- Table structure for table `mg_app_settings`
--

DROP TABLE IF EXISTS `mg_app_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_app_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_app_settings`
--

LOCK TABLES `mg_app_settings` WRITE;
/*!40000 ALTER TABLE `mg_app_settings` DISABLE KEYS */;
INSERT INTO `mg_app_settings` VALUES (125,'check_key','EMAIL','2018-12-12 11:17:41'),(130,'STORAGE_PATH','record','2018-12-13 10:54:00'),(141,'EMAIL_SUBJECT_PREFIX','DevOps','2019-01-16 18:09:35'),(142,'EMAIL_HOST','smtp.163.com','2019-01-16 18:09:35'),(143,'EMAIL_PORT','465','2019-01-16 18:09:35'),(144,'EMAIL_HOST_USER','your_name@163.com','2019-01-16 18:09:35'),(145,'EMAIL_HOST_PASSWORD','zheshicuowumima','2019-01-16 18:09:35'),(146,'EMAIL_USE_SSL','1','2019-01-16 18:09:35'),(147,'EMAIL_USE_TLS','0','2019-01-16 18:09:35'),(148,'SMS_REGION','cn-hangzhou','2019-01-16 18:09:49'),(149,'SMS_PRODUCT_NAME','Dysmsapi','2019-01-16 18:09:49'),(150,'SMS_DOMAIN','dysmsapi.aliyuncs.com','2019-01-16 18:09:49'),(151,'SMS_ACCESS_KEY_ID','access_key_id','2019-01-16 18:09:49'),(152,'SMS_ACCESS_KEY_SECRET','cuowudekey','2019-01-16 18:09:49'),(153,'EMAILLOGIN_SERVER','smtp.exmail.qq.com','2019-01-16 18:10:03'),(154,'EMAILLOGIN_DOMAIN','opendevops.cn','2019-01-16 18:10:03'),(159,'STORAGE_REGION','cn-shanghai','2019-01-16 18:54:33'),(160,'STORAGE_NAME','opendevops-demo','2019-01-16 18:54:33'),(161,'STORAGE_KEY_ID','access_key_id','2019-01-16 18:54:33'),(162,'STORAGE_KEY_SECRET','cuowudekey','2019-01-16 18:54:33'),(163,'WEBSITE_API_GW_URL','http://gw.domain.com/api/','2019-01-17 10:39:09');
/*!40000 ALTER TABLE `mg_app_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_components`
--

DROP TABLE IF EXISTS `mg_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_components` (
  `comp_id` int(11) NOT NULL AUTO_INCREMENT,
  `component_name` varchar(60) DEFAULT NULL,
  `status` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`comp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_components`
--

LOCK TABLES `mg_components` WRITE;
/*!40000 ALTER TABLE `mg_components` DISABLE KEYS */;
INSERT INTO `mg_components` VALUES (2,'edit_button','0'),(3,'publish_button','0'),(7,'cessss','0'),(8,'reset_mfa_btn','0'),(9,'reset_pwd_btn','0'),(10,'new_user_btn','0');
/*!40000 ALTER TABLE `mg_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_functions`
--

DROP TABLE IF EXISTS `mg_functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_functions` (
  `func_id` int(11) NOT NULL AUTO_INCREMENT,
  `func_name` varchar(60) NOT NULL,
  `uri` varchar(300) NOT NULL,
  `method_type` varchar(10) NOT NULL,
  `status` varchar(5) NOT NULL,
  `utime` datetime DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`func_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_functions`
--

LOCK TABLES `mg_functions` WRITE;
/*!40000 ALTER TABLE `mg_functions` DISABLE KEYS */;
INSERT INTO `mg_functions` VALUES (6,'ss','/login/','ALL','10','2018-03-21 10:29:14','2018-03-20 18:35:24'),(8,'家目录','/home/','ALL','0','2018-03-21 14:03:25','2018-03-21 14:03:25'),(9,'管理员','/','ALL','0','2018-03-21 14:04:59','2018-03-21 14:04:59'),(10,'任务管理员','/v1/task/','ALL','0','2018-11-28 10:59:48','2018-03-22 10:09:10'),(12,'修改密码','/password/','PATCH','0','2018-03-22 16:32:16','2018-03-22 16:27:12'),(15,'提交任务','/v1/task/accept/','POST','0','2018-06-08 09:26:00','2018-06-08 09:26:00'),(16,'获取CSRF','/v1/task/accept/','GET','0','2018-06-08 09:26:51','2018-06-08 09:26:51'),(17,'获取RDS信息','/v1/cmdb/rds/','GET','0','2018-07-05 10:40:48','2018-07-05 10:40:48'),(18,'CMDB访问','/v1/cmdb/','GET','0','2018-07-10 09:46:41','2018-07-10 09:46:41'),(19,'菜单','/v1/accounts/menu/nav/','GET','0','2018-07-11 17:34:03','2018-07-11 17:34:03'),(20,'个人信息','/v1/accounts/my_info/','ALL','0','2018-07-11 17:35:13','2018-07-11 17:35:13'),(21,'任务列表','/v1/task/list/','ALL','0','2018-07-11 17:50:53','2018-07-11 17:50:53'),(22,'任务检查','/v1/task/check/','GET','0','2018-07-11 17:52:25','2018-07-11 17:52:25'),(23,'任务处理','/v1/task/sched/','ALL','0','2018-07-11 17:52:52','2018-07-11 17:52:52'),(24,'任务日志','/v1/task/log/','GET','0','2018-07-11 17:53:20','2018-07-11 17:53:20'),(25,'修改个人信息','/v1/accounts/user/','PUT','0','2018-07-11 17:57:41','2018-07-11 17:57:41'),(26,'提交SQL优化','/v1/jobs/sql_ad/','POST','0','2018-08-02 19:11:32','2018-08-02 19:11:32'),(27,'页面任务提交','/v1/jobs/','POST','0','2018-08-06 17:04:00','2018-08-06 17:04:00'),(28,'申请资源','/v1/jobs/purchase/','POST','0','2018-08-08 13:21:09','2018-08-08 13:21:09'),(29,'注销1','/logout/','GET','0','2018-10-23 15:01:37','2018-08-13 17:06:47'),(33,'发布配置','/task/v2/task_other/publish_cd/','GET','0','2018-12-05 09:59:48','2018-12-05 09:37:24'),(34,'CMDB-资产访问','/cmdb/api/cmdb/server_list/','GET','0','2018-12-05 16:58:06','2018-12-05 16:58:06'),(35,'系统用户获取','/mg/v2/accounts/','GET','0','2018-12-14 14:44:51','2018-12-14 14:40:48'),(36,'查看所有','/','GET','0','2018-12-26 14:56:07','2018-12-26 14:56:07'),(37,'获取镜像仓库信息','/task/v2/task_other/docker_registry/','GET','0','2019-01-14 16:12:14','2019-01-14 16:12:14');
/*!40000 ALTER TABLE `mg_functions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_menus`
--

DROP TABLE IF EXISTS `mg_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_menus` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_menus`
--

LOCK TABLES `mg_menus` WRITE;
/*!40000 ALTER TABLE `mg_menus` DISABLE KEYS */;
INSERT INTO `mg_menus` VALUES (1,'home','0'),(2,'_home','0'),(3,'components','0'),(4,'count_to_page','0'),(5,'tables_page','0'),(6,'usermanage','0'),(7,'user','0'),(8,'role','0'),(9,'functions','0'),(10,'menus','0'),(12,'systemmanage','0'),(13,'system','0'),(14,'systemlog','0'),(18,'cron','0'),(19,'cronjobs','0'),(20,'cronlogs','0'),(22,'task_layout','0'),(23,'commandlist','0'),(24,'argslist','0'),(25,'templist','0'),(26,'order','0'),(27,'taskOrderList','0'),(28,'taskuser','0'),(29,'operation_center','0'),(30,'level_2_1','0'),(32,'mysqlAudit','0'),(33,'publishApp','0'),(34,'mysqlOptimize','0'),(35,'resourceApplication','0'),(37,'customTasks','0'),(38,'publishConfig','0'),(39,'codeRepository','0'),(40,'dockerRegistry','0'),(41,'cmdb','0'),(42,'server_list','0'),(43,'server_log','0'),(44,'server_auth','0'),(45,'server_group','0'),(46,'tag','0'),(47,'adm_user','0'),(48,'WebSSH','0'),(49,'SshRecord','0'),(50,'k8s','0'),(51,'project','0'),(52,'app','0'),(53,'project_publish','0'),(54,'publish_list','0'),(55,'server_db','0'),(56,'statisticaldata','0'),(57,'statisticalImage','0'),(58,'historyTaskList','0');
/*!40000 ALTER TABLE `mg_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_role_functions`
--

DROP TABLE IF EXISTS `mg_role_functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_role_functions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(11) NOT NULL,
  `func_id` varchar(11) NOT NULL,
  `status` varchar(5) NOT NULL,
  `utime` datetime DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_role_functions`
--

LOCK TABLES `mg_role_functions` WRITE;
/*!40000 ALTER TABLE `mg_role_functions` DISABLE KEYS */;
INSERT INTO `mg_role_functions` VALUES (1,'3','3','0','2017-12-21 14:26:04','2017-12-21 14:26:04'),(3,'4','5','0','2017-12-21 14:26:04','2017-12-21 14:26:04'),(5,'1','5','0','2017-12-21 14:26:04','2017-12-21 14:26:04'),(6,'2','8','0','2018-03-22 10:19:26','2018-03-22 10:19:26'),(14,'3','9','0','2018-03-22 10:33:19','2018-03-22 10:33:19'),(19,'2','12','0','2018-03-26 16:33:34','2018-03-26 16:33:34'),(21,'2','9','0','2018-03-26 16:37:38','2018-03-26 16:37:38'),(24,'3','13','0','2018-04-10 09:48:29','2018-04-10 09:48:29'),(27,'5','14','0','2018-04-11 14:20:42','2018-04-11 14:20:42'),(28,'9','16','0','2018-06-08 09:27:27','2018-06-08 09:27:27'),(29,'9','15','0','2018-06-08 09:27:28','2018-06-08 09:27:28'),(30,'10','17','0','2018-07-05 10:41:13','2018-07-05 10:41:13'),(31,'10','18','0','2018-07-10 09:46:46','2018-07-10 09:46:46'),(33,'11','8','0','2018-07-11 17:28:57','2018-07-11 17:28:57'),(34,'11','12','0','2018-07-11 17:29:01','2018-07-11 17:29:01'),(35,'11','19','0','2018-07-11 17:34:11','2018-07-11 17:34:11'),(36,'11','20','0','2018-07-11 17:35:19','2018-07-11 17:35:19'),(37,'11','24','0','2018-07-11 17:53:27','2018-07-11 17:53:27'),(38,'11','23','0','2018-07-11 17:53:28','2018-07-11 17:53:28'),(39,'11','22','0','2018-07-11 17:53:28','2018-07-11 17:53:28'),(40,'11','21','0','2018-07-11 17:53:29','2018-07-11 17:53:29'),(41,'11','25','0','2018-07-11 17:57:48','2018-07-11 17:57:48'),(42,'12','8','0','2018-07-17 16:09:54','2018-07-17 16:09:54'),(43,'12','12','0','2018-07-17 16:09:55','2018-07-17 16:09:55'),(44,'12','25','0','2018-07-17 16:09:58','2018-07-17 16:09:58'),(45,'12','24','0','2018-07-17 16:09:59','2018-07-17 16:09:59'),(46,'12','23','0','2018-07-17 16:10:00','2018-07-17 16:10:00'),(47,'12','22','0','2018-07-17 16:10:00','2018-07-17 16:10:00'),(48,'12','21','0','2018-07-17 16:10:01','2018-07-17 16:10:01'),(49,'12','20','0','2018-07-17 16:10:01','2018-07-17 16:10:01'),(50,'12','19','0','2018-07-17 16:10:02','2018-07-17 16:10:02'),(55,'12','18','0','2018-07-17 16:10:29','2018-07-17 16:10:29'),(56,'13','12','0','2018-08-02 17:37:32','2018-08-02 17:37:32'),(57,'13','15','0','2018-08-02 17:37:36','2018-08-02 17:37:36'),(59,'13','17','0','2018-08-02 17:37:45','2018-08-02 17:37:45'),(60,'13','19','0','2018-08-02 17:37:50','2018-08-02 17:37:50'),(61,'13','20','0','2018-08-02 17:37:51','2018-08-02 17:37:51'),(62,'13','24','0','2018-08-02 17:37:56','2018-08-02 17:37:56'),(63,'13','25','0','2018-08-02 17:37:58','2018-08-02 17:37:58'),(64,'13','8','0','2018-08-02 18:35:11','2018-08-02 18:35:11'),(65,'13','21','0','2018-08-02 18:37:16','2018-08-02 18:37:16'),(67,'13','23','0','2018-08-02 18:37:18','2018-08-02 18:37:18'),(68,'13','26','0','2018-08-02 19:11:43','2018-08-02 19:11:43'),(69,'12','15','0','2018-08-06 17:03:13','2018-08-06 17:03:13'),(70,'12','27','0','2018-08-06 17:04:07','2018-08-06 17:04:07'),(71,'14','8','0','2018-08-08 12:56:00','2018-08-08 12:56:00'),(72,'14','12','0','2018-08-08 12:56:01','2018-08-08 12:56:01'),(73,'14','15','0','2018-08-08 12:56:01','2018-08-08 12:56:01'),(74,'14','22','0','2018-08-08 12:56:27','2018-08-08 12:56:27'),(75,'14','23','0','2018-08-08 12:56:27','2018-08-08 12:56:27'),(76,'14','24','0','2018-08-08 12:56:27','2018-08-08 12:56:27'),(77,'14','25','0','2018-08-08 12:56:31','2018-08-08 12:56:31'),(78,'14','19','0','2018-08-08 12:56:43','2018-08-08 12:56:43'),(79,'14','20','0','2018-08-08 12:56:45','2018-08-08 12:56:45'),(80,'14','21','0','2018-08-08 12:56:48','2018-08-08 12:56:48'),(81,'12','28','0','2018-08-08 13:21:19','2018-08-08 13:21:19'),(82,'12','16','0','2018-08-08 13:23:02','2018-08-08 13:23:02'),(83,'13','16','0','2018-08-08 13:24:57','2018-08-08 13:24:57'),(84,'14','16','0','2018-08-08 13:25:02','2018-08-08 13:25:02'),(85,'15','8','0','2018-08-10 10:06:55','2018-08-10 10:06:55'),(86,'15','12','0','2018-08-10 10:06:56','2018-08-10 10:06:56'),(87,'15','15','0','2018-08-10 10:06:57','2018-08-10 10:06:57'),(88,'15','16','0','2018-08-10 10:06:57','2018-08-10 10:06:57'),(89,'15','19','0','2018-08-10 10:07:05','2018-08-10 10:07:05'),(90,'15','20','0','2018-08-10 10:07:07','2018-08-10 10:07:07'),(91,'15','21','0','2018-08-10 10:07:07','2018-08-10 10:07:07'),(92,'15','22','0','2018-08-10 10:07:07','2018-08-10 10:07:07'),(93,'15','23','0','2018-08-10 10:07:08','2018-08-10 10:07:08'),(94,'15','24','0','2018-08-10 10:07:08','2018-08-10 10:07:08'),(95,'15','25','0','2018-08-10 10:07:09','2018-08-10 10:07:09'),(96,'16','8','0','2018-08-10 17:04:27','2018-08-10 17:04:27'),(97,'16','12','0','2018-08-10 17:04:30','2018-08-10 17:04:30'),(98,'16','15','0','2018-08-10 17:04:30','2018-08-10 17:04:30'),(99,'16','16','0','2018-08-10 17:04:32','2018-08-10 17:04:32'),(100,'16','19','0','2018-08-10 17:04:34','2018-08-10 17:04:34'),(101,'16','20','0','2018-08-10 17:04:37','2018-08-10 17:04:37'),(102,'16','21','0','2018-08-10 17:04:37','2018-08-10 17:04:37'),(103,'16','22','0','2018-08-10 17:04:37','2018-08-10 17:04:37'),(104,'16','23','0','2018-08-10 17:04:38','2018-08-10 17:04:38'),(105,'16','24','0','2018-08-10 17:04:39','2018-08-10 17:04:39'),(106,'16','25','0','2018-08-10 17:04:41','2018-08-10 17:04:41'),(107,'16','29','0','2018-08-13 17:06:54','2018-08-13 17:06:54'),(108,'15','29','0','2018-08-13 17:06:57','2018-08-13 17:06:57'),(109,'14','29','0','2018-08-13 17:07:00','2018-08-13 17:07:00'),(110,'13','29','0','2018-08-13 17:07:04','2018-08-13 17:07:04'),(111,'13','22','0','2018-09-13 09:26:02','2018-09-13 09:26:02'),(113,'2','18','0',NULL,NULL),(114,'2','19','0',NULL,NULL),(115,'22','8','0',NULL,NULL),(116,'22','19','0',NULL,NULL),(117,'22','9','0',NULL,NULL),(118,'23','9','0',NULL,NULL),(119,'23','8','0',NULL,NULL),(120,'23','15','0',NULL,NULL),(121,'23','23','0',NULL,NULL),(122,'23','24','0',NULL,NULL),(123,'23','32','0',NULL,NULL),(124,'23','10','0',NULL,NULL),(125,'23','18','0',NULL,NULL),(126,'23','29','0',NULL,NULL),(127,'23','21','0',NULL,NULL),(128,'23','12','0',NULL,NULL),(129,'23','17','0',NULL,NULL),(130,'23','22','0',NULL,NULL),(131,'23','27','0',NULL,NULL),(132,'23','20','0',NULL,NULL),(133,'23','26','0',NULL,NULL),(134,'23','19','0',NULL,NULL),(135,'23','16','0',NULL,NULL),(136,'23','25','0',NULL,NULL),(137,'23','28','0',NULL,NULL),(138,'25','33','0',NULL,NULL),(139,'2','34','0',NULL,NULL),(140,'10','34','0',NULL,NULL),(141,'10','35','0',NULL,NULL),(142,'26','36','0',NULL,NULL);
/*!40000 ALTER TABLE `mg_role_functions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_role_menus`
--

DROP TABLE IF EXISTS `mg_role_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_role_menus` (
  `role_menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu_id` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`role_menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_role_menus`
--

LOCK TABLES `mg_role_menus` WRITE;
/*!40000 ALTER TABLE `mg_role_menus` DISABLE KEYS */;
INSERT INTO `mg_role_menus` VALUES (2,'2',NULL,'0'),(3,'2','8','0'),(5,'2','7','0'),(6,'2','1','0'),(7,'2','10','0'),(8,'2','2','0'),(9,'2','6','0'),(10,'2','9','0'),(11,'2','13','0'),(12,'2','12','0'),(13,'2','14','0'),(14,'3','12','0'),(15,'3','13','0'),(16,'3','14','0'),(17,'3','9','0'),(18,'3','8','0'),(19,'3','10','0'),(23,'5','14','0'),(25,'3','7','0'),(26,'2','20','0'),(27,'2','18','0'),(28,'2','19','0'),(29,'2','24','0'),(30,'2','23','0'),(31,'2','22','0'),(32,'2','25','0'),(33,'3','1','0'),(34,'3','19','0'),(35,'3','2','0'),(36,'3','4','0'),(37,'3','25','0'),(38,'3','22','0'),(39,'3','6','0'),(40,'3','20','0'),(41,'3','23','0'),(42,'3','5','0'),(43,'3','3','0'),(44,'3','24','0'),(45,'3','18','0'),(46,'2','27','0'),(47,'2','26','0'),(48,'2','28','0'),(49,'22','2','0'),(50,'22','1','0'),(51,'23','8','0'),(52,'23','23','0'),(53,'23','24','0'),(54,'23','4','0'),(55,'23','2','0'),(56,'23','10','0'),(57,'23','18','0'),(58,'23','6','0'),(59,'23','12','0'),(60,'23','27','0'),(61,'23','22','0'),(62,'23','26','0'),(63,'23','20','0'),(64,'23','1','0'),(65,'23','9','0'),(66,'23','14','0'),(67,'23','3','0'),(68,'23','5','0'),(69,'23','13','0'),(70,'23','7','0'),(71,'23','19','0'),(72,'23','25','0'),(73,'23','28','0'),(74,'2','29','0'),(75,'2','30','0'),(77,'2','35','0'),(78,'2','32','0'),(79,'2','34','0'),(80,'2','33','0'),(81,'2','37','0'),(82,'2','38','0'),(83,'2','39','0'),(84,'2','40','0'),(85,'2','54','0'),(86,'2','53','0'),(87,'2','43','0'),(88,'2','45','0'),(89,'2','41','0'),(90,'2','47','0'),(91,'2','46','0'),(92,'2','42','0'),(93,'2','50','0'),(94,'2','49','0'),(95,'2','52','0'),(96,'2','48','0'),(97,'2','44','0'),(98,'2','51','0'),(99,'26','23','0'),(100,'26','50','0'),(101,'26','48','0'),(102,'26','6','0'),(103,'26','8','0'),(105,'26','19','0'),(106,'26','10','0'),(107,'26','9','0'),(108,'26','37','0'),(109,'26','42','0'),(110,'26','27','0'),(111,'26','22','0'),(112,'26','3','0'),(113,'26','49','0'),(114,'26','52','0'),(115,'26','51','0'),(116,'26','41','0'),(117,'26','24','0'),(118,'26','12','0'),(119,'26','5','0'),(120,'26','43','0'),(121,'26','35','0'),(122,'26','54','0'),(125,'26','34','0'),(126,'26','4','0'),(127,'26','18','0'),(128,'26','13','0'),(129,'26','44','0'),(130,'26','20','0'),(131,'26','47','0'),(132,'26','14','0'),(133,'26','32','0'),(134,'26','40','0'),(135,'26','39','0'),(136,'26','33','0'),(137,'26','46','0'),(138,'26','38','0'),(139,'26','1','0'),(140,'26','25','0'),(141,'26','29','0'),(142,'26','53','0'),(143,'26','45','0'),(144,'26','2','0'),(145,'26','26','0'),(146,'2','55','0'),(147,'2','57','0'),(148,'2','58','0'),(149,'2','56','0'),(150,'26','57','0'),(151,'26','58','0'),(152,'26','56','0'),(153,'26','55','0'),(154,'3','48','0'),(155,'3','51','0'),(156,'3','38','0'),(157,'3','49','0'),(158,'3','46','0'),(159,'3','27','0'),(160,'3','58','0'),(161,'3','29','0'),(162,'3','47','0'),(163,'3','40','0'),(164,'3','42','0'),(165,'3','35','0'),(166,'3','39','0'),(167,'3','56','0'),(168,'3','32','0'),(169,'3','28','0'),(170,'3','45','0'),(171,'3','57','0'),(172,'3','53','0'),(173,'3','43','0'),(174,'3','37','0'),(175,'3','34','0'),(176,'3','26','0'),(177,'3','52','0'),(178,'3','54','0'),(179,'3','41','0'),(180,'3','44','0'),(181,'3','55','0'),(182,'3','50','0'),(183,'3','30','0'),(184,'3','33','0');
/*!40000 ALTER TABLE `mg_role_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_roles`
--

DROP TABLE IF EXISTS `mg_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(30) NOT NULL,
  `status` varchar(5) NOT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_roles`
--

LOCK TABLES `mg_roles` WRITE;
/*!40000 ALTER TABLE `mg_roles` DISABLE KEYS */;
INSERT INTO `mg_roles` VALUES (2,'test','0','2018-04-17 13:23:31'),(3,'admin','0','2017-12-21 14:26:04'),(12,'OPS','0','2018-07-17 16:09:34'),(25,'publish','0','2018-12-05 09:35:29');
/*!40000 ALTER TABLE `mg_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_roles_components`
--

DROP TABLE IF EXISTS `mg_roles_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_roles_components` (
  `role_comp_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(11) DEFAULT NULL,
  `comp_id` varchar(11) DEFAULT NULL,
  `status` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`role_comp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_roles_components`
--

LOCK TABLES `mg_roles_components` WRITE;
/*!40000 ALTER TABLE `mg_roles_components` DISABLE KEYS */;
INSERT INTO `mg_roles_components` VALUES (3,'3','3','0'),(6,'2','2','0'),(7,'2','3','0'),(8,'4','3','0'),(13,'3','10','0'),(14,'3','8','0'),(15,'3','9','0'),(16,'3','2','0'),(17,'3','7','0'),(18,'23','2','0'),(19,'23','10','0'),(20,'23','8','0'),(21,'23','3','0'),(22,'23','7','0'),(23,'23','9','0'),(24,'25','7','0'),(25,'25','8','0'),(26,'25','9','0'),(27,'25','2','0'),(28,'25','10','0'),(29,'25','3','0'),(30,'26','2','0'),(31,'26','3','0'),(32,'26','8','0'),(33,'26','10','0'),(34,'26','7','0'),(35,'26','9','0');
/*!40000 ALTER TABLE `mg_roles_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_user_roles`
--

DROP TABLE IF EXISTS `mg_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_user_roles` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(11) NOT NULL,
  `user_id` varchar(11) NOT NULL,
  `status` varchar(5) NOT NULL,
  `utime` datetime DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`user_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32849 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_user_roles`
--

LOCK TABLES `mg_user_roles` WRITE;
/*!40000 ALTER TABLE `mg_user_roles` DISABLE KEYS */;
INSERT INTO `mg_user_roles` VALUES (5,'4','2','0','2017-12-21 14:26:04','2017-12-21 14:26:04'),(15,'5','5','0','2018-04-11 14:19:03','2018-04-11 14:19:03'),(16,'3','11','0','2018-05-29 09:17:36','2018-05-29 09:17:36'),(18,'9','13','0','2018-06-08 09:27:55','2018-06-08 09:27:55'),(19,'4','13','0','2018-06-12 09:35:10','2018-06-12 09:35:10'),(20,'4','11','0','2018-06-12 09:35:20','2018-06-12 09:35:20'),(23,'10','19','0','2018-07-05 10:41:25','2018-07-05 10:41:25'),(24,'11','5','0','2018-07-11 17:29:19','2018-07-11 17:29:19'),(31,'13','22','0','2018-08-03 09:39:13','2018-08-03 09:39:13'),(32,'9','2','0','2018-08-07 17:31:06','2018-08-07 17:31:06'),(33,'9','14','0','2018-08-07 17:31:40','2018-08-07 17:31:40'),(34,'9','11','0','2018-08-07 17:31:49','2018-08-07 17:31:49'),(35,'9','6','0','2018-08-07 17:31:55','2018-08-07 17:31:55'),(38,'12','11','0','2018-08-08 13:33:25','2018-08-08 13:33:25'),(41,'14','23','0','2018-08-08 14:31:23','2018-08-08 14:31:23'),(44,'15','24','0','2018-08-10 10:11:11','2018-08-10 10:11:11'),(45,'16','26','0','2018-08-10 17:03:46','2018-08-10 17:03:46'),(46,'16','21','0','2018-08-13 16:49:57','2018-08-13 16:49:57'),(47,'16','28','0','2018-08-13 17:01:45','2018-08-13 17:01:45'),(48,'14','25','0','2018-08-14 14:49:51','2018-08-14 14:49:51'),(32832,'2','2','0','2018-10-24 14:04:27','2018-10-24 14:04:27'),(32834,'2','11','0','2018-10-25 15:26:13','2018-10-25 15:26:13'),(32838,'22','54','0','2018-11-28 11:08:54','2018-11-28 11:08:54'),(32839,'23','55','0','2018-11-28 17:51:24','2018-11-28 17:51:24'),(32840,'25','56','0','2018-12-05 09:35:38','2018-12-05 09:35:38'),(32842,'2','57','0','2018-12-11 13:12:10','2018-12-11 13:12:10'),(32843,'4','14','0','2018-12-13 16:08:56','2018-12-13 16:08:56'),(32844,'2','14','0','2018-12-13 16:13:56','2018-12-13 16:13:56'),(32845,'26','58','0','2018-12-26 14:55:28','2018-12-26 14:55:28'),(32846,'2','19','0','2019-01-16 17:00:37','2019-01-16 17:00:37'),(32847,'3','59','0','2019-01-16 18:07:50','2019-01-16 18:07:50'),(32848,'12','59','0','2019-01-16 19:02:27','2019-01-16 19:02:27');
/*!40000 ALTER TABLE `mg_user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_users`
--

DROP TABLE IF EXISTS `mg_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `tel` varchar(11) DEFAULT NULL,
  `wechat` varchar(50) DEFAULT NULL,
  `no` varchar(50) NOT NULL,
  `department` varchar(50) NOT NULL,
  `superuser` varchar(5) NOT NULL,
  `status` varchar(5) NOT NULL,
  `last_ip` varchar(18) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `google_auth` varchar(80) DEFAULT NULL,
  `google_key` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_users`
--

LOCK TABLES `mg_users` WRITE;
/*!40000 ALTER TABLE `mg_users` DISABLE KEYS */;
INSERT INTO `mg_users` VALUES (19,'cmdb','66E7BCB387A66F2BF98AD62DE7B8A82C','CMDB','system用户请勿删除','10000000002','15618718888','15618718888','system','10','0','127.0.0.1','2018-12-14 16:02:09','2018-07-05 10:39:57',NULL,''),(56,'publish','66E7BCB387A66F2BF98AD62DE7B8A82C','publish','system用户请勿删除','10000000000','publish','9527','system','10','0','127.0.0.1','2018-12-13 14:50:48','2018-12-04 18:40:05',NULL,''),(59,'admin','66E7BCB387A66F2BF98AD62DE7B8A82C','admin','admin@opendevops.cn','10000000001','admin','1','admin','0','0','127.0.0.1','2019-01-17 10:35:49','2019-01-16 18:02:10',NULL,'');
/*!40000 ALTER TABLE `mg_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operation_record`
--

DROP TABLE IF EXISTS `operation_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operation_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login_ip` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uri` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8mb4_unicode_ci,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=544 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation_record`
--

LOCK TABLES `operation_record` WRITE;
/*!40000 ALTER TABLE `operation_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `operation_record` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-17 11:08:11
