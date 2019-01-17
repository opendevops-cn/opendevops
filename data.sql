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

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `codo_admin` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

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

--
-- Current Database: `codo_task`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `codo_task` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `codo_task`;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_cmd_list`
--

LOCK TABLES `scheduler_cmd_list` WRITE;
/*!40000 ALTER TABLE `scheduler_cmd_list` DISABLE KEYS */;
INSERT INTO `scheduler_cmd_list` VALUES (17,'【Server发布】获取配置信息','python3 /opt/ops_scripts/codo-publish/get_publish_info.py','PUBLISH_NAME FLOW_ID','','yanghongfei','2018-12-10 16:03:22','2018-12-26 14:01:43'),(18,'【Server发布】拉取代码','python3 /opt/ops_scripts/codo-publish/server/pull_code.py','FLOW_ID PUBLISH_TAG','','yanghongfei','2018-12-10 16:05:03','2018-12-26 14:02:16'),(19,'【Server发布】编译代码','python3 /opt/ops_scripts/codo-publish/server/bulid_code.py','FLOW_ID','','yanghongfei','2018-12-10 16:05:43','2018-12-26 14:02:28'),(20,'【Server发布】分发代码','python3 /opt/ops_scripts/codo-publish/server/upload_code.py','FLOW_ID','','yanghongfei','2018-12-10 16:06:24','2018-12-26 14:08:33'),(21,'【Server发布】备份代码','python3 /opt/ops_scripts/codo-publish/server/backup_code.py','FLOW_ID','','yanghongfei','2018-12-10 16:07:16','2018-12-26 14:08:52'),(22,'【Server发布】部署代码','python3 /opt/ops_scripts/codo-publish/server/deploy_code.py','FLOW_ID','','yanghongfei','2018-12-10 16:08:25','2018-12-26 14:09:09'),(23,'【Bucket发布】COS发布','python3 /opt/ops_scripts/codo-publish/bucker/upload_cos.py','PUBLISH_NAME PUBLISH_TAG','','yanghongfei','2018-12-11 16:58:19','2018-12-26 14:09:24'),(24,'【Bucket发布】OSS发布','python3 /opt/ops_scripts/codo-publish/bucker/upload_oss.py','PUBLISH_NAME PUBLISH_TAG','','yanghongfei','2018-12-12 16:36:58','2018-12-26 14:09:45'),(25,'【Bucket发布】S3发布','python3 /opt/ops_scripts/codo-publish/bucker/upload_s3.py','PUBLISH_NAME PUBLISH_TAG','','yanghongfei','2018-12-13 14:35:57','2018-12-26 14:10:01'),(26,'安装依赖','pip3 install -r /opt/ops_scripts/codo-publish/requirements.txt','','','yanghongfei','2018-12-28 13:33:22','2018-12-28 13:33:22'),(27,'重启NGINX进程','service nginx restart','','','yanghongfei','2018-12-29 10:35:04','2018-12-29 10:35:04'),(28,'SQL优化-内网','python3.6 /opt/ops_scripts/codo-check/exec_sqladvisor.py','PUBLISH_NAME DB_NAME SQLS','172.16.0.230','ss','2019-01-08 15:28:02','2019-01-08 15:28:02'),(29,'【k8s发布】获取配置信息','python3 /opt/ops_scripts/codo-publish/get_publish_info.py','PUBLISH_NAME FLOW_ID','','ss','2019-01-15 14:36:53','2019-01-15 14:36:53'),(30,'【k8s发布】拉取代码','python3 /opt/ops_scripts/codo-publish/k8s/pull_code.py','FLOW_ID PUBLISH_TAG','','ss','2019-01-15 14:38:05','2019-01-15 14:38:05'),(31,'【k8s发布】编译代码','python3 /opt/ops_scripts/codo-publish/k8s/bulid_code.py','FLOW_ID','','ss','2019-01-15 14:53:37','2019-01-15 14:53:37'),(32,'【k8s发布】编译镜像并上传','python3 /opt/ops_scripts/codo-publish/k8s/bulid_image.py','FLOW_ID PUBLISH_TAG','','ss','2019-01-15 14:54:11','2019-01-15 14:54:11'),(33,'【k8sr发布】滚动升级并检查','python3 /opt/ops_scripts/codo-publish/k8s/deploy_app.py','FLOW_ID PUBLISH_TAG','','ss','2019-01-15 14:54:50','2019-01-15 14:54:50'),(34,'代码检查','python3 /opt/ops_scripts/codo-check/exec_sonar.py	','PUBLISH_NAME PUBLISH_TAG','127.0.0.1','ss','2019-01-15 14:56:14','2019-01-15 14:56:14');
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
  `exec_user` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ssh_port` int(11) DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_key` text COLLATE utf8mb4_unicode_ci,
  `remarks` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `exec_user` (`exec_user`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_execute_user`
