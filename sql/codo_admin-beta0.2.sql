-- MySQL dump 10.14  Distrib 5.5.60-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: codo_admin
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_app_settings`
--

LOCK TABLES `mg_app_settings` WRITE;
/*!40000 ALTER TABLE `mg_app_settings` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_components`
--

LOCK TABLES `mg_components` WRITE;
/*!40000 ALTER TABLE `mg_components` DISABLE KEYS */;
INSERT INTO `mg_components` VALUES (2,'edit_button','0'),(3,'publish_button','0'),(7,'cessss','0'),(8,'reset_mfa_btn','0'),(9,'reset_pwd_btn','0'),(10,'new_user_btn','0'),(12,'get_token_btn','0');
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
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_functions`
--

LOCK TABLES `mg_functions` WRITE;
/*!40000 ALTER TABLE `mg_functions` DISABLE KEYS */;
INSERT INTO `mg_functions` VALUES (6,'ss','/login/','ALL','10','2018-03-21 10:29:14','2018-03-20 18:35:24'),(9,'管理员','/','ALL','0','2018-03-21 14:04:59','2018-03-21 14:04:59'),(10,'任务管理员','/task/v2/task/','ALL','0','2019-03-21 10:57:54','2018-03-22 10:09:10'),(12,'修改密码','/mg/v2/accounts/password/','PATCH','0','2019-03-21 11:07:20','2018-03-22 16:27:12'),(15,'提交任务','/task/v2/task/accept/','POST','0','2019-03-21 10:57:29','2018-06-08 09:26:00'),(16,'获取CSRF','/task/v2/task/accept/','GET','0','2018-12-27 13:16:41','2018-06-08 09:26:51'),(33,'发布配置','/task/v2/task_other/publish_cd/','GET','0','2018-12-05 09:59:48','2018-12-05 09:37:24'),(34,'CMDB-资产访问','/cmdb/v1/cmdb/all_server/','GET','0','2019-01-04 16:21:23','2018-12-05 16:58:06'),(35,'系统用户获取','/mg/v2/accounts/','GET','0','2018-12-14 14:44:51','2018-12-14 14:40:48'),(36,'发送邮件','/mg/v2/notifications/mail/','POST','0','2018-12-27 13:11:20','2018-12-27 13:11:20'),(37,'获取前端权限','/accounts/authorization/','GET','0','2018-12-27 16:28:07','2018-12-27 16:28:07'),(38,'获取镜像仓库信息','/task/v2/task_other/docker_registry/','GET','0','2019-01-14 16:12:58','2019-01-14 16:12:58'),(39,'已发布配置获取','/kerrigan/v1/conf/publish/','GET','0','2019-01-29 16:01:36','2019-01-29 16:01:36'),(40,'钩子提交任务','/task/v2/task/accept/','POST','0','2019-03-18 16:49:01','2019-03-18 16:48:48'),(42,'获取订单','/task/v2/task/list/','GET','0','2019-03-21 10:55:51','2019-03-21 10:55:51'),(43,'超管注册用户','/mg/register/','POST','0','2019-03-21 11:08:50','2019-03-21 11:05:28'),(44,'超管重置MFA','/mg/v2/accounts/reset_mfa/','PUT','0','2019-03-21 11:09:42','2019-03-21 11:09:42'),(45,'超管重置用户密码','/mg/v2/accounts/reset_pw/','PUT','0','2019-03-21 11:10:18','2019-03-21 11:10:18'),(46,'查看系统配置','/mg/v2/sysconfig/settings/','GET','0','2019-03-21 11:11:32','2019-03-21 11:11:32'),(47,'修改系统配置','/mg/v2/sysconfig/settings/','POST','0','2019-03-21 11:12:09','2019-03-21 11:12:09'),(48,'测试邮件和短信','/mg//v2/sysconfig/check/','POST','0','2019-03-21 11:12:40','2019-03-21 11:12:40'),(49,'用户管理所有权限','/mg//v2/accounts/','ALL','0','2019-03-21 11:13:43','2019-03-21 11:13:43'),(50,'发送短信API','/mg/v2/notifications/sms/','POST','0','2019-03-21 11:15:19','2019-03-21 11:15:19'),(51,'发送邮件API','/mg/v2/notifications/mail/','POST','0','2019-03-21 11:15:46','2019-03-21 11:15:46'),(52,'配置中心所有权限-项目要单独赋权','/kerrigan/v1/conf/','ALL','0','2019-03-21 11:40:13','2019-03-21 11:40:13'),(53,'调度任务日志','/task/ws/v1/task/log/','ALL','0','2019-04-12 09:22:39','2019-03-21 11:41:51'),(54,'查看任务详情','/task/v2/task/check/','GET','0','2019-03-21 11:47:15','2019-03-21 11:47:15'),(55,'查看历史任务','/task/v2/task/check_history/','GET','0','2019-03-21 12:09:43','2019-03-21 11:51:44'),(56,'干预调度任务','/task/v2/task/check/','PUT','0','2019-03-21 12:00:17','2019-03-21 11:54:50'),(57,'调度任务审批-重做-终止','/task/v2/task/check/','PATCH','0','2019-03-21 11:55:35','2019-03-21 11:55:35'),(59,'调度任务模板','/task/v2/task_layout/','ALL','0','2019-03-21 11:57:36','2019-03-21 11:57:36'),(60,'调度任务全部终止','/task/v2/task/list/','PUT','0','2019-03-21 12:00:39','2019-03-21 12:00:39'),(61,'资产管理查看主机','/cmdb/v1/cmdb/server/','GET','0','2019-03-21 12:19:58','2019-03-21 12:05:00'),(62,'资产管理-查看主机组','/cmdb/v1/cmdb/server_group/','GET','0','2019-03-21 12:20:04','2019-03-21 12:05:18'),(63,'资产管理-查看审计日志','/cmdb/v1/cmdb/server_log/','GET','0','2019-03-21 12:20:08','2019-03-21 12:05:38'),(64,'数据库优化日志','/task/ws/v1/task/log_data/','ALL','0','2019-04-12 09:23:27','2019-04-12 09:23:27'),(65,'页面任务发布','/task//other/v1/submission/','ALL','0','2019-04-12 09:24:36','2019-04-12 09:24:36'),(66,'任务提交-发布','/task/other/v1/submission/publish/','ALL','0','2019-04-12 09:25:06','2019-04-12 09:25:06'),(67,'任务提交-数据库审计','/task/other/v1/submission/mysql_audit/','ALL','0','2019-04-12 09:25:55','2019-04-12 09:25:55'),(68,'任务提交-数据库优化','/task/other/v1/submission/mysql_opt/','ALL','0','2019-04-12 09:26:24','2019-04-12 09:26:24'),(69,'任务提交-自定义','/task/other/v1/submission/custom_task/','ALL','0','2019-04-12 09:26:54','2019-04-12 09:26:54'),(70,'任务提交-自定义-代理','/task/other/v1/submission/custom_task_proxy/','ALL','0','2019-04-12 09:27:49','2019-04-12 09:27:49'),(71,'任务提交-自定义-json','/task/other/v1/submission/post_task/','ALL','0','2019-04-12 09:28:18','2019-04-12 09:28:18');
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_menus`
--

