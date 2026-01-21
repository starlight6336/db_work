CREATE DATABASE  IF NOT EXISTS `mental` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mental`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: mental
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `arrangement`
--

DROP TABLE IF EXISTS `arrangement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arrangement` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` bigint DEFAULT NULL,
  `user_type` tinyint(1) DEFAULT NULL,
  `sid` bigint DEFAULT NULL,
  `day_of_week` smallint DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arrangement`
--

LOCK TABLES `arrangement` WRITE;
/*!40000 ALTER TABLE `arrangement` DISABLE KEYS */;
INSERT INTO `arrangement` VALUES (1,7,3,1,1,'09:00:00','09:30:00','2024-01-11 15:14:57','2024-01-11 15:14:57',0),(2,7,3,1,1,'14:00:00','14:30:00','2024-01-11 15:18:08','2024-01-11 15:18:08',0),(3,8,3,1,2,'09:00:00','09:30:00','2024-01-11 15:18:52','2024-01-11 15:18:52',0),(4,8,3,1,2,'14:00:00','14:30:00','2024-01-11 15:19:09','2024-01-11 15:19:09',0),(5,9,3,1,3,'09:00:00','09:30:00','2024-01-11 15:19:27','2024-01-11 15:19:27',0),(6,9,3,1,3,'14:00:00','14:30:00','2024-01-11 15:19:38','2024-01-11 15:19:38',0),(7,11,5,1,3,'14:00:00','15:00:00','2024-01-11 15:28:02','2024-01-11 15:28:02',0),(8,11,5,1,3,'09:00:00','10:00:00','2024-01-11 15:28:18','2024-01-11 15:28:18',0),(9,12,5,1,4,'09:00:00','10:00:00','2024-01-11 15:28:25','2024-01-11 15:28:25',0),(10,12,5,1,4,'14:00:00','15:00:00','2024-01-11 15:28:31','2024-01-11 15:28:31',0),(11,13,5,1,5,'09:00:00','10:00:00','2024-01-11 15:28:41','2024-01-11 15:28:41',0),(12,13,5,1,5,'14:00:00','15:00:00','2024-01-11 15:28:45','2024-01-11 15:28:55',1),(13,13,5,1,5,'14:00:00','15:00:00','2024-01-11 15:28:57','2024-01-11 15:28:57',0),(14,11,5,1,3,'16:00:00','17:00:00','2024-01-11 15:31:03','2024-01-11 15:31:03',0),(15,13,5,1,5,'16:00:00','17:00:00','2024-01-11 15:46:52','2024-01-11 15:46:52',0),(16,9,3,1,3,'14:30:00','15:00:00','2024-01-11 19:23:57','2024-01-11 19:23:57',0);
/*!40000 ALTER TABLE `arrangement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultation`
--

DROP TABLE IF EXISTS `consultation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rid` bigint DEFAULT NULL,
  `fid` bigint DEFAULT NULL,
  `tid2` bigint DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `week_day` smallint DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `state` smallint DEFAULT NULL,
  `detail` varchar(1000) DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultation`
--