--

LOCK TABLES `scheduler_execute_user` WRITE;
/*!40000 ALTER TABLE `scheduler_execute_user` DISABLE KEYS */;
INSERT INTO `scheduler_execute_user` VALUES (2,'root',22,'shinezone20181121','-----BEGIN RSA PRIVATE KEY-----\nMIIJKAIBAAKCAgEA3Lgs3t8B+JQ2mP4DybeYYm/Dl7eE5euk+/bkVD3ASIwlQ+34\nwHRXdiagUlVSKL2K5XQ4gArjF77VOJFFKc+kORGxG3YybI0mYxy6PlVsGYGTcDUZ\n88OEvaKglT0tG9hTDrtqDcOFuXqfOZIasicf6P+AFGd7FLOoaQWZw2BH4TcY0YN5\nacBQxAKlWRu2LPHUd06wY3ZF77YCIBsH29acZUVSd5tEvTl0BtkoxsfJKt4jM3Er\ndrHoW1BosFtAZeuy6D73ALrkK5dd9dXKGdLr3cUv1G9cX/o+uyJCsKsyd/1sctRw\n1I41l7jtumTGNGEE31SqHRXJD0PD1ky2JTLYqo4PkIP/0pqydlet4u2mA6xio7h5\np8HEV1ShGvVUsDJuqM5NO8ra+dVMKYc0HDCL/JdoPb6Ov1t1yl6jjj+okfn7C2eu\n+5rcG19b0HBYDNrUGyvbwbqWbIh0axi94DKSWGmf3L6RPDPCdBOMNhNJv8Rhv336\nInUtCte2D0OS2Rl/n0/YkJ1z\npvfZwAMCAwEA\nAQKCAEKQzNpxH\nZLBu904WFK8dHPVYe00bo5TT7nH4EYXIT+mybURbDYx8+uQMngdvfjbD6bZ2q82f\ntU1RPkWTWXJrDD7OZKCrNmzQd8ZT+tuRzGUJAoE7fnKD/iudN5NBp5WMcsIkT85y\nd2TtfVLIROzCam3TEQJM0SiKZGF+1+B9AfYxnYgPblxhCIZ5e06oIJI6HPhyysii\noNn0iKhsD7bh/6b0IX/051znTs/rD/Lw7qRK463zLULFrW1F7B5kU172H01qk4xH\ngaIf7VkyPcPRhZv11lN3wYXZEbMyroVeZUzTmfahYZPcj0irjV7qnylwg6Ay4aR2\n2/ZNWtfibeE4N7MigGJF+K4KIhZg1+r6uWVD2BmEFHDz+ddiAQKCAQEA+EgDyojF\nDUCukx2pMYK6xNu5CWY48ywFI/1ptmRGGIweYdHw1DPdlV4wfO1BeRfOlABD+tRL\n1HPj3EJmp4R9CwVdUv5ZYHiRahm9ByAW1AxNBBrRX1oh2nPy4PNU+7+DpK9JfxRS\nw+rhI4S0g0NGBPjgB28quYt4Bp9ZG+8bg57tMubqvJyrwXV3xhx3iymCUSRDY7Dx\nadfruyHfld7pVwIW6sQpdWNuPWRSPk/zV0e8LpMnr99TuQ7PJbPrh5ZzVktY4B8q\n4Dt3t+nQOutjS7AyraVYBqoVmlPyPbwugLU3TWmnEJ+4U97GVZXi2H3OfyZMFs15\nJIK8I+lhIuQWowKCAQEA45TOFtPJl1ceQnDgWMt5wehofwKCmXmphgZxRZSp+Cm4\nnP0JzollNswyD1HlwzbjxDBYbCoJMFJKm7c8vD0ATIBbcMq5GYFEB+sIAxRdTHnV\nhoolw9JP0QRy7nYYtIqwAr5RI0rw9DaXGGDN6+52Rvba+AE8zeqSUYx4K0pclGPR\nMJAS3pPsme918E/B6ghd8xwJjNGHXDNpCWJse6zZVR1WJ9oD3kIh/0rbJZ5k7IOR\nT86/h1Dqm/3Ru5KVNNzliHjbGWe1yvd2iCouu388bXVkIwwusBDXJ6/i1BYoeFGh\neB1Wru5wxONUSYgogZwovfc5uLSnn78GS6lIHMXzAQKCAQAZs1qxHHdJZ+iqUeex\nuFadCiGdV3eNtIDTuOe4eajH4blDZvgG/1dwns9mHykn388CgwSGcnNnCpgLtNPr\ng0tuWJ/Qd4PI+LIUyZVHp4q1aJCQXDZQKIRYmKgLoSSq6qg14+83uGLY5PdpNdN5\nwvz8hsap/lft3QIPrW8L9TRj64+iNUUXQSCGZiJ/33KAdUuIGrjfGPHkgvVj6Z27\nZdfBqfW1V5jzDdfbgwcAbEZEQqi4KYNyMSv5fA71WCqJXomR5TrN+Gv3yjAaWZm0\nf6lHrHWShAsYpYKW9xmcSl6F9DxFRyqEDgSGqgjd0yYoQt2dS9mUgrCHlwDitsXX\nVsUBAoIBAAMJ2pKNc1SU8i966FPnK5H+M172vp2j9TJ35Y1DRd2tWOynqDjctsA7\ni7OOqV2o3vOgnZ2cFhFSF/LqSGJPAjEDSbVAz6XahvkAF1RLMk+yFLq+H3D03uHw\niERMyVmnvF/dAKJS/tKT5AKMUFOFFIkwBI5pHdG1/wwdrwEM9h15E7LtSYM1QGRx\nwQZbWkBwqihzyGDb70241f8tFDu2fBRZ1uujSofuJBwPeMuQyNIrk4YYQZBh8S/x\n/JnfhCR3ioz+6BX3v4KdOTTqM0OHmFvxxEt/fyQUpXq/K20fepzYoipDYgPl5RWL\n33U33yqT1itrIJcpuk80srXR5ceUkQECggEBANiLXRZvL9vcYgBMJSRsXTqfnHjB\nbsQSL7Y69vRteM0Lc/5loua0FOO+6d5wN5vjmWCvryLm+9Ecx2HXNW8gc/59/NT8\nwA+EglFdnP6DEPEW2uiQWnPyE7aAW1T8ndc5M6ffW1lAp2ykaxHkXIqcU43WUMuJ\nxIeZiAqP0yLuLB4GFOKxsNxjCnEj8i/Gt+KVSlkQqBNdtJLpXxLrVz+lklHRtWAA\nLsDAByM6pCQHQC9uh886QR0xrCU0iCHbf5Zsa/cWL4nXjvgMz25EgfVSK1qRt+0+\nL7sM6NSZLvlccRcDHqjUo3CfNpj1E6GEttAlE45vrQZlW8g5adALeTEzUkc=\n-----END RSA PRIVATE KEY-----','你任务中强制指定的主机，需要你来此添加信息，系统会通过此信息进行连接','2019-01-17 10:51:38');
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
) ENGINE=InnoDB AUTO_INCREMENT=5379 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1376 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=393 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_temp_details`
--

LOCK TABLES `scheduler_temp_details` WRITE;
/*!40000 ALTER TABLE `scheduler_temp_details` DISABLE KEYS */;
INSERT INTO `scheduler_temp_details` VALUES (1,'None',999,999,'测试一下','ls','wwdfd','hand','root','','ss','2018-11-08 16:09:04'),(3,'None',999,999,'测试一下','ls','wwdfd','hand','root','','ss','2018-11-08 16:09:27'),(4,'None',999,999,'sdafdsa','gdsas','dfasd','hand','root','gadssadfds','ss','2018-11-08 16:09:27'),(5,'None',999,999,'测试一下','ls','wwdfd','hand','root','','ss','2018-11-08 16:09:54'),(6,'None',999,999,'sdafdsa','gdsas','dfasd','hand','root','gadssadfds','ss','2018-11-08 16:09:54'),(7,'None',999,999,'测试一下','ls','wwdfd','hand','root','','ss','2018-11-08 16:10:25'),(8,'None',999,999,'sdafdsa','gdsas','dfasd','hand','root','gadssadfds','ss','2018-11-08 16:10:25'),(9,'None',999,999,'测试一下','ls','wwdfd','hand','root','','ss','2018-11-08 16:10:50'),(10,'None',999,999,'sdafdsa','gdsas','dfasd','hand','root','gadssadfds','ss','2018-11-08 16:10:50'),(11,'None',999,999,'测试一下','ls','wwdfd','hand','root','','ss','2018-11-08 16:11:39'),(12,'None',999,999,'sdafdsa','gdsas','dfasd','hand','root','gadssadfds','ss','2018-11-08 16:11:39'),(13,'None',999,999,'测试一下','ls','wwdfd','hand','root','','ss','2018-11-08 16:12:33'),(14,'None',999,999,'sdafdsa','gdsas','dfasd','hand','root','gadssadfds','ss','2018-11-08 16:12:33'),(149,'16',88,1,'ceshi3','echo  \"ceshi3\"','','hand','root','','yanghongfei','2018-11-09 17:20:22'),(150,'16',88,2,'ceshi4','echo \"ceshi4\"','','order','root','','yanghongfei','2018-11-09 17:20:22'),(151,'16',88,3,'ceshi5','echo \"ceshi5\"','','timed','root','','yanghongfei','2018-11-09 17:20:22'),(153,'3',88,88,'测试一下','sh /root/ops_scripts/yanghongfei/OfficeSite/game_prod_release.sh','wwdfd','hand','root','','ss','2018-11-12 15:27:57'),(154,'3',88,88,'测试一下','sh /root/ops_scripts/yanghongfei/OfficeSite/game_prod_release.sh','wwdfd','hand','root','','ss','2018-11-12 15:27:57'),(155,'3',88,88,'sdafdsa','gdsas','dfasd','hand','root','gadssadfds','ss','2018-11-12 15:27:57'),(184,'2',1,1,'测试一下','ls','wwdfd','order','root','xxx','ss','2018-11-12 17:00:24'),(185,'2',88,88,'测试一下','ls','wwdfd','hand','root','','ss','2018-11-12 17:00:24'),(186,'2',88,88,'sdafdsa','gdsas','dfasd','hand','root','gadssadfds','ss','2018-11-12 17:00:24'),(187,'2',88,88,'测试一下','ls','wwdfd','hand','root','','ss','2018-11-12 17:00:24'),(188,'2',88,88,'sdafdsa','gdsas','dfasd','hand','root','gadssadfds','ss','2018-11-12 17:00:24'),(189,'2',88,88,'dsaf','dgsdafg','d','hand','root','','ss','2018-11-12 17:00:24'),(190,'2',88,88,'ceshi1','ls','','hand','root','','ss','2018-11-12 17:00:24'),(191,'2',88,88,'ceshi2','pwd','','hand','root','','ss','2018-11-12 17:00:24'),(192,'2',88,88,'ceshi4','echo \"ceshi4\"','','hand','root','','ss','2018-11-12 17:00:24'),(193,'2',88,88,'ceshi5','echo \"ceshi5\"','','hand','root','','ss','2018-11-12 17:00:24'),(194,'2',88,88,'ceshi6','echo \"ceshi6\"','','hand','root','','ss','2018-11-12 17:00:24'),(195,'2',88,88,'ceshi7','echo \"ceshi7\"','','hand','root','','ss','2018-11-12 17:00:24'),(326,'1',1,1,'正确命令','ls -l','','timed','root','','ss','2018-11-28 17:09:38'),(327,'1',1,2,'测试休眠命令','ls && sleep 30  && ls /tmp','','order','root','','ss','2018-11-28 17:09:38'),(328,'1',1,3,'找不到命令的命令','python3  /tmp/shenshuo.py','','order','root','','ss','2018-11-28 17:09:38'),(329,'1',1,4,'正确命令','ls -l','','order','root','','ss','2018-11-28 17:09:38'),(330,'1',2,1,'测试一下','ls','wwdfd','hand','root','','ss','2018-11-28 17:09:38'),(331,'1',2,2,'sdafdsa','gdsas','dfasd','order','root','gadssadfds','ss','2018-11-28 17:09:38'),(332,'1',2,3,'测试一下','ls','wwdfd','order','root','','ss','2018-11-28 17:09:38'),(333,'1',3,1,'sdafdsa','gdsas','dfasd','timed','root','gadssadfds','ss','2018-11-28 17:09:38'),(336,'23',1,1,'测试一下','sh /root/ops_scripts/yanghongfei/OfficeSite/game_prod_release.sh','wwdfd','hand','root','','ss','2018-12-06 15:33:28'),(337,'23',1,2,'ceshi6','echo \"ceshi6\"','','hand','root','','ss','2018-12-06 15:33:28'),(348,'24',1,1,'【Server发布】获取配置信息','python3 /root/git/publish/get_publish_info.py','PUBLISH_NAME FLOW_ID','order','root','172.16.0.101','yanghongfei','2018-12-10 17:13:00'),(349,'24',1,2,'【Server发布】拉取代码','python3 /root/git/publish/server/pull_code.py','FLOW_ID PUBLISH_TAG','order','root','172.16.0.101','yanghongfei','2018-12-10 17:13:00'),(350,'24',1,3,'【Server发布】编译代码','python3 /root/git/publish/server/bulid_code.py','FLOW_ID','order','root','172.16.0.101','yanghongfei','2018-12-10 17:13:00'),(351,'24',1,4,'【Server发布】分发代码','python3 /root/git/publish/server/upload_code.py','FLOW_ID','order','root','172.16.0.101','yanghongfei','2018-12-10 17:13:00'),(352,'24',1,5,'【Server发布】备份代码','python3 /root/git/publish/server/backup_code.py','FLOW_ID','order','root','172.16.0.101','yanghongfei','2018-12-10 17:13:00'),(353,'24',1,6,'【Server发布】部署代码','python3 /root/git/publish/server/deploy_code.py','FLOW_ID','order','root','172.16.0.101','yanghongfei','2018-12-10 17:13:00'),(355,'25',1,1,'【Bucket发布】COS发布','python3 /root/git/publish/bucker/upload_cos.py','PUBLISH_NAME PUBLISH_TAG','order','root','172.16.0.101','yanghongfei','2018-12-11 17:01:53'),(356,'26',1,1,'【Bucket发布】OSS发布','python3 /root/git/publish/bucker/upload_oss.py','PUBLISH_NAME PUBLISH_TAG','order','root','172.16.0.101','yanghongfei','2018-12-12 16:37:54'),(358,'27',1,1,'【Bucket发布】S3发布','python3 /root/git/publish/bucker/upload_s3.py','PUBLISH_NAME PUBLISH_TAG','order','root','172.16.0.101','yanghongfei','2018-12-13 14:49:53'),(378,'28',1,1,'安装依赖','pip3 install -r /opt/ops_scripts/codo-publish/requirements.txt','','order','root','','yanghongfei','2018-12-29 10:36:37'),(379,'28',1,2,'【Server发布】获取配置信息','python3 /opt/ops_scripts/codo-publish/get_publish_info.py','PUBLISH_NAME FLOW_ID','order','root','','yanghongfei','2018-12-29 10:36:37'),(380,'28',1,3,'【Server发布】拉取代码','python3 /opt/ops_scripts/codo-publish/server/pull_code.py','FLOW_ID PUBLISH_TAG','order','root','','yanghongfei','2018-12-29 10:36:37'),(381,'28',1,4,'【Server发布】编译代码','python3 /opt/ops_scripts/codo-publish/server/bulid_code.py','FLOW_ID','order','root','','yanghongfei','2018-12-29 10:36:37'),(382,'28',1,5,'【Server发布】分发代码','python3 /opt/ops_scripts/codo-publish/server/upload_code.py','FLOW_ID','order','root','','yanghongfei','2018-12-29 10:36:37'),(383,'28',1,6,'【Server发布】备份代码','python3 /opt/ops_scripts/codo-publish/server/backup_code.py','FLOW_ID','order','root','','yanghongfei','2018-12-29 10:36:37'),(384,'28',1,7,'【Server发布】部署代码','python3 /opt/ops_scripts/codo-publish/server/deploy_code.py','FLOW_ID','timed','root','','yanghongfei','2018-12-29 10:36:37'),(385,'28',1,8,'重启NGINX进程','service nginx restart','','hand','root','','yanghongfei','2018-12-29 10:36:37'),(386,'29',1,1,'SQL优化-内网','python3.6 /opt/ops_scripts/codo-check/exec_sqladvisor.py','PUBLISH_NAME DB_NAME SQLS','order','root','172.16.0.230','ss','2019-01-08 15:28:41'),(387,'30',1,1,'【k8s发布】获取配置信息','python3 /opt/ops_scripts/codo-publish/get_publish_info.py','PUBLISH_NAME FLOW_ID','order','root','','ss','2019-01-15 14:57:27'),(388,'30',1,2,'【k8s发布】拉取代码','python3 /opt/ops_scripts/codo-publish/k8s/pull_code.py','FLOW_ID PUBLISH_TAG','order','root','','ss','2019-01-15 14:57:27'),(389,'30',1,4,'【k8s发布】编译代码','python3 /opt/ops_scripts/codo-publish/k8s/bulid_code.py','FLOW_ID','order','root','','ss','2019-01-15 14:57:27'),(390,'30',1,5,'【k8s发布】编译镜像并上传','python3 /opt/ops_scripts/codo-publish/k8s/bulid_image.py','FLOW_ID PUBLISH_TAG','order','root','','ss','2019-01-15 14:57:27'),(391,'30',1,6,'【k8sr发布】滚动升级并检查','python3 /opt/ops_scripts/codo-publish/k8s/deploy_app.py','FLOW_ID PUBLISH_TAG','timed','root','','ss','2019-01-15 14:57:27'),(392,'30',1,3,'代码检查','python3 /opt/ops_scripts/codo-check/exec_sonar.py	','PUBLISH_NAME PUBLISH_TAG','order','root','127.0.0.1','ss','2019-01-15 14:57:27');
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_temp_list`
--