LOCK TABLES `mg_menus` WRITE;
/*!40000 ALTER TABLE `mg_menus` DISABLE KEYS */;
INSERT INTO `mg_menus` VALUES (1,'home','0'),(2,'_home','0'),(3,'components','0'),(4,'count_to_page','0'),(5,'tables_page','0'),(6,'usermanage','0'),(7,'user','0'),(8,'role','0'),(9,'functions','0'),(10,'menus','0'),(12,'systemmanage','0'),(13,'system','0'),(14,'systemlog','0'),(18,'cron','0'),(19,'cronjobs','0'),(20,'cronlogs','0'),(22,'task_layout','0'),(23,'commandlist','0'),(24,'argslist','0'),(25,'templist','0'),(26,'order','0'),(27,'taskOrderList','0'),(28,'taskuser','0'),(29,'operation_center','0'),(30,'level_2_1','0'),(32,'mysqlAudit','0'),(33,'publishApp','0'),(34,'mysqlOptimize','0'),(35,'resourceApplication','0'),(37,'customTasks','0'),(38,'publishConfig','0'),(39,'codeRepository','0'),(40,'dockerRegistry','0'),(41,'cmdb','0'),(42,'server_list','0'),(43,'server_log','0'),(44,'server_auth','0'),(45,'server_group','0'),(46,'tag','0'),(47,'adm_user','0'),(48,'WebSSH','0'),(49,'SshRecord','0'),(50,'k8s','20'),(51,'project','20'),(52,'app','20'),(53,'project_publish','0'),(54,'publish_list','0'),(55,'statisticaldata','0'),(56,'statisticalImage','0'),(57,'historyTaskList','0'),(58,'server_db','0'),(59,'config_center','0'),(60,'project_config_list','0'),(61,'my_config_list','0'),(62,'confd','0'),(63,'confd_project','0'),(64,'confd_config','0'),(65,'devopstools','0'),(66,'prometheus_alert','0'),(68,'tagTree','0'),(69,'event_manager','0'),(70,'password_mycrypy','0'),(72,'proxyInfo','0'),(73,'paid_reminder','0'),(74,'project_manager','0'),(75,'postTasks','0'),(76,'taskCenter','0'),(77,'fault_manager','0'),(78,'assetPurchase','0'),(79,'nodeAdd','0'),(80,'customTasksProxy','0');
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
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_role_functions`
--

LOCK TABLES `mg_role_functions` WRITE;
/*!40000 ALTER TABLE `mg_role_functions` DISABLE KEYS */;
INSERT INTO `mg_role_functions` VALUES (3,'4','5','0','2017-12-21 14:26:04','2017-12-21 14:26:04'),(5,'1','5','0','2017-12-21 14:26:04','2017-12-21 14:26:04'),(6,'2','8','0','2018-03-22 10:19:26','2018-03-22 10:19:26'),(14,'3','9','0','2018-03-22 10:33:19','2018-03-22 10:33:19'),(19,'2','12','0','2018-03-26 16:33:34','2018-03-26 16:33:34'),(21,'2','9','0','2018-03-26 16:37:38','2018-03-26 16:37:38'),(27,'5','14','0','2018-04-11 14:20:42','2018-04-11 14:20:42'),(28,'9','16','0','2018-06-08 09:27:27','2018-06-08 09:27:27'),(29,'9','15','0','2018-06-08 09:27:28','2018-06-08 09:27:28'),(30,'10','17','0','2018-07-05 10:41:13','2018-07-05 10:41:13'),(31,'10','18','0','2018-07-10 09:46:46','2018-07-10 09:46:46'),(33,'11','8','0','2018-07-11 17:28:57','2018-07-11 17:28:57'),(34,'11','12','0','2018-07-11 17:29:01','2018-07-11 17:29:01'),(35,'11','19','0','2018-07-11 17:34:11','2018-07-11 17:34:11'),(36,'11','20','0','2018-07-11 17:35:19','2018-07-11 17:35:19'),(37,'11','24','0','2018-07-11 17:53:27','2018-07-11 17:53:27'),(38,'11','23','0','2018-07-11 17:53:28','2018-07-11 17:53:28'),(39,'11','22','0','2018-07-11 17:53:28','2018-07-11 17:53:28'),(40,'11','21','0','2018-07-11 17:53:29','2018-07-11 17:53:29'),(41,'11','25','0','2018-07-11 17:57:48','2018-07-11 17:57:48'),(42,'12','8','0','2018-07-17 16:09:54','2018-07-17 16:09:54'),(43,'12','12','0','2018-07-17 16:09:55','2018-07-17 16:09:55'),(44,'12','25','0','2018-07-17 16:09:58','2018-07-17 16:09:58'),(45,'12','24','0','2018-07-17 16:09:59','2018-07-17 16:09:59'),(46,'12','23','0','2018-07-17 16:10:00','2018-07-17 16:10:00'),(47,'12','22','0','2018-07-17 16:10:00','2018-07-17 16:10:00'),(48,'12','21','0','2018-07-17 16:10:01','2018-07-17 16:10:01'),(49,'12','20','0','2018-07-17 16:10:01','2018-07-17 16:10:01'),(50,'12','19','0','2018-07-17 16:10:02','2018-07-17 16:10:02'),(55,'12','18','0','2018-07-17 16:10:29','2018-07-17 16:10:29'),(56,'13','12','0','2018-08-02 17:37:32','2018-08-02 17:37:32'),(57,'13','15','0','2018-08-02 17:37:36','2018-08-02 17:37:36'),(59,'13','17','0','2018-08-02 17:37:45','2018-08-02 17:37:45'),(60,'13','19','0','2018-08-02 17:37:50','2018-08-02 17:37:50'),(61,'13','20','0','2018-08-02 17:37:51','2018-08-02 17:37:51'),(62,'13','24','0','2018-08-02 17:37:56','2018-08-02 17:37:56'),(63,'13','25','0','2018-08-02 17:37:58','2018-08-02 17:37:58'),(64,'13','8','0','2018-08-02 18:35:11','2018-08-02 18:35:11'),(65,'13','21','0','2018-08-02 18:37:16','2018-08-02 18:37:16'),(67,'13','23','0','2018-08-02 18:37:18','2018-08-02 18:37:18'),(68,'13','26','0','2018-08-02 19:11:43','2018-08-02 19:11:43'),(69,'12','15','0','2018-08-06 17:03:13','2018-08-06 17:03:13'),(70,'12','27','0','2018-08-06 17:04:07','2018-08-06 17:04:07'),(71,'14','8','0','2018-08-08 12:56:00','2018-08-08 12:56:00'),(72,'14','12','0','2018-08-08 12:56:01','2018-08-08 12:56:01'),(73,'14','15','0','2018-08-08 12:56:01','2018-08-08 12:56:01'),(74,'14','22','0','2018-08-08 12:56:27','2018-08-08 12:56:27'),(75,'14','23','0','2018-08-08 12:56:27','2018-08-08 12:56:27'),(76,'14','24','0','2018-08-08 12:56:27','2018-08-08 12:56:27'),(77,'14','25','0','2018-08-08 12:56:31','2018-08-08 12:56:31'),(78,'14','19','0','2018-08-08 12:56:43','2018-08-08 12:56:43'),(79,'14','20','0','2018-08-08 12:56:45','2018-08-08 12:56:45'),(80,'14','21','0','2018-08-08 12:56:48','2018-08-08 12:56:48'),(81,'12','28','0','2018-08-08 13:21:19','2018-08-08 13:21:19'),(82,'12','16','0','2018-08-08 13:23:02','2018-08-08 13:23:02'),(83,'13','16','0','2018-08-08 13:24:57','2018-08-08 13:24:57'),(84,'14','16','0','2018-08-08 13:25:02','2018-08-08 13:25:02'),(85,'15','8','0','2018-08-10 10:06:55','2018-08-10 10:06:55'),(86,'15','12','0','2018-08-10 10:06:56','2018-08-10 10:06:56'),(87,'15','15','0','2018-08-10 10:06:57','2018-08-10 10:06:57'),(88,'15','16','0','2018-08-10 10:06:57','2018-08-10 10:06:57'),(89,'15','19','0','2018-08-10 10:07:05','2018-08-10 10:07:05'),(90,'15','20','0','2018-08-10 10:07:07','2018-08-10 10:07:07'),(91,'15','21','0','2018-08-10 10:07:07','2018-08-10 10:07:07'),(92,'15','22','0','2018-08-10 10:07:07','2018-08-10 10:07:07'),(93,'15','23','0','2018-08-10 10:07:08','2018-08-10 10:07:08'),(94,'15','24','0','2018-08-10 10:07:08','2018-08-10 10:07:08'),(95,'15','25','0','2018-08-10 10:07:09','2018-08-10 10:07:09'),(97,'16','12','0','2018-08-10 17:04:30','2018-08-10 17:04:30'),(98,'16','15','0','2018-08-10 17:04:30','2018-08-10 17:04:30'),(99,'16','16','0','2018-08-10 17:04:32','2018-08-10 17:04:32'),(108,'15','29','0','2018-08-13 17:06:57','2018-08-13 17:06:57'),(109,'14','29','0','2018-08-13 17:07:00','2018-08-13 17:07:00'),(110,'13','29','0','2018-08-13 17:07:04','2018-08-13 17:07:04'),(111,'13','22','0','2018-09-13 09:26:02','2018-09-13 09:26:02'),(113,'2','18','0',NULL,NULL),(114,'2','19','0',NULL,NULL),(115,'22','8','0',NULL,NULL),(116,'22','19','0',NULL,NULL),(117,'22','9','0',NULL,NULL),(118,'23','9','0',NULL,NULL),(119,'23','8','0',NULL,NULL),(120,'23','15','0',NULL,NULL),(121,'23','23','0',NULL,NULL),(122,'23','24','0',NULL,NULL),(123,'23','32','0',NULL,NULL),(124,'23','10','0',NULL,NULL),(125,'23','18','0',NULL,NULL),(126,'23','29','0',NULL,NULL),(127,'23','21','0',NULL,NULL),(128,'23','12','0',NULL,NULL),(129,'23','17','0',NULL,NULL),(130,'23','22','0',NULL,NULL),(131,'23','27','0',NULL,NULL),(132,'23','20','0',NULL,NULL),(133,'23','26','0',NULL,NULL),(134,'23','19','0',NULL,NULL),(135,'23','16','0',NULL,NULL),(136,'23','25','0',NULL,NULL),(137,'23','28','0',NULL,NULL),(138,'25','33','0',NULL,NULL),(139,'2','34','0',NULL,NULL),(140,'10','34','0',NULL,NULL),(141,'10','35','0',NULL,NULL),(142,'25','36','0',NULL,NULL),(143,'25','16','0',NULL,NULL),(144,'25','34','0',NULL,NULL),(145,'25','38','0',NULL,NULL),(146,'25','39','0',NULL,NULL),(147,'25','21','0',NULL,NULL),(148,'25','22','0',NULL,NULL),(149,'25','23','0',NULL,NULL),(150,'25','27','0',NULL,NULL),(151,'25','40','0',NULL,NULL),(152,'3','24','0',NULL,NULL),(153,'3','16','0',NULL,NULL),(154,'3','18','0',NULL,NULL),(155,'3','39','0',NULL,NULL),(156,'3','12','0',NULL,NULL),(157,'3','8','0',NULL,NULL),(158,'3','15','0',NULL,NULL),(159,'3','22','0',NULL,NULL),(160,'3','28','0',NULL,NULL),(161,'3','36','0',NULL,NULL),(162,'3','38','0',NULL,NULL),(163,'3','35','0',NULL,NULL),(164,'3','17','0',NULL,NULL),(165,'3','20','0',NULL,NULL),(166,'3','19','0',NULL,NULL),(167,'3','26','0',NULL,NULL),(168,'3','10','0',NULL,NULL),(169,'3','21','0',NULL,NULL),(170,'3','27','0',NULL,NULL),(171,'3','29','0',NULL,NULL),(172,'3','40','0',NULL,NULL),(173,'3','34','0',NULL,NULL),(174,'3','37','0',NULL,NULL),(175,'3','23','0',NULL,NULL),(176,'3','25','0',NULL,NULL),(177,'3','33','0',NULL,NULL),(179,'16','42','0',NULL,NULL),(180,'16','54','0',NULL,NULL),(181,'16','53','0',NULL,NULL),(182,'16','57','0',NULL,NULL),(183,'16','56','0',NULL,NULL),(184,'16','60','0',NULL,NULL),(185,'26','62','0',NULL,NULL),(186,'26','63','0',NULL,NULL),(187,'26','61','0',NULL,NULL),(189,'16','55','0',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_role_menus`
--