LOCK TABLES `consultation` WRITE;
/*!40000 ALTER TABLE `consultation` DISABLE KEYS */;
INSERT INTO `consultation` VALUES (1,2,1,11,'2023-12-06','2024-01-03',3,'09:00:00','10:00:00',4,'此人骨骼清奇，适合来软院修电脑','2024-01-11 08:00:32','2024-01-11 16:25:34',0),(2,1,3,12,'2024-01-11','2024-02-01',4,'09:00:00','10:00:00',3,NULL,'2024-01-11 16:42:12','2024-01-11 16:42:12',0),(3,2,24,12,'2023-11-23','2023-11-30',4,'09:00:00','10:00:00',4,'还行，小伙子恢复得挺快得','2024-01-11 18:56:14','2024-01-11 18:59:14',0),(4,2,25,12,'2023-11-23','2023-12-28',4,'14:00:00','15:00:00',4,'搞这个人可是花了我好久','2024-01-11 18:59:14','2024-01-11 19:13:41',0),(5,2,26,12,'2024-01-04','2024-01-25',4,'14:00:00','15:00:00',3,NULL,'2024-01-11 19:13:41','2024-01-11 19:13:41',0),(6,1,27,11,'2024-01-17','2024-02-07',3,'09:00:00','10:00:00',2,NULL,'2024-01-11 19:27:36','2024-01-11 19:27:36',0),(7,1,28,11,'2024-01-17','2024-02-07',3,'14:00:00','15:00:00',2,NULL,'2024-01-11 19:27:36','2024-01-11 19:27:36',0),(8,NULL,31,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2024-01-11 19:37:16','2024-01-11 19:37:16',0),(9,NULL,32,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2024-01-11 19:37:16','2024-01-11 19:37:16',0);
/*!40000 ALTER TABLE `consultation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultation_extend_request`
--

DROP TABLE IF EXISTS `consultation_extend_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultation_extend_request` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cid` bigint DEFAULT NULL,
  `times` smallint DEFAULT NULL,
  `reason` varchar(300) DEFAULT NULL,
  `is_solved` tinyint(1) DEFAULT '0',
  `state` tinyint(1) DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultation_extend_request`
--

LOCK TABLES `consultation_extend_request` WRITE;
/*!40000 ALTER TABLE `consultation_extend_request` DISABLE KEYS */;
INSERT INTO `consultation_extend_request` VALUES (1,1,1,'这byd放我鸽子',1,1,'2024-01-11 08:07:56','2024-01-11 19:05:18',0),(2,4,2,'再来两次用用',1,1,'2024-01-11 19:05:18','2024-01-11 19:05:18',0),(3,5,1,'再来一次用用',0,NULL,'2024-01-11 12:42:46','2024-01-11 12:42:46',0);
/*!40000 ALTER TABLE `consultation_extend_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultation_record`
--

DROP TABLE IF EXISTS `consultation_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultation_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cid` bigint DEFAULT NULL,
  `is_done` tinyint(1) DEFAULT '0',
  `result` smallint DEFAULT NULL,
  `record` varchar(600) DEFAULT NULL,
  `consult_date` date DEFAULT NULL,
  `week_day` smallint DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultation_record`
--

LOCK TABLES `consultation_record` WRITE;
/*!40000 ALTER TABLE `consultation_record` DISABLE KEYS */;
INSERT INTO `consultation_record` VALUES (1,1,1,1,'长得挺帅的','2023-12-06',3,'09:00:00','10:00:00','2024-01-11 08:01:42','2024-01-11 08:01:42',0),(2,1,1,1,'说话也很好听','2023-12-13',3,'09:00:00','10:00:00','2024-01-11 08:01:42','2024-01-11 08:01:42',0),(3,1,1,2,'好像有点脑残阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴','2023-12-20',3,'09:00:00','10:00:00','2024-01-11 08:01:42','2024-01-11 19:15:28',0),(4,1,1,1,'适合修电脑','2023-12-27',3,'09:00:00','10:00:00','2024-01-11 08:01:42','2024-01-11 08:01:42',0),(5,1,1,1,'果然很适合修电脑','2024-01-03',3,'09:00:00','10:00:00','2024-01-11 16:23:16','2024-01-11 16:23:50',0),(6,2,1,1,'按时到了，可以的','2024-01-11',4,'09:00:00','10:00:00','2024-01-11 16:42:52','2024-01-11 16:42:52',0),(7,2,0,NULL,NULL,'2024-01-18',4,'09:00:00','10:00:00','2024-01-11 16:42:52','2024-01-11 19:01:53',0),(8,2,0,NULL,NULL,'2024-01-25',4,'09:00:00','10:00:00','2024-01-11 16:42:52','2024-01-11 19:01:53',0),(9,2,0,NULL,NULL,'2024-02-01',4,'09:00:00','10:00:00','2024-01-11 16:42:52','2024-01-11 19:01:53',0),(10,3,1,1,'怎么感觉挺正常地','2023-11-23',4,'09:00:00','10:00:00','2024-01-11 19:01:53','2024-01-11 19:01:53',0),(11,3,1,1,'放他走吧','2023-11-30',4,'09:00:00','10:00:00','2024-01-11 19:01:53','2024-01-11 19:01:53',0),(12,3,0,NULL,NULL,'2023-12-07',4,'09:00:00','10:00:00','2024-01-11 19:01:53','2024-01-11 19:01:53',1),(13,3,0,NULL,NULL,'2023-12-14',4,'09:00:00','10:00:00','2024-01-11 19:01:53','2024-01-11 19:01:53',1),(14,4,1,1,'一一一','2023-11-23',4,'14:00:00','15:00:00','2024-01-11 19:04:43','2024-01-11 19:15:28',0),(15,4,1,1,'二二二二','2023-11-30',4,'14:00:00','15:00:00','2024-01-11 19:04:43','2024-01-11 19:15:28',0),(16,4,1,1,'三三三三三','2023-12-07',4,'14:00:00','15:00:00','2024-01-11 19:04:43','2024-01-11 19:15:28',0),(17,4,1,1,'四四四','2023-12-14',4,'14:00:00','15:00:00','2024-01-11 19:04:43','2024-01-11 19:15:28',0),(18,4,1,1,'五五五五','2023-12-21',4,'14:00:00','15:00:00','2024-01-11 19:04:43','2024-01-11 19:15:28',0),(19,4,1,1,'六六六六六','2023-12-28',4,'14:00:00','15:00:00','2024-01-11 19:04:43','2024-01-11 19:15:28',0),(20,5,1,1,'我是一个一','2024-01-04',4,'14:00:00','15:00:00','2024-01-11 19:15:28','2024-01-11 19:15:28',0),(21,5,1,1,'我是二','2024-01-11',4,'14:00:00','15:00:00','2024-01-11 19:15:28','2024-01-11 19:15:28',0),(22,5,0,NULL,NULL,'2024-01-18',4,'14:00:00','15:00:00','2024-01-11 19:15:28','2024-01-11 19:37:43',0),(23,5,0,NULL,NULL,'2024-01-25',4,'14:00:00','15:00:00','2024-01-11 19:15:28','2024-01-11 19:37:43',0),(24,6,0,NULL,NULL,'2024-01-17',3,'09:00:00','10:00:00','2024-01-11 19:30:37','2024-01-11 19:37:43',0),(25,6,0,NULL,NULL,'2024-01-24',3,'09:00:00','10:00:00','2024-01-11 19:30:37','2024-01-11 19:37:43',0),(26,6,0,NULL,NULL,'2024-01-31',3,'09:00:00','10:00:00','2024-01-11 19:30:37','2024-01-11 19:37:43',0),(27,6,0,NULL,NULL,'2024-02-07',3,'09:00:00','10:00:00','2024-01-11 19:30:37','2024-01-11 19:37:43',0),(28,7,0,NULL,NULL,'2024-01-17',3,'14:00:00','15:00:00','2024-01-11 19:30:37','2024-01-11 19:37:43',0),(29,7,0,NULL,NULL,'2024-01-24',3,'14:00:00','15:00:00','2024-01-11 19:30:37','2024-01-11 19:37:43',0),(30,7,0,NULL,NULL,'2024-01-31',3,'14:00:00','15:00:00','2024-01-11 19:30:37','2024-01-11 19:37:43',0),(31,7,0,NULL,NULL,'2024-02-07',3,'14:00:00','15:00:00','2024-01-11 19:30:37','2024-01-11 19:37:43',0);
/*!40000 ALTER TABLE `consultation_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dictionary`
--

DROP TABLE IF EXISTS `dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dictionary` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dic_type` varchar(20) DEFAULT NULL,
  `dic_key` smallint DEFAULT NULL,
  `dic_value` varchar(50) DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dictionary`
--

LOCK TABLES `dictionary` WRITE;
/*!40000 ALTER TABLE `dictionary` DISABLE KEYS */;
INSERT INTO `dictionary` VALUES (1,'来访主题',1,'自我探索与成长','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(2,'来访主题',2,'感情问题','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(3,'来访主题',3,'人际关系','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(4,'来访主题',4,'心理测试解释','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(5,'来访主题',5,'性别认同与同性恋','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(6,'来访主题',6,'情绪困扰','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(7,'来访主题',7,'学习问题','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(8,'来访主题',8,'心理治疗问题','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(9,'来访主题',9,'生涯规划和未来','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(10,'来访主题',10,'家庭问题','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(11,'来访主题',11,'其它','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(12,'自述紧急程度',1,'一般','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(13,'自述紧急程度',2,'紧急','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(14,'自述紧急程度',3,'非常紧急','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(15,'初访状态',1,'等待安排','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(16,'初访状态',2,'待确认','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(17,'初访状态',3,'匹配成功 等待访谈','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(18,'初访状态',4,'等待新安排','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(19,'初访状态',5,'放弃排队','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(20,'初访状态',6,'已拒绝','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(21,'初访状态',7,'访谈中','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(22,'初访状态',8,'已结束','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(23,'初访状态',9,'已取消','2024-01-06 16:18:01','2024-01-07 15:39:36',0),(24,'初访状态',10,'未提交','2024-01-09 14:17:43','2024-01-09 14:17:43',0),(25,'初访状态',11,'已撤销','2024-01-12 10:10:19','2024-01-12 10:10:19',0),(26,'初访结论',1,'无需咨询','2024-01-07 15:27:41','2024-01-12 10:10:06',0),(27,'初访结论',2,'安排咨询','2024-01-07 15:27:41','2024-01-12 10:10:06',0),(28,'初访结论',3,'转介送诊','2024-01-07 15:27:41','2024-01-12 10:10:06',0),(29,'危机等级',1,'低','2024-01-07 15:36:09','2024-01-12 10:10:06',0),(30,'危机等级',2,'中','2024-01-07 15:36:09','2024-01-12 10:10:06',0),(31,'危机等级',3,'高','2024-01-07 15:36:09','2024-01-12 10:10:06',0),(32,'问题类型',1,'自我问题','2024-01-07 15:36:09','2024-01-12 10:10:06',0),(33,'问题类型',2,'恋爱与性心理','2024-01-07 15:36:09','2024-01-12 10:10:06',0),(34,'问题类型',3,'性别认同与同性恋','2024-01-07 15:36:09','2024-01-12 10:10:06',0),(35,'问题类型',4,'人际关系问题','2024-01-07 15:36:09','2024-01-12 10:10:06',0),(36,'问题类型',5,'学习问题','2024-01-07 15:36:09','2024-01-12 10:10:06',0),(37,'问题类型',6,'家庭矛盾问题','2024-01-07 15:36:09','2024-01-12 10:10:06',0),(38,'问题类型',7,'新生适应问题','2024-01-07 15:36:09','2024-01-12 10:10:06',0),(39,'问题类型',8,'应激反应','2024-01-07 15:36:09','2024-01-12 10:10:06',0),(40,'问题类型',9,'疑似','2024-01-07 15:37:34','2024-01-12 10:10:06',0),(41,'问题类型',10,'确诊','2024-01-07 17:27:35','2024-01-12 10:10:06',0),(42,'问题类型',11,'其它','2024-01-07 17:27:35','2024-01-12 10:10:06',0),(43,'病症',1,'抑郁症','2024-01-07 17:30:39','2024-01-12 10:10:06',0),(44,'病症',2,'焦虑症','2024-01-07 17:30:39','2024-01-12 10:10:06',0),(45,'病症',3,'双向情感障碍','2024-01-07 17:30:39','2024-01-12 10:10:06',0),(46,'病症',4,'精神分裂症','2024-01-07 17:30:39','2024-01-12 10:10:06',0),(47,'病症',5,'人格障碍','2024-01-07 17:30:39','2024-01-12 10:10:06',0),(48,'病症',6,'强迫症','2024-01-07 17:30:39','2024-01-12 10:10:06',0),(49,'病症',7,'恶劣环境','2024-01-07 17:30:39','2024-01-12 10:10:06',0),(50,'病症',8,'适应障碍','2024-01-07 17:30:39','2024-01-12 10:10:06',0),(51,'病症',9,'进食障碍','2024-01-07 17:30:39','2024-01-12 10:10:06',0),(52,'病症',10,'社交恐惧症','2024-01-07 17:30:39','2024-01-12 10:10:06',0),(101,'咨询状态',1,'等待安排','2024-01-04 14:40:04','2024-01-07 15:36:54',0),(102,'咨询状态',2,'等待咨询','2024-01-04 14:40:04','2024-01-07 15:36:54',0),(103,'咨询状态',3,'咨询中','2024-01-04 14:40:04','2024-01-07 15:36:54',0),(104,'咨询状态',4,'已结案','2024-01-04 14:40:04','2024-01-07 15:36:54',0),(105,'咨询状态',5,'脱落','2024-01-04 14:42:28','2024-01-07 15:36:54',0),(106,'学生户口类型',0,'农村','2024-01-05 11:09:46','2024-01-07 15:36:54',0),(107,'学生户口类型',1,'城市','2024-01-05 11:09:46','2024-01-07 15:36:54',0),(108,'自述紧急程度',1,'一般','2024-01-05 11:18:37','2024-01-07 15:36:54',0),(109,'自述紧急程度',2,'紧急','2024-01-05 11:18:37','2024-01-07 15:36:54',0),(110,'自述紧急程度',3,'非常紧急','2024-01-05 11:18:37','2024-01-07 15:36:54',0),(111,'咨询结果',1,'完成咨询','2024-01-07 17:36:33','2024-01-07 17:36:33',0),(112,'咨询结果',2,'旷约','2024-01-07 17:36:33','2024-01-07 17:36:33',0),(113,'咨询结果',3,'请假','2024-01-07 17:36:33','2024-01-07 17:36:33',0),(151,'学生户口类型',1,'城市','2024-01-09 18:55:30','2024-01-09 18:55:30',0),(152,'学生户口类型',2,'乡镇','2024-01-09 18:55:30','2024-01-09 18:55:30',0),(153,'学生户口类型',3,'农村','2024-01-09 18:55:30','2024-01-09 18:55:30',0);
/*!40000 ALTER TABLE `dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluation_question`
--

DROP TABLE IF EXISTS `evaluation_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluation_question` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `emergent` tinyint(1) DEFAULT NULL,
  `uid` bigint NOT NULL,
  `qid` bigint NOT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_question`
--

LOCK TABLES `evaluation_question` WRITE;
/*!40000 ALTER TABLE `evaluation_question` DISABLE KEYS */;
INSERT INTO `evaluation_question` VALUES (1,0,1,1,'2024-01-11 07:57:31','2024-01-11 07:57:31',0),(2,0,1,2,'2024-01-11 07:57:31','2024-01-11 07:57:31',0),(3,0,1,3,'2024-01-11 07:57:31','2024-01-11 07:57:31',0),(4,0,1,4,'2024-01-11 07:57:31','2024-01-11 07:57:31',0),(5,0,1,5,'2024-01-11 07:57:31','2024-01-11 07:57:31',0),(6,NULL,2,10,'2024-01-11 16:22:20','2024-01-11 16:22:20',0),(7,NULL,3,30,'2024-01-11 16:22:20','2024-01-11 16:22:20',0),(8,NULL,10,1,'2024-01-11 17:13:13','2024-01-11 17:13:13',0),(9,NULL,15,11,'2024-01-11 17:38:38','2024-01-11 17:38:38',0),(10,NULL,15,12,'2024-01-11 17:38:38','2024-01-11 17:38:38',0),(11,NULL,15,22,'2024-01-11 17:38:38','2024-01-11 17:38:38',0),(12,NULL,16,2,'2024-01-11 17:40:10','2024-01-11 17:40:10',0),(13,NULL,16,3,'2024-01-11 17:40:10','2024-01-11 17:40:10',0),(14,NULL,17,2,'2024-01-11 17:45:14','2024-01-11 17:45:14',0),(15,NULL,17,3,'2024-01-11 17:45:14','2024-01-11 17:45:14',0),(16,NULL,17,4,'2024-01-11 17:45:14','2024-01-11 17:45:14',0),(17,NULL,17,5,'2024-01-11 17:45:14','2024-01-11 17:45:14',0),(18,NULL,17,6,'2024-01-11 17:45:14','2024-01-11 17:45:14',0),(19,NULL,17,7,'2024-01-11 17:45:14','2024-01-11 17:45:14',0),(20,NULL,17,8,'2024-01-11 17:45:14','2024-01-11 17:45:14',0),(21,NULL,18,2,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(22,NULL,18,3,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(23,NULL,18,4,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(24,NULL,18,5,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(25,NULL,18,6,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(26,NULL,18,7,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(27,NULL,18,8,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(28,NULL,18,9,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(29,NULL,18,10,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(30,NULL,18,13,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(31,NULL,18,14,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(32,NULL,18,15,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(33,NULL,18,16,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(34,NULL,18,17,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(35,NULL,18,18,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(36,NULL,18,19,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(37,NULL,18,20,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(38,NULL,18,21,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(39,NULL,18,23,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(40,NULL,18,25,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(41,NULL,18,27,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(42,NULL,18,28,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(43,NULL,18,31,'2024-01-11 17:47:32','2024-01-11 17:47:32',0),(44,NULL,19,2,'2024-01-11 17:48:55','2024-01-11 17:48:55',0),(45,NULL,19,3,'2024-01-11 17:48:55','2024-01-11 17:48:55',0),(46,NULL,19,5,'2024-01-11 17:48:55','2024-01-11 17:48:55',0),(47,NULL,19,7,'2024-01-11 17:48:55','2024-01-11 17:48:55',0),(48,NULL,19,8,'2024-01-11 17:48:55','2024-01-11 17:48:55',0),(49,NULL,19,9,'2024-01-11 17:48:55','2024-01-11 17:48:55',0),(50,NULL,19,10,'2024-01-11 17:48:55','2024-01-11 17:48:55',0),(51,NULL,20,2,'2024-01-11 17:50:20','2024-01-11 17:50:20',0),(52,NULL,20,3,'2024-01-11 17:50:20','2024-01-11 17:50:20',0),(53,NULL,20,4,'2024-01-11 17:50:20','2024-01-11 17:50:20',0),(54,NULL,21,2,'2024-01-11 17:53:08','2024-01-11 17:53:08',0),(55,NULL,21,3,'2024-01-11 17:53:08','2024-01-11 17:53:08',0),(56,NULL,22,2,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(57,NULL,22,13,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(58,NULL,22,14,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(59,NULL,22,15,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(60,NULL,22,16,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(61,NULL,22,17,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(62,NULL,22,18,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(63,NULL,22,19,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(64,NULL,22,20,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(65,NULL,22,21,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(66,NULL,22,23,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(67,NULL,22,24,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(68,NULL,22,25,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(69,NULL,22,27,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(70,NULL,22,28,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(71,NULL,22,29,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(72,NULL,22,30,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(73,NULL,22,31,'2024-01-11 17:53:57','2024-01-11 17:53:57',0),(74,NULL,23,3,'2024-01-11 17:54:51','2024-01-11 17:54:51',0),(75,NULL,23,4,'2024-01-11 17:54:51','2024-01-11 17:54:51',0),(76,NULL,23,5,'2024-01-11 17:54:51','2024-01-11 17:54:51',0),(77,NULL,24,6,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(78,NULL,24,13,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(79,NULL,24,14,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(80,NULL,24,15,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(81,NULL,24,16,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(82,NULL,24,17,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(83,NULL,24,18,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(84,NULL,24,19,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(85,NULL,24,20,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(86,NULL,24,21,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(87,NULL,24,23,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(88,NULL,24,24,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(89,NULL,24,25,'2024-01-11 18:19:39','2024-01-11 18:19:39',0),(90,NULL,24,27,'2024-01-11 18:19:39','2024-01-11 18:19:39',0);
/*!40000 ALTER TABLE `evaluation_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `first_visit`
--

DROP TABLE IF EXISTS `first_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `first_visit` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rid` bigint DEFAULT NULL,
  `sid` bigint DEFAULT NULL,
  `tid1` bigint DEFAULT NULL,
  `self_emergency` smallint DEFAULT NULL,
  `theme` smallint DEFAULT NULL,
  `expect_time1` varchar(50) DEFAULT NULL,
  `expect_time2` varchar(50) DEFAULT NULL,
  `expect_time3` varchar(50) DEFAULT NULL,
  `submit_time` datetime DEFAULT NULL,
  `score` smallint DEFAULT NULL,
  `first_visit_date` date DEFAULT NULL,
  `week_day` smallint DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `state` smallint DEFAULT NULL,
  `danger` smallint DEFAULT NULL,
  `problem` smallint DEFAULT NULL,
  `disease` smallint DEFAULT NULL,
  `consultation_expectation` varchar(300) DEFAULT NULL,
  `conclusion` smallint DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `first_visit`
--

LOCK TABLES `first_visit` WRITE;
/*!40000 ALTER TABLE `first_visit` DISABLE KEYS */;
INSERT INTO `first_visit` VALUES (1,1,1,7,1,1,'2023-12-04 09:00:00~09:30:00',NULL,NULL,'2023-12-01 12:00:00',5,'2023-12-04',1,'09:00:00','09:30:00',8,1,1,NULL,'从哪来回哪去，好好考试',2,'2024-01-11 07:57:02','2024-01-11 07:57:42',0),(2,2,2,8,3,3,'2023-12-05 09:00:00~09:30:00',NULL,NULL,'2023-12-01 12:00:01',1,'2023-12-05',2,'09:00:00','09:30:00',8,3,9,1,'有点牛',3,'2024-01-11 16:22:16','2024-01-11 16:25:44',0),(3,1,2,8,1,4,'2024-01-09 09:00:00~09:30:00',NULL,NULL,'2024-01-08 12:00:01',1,'2024-01-09',2,'09:00:00','09:30:00',8,1,3,NULL,'再看看吧',2,'2024-01-11 16:22:16','2024-01-11 19:52:26',0),(4,NULL,3,NULL,1,1,'2023-12-04 09:00:00~09:30:00',NULL,NULL,'2023-12-01 12:00:00',0,NULL,NULL,NULL,NULL,6,NULL,NULL,NULL,NULL,NULL,'2024-01-11 16:53:14','2024-01-11 17:14:04',0),(5,NULL,3,NULL,1,4,'2023-12-05 09:00:00~09:30:00',NULL,NULL,'2023-12-04 12:00:00',0,NULL,NULL,NULL,NULL,5,NULL,NULL,NULL,NULL,NULL,'2024-01-11 16:53:14','2024-01-11 17:19:20',0),(6,1,3,9,1,1,'2023-12-06 09:00:00~09:30:00',NULL,NULL,'2023-12-05 12:00:00',0,'2023-12-06',3,'09:00:00','09:30:00',9,NULL,NULL,NULL,NULL,NULL,'2024-01-11 16:53:14','2024-01-11 17:14:04',0),(7,NULL,4,NULL,1,6,'2023-12-04 09:00:00~09:30:00',NULL,NULL,'2023-12-01 12:00:00',0,NULL,NULL,NULL,NULL,6,NULL,NULL,NULL,NULL,NULL,'2024-01-11 16:53:14','2024-01-11 17:19:20',0),(8,NULL,4,NULL,1,2,'2023-12-05 09:00:00~09:30:00',NULL,NULL,'2023-12-04 12:00:00',0,NULL,NULL,NULL,NULL,5,NULL,NULL,NULL,NULL,NULL,'2024-01-11 16:53:14','2024-01-11 17:19:20',0),(9,1,4,9,1,1,'2023-12-06 09:00:00~09:30:00',NULL,NULL,'2023-12-05 12:00:00',0,'2023-12-06',3,'14:00:00','14:30:00',9,NULL,NULL,NULL,NULL,NULL,'2024-01-11 16:53:14','2024-01-11 17:14:04',0),(10,1,3,7,1,1,'2024-01-16 14:00:00~14:30:00',NULL,NULL,'2024-01-10 12:51:14',1,'2024-01-15',1,'14:00:00','14:30:00',4,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:14:04','2024-01-11 17:14:04',0),(11,1,2,7,2,3,'2024-01-16 14:00:00~14:30:00','2024-01-16 09:00:00~09:30:00',NULL,'2024-01-11 19:21:00',0,'2024-01-16',2,'09:00:00','09:30:00',3,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:19:20','2024-01-11 17:19:20',0),(12,1,4,8,1,5,'2024-01-15 09:00:00~09:30:00',NULL,NULL,'2024-01-10 15:49:00',0,'2024-01-15',1,'09:00:00','09:30:00',3,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:19:20','2024-01-11 17:19:20',0),(13,2,1,9,3,3,'2024-01-17 09:00:00~09:30:00',NULL,NULL,'2024-01-12 12:49:00',0,'2024-01-17',3,'09:00:00','09:30:00',2,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:25:50','2024-01-11 17:25:50',0),(14,3,14,9,1,10,'2024-01-17 14:00:00~14:30:00',NULL,NULL,'2024-01-10 21:41:40',0,'2024-01-17',3,'14:00:00','14:30:00',2,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:25:50','2024-01-11 17:25:50',0),(15,NULL,15,NULL,2,5,'2024-01-15 09:00:00~09:30:00','2024-01-15 14:00:00~14:30:00','2024-01-16 09:00:00~09:30:00','2024-01-11 17:38:38',3,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:38:38','2024-01-11 18:55:08',0),(16,NULL,16,NULL,3,2,'2024-01-15 09:00:00~09:30:00','2024-01-15 14:00:00~14:30:00','2024-01-16 14:00:00~14:30:00','2024-01-11 17:40:10',2,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:40:10','2024-01-11 18:55:08',0),(17,NULL,17,NULL,3,2,'2024-01-16 14:00:00~14:30:00','2024-01-16 09:00:00~09:30:00','2024-01-15 09:00:00~09:30:00','2024-01-11 17:45:15',7,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:45:14','2024-01-11 18:55:08',0),(18,NULL,18,NULL,2,6,'2024-01-16 14:00:00~14:30:00','2024-01-16 09:00:00~09:30:00','2024-01-15 14:00:00~14:30:00','2024-01-11 17:47:32',23,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:47:32','2024-01-11 18:55:08',0),(19,NULL,19,NULL,1,7,'2024-01-15 09:00:00~09:30:00','2024-01-15 14:00:00~14:30:00','2024-01-16 14:00:00~14:30:00','2024-01-11 17:48:55',7,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:48:55','2024-01-11 18:55:08',0),(20,NULL,20,NULL,1,7,'2024-01-15 09:00:00~09:30:00','2024-01-15 14:00:00~14:30:00','2024-01-16 14:00:00~14:30:00','2024-01-11 17:50:20',3,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:50:20','2024-01-11 18:55:08',0),(21,NULL,21,NULL,1,1,'2024-01-15 09:00:00~09:30:00','2024-01-15 14:00:00~14:30:00','2024-01-16 14:00:00~14:30:00','2024-01-11 17:53:08',2,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:53:08','2024-01-11 18:55:08',0),(22,NULL,22,NULL,2,9,'2024-01-16 14:00:00~14:30:00','2024-01-16 09:00:00~09:30:00','2024-01-15 14:00:00~14:30:00','2024-01-11 17:53:58',18,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2024-01-11 17:53:57','2024-01-11 18:55:08',0),(23,NULL,23,NULL,1,4,'2024-01-16 14:00:00~14:30:00','2024-01-16 09:00:00~09:30:00','2024-01-15 14:00:00~14:30:00','2024-01-11 18:19:39',14,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2024-01-11 18:19:39','2024-01-11 18:55:08',0),(24,1,15,7,1,3,'2023-11-20 09:00:00~09:30:00',NULL,NULL,'2023-11-18 12:00:00',0,'2023-11-20',1,'09:00:00','09:30:00',8,3,2,NULL,'治疗',2,'2024-01-11 18:55:08','2024-01-11 18:55:08',0),(25,2,16,7,1,6,'2023-11-20 09:00:00~09:30:00',NULL,NULL,'2023-11-18 12:00:00',0,'2023-11-20',1,'14:00:00','14:30:00',8,2,5,NULL,'治治他',2,'2024-01-11 18:55:08','2024-01-11 18:55:08',0),(26,3,24,8,1,2,'2023-11-20 09:00:00~09:30:00',NULL,NULL,'2023-11-18 12:00:00',0,'2023-11-21',2,'09:00:00','09:30:00',8,3,7,NULL,'治疗一下',2,'2024-01-11 18:55:08','2024-01-11 19:25:29',0),(27,1,25,8,2,5,'2023-11-20 09:00:00~09:30:00',NULL,NULL,'2023-11-18 12:00:00',0,'2023-11-21',2,'14:00:00','14:30:00',8,2,9,1,'治疗',2,'2024-01-11 19:25:29','2024-01-11 19:25:29',0),(28,2,26,9,1,1,'2023-11-20 09:00:00~09:30:00',NULL,NULL,'2023-11-18 12:00:00',0,'2023-11-22',3,'09:00:00','09:30:00',8,2,2,NULL,'治疗一下下',2,'2024-01-11 19:25:29','2024-01-11 19:25:29',0),(29,3,27,9,1,2,'2023-11-20 09:00:00~09:30:00',NULL,NULL,'2023-11-18 12:00:00',0,'2023-11-22',3,'14:00:00','14:30:00',8,2,9,1,'治疗一下呗',2,'2024-01-11 19:25:29','2024-01-11 19:25:29',0),(30,1,28,9,1,7,'2023-11-20 09:00:00~09:30:00',NULL,NULL,'2023-11-18 12:00:00',0,'2023-11-22',3,'14:30:00','15:00:00',8,2,1,NULL,'嘻嘻',2,'2024-01-11 19:25:29','2024-01-11 19:25:29',0),(31,1,29,7,1,4,'2023-11-20 09:00:00~09:30:00',NULL,NULL,'2023-11-18 12:00:00',0,'2023-11-27',1,'09:00:00','09:30:00',8,2,1,NULL,'哈哈哈',2,'2024-01-11 19:37:00','2024-01-11 19:37:00',0),(32,1,30,7,1,2,'2023-11-20 09:00:00~09:30:00',NULL,NULL,'2023-11-18 12:00:00',0,'2023-11-27',1,'14:00:00','14:30:00',8,1,8,NULL,'呼呼呼',2,'2024-01-11 19:37:00','2024-01-11 19:37:00',0);
/*!40000 ALTER TABLE `first_visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail`
--

DROP TABLE IF EXISTS `mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` bigint DEFAULT NULL,
  `reply` varchar(20) DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail`
--

LOCK TABLES `mail` WRITE;
/*!40000 ALTER TABLE `mail` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `detail` varchar(250) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'学生模块','学生模块',0,'2024-01-11 06:55:24','2024-01-11 06:55:24'),(2,'中心管理员模块','中心管理员模块',0,'2024-01-11 06:55:24','2024-01-11 06:55:24'),(3,'初访员模块','初访员模块',0,'2024-01-11 06:55:24','2024-01-11 06:55:24'),(4,'心理助理模块','心理助理模块',0,'2024-01-11 06:55:24','2024-01-11 06:55:24'),(5,'咨询师模块','咨询师模块',0,'2024-01-11 06:55:24','2024-01-11 06:55:24');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `emergent` tinyint(1) DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'我最近会容易悲伤哭泣',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(2,'我最近睡眠明显变少或变多',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(3,'我最近对很多事情失去兴趣',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(4,'我最近的食量明显增加或减少',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(5,'我最近常有罪恶感',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(6,'我觉得身体无力',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(7,'我最近容易自我批评',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(8,'我觉得自己没有价值',0,'2024-01-03 11:01:54','2024-01-05 11:13:41',0),(9,'我最近经常感觉精神衰弱和疲惫',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(10,'我有自杀的念头',1,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(11,'我真想从此做个隐士',1,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(12,'我觉得心跳很快',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(13,'我有幻觉体验',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(14,'生活中我受到了很多伤害',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(15,'我最近变得思维特别活跃，很兴奋',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(16,'我最近常常觉得内心痛苦',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(17,'我觉得比平时容易紧张或着急',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(18,'我无缘无故地感到害怕',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(19,'我容易心里烦乱或感到惊恐',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(20,'我觉得我可能快要疯掉了',0,'2024-01-03 11:01:54','2024-01-05 11:13:41',0),(21,'我最近经常会思考自杀的方式和计划',1,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(22,'我最近经常手脚发抖打颤',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(23,'我最近常感到绝望',0,'2024-01-03 11:01:54','2024-01-05 11:13:41',0),(24,'我因为头疼、颈疼和背痛而苦恼',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(25,'我最近经常思考人活着的意义',1,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(26,'我相信有人正在密谋如何对付我',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(27,'我最近常觉得很孤独，不想和任何人说话',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(28,'我觉得自己的思想被一种外在力量拿走了',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(29,'别人在不停地对我的行为和想法评头论足',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0),(30,'我经常花销无度，无法自控',0,'2024-01-03 11:01:54','2024-01-03 11:01:54',0);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `detail` varchar(250) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'学生','学生用户',0,'2024-01-02 17:07:34','2024-01-03 17:16:45'),(2,'中心管理员','中心管理员',0,'2024-01-03 10:41:17','2024-01-03 10:41:17'),(3,'初访员','初访员',0,'2024-01-03 10:41:17','2024-01-03 10:41:17'),(4,'心理助理','心理助理',0,'2024-01-03 10:41:17','2024-01-03 10:41:17'),(5,'咨询员','咨询员',0,'2024-01-03 10:41:17','2024-01-03 10:41:17'),(6,'初访员，咨询师','伪双角色',0,'2024-01-04 09:09:35','2024-01-11 06:55:59');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_menu`
--

DROP TABLE IF EXISTS `role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rid` bigint NOT NULL,
  `mid` bigint NOT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_menu`
--

LOCK TABLES `role_menu` WRITE;
/*!40000 ALTER TABLE `role_menu` DISABLE KEYS */;
INSERT INTO `role_menu` VALUES (1,1,1,'2024-01-11 06:56:02','2024-01-11 06:56:02',0),(2,2,2,'2024-01-11 06:56:02','2024-01-11 06:56:02',0),(3,3,3,'2024-01-11 06:56:02','2024-01-11 06:56:02',0),(4,4,4,'2024-01-11 06:56:02','2024-01-11 06:56:02',0),(5,5,5,'2024-01-11 06:56:02','2024-01-11 06:56:02',0),(6,6,3,'2024-01-11 06:56:02','2024-01-11 06:56:02',0),(7,6,5,'2024-01-11 06:56:02','2024-01-11 06:56:02',0);
/*!40000 ALTER TABLE `role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,'教室A',1,0,'2024-01-11 15:12:00','2024-01-11 18:47:07'),(2,'教室B',1,0,'2024-01-11 15:12:34','2024-01-11 15:12:34'),(3,'教室C',1,0,'2024-01-11 15:12:40','2024-01-11 15:12:40');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setting` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `semester` varchar(30) DEFAULT NULL,
  `first_visit_time` smallint DEFAULT NULL,
  `consultation_time` smallint DEFAULT NULL,
  `semester_start_date` date DEFAULT NULL,
  `semester_end_date` date DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
INSERT INTO `setting` VALUES (1,NULL,'2023年秋季学期',30,60,'2023-09-04','2024-03-10','2024-01-11 07:10:37','2024-01-11 07:10:37',0);
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_info`
--

DROP TABLE IF EXISTS `student_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` bigint DEFAULT NULL,
  `entrance` date DEFAULT NULL,
  `residence` smallint DEFAULT NULL,
  `facility` varchar(30) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `degree` varchar(20) DEFAULT NULL,
  `emergent_contactor` varchar(30) DEFAULT NULL,
  `emergent_telephone` varchar(20) DEFAULT NULL,
  `relationship` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_info`
--

LOCK TABLES `student_info` WRITE;
/*!40000 ALTER TABLE `student_info` DISABLE KEYS */;
INSERT INTO `student_info` VALUES (1,1,'2021-09-01',3,'软件学院','13305063935','大学本科','黄某人','13305063935','兄弟','532092252@qq.com','2024-01-11 06:34:47','2024-01-11 06:34:47',0),(2,2,'2021-09-01',1,'软件学院','15801024142','硕士研究生','黄某人','13305063935','兄弟','532092252@qq.com','2024-01-11 06:34:47','2024-01-11 17:21:31',0),(3,3,'2021-09-01',1,'软件学院','13305041423','博士研究生','黄某人','13305063935','兄弟','532092252@qq.com','2024-01-11 06:34:47','2024-01-11 16:57:41',0),(4,4,'2021-09-01',1,'软件学院','15805068451','大学本科','黄某人','13305063935','兄弟','532092252@qq.com','2024-01-11 06:34:47','2024-01-11 17:21:31',0),(5,14,'2021-09-01',2,'软件学院','14829483849','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:21:31','2024-01-11 17:21:31',0),(6,15,'2020-09-01',1,'人文学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(7,16,'2020-09-01',1,'计算机学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(8,17,'2020-09-01',1,'电子学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(9,18,'2020-09-01',1,'电气学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(10,19,'2020-09-01',1,'自动化学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(11,20,'2020-09-01',1,'英语学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(12,21,'2020-09-01',1,'历史学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(13,22,'2020-09-01',1,'自动化学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(14,23,'2020-09-01',1,'计算机学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(15,24,'2020-09-01',1,'微电子学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(16,25,'2020-09-01',1,'电子学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(17,26,'2020-09-01',1,'人文学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(18,27,'2020-09-01',1,'测绘学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(19,28,'2020-09-01',1,'电气学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(20,29,'2020-09-01',1,'电气学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0),(21,30,'2020-09-01',1,'电气学院','12345678902','大学本科','黄某人','13305063935','父亲','532092252@qq.com','2024-01-11 17:32:42','2024-01-11 17:32:42',0);
/*!40000 ALTER TABLE `student_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_info`
--

DROP TABLE IF EXISTS `teacher_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` bigint DEFAULT NULL,
  `state` tinyint(1) DEFAULT '1',
  `avatar` varchar(100) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `school` varchar(30) DEFAULT NULL,
  `detail` varchar(250) DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_info`
--

LOCK TABLES `teacher_info` WRITE;
/*!40000 ALTER TABLE `teacher_info` DISABLE KEYS */;
INSERT INTO `teacher_info` VALUES (8,5,1,'blob:http://127.0.0.1:8081/d9c7b6db-b59d-4a37-8c6f-f584705b83dc','副院长','西安交通大学','分管对外交流、创新港建设','2024-01-11 06:44:18','2024-01-11 06:44:18',0),(9,6,1,'blob:http://127.0.0.1:8081/d9c7b6db-b59d-4a37-8c6f-f584705b83dc','学院秘书','西安交通大学','分管研究生培养、学科建设','2024-01-11 06:44:18','2024-01-11 06:46:30',0),(10,7,1,'blob:http://127.0.0.1:8081/1e592549-2c44-4a3a-949c-417905f9b397','副院长','西安交通大学','教授，博士生导师。研究方向：计算机视觉（三维视觉，图像去模糊，视频关键帧定位）','2024-01-11 06:44:18','2024-01-11 06:46:30',0),(11,8,1,'blob:http://127.0.0.1:8081/d9c7b6db-b59d-4a37-8c6f-f584705b83dc','副教授','西安交通大学','杜小智，男，博士、副教授，研究生导师。主要从事大数据（机器学习/深度学习）、人工智能、智能软件工程(定制化软件开发)、嵌入式系统等方面的教学和研究。曾在TCL移动通信有限公司从事软件研发工作（参与研发国产第一款智能手机），现为西安交通大学软件学院教师。2021年度“高校计算机专业优秀教师奖励计划”获奖教师。2018年获陕西省科技工作者创新创业大赛银奖。','2024-01-11 06:44:18','2024-01-11 06:46:30',0),(12,9,1,'blob:http://127.0.0.1:8081/d9c7b6db-b59d-4a37-8c6f-f584705b83dc','研究员','西安交通大学','课题组每年招收博士研究生、硕士研究生与本科实习生，具体研究方向包括图像处理、模式识别与智能系统、机器学习、深度学习等领域。','2024-01-11 06:44:18','2024-01-11 06:47:18',0),(13,10,1,'blob:http://127.0.0.1:8081/d9c7b6db-b59d-4a37-8c6f-f584705b83dc','副教授','西安交通大学','西安交通大学软件学院长聘副教授、博士生导师，英国爱丁堡大学信息学院访问学者。2009年获得西安交通大学计算机科学与技术系工学学士学位，2016年获得西安交通大学计算机科学与技术系工学博士学位。在国内外学术期刊与会议上发表学术论文25余篇，包括IEEE Transactions on Image Processing、IEEE Transactions on Multimedia、ACM Multimedia、Neural Networks等，以及国内权威期刊《计算机学报》等；授权专利5余项。','2024-01-11 06:44:18','2024-01-11 06:49:31',0),(14,11,1,'blob:http://127.0.0.1:8081/ab31cfcc-dd36-45dc-a386-4ba6c505096b','副书记','西安交通大学','原神，启动！','2024-01-11 06:44:18','2024-01-11 06:49:31',0),(15,12,1,'blob:http://127.0.0.1:8081/dc82beb1-556e-4a63-a989-cb851bf71ac4','教授','西安交通大学','美国卡内基梅隆大学（Carnegie Mellon University）计算机科学系语言研究所(LTI)访问学者，IBM公司访问学者，教授、博士生导师。目前为复杂产品智能制造系统技术全国重点实验室系统总体技术及基础理论专委会副主任；中文信息学会社交媒体计算专委会、情感计算专委会委员以及开源情报技术专委会委员，中国自动化协会社会计算专委会成员，陕西省人工智能联合（重点）实验室秘书长、副主任，西安市社会智能与复杂数据处理重点实验室主任','2024-01-11 06:44:18','2024-01-11 06:49:31',0),(16,13,1,'blob:http://127.0.0.1:8081/d9c7b6db-b59d-4a37-8c6f-f584705b83dc','教授','西安交通大学','2001-2006年，西安交通大学，信息工程专业，工学学士学位；2006-2013年，西安交通大学，控制科学与工程专业，工学博士学位；2011年7-9月，美国伦斯勒理工学院（Rensselaer Polytechnic Institute, RPI），访问学生','2024-01-11 06:44:18','2024-01-11 06:49:31',0);
/*!40000 ALTER TABLE `teacher_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `loginName` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'20240111','123456','黄俊凯','男','2003-04-11','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(2,'20240112','123456','牟展宏','男','2002-11-06','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(3,'20240113','123456','宋天鹏','男','2000-01-01','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(4,'20240114','123456','谢志成','男','2000-01-01','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(5,'20230101','123456','金莉','女','2000-01-01','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(6,'20230102','123456','路璐','女','2000-01-01','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(7,'20230103','123456','祝继华','男','2000-01-01','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(8,'20230104','123456','杜小智','男','2000-01-01','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(9,'20230105','123456','宋永红','女','2000-01-01','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(10,'20230106','123456','白秀秀','女','2000-01-01','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(11,'20230107','123456','原盛','男','2000-01-01','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(12,'20230108','123456','饶元','男','2000-01-01','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(13,'20230109','123456','张斌','男','2000-01-01','2024-01-11 06:25:15','2024-01-11 06:25:15',0),(14,'20241111','123456','小白鼠','男','2000-01-01','2024-01-11 17:20:24','2024-01-11 17:20:24',0),(15,'20241','123456','赵一','男','2000-01-01','2024-01-11 17:31:06','2024-01-11 17:31:06',0),(16,'20242','123456','钱二','男','2000-01-01','2024-01-11 17:31:06','2024-01-11 17:31:06',0),(17,'20243','123456','张三','女','2000-01-01','2024-01-11 17:31:06','2024-01-11 17:31:06',0),(18,'20244','123456','李四','男','2000-01-01','2024-01-11 17:31:06','2024-01-11 17:31:06',0),(19,'20245','123456','王五','女','2000-01-01','2024-01-11 17:31:06','2024-01-11 17:31:06',0),(20,'20246','123456','吴六','女','2000-01-01','2024-01-11 17:31:06','2024-01-11 17:31:06',0),(21,'20247','123456','魏七','女','2000-01-01','2024-01-11 17:31:06','2024-01-11 17:31:06',0),(22,'20248','123456','曾八','女','2000-01-01','2024-01-11 17:31:06','2024-01-11 17:31:06',0),(23,'20249','123456','肖久','男','2000-01-01','2024-01-11 17:31:06','2024-01-11 17:31:06',0),(24,'202410','123456','诸葛十','男',NULL,'2024-01-11 19:19:24','2024-01-11 19:34:14',0),(25,'202411','123456','萧十一','男',NULL,'2024-01-11 19:19:24','2024-01-11 19:34:14',0),(26,'202412','123456','金十二','男',NULL,'2024-01-11 19:19:24','2024-01-11 19:34:14',0),(27,'202413','123456','牟十三','男',NULL,'2024-01-11 19:19:24','2024-01-11 19:34:14',0),(28,'202414','123456','谢十四','男',NULL,'2024-01-11 19:19:24','2024-01-11 19:34:14',0),(29,'202415','123456','王十五','男',NULL,'2024-01-11 19:34:14','2024-01-11 19:34:14',0),(30,'202416','123456','向十六','男',NULL,'2024-01-11 19:34:14','2024-01-11 19:34:14',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` bigint NOT NULL,
  `rid` bigint NOT NULL,
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,1,1,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(2,2,1,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(3,3,1,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(4,4,1,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(5,5,2,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(6,6,2,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(7,7,3,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(8,8,3,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(9,9,3,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(10,10,4,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(11,11,5,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(12,12,5,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(13,13,5,'2024-01-11 06:32:22','2024-01-11 06:32:22',0),(14,14,1,'2024-01-11 17:20:32','2024-01-11 17:20:32',0),(15,15,1,'2024-01-11 17:31:39','2024-01-11 17:31:39',0),(16,16,1,'2024-01-11 17:31:39','2024-01-11 17:31:39',0),(17,17,1,'2024-01-11 17:31:39','2024-01-11 17:31:39',0),(18,18,1,'2024-01-11 17:31:39','2024-01-11 17:31:39',0),(19,19,1,'2024-01-11 17:31:39','2024-01-11 17:31:39',0),(20,20,1,'2024-01-11 17:31:39','2024-01-11 17:31:39',0),(21,21,1,'2024-01-11 17:31:39','2024-01-11 17:31:39',0),(22,22,1,'2024-01-11 17:31:39','2024-01-11 17:31:39',0),(23,23,1,'2024-01-11 17:31:39','2024-01-11 17:31:39',0),(24,24,1,'2024-01-11 19:19:46','2024-01-11 19:19:46',0),(25,25,1,'2024-01-11 19:19:46','2024-01-11 19:19:46',0),(26,26,1,'2024-01-11 19:19:46','2024-01-11 19:19:46',0),(27,27,1,'2024-01-11 19:19:46','2024-01-11 19:19:46',0),(28,28,1,'2024-01-11 19:19:46','2024-01-11 19:19:46',0),(29,29,1,'2024-01-11 19:34:25','2024-01-11 19:34:25',0),(30,30,1,'2024-01-11 19:34:25','2024-01-11 19:34:25',0);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mental'
--

--
-- Dumping routines for database 'mental'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-12 10:17:59
