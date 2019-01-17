-- MySQL dump 10.14  Distrib 5.5.60-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: codo_task
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
INSERT INTO `scheduler_execute_user` VALUES (2,'root',22,'shinezone20181121','-----BEGIN RSA PRIVATE KEY-----\nMIIJKAIBAAKCAgEA3Lgs3t8B+JQ2mP4DybeYYm/Dl7eE5euk+/bkVD3ASIwlQ+34\nwHRXdiagUlVSKL2K5XQ4gArjF77VOJFFKc+kORGxG3YybI0mYxy6PlVsGYGTcDUZ\n88OEvaKglT0tG9hTDrtqDcOFuXqfOZIasicf6P+AFGd7FLOoaQWZw2BH4TcY0YN5\nacBQxAKlWRu2LPHUd06wY3ZF77YCIBsH29acZUVSd5tEvTl0BtkoxsfJKt4jM3Er\ndrHoW1BosFtAZeuy6D73ALrkK5dd9dXKGdLr3cUv1G9cX/o+uyJCsKsyd/1sctRw\n1I41l7jtumTGNGEE31SqHRXJD0PD1ky2JTLYqo4PkIP/0pqydlet4u2mA6xio7h5\np8HEV1ShGvVUsDJuqM5NO8ra+dVMKYc0HDCL/JdoPb6Ov1t1yl6jjj+okfn7C2eu\n+5rcG19b0HBYDNrUGyvbwbqWbIh0axi94DKSWGmf3L6RPDPCdBOMNhNJv8Rhv336\nInUtCte2D0OS2Rl/n0/YkJ1z\npvfZwAMCAwEA\nAQKCAEKQzNpxH\n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\n-----END RSA PRIVATE KEY-----','你任务中强制指定的主机，需要你来此添加信息，系统会通过此信息进行连接','2019-01-17 10:51:38');
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-17 11:08:18