LOCK TABLES `mg_role_menus` WRITE;
/*!40000 ALTER TABLE `mg_role_menus` DISABLE KEYS */;
INSERT INTO `mg_role_menus` VALUES (2,'2',NULL,'0'),(3,'2','8','0'),(5,'2','7','0'),(6,'2','1','0'),(7,'2','10','0'),(8,'2','2','0'),(9,'2','6','0'),(10,'2','9','0'),(11,'2','13','0'),(12,'2','12','0'),(13,'2','14','0'),(14,'3','12','0'),(15,'3','13','0'),(16,'3','14','0'),(17,'3','9','0'),(18,'3','8','0'),(19,'3','10','0'),(23,'5','14','0'),(25,'3','7','0'),(26,'2','20','0'),(27,'2','18','0'),(28,'2','19','0'),(29,'2','24','0'),(30,'2','23','0'),(31,'2','22','0'),(32,'2','25','0'),(33,'3','1','0'),(34,'3','19','0'),(35,'3','2','0'),(36,'3','4','0'),(37,'3','25','0'),(38,'3','22','0'),(39,'3','6','0'),(40,'3','20','0'),(41,'3','23','0'),(42,'3','5','0'),(43,'3','3','0'),(44,'3','24','0'),(45,'3','18','0'),(46,'2','27','0'),(47,'2','26','0'),(48,'2','28','0'),(49,'22','2','0'),(50,'22','1','0'),(51,'23','8','0'),(52,'23','23','0'),(53,'23','24','0'),(54,'23','4','0'),(55,'23','2','0'),(56,'23','10','0'),(57,'23','18','0'),(58,'23','6','0'),(59,'23','12','0'),(60,'23','27','0'),(61,'23','22','0'),(62,'23','26','0'),(63,'23','20','0'),(64,'23','1','0'),(65,'23','9','0'),(66,'23','14','0'),(67,'23','3','0'),(68,'23','5','0'),(69,'23','13','0'),(70,'23','7','0'),(71,'23','19','0'),(72,'23','25','0'),(73,'23','28','0'),(74,'2','29','0'),(75,'2','30','0'),(77,'2','35','0'),(78,'2','32','0'),(79,'2','34','0'),(80,'2','33','0'),(81,'2','37','0'),(82,'2','38','0'),(83,'2','39','0'),(84,'2','40','0'),(85,'2','41','0'),(86,'2','42','0'),(87,'2','43','0'),(88,'2','44','0'),(102,'2','55','0'),(103,'2','57','0'),(104,'2','56','0'),(105,'2','53','0'),(107,'2','54','0'),(110,'2','49','0'),(111,'2','46','0'),(112,'2','47','0'),(113,'2','48','0'),(114,'2','45','0'),(115,'2','58','0'),(116,'2','59','0'),(117,'2','60','0'),(118,'2','61','0'),(119,'2','62','0'),(120,'2','64','0'),(121,'2','63','0'),(122,'2','66','0'),(123,'2','65','0'),(125,'3','55','0'),(126,'3','32','0'),(127,'3','63','0'),(128,'3','60','0'),(129,'3','62','0'),(130,'3','28','0'),(131,'3','35','0'),(133,'3','44','0'),(134,'3','49','0'),(135,'3','58','0'),(136,'3','46','0'),(137,'3','41','0'),(138,'3','65','0'),(139,'3','43','0'),(140,'3','56','0'),(141,'3','61','0'),(142,'3','53','0'),(143,'3','39','0'),(144,'3','47','0'),(145,'3','59','0'),(146,'3','38','0'),(147,'3','42','0'),(149,'3','26','0'),(150,'3','66','0'),(151,'3','27','0'),(152,'3','29','0'),(153,'3','40','0'),(154,'3','54','0'),(155,'3','30','0'),(156,'3','34','0'),(157,'3','45','0'),(159,'3','37','0'),(160,'3','48','0'),(162,'3','64','0'),(163,'3','33','0'),(164,'3','57','0'),(165,'16','27','0'),(166,'16','55','0'),(167,'16','57','0'),(168,'16','26','0'),(169,'16','1','0'),(170,'16','2','0'),(171,'16','56','0'),(172,'2','68','0'),(173,'2','69','0'),(174,'3','68','0'),(175,'2','70','0'),(177,'2','72','0'),(178,'3','73','0'),(179,'2','73','0'),(180,'2','74','0'),(181,'2','75','0'),(182,'3','72','0'),(183,'3','69','0'),(184,'3','75','0'),(185,'2','76','0'),(186,'3','76','0'),(187,'2','77','0'),(188,'2','79','0'),(189,'2','78','0'),(190,'3','74','0'),(191,'3','70','0'),(192,'3','77','0'),(193,'3','78','0'),(194,'3','79','0'),(195,'2','80','0'),(196,'3','80','0');
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
INSERT INTO `mg_roles` VALUES (3,'admin','0','2017-12-21 14:26:04'),(25,'publish','0','2018-12-05 09:35:29'),(26,'home','0','2019-03-21 12:04:10');
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_roles_components`
--

LOCK TABLES `mg_roles_components` WRITE;
/*!40000 ALTER TABLE `mg_roles_components` DISABLE KEYS */;
INSERT INTO `mg_roles_components` VALUES (3,'3','3','0'),(6,'2','2','0'),(7,'2','3','0'),(8,'4','3','0'),(13,'3','10','0'),(14,'3','8','0'),(15,'3','9','0'),(16,'3','2','0'),(17,'3','7','0'),(18,'23','2','0'),(19,'23','10','0'),(20,'23','8','0'),(21,'23','3','0'),(22,'23','7','0'),(23,'23','9','0'),(24,'25','7','0'),(25,'25','8','0'),(26,'25','9','0'),(27,'25','2','0'),(28,'25','10','0'),(29,'25','3','0'),(31,'2','10','0'),(32,'2','8','0'),(33,'2','9','0'),(34,'2','12','0');
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
) ENGINE=InnoDB AUTO_INCREMENT=32857 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_user_roles`
--