LOCK TABLES `scheduler_temp_list` WRITE;
/*!40000 ALTER TABLE `scheduler_temp_list` DISABLE KEYS */;
INSERT INTO `scheduler_temp_list` VALUES (26,'OSS发布示例','yanghongfei','2018-12-12 16:37:32','2018-12-12 16:37:32'),(28,'Server发布示例','yanghongfei','2018-12-26 14:32:09','2018-12-26 14:32:09'),(29,'SQL优化-内网','ss','2019-01-08 15:28:16','2019-01-08 15:28:16'),(30,'kubernetes-CD-NW','ss','2019-01-15 14:35:32','2019-01-15 14:35:32');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_docker_registry`
--

LOCK TABLES `task_docker_registry` WRITE;
/*!40000 ALTER TABLE `task_docker_registry` DISABLE KEYS */;
INSERT INTO `task_docker_registry` VALUES (2,'demo','harbor.opendevops.cn/codo','admin','password','2019-01-17 10:49:05');
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
  `publish_hosts` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_hosts_api` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bucket_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bucket_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bucket_path` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SecretID` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SecretKey` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docker_registry` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `k8s_api` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `namespace` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `mail_to` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `k8s_host` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_file` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `publish_name` (`publish_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_publish_config`
--

LOCK TABLES `task_publish_config` WRITE;
/*!40000 ALTER TABLE `task_publish_config` DISABLE KEYS */;
INSERT INTO `task_publish_config` VALUES (9,'demo','service','https://github.com/opendevops-cn/opendevops','127.0.0.1','.git/\n.svn/','Server发布示例',NULL,'/var/www/demo','10.0.0.10 22 root password\n10.0.0.20 22 root password','http://demo.yanghongfei.me/api/cmdb/v1/cmdb/all_server/?group=demo','oss','','','','','','','','','2019-01-17 10:46:29','demo@opendevops.cn',NULL,NULL),(10,'OSS','bucket','https://github.com/opendevops-cn/opendevops','127.0.0.1','.git/\n.svn/','Server发布示例',NULL,'/var/www/demo','10.0.0.10 22 root password\n10.0.0.20 22 root password','http://demo.yanghongfei.me/api/cmdb/v1/cmdb/all_server/?group=demo','oss','cn-shanghai','opendevops','','Access_ID','Access_Key','','','','2019-01-17 10:47:58','demo@opendevops.cn',NULL,NULL);
/*!40000 ALTER TABLE `task_publish_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `codo_cron`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `codo_cron` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `codo_cron`;