LOCK TABLES `mg_user_roles` WRITE;
/*!40000 ALTER TABLE `mg_user_roles` DISABLE KEYS */;
INSERT INTO `mg_user_roles` VALUES (4,'3','2','0','2017-12-21 14:26:04','2017-12-21 14:26:04'),(5,'4','2','0','2017-12-21 14:26:04','2017-12-21 14:26:04'),(15,'5','5','0','2018-04-11 14:19:03','2018-04-11 14:19:03'),(18,'9','13','0','2018-06-08 09:27:55','2018-06-08 09:27:55'),(19,'4','13','0','2018-06-12 09:35:10','2018-06-12 09:35:10'),(23,'10','19','0','2018-07-05 10:41:25','2018-07-05 10:41:25'),(24,'11','5','0','2018-07-11 17:29:19','2018-07-11 17:29:19'),(28,'12','20','0','2018-07-17 16:12:04','2018-07-17 16:12:04'),(31,'13','22','0','2018-08-03 09:39:13','2018-08-03 09:39:13'),(32,'9','2','0','2018-08-07 17:31:06','2018-08-07 17:31:06'),(38,'12','11','0','2018-08-08 13:33:25','2018-08-08 13:33:25'),(40,'12','2','0','2018-08-08 13:34:11','2018-08-08 13:34:11'),(41,'14','23','0','2018-08-08 14:31:23','2018-08-08 14:31:23'),(44,'15','24','0','2018-08-10 10:11:11','2018-08-10 10:11:11'),(45,'16','26','0','2018-08-10 17:03:46','2018-08-10 17:03:46'),(48,'14','25','0','2018-08-14 14:49:51','2018-08-14 14:49:51'),(49,'3','20','0','2018-09-03 16:35:04','2018-09-03 16:35:04'),(32832,'2','2','0','2018-10-24 14:04:27','2018-10-24 14:04:27'),(32837,'2','20','0','2018-11-26 17:42:24','2018-11-26 17:42:24'),(32838,'22','54','0','2018-11-28 11:08:54','2018-11-28 11:08:54'),(32839,'23','55','0','2018-11-28 17:51:24','2018-11-28 17:51:24'),(32840,'25','56','0','2018-12-05 09:35:38','2018-12-05 09:35:38'),(32841,'3','57','0','2018-12-11 13:11:06','2018-12-11 13:11:06'),(32842,'2','57','0','2018-12-11 13:12:10','2018-12-11 13:12:10'),(32845,'3','59','0','2019-03-19 17:13:33','2019-03-19 17:13:33'),(32846,'3','58','0','2019-03-19 17:13:33','2019-03-19 17:13:33'),(32847,'2','59','0','2019-03-19 17:16:46','2019-03-19 17:16:46'),(32848,'2','58','0','2019-03-19 17:16:46','2019-03-19 17:16:46'),(32849,'12','59','0','2019-03-19 17:17:04','2019-03-19 17:17:04'),(32850,'12','58','0','2019-03-19 17:17:04','2019-03-19 17:17:04'),(32851,'16','61','0','2019-03-21 10:51:28','2019-03-21 10:51:28'),(32852,'16','11','0','2019-03-21 11:44:22','2019-03-21 11:44:22'),(32853,'26','11','0','2019-03-21 12:06:04','2019-03-21 12:06:04'),(32854,'26','26','0','2019-03-21 12:06:04','2019-03-21 12:06:04'),(32855,'3','11','0','2019-03-21 12:28:50','2019-03-21 12:28:50'),(32856,'2','11','0','2019-03-28 18:23:08','2019-03-28 18:23:08');
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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_users`
--

LOCK TABLES `mg_users` WRITE;
/*!40000 ALTER TABLE `mg_users` DISABLE KEYS */;
INSERT INTO `mg_users` VALUES (11,'admin','66e7bcb387a66f2bf98ad62de7b8a82c','admin','admin@opendevops.cn','10000000001','15537065606','610','OPS','0','0','172.16.80.17','2019-04-12 16:42:09','2018-05-29 09:15:22',NULL,''),(56,'publish','7d491c440ba46ca20fde0c5be1377aec','publish','publish@opendevops.cn','10000000000','publish','9527','system','10','0','118.25.93.166','2019-04-12 10:11:02','2018-12-04 18:40:05',NULL,'');
/*!40000 ALTER TABLE `mg_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mysql_list`
--

DROP TABLE IF EXISTS `mysql_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mysql_list` (
  `mysql_id` int(11) NOT NULL AUTO_INCREMENT,
  `db_mark` varchar(20) NOT NULL,
  `app_id` int(11) NOT NULL,
  `department` varchar(50) NOT NULL,
  `project_name` varchar(50) NOT NULL,
  `app_name` varchar(50) NOT NULL,
  `role` varchar(10) NOT NULL,
  `version` varchar(10) NOT NULL,
  `instance_type` varchar(20) NOT NULL,
  `db_name` varchar(50) DEFAULT NULL,
  `db_host` varchar(60) DEFAULT NULL,
  `db_port` int(11) NOT NULL,
  `db_user` varchar(10) NOT NULL,
  `db_password` varchar(40) NOT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`mysql_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mysql_list`
--

LOCK TABLES `mysql_list` WRITE;
/*!40000 ALTER TABLE `mysql_list` DISABLE KEYS */;
INSERT INTO `mysql_list` VALUES (1,'OPS-OR-01-M01',1,'OPS','ELK','ELK','master','5.7','t2.micro','db name','xxxx',3306,'ops_user','shenshuo','2018-04-19 10:57:10'),(2,'OPS-OR-02-M01',2,'OPS','zabbix','zabbix','master','5.7','t2.small','zabbix db','dddd',3306,'ops_user','shenshuo','2018-04-19 14:45:23'),(3,'OPS-VA-test01-M01',1,'OPS','TEST','TEST','master','5.7','db.t2.micro','test','test.cpv0ldyxbi1j.us-east-1.rds.amazonaws.com',3306,'ops_user','aabb1122','2018-04-24 11:02:46');
/*!40000 ALTER TABLE `mysql_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operation_record`
--

DROP TABLE IF EXISTS `operation_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operation_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `method` varchar(10) NOT NULL,
  `uri` varchar(150) NOT NULL,
  `data` longtext,
  `ctime` datetime DEFAULT NULL,
  `login_ip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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

-- Dump completed on 2019-04-12 16:55:48