--
-- Table structure for table `apscheduler_jobs`
--

DROP TABLE IF EXISTS `apscheduler_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apscheduler_jobs` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `next_run_time` double DEFAULT NULL,
  `job_state` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_apscheduler_jobs_next_run_time` (`next_run_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apscheduler_jobs`
--

LOCK TABLES `apscheduler_jobs` WRITE;
/*!40000 ALTER TABLE `apscheduler_jobs` DISABLE KEYS */;
INSERT INTO `apscheduler_jobs` VALUES ('ls_test',NULL,'���\0\0\0\0\0\0}�(�version�K�id��ls_test��func��\Zcron.applications:exec_cmd��trigger��apscheduler.triggers.cron��CronTrigger���)��}�(hK�timezone��pytz��_p���(�\rAsia/Shanghai�M�qK\0�LMT�t�R��\nstart_date�N�end_date�N�fields�]�(� apscheduler.triggers.cron.fields��	BaseField���)��}�(�name��year��\nis_default���expressions�]��%apscheduler.triggers.cron.expressions��\rAllExpression���)��}��step�Nsbaubh�\nMonthField���)��}�(h�month�h�h ]�h$)��}�h\'Nsbaubh�DayOfMonthField���)��}�(h�day�h�h ]�h$)��}�h\'Nsbaubh�	WeekField���)��}�(h�week�h�h ]�h$)��}�h\'Nsbaubh�DayOfWeekField���)��}�(h�day_of_week�h�h ]�h$)��}�h\'Nsbaubh\Z)��}�(h�hour�h�h ]�h\"�RangeExpression���)��}�(h\'N�first�K�last�Kubaubh\Z)��}�(h�minute�h�h ]�h$)��}�h\'Ksbaubh\Z)��}�(h�second�h�h ]�hM)��}�(h\'NhPK\nhQK\nubaube�jitter�Nub�executor��default��args�)�kwargs�}�(�cmd��\nls -l /tmp��job_id�huh�exec_cmd��misfire_grace_time�K�coalesce���\rmax_instances�K�\rnext_run_time�Nu.');
/*!40000 ALTER TABLE `apscheduler_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cron_log`
--

DROP TABLE IF EXISTS `cron_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cron_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_cmd` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_log` text COLLATE utf8mb4_unicode_ci,
  `exec_time` datetime DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1336 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cron_log`
--

LOCK TABLES `cron_log` WRITE;
/*!40000 ALTER TABLE `cron_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cron_log` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2019-01-17 10:56:56
