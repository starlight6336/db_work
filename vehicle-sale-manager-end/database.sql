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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arrangement`
--

LOCK TABLES `arrangement` WRITE;
/*!40000 ALTER TABLE `arrangement` DISABLE KEYS */;
INSERT INTO `arrangement` VALUES (1,3,3,1,4,'13:00:00','13:30:00','2024-01-04 11:12:49','2024-01-04 17:38:03',0),(2,5,5,1,5,'14:00:00','15:00:00','2024-01-04 11:13:29','2024-01-06 11:44:09',0),(3,3,3,1,3,'15:00:00','15:30:00','2024-01-04 16:35:54','2024-01-05 16:58:41',0),(4,3,3,1,3,'15:30:00','16:00:00','2024-01-04 16:49:25','2024-01-05 16:58:41',0),(5,3,3,1,3,'14:30:00','15:00:00','2024-01-04 16:49:37','2024-01-05 16:58:41',0),(6,3,3,1,2,'15:00:00','15:30:00','2024-01-04 19:07:11','2024-01-05 16:58:41',0),(7,5,5,1,3,'16:00:00','17:00:00','2024-01-04 19:10:28','2024-01-05 16:58:41',0),(8,7,3,1,4,'13:00:00','13:30:00','2024-01-05 16:58:41','2024-01-05 16:58:41',0),(9,8,3,1,4,'13:00:00','13:30:00','2024-01-05 16:58:41','2024-01-05 16:58:41',0),(10,10,5,1,1,'14:00:00','15:00:00','2024-01-06 19:56:25','2024-01-06 19:56:33',0),(11,5,5,1,2,'14:00:00','15:00:00','2024-01-07 13:10:19','2024-01-07 13:10:19',0),(12,11,5,1,4,'14:00:00','15:00:00','2024-01-08 14:13:12','2024-01-08 14:13:12',0),(13,13,3,1,4,'13:00:00','13:30:00','2024-01-08 17:12:05','2024-01-08 17:14:27',0),(14,11,5,1,2,'14:00:00','15:00:00','2024-01-10 09:33:16','2024-01-10 09:34:22',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultation`
--

LOCK TABLES `consultation` WRITE;
/*!40000 ALTER TABLE `consultation` DISABLE KEYS */;
INSERT INTO `consultation` VALUES (1,2,2,5,'2023-12-29','2024-01-19',5,'14:00:00','15:00:00',3,NULL,'2024-01-04 11:08:30','2024-01-07 11:58:42',0),(2,3,5,10,'2023-12-04','2023-12-25',1,'14:00:00','15:00:00',4,'此人甚吊','2024-01-06 19:59:12','2024-01-06 19:59:12',0),(3,1,6,10,'2024-01-01','2024-01-29',1,'14:00:00','15:00:00',4,'这人我真治不了他','2024-01-07 12:07:55','2024-01-09 11:25:37',0),(4,2,NULL,5,'2023-12-27','2023-12-27',3,'16:00:00','17:00:00',4,'niubi','2024-01-07 12:28:28','2024-01-07 13:11:45',0),(5,3,7,5,'2023-12-26','2024-01-23',2,'14:00:00','15:00:00',3,NULL,'2024-01-07 13:11:45','2024-01-10 18:36:49',0),(6,1,10,5,'2024-01-10','2024-01-31',3,'16:00:00','17:00:00',3,NULL,'2024-01-08 17:38:04','2024-01-09 11:21:11',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultation_extend_request`
--

LOCK TABLES `consultation_extend_request` WRITE;
/*!40000 ALTER TABLE `consultation_extend_request` DISABLE KEYS */;
INSERT INTO `consultation_extend_request` VALUES (1,5,1,'过圣诞旷工一次，请求补全',0,NULL,'2024-01-07 13:15:17','2024-01-11 11:28:28',0),(2,3,1,'这byd旷了一次，我得给他上上强度',0,NULL,'2024-01-09 11:22:23','2024-01-11 11:28:28',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultation_record`
--

LOCK TABLES `consultation_record` WRITE;
/*!40000 ALTER TABLE `consultation_record` DISABLE KEYS */;
INSERT INTO `consultation_record` VALUES (1,1,1,1,'123','2023-12-29',5,'14:00:00','15:00:00','2024-01-05 18:36:55','2024-01-07 17:43:32',0),(2,1,1,1,'456','2024-01-05',5,'14:00:00','15:00:00','2024-01-05 18:37:16','2024-01-07 17:43:32',0),(3,1,0,NULL,NULL,'2024-01-12',5,'14:00:00','15:00:00','2024-01-06 19:50:04','2024-01-06 19:50:04',0),(4,1,0,NULL,NULL,'2024-01-19',5,'14:00:00','15:00:00','2024-01-06 19:50:04','2024-01-06 19:50:04',0),(5,2,1,1,'一','2024-12-04',1,'14:00:00','15:00:00','2024-01-06 20:00:32','2024-01-07 17:43:32',0),(6,2,1,1,'二','2024-12-11',1,'14:00:00','15:00:00','2024-01-06 20:00:32','2024-01-07 17:43:32',0),(7,2,1,1,'三','2024-12-18',1,'14:00:00','15:00:00','2024-01-06 20:00:32','2024-01-07 17:43:32',0),(8,2,1,1,'思','2024-12-25',1,'14:00:00','15:00:00','2024-01-06 20:00:32','2024-01-07 17:43:32',0),(9,3,1,1,'我是一','2024-01-01',1,'14:00:00','15:00:00','2024-01-07 12:08:26','2024-01-07 17:43:32',0),(10,3,0,NULL,NULL,'2024-01-08',1,'14:00:00','15:00:00','2024-01-07 12:08:26','2024-01-09 11:25:37',1),(11,3,0,NULL,NULL,'2024-01-15',1,'14:00:00','15:00:00','2024-01-07 12:08:26','2024-01-09 11:25:37',1),(12,3,0,NULL,NULL,'2024-01-22',1,'14:00:00','15:00:00','2024-01-07 12:08:26','2024-01-09 11:25:37',1),(13,4,1,1,'炸裂','2023-12-27',3,'16:00:00','17:00:00','2024-01-07 13:13:08','2024-01-07 17:43:32',0),(14,5,1,1,'我是个一','2023-12-26',2,'14:00:00','15:00:00','2024-01-07 13:14:45','2024-01-07 17:43:32',0),(15,5,1,1,'我是个二','2024-01-02',2,'14:00:00','15:00:00','2024-01-07 13:14:45','2024-01-07 17:43:32',0),(16,5,1,1,'人好帅，喜欢住了','2024-01-09',2,'14:00:00','15:00:00','2024-01-07 13:14:45','2024-01-09 10:23:13',0),(17,5,0,NULL,NULL,'2024-01-16',2,'14:00:00','15:00:00','2024-01-07 13:14:45','2024-01-07 13:57:50',0),(18,5,0,NULL,NULL,'2024-01-23',2,'14:00:00','15:00:00','2024-01-07 13:56:25','2024-01-07 13:56:25',0),(19,4,0,NULL,NULL,'2024-01-17',3,'16:00:00','17:00:00','2024-01-08 11:59:34','2024-01-08 14:21:54',1),(20,6,0,NULL,NULL,'2024-01-10',3,'16:00:00','17:00:00','2024-01-08 17:57:25','2024-01-08 17:57:25',0),(21,6,0,NULL,NULL,'2024-01-17',3,'16:00:00','17:00:00','2024-01-08 17:57:25','2024-01-08 17:57:25',0),(22,6,0,NULL,NULL,'2024-01-24',3,'16:00:00','17:00:00','2024-01-08 17:57:25','2024-01-08 17:57:25',0),(23,6,0,NULL,NULL,'2024-01-31',3,'16:00:00','17:00:00','2024-01-08 17:57:25','2024-01-08 17:57:25',0),(24,3,0,NULL,NULL,'2024-01-29',1,'14:00:00','15:00:00','2024-01-09 11:23:14','2024-01-09 11:25:37',1);
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
INSERT INTO `dictionary` VALUES (1,'来访主题',1,'自我探索与成长','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(2,'来访主题',2,'感情问题','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(3,'来访主题',3,'人际关系','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(4,'来访主题',4,'心理测试解释','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(5,'来访主题',5,'性别认同与同性恋','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(6,'来访主题',6,'情绪困扰','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(7,'来访主题',7,'学习问题','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(8,'来访主题',8,'心理治疗问题','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(9,'来访主题',9,'生涯规划和未来','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(10,'来访主题',10,'家庭问题','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(11,'来访主题',11,'其它','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(12,'自述紧急程度',1,'一般','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(13,'自述紧急程度',2,'紧急','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(14,'自述紧急程度',3,'非常紧急','2024-01-07 15:41:37','2024-01-07 15:41:37',0),(15,'初访状态',1,'等待安排','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(16,'初访状态',2,'待确认','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(17,'初访状态',3,'匹配成功 等待访谈','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(18,'初访状态',4,'等待新安排','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(19,'初访状态',5,'放弃排队','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(20,'初访状态',6,'已拒绝','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(21,'初访状态',7,'访谈中','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(22,'初访状态',8,'已结束','2024-01-04 10:36:44','2024-01-07 15:39:36',0),(23,'初访状态',9,'已取消','2024-01-06 16:18:01','2024-01-07 15:39:36',0),(24,'初访状态',10,'未提交','2024-01-09 14:17:43','2024-01-09 14:17:43',0),(25,'初访结论',1,'无需咨询','2024-01-07 15:27:41','2024-01-09 14:17:23',0),(26,'初访结论',2,'安排咨询','2024-01-07 15:27:41','2024-01-09 14:17:23',0),(27,'初访结论',3,'转介送诊','2024-01-07 15:27:41','2024-01-09 14:17:23',0),(28,'危机等级',1,'低','2024-01-07 15:36:09','2024-01-09 14:17:23',0),(29,'危机等级',2,'中','2024-01-07 15:36:09','2024-01-09 14:17:23',0),(30,'危机等级',3,'高','2024-01-07 15:36:09','2024-01-09 14:17:23',0),(31,'问题类型',1,'自我问题','2024-01-07 15:36:09','2024-01-09 14:17:23',0),(32,'问题类型',2,'恋爱与性心理','2024-01-07 15:36:09','2024-01-09 14:17:23',0),(33,'问题类型',3,'性别认同与同性恋','2024-01-07 15:36:09','2024-01-09 14:17:23',0),(34,'问题类型',4,'人际关系问题','2024-01-07 15:36:09','2024-01-09 14:17:23',0),(35,'问题类型',5,'学习问题','2024-01-07 15:36:09','2024-01-09 14:17:23',0),(36,'问题类型',6,'家庭矛盾问题','2024-01-07 15:36:09','2024-01-09 14:17:23',0),(37,'问题类型',7,'新生适应问题','2024-01-07 15:36:09','2024-01-09 14:17:23',0),(38,'问题类型',8,'应激反应','2024-01-07 15:36:09','2024-01-09 14:17:23',0),(39,'问题类型',9,'疑似','2024-01-07 15:37:34','2024-01-09 14:17:23',0),(40,'问题类型',10,'确诊','2024-01-07 17:27:35','2024-01-09 14:17:23',0),(41,'问题类型',11,'其它','2024-01-07 17:27:35','2024-01-09 14:17:23',0),(42,'病症',1,'抑郁症','2024-01-07 17:30:39','2024-01-09 14:17:23',0),(43,'病症',2,'焦虑症','2024-01-07 17:30:39','2024-01-09 14:17:23',0),(44,'病症',3,'双向情感障碍','2024-01-07 17:30:39','2024-01-09 14:17:23',0),(45,'病症',4,'精神分裂症','2024-01-07 17:30:39','2024-01-09 14:17:23',0),(46,'病症',5,'人格障碍','2024-01-07 17:30:39','2024-01-09 14:17:23',0),(47,'病症',6,'强迫症','2024-01-07 17:30:39','2024-01-09 14:17:23',0),(48,'病症',7,'恶劣环境','2024-01-07 17:30:39','2024-01-09 14:17:23',0),(49,'病症',8,'适应障碍','2024-01-07 17:30:39','2024-01-09 14:17:23',0),(50,'病症',9,'进食障碍','2024-01-07 17:30:39','2024-01-09 14:17:23',0),(51,'病症',10,'社交恐惧症','2024-01-07 17:30:39','2024-01-09 14:17:23',0),(101,'咨询状态',1,'等待安排','2024-01-04 14:40:04','2024-01-07 15:36:54',0),(102,'咨询状态',2,'等待咨询','2024-01-04 14:40:04','2024-01-07 15:36:54',0),(103,'咨询状态',3,'咨询中','2024-01-04 14:40:04','2024-01-07 15:36:54',0),(104,'咨询状态',4,'已结案','2024-01-04 14:40:04','2024-01-07 15:36:54',0),(105,'咨询状态',5,'脱落','2024-01-04 14:42:28','2024-01-07 15:36:54',0),(106,'学生户口类型',0,'农村','2024-01-05 11:09:46','2024-01-07 15:36:54',0),(107,'学生户口类型',1,'城市','2024-01-05 11:09:46','2024-01-07 15:36:54',0),(108,'自述紧急程度',1,'一般','2024-01-05 11:18:37','2024-01-07 15:36:54',0),(109,'自述紧急程度',2,'紧急','2024-01-05 11:18:37','2024-01-07 15:36:54',0),(110,'自述紧急程度',3,'非常紧急','2024-01-05 11:18:37','2024-01-07 15:36:54',0),(111,'咨询结果',1,'完成咨询','2024-01-07 17:36:33','2024-01-07 17:36:33',0),(112,'咨询结果',2,'旷约','2024-01-07 17:36:33','2024-01-07 17:36:33',0),(113,'咨询结果',3,'请假','2024-01-07 17:36:33','2024-01-07 17:36:33',0),(151,'学生户口类型',1,'城市','2024-01-09 18:55:30','2024-01-09 18:55:30',0),(152,'学生户口类型',2,'乡镇','2024-01-09 18:55:30','2024-01-09 18:55:30',0),(153,'学生户口类型',3,'农村','2024-01-09 18:55:30','2024-01-09 18:55:30',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_question`
--

LOCK TABLES `evaluation_question` WRITE;
/*!40000 ALTER TABLE `evaluation_question` DISABLE KEYS */;
INSERT INTO `evaluation_question` VALUES (1,0,1,1,'2024-01-05 11:15:12','2024-01-05 11:15:12',0),(2,0,1,2,'2024-01-05 11:15:12','2024-01-05 11:15:12',0),(3,0,1,3,'2024-01-05 11:15:12','2024-01-05 11:15:12',0),(4,1,1,21,'2024-01-05 11:15:12','2024-01-05 11:15:12',0),(5,1,2,21,'2024-01-06 20:50:47','2024-01-06 20:50:47',0),(6,0,2,1,'2024-01-06 20:50:47','2024-01-06 20:50:47',0),(7,0,3,1,'2024-01-07 17:07:16','2024-01-07 17:07:16',0),(8,NULL,11,1,'2024-01-09 19:00:47','2024-01-09 19:01:15',1),(9,NULL,11,2,'2024-01-09 19:00:47','2024-01-09 19:01:15',1),(10,NULL,11,3,'2024-01-09 19:00:47','2024-01-09 19:01:15',1),(11,NULL,11,4,'2024-01-09 19:00:47','2024-01-09 19:01:15',1),(12,NULL,11,5,'2024-01-09 19:00:47','2024-01-09 19:01:15',1),(13,NULL,11,1,'2024-01-09 19:01:15','2024-01-09 19:03:41',1),(14,NULL,11,2,'2024-01-09 19:01:15','2024-01-09 19:03:41',1),(15,NULL,11,3,'2024-01-09 19:01:15','2024-01-09 19:03:41',1),(16,NULL,11,4,'2024-01-09 19:01:15','2024-01-09 19:03:41',1),(17,NULL,11,5,'2024-01-09 19:01:15','2024-01-09 19:03:41',1),(18,NULL,11,1,'2024-01-09 19:03:41','2024-01-09 19:08:57',1),(19,NULL,11,2,'2024-01-09 19:03:41','2024-01-09 19:08:57',1),(20,NULL,11,3,'2024-01-09 19:03:41','2024-01-09 19:08:57',1),(21,NULL,11,4,'2024-01-09 19:03:41','2024-01-09 19:08:57',1),(22,NULL,11,5,'2024-01-09 19:03:41','2024-01-09 19:08:57',1),(23,NULL,12,1,'2024-01-09 19:06:00','2024-01-09 19:06:00',0),(24,NULL,12,2,'2024-01-09 19:06:00','2024-01-09 19:06:00',0),(25,NULL,12,3,'2024-01-09 19:06:00','2024-01-09 19:06:00',0),(26,NULL,12,4,'2024-01-09 19:06:00','2024-01-09 19:06:00',0),(27,NULL,12,5,'2024-01-09 19:06:00','2024-01-09 19:06:00',0),(28,NULL,11,1,'2024-01-09 19:08:57','2024-01-09 19:11:25',1),(29,NULL,11,2,'2024-01-09 19:08:57','2024-01-09 19:11:25',1),(30,NULL,11,3,'2024-01-09 19:08:57','2024-01-09 19:11:25',1),(31,NULL,11,4,'2024-01-09 19:08:57','2024-01-09 19:11:25',1),(32,NULL,11,5,'2024-01-09 19:08:57','2024-01-09 19:11:25',1),(33,NULL,13,1,'2024-01-09 19:10:32','2024-01-09 19:10:32',0),(34,NULL,13,2,'2024-01-09 19:10:32','2024-01-09 19:10:32',0),(35,NULL,13,3,'2024-01-09 19:10:32','2024-01-09 19:10:32',0),(36,NULL,13,4,'2024-01-09 19:10:32','2024-01-09 19:10:32',0),(37,NULL,13,5,'2024-01-09 19:10:32','2024-01-09 19:10:32',0),(38,NULL,11,1,'2024-01-09 19:11:25','2024-01-10 21:46:00',1),(39,NULL,11,2,'2024-01-09 19:11:25','2024-01-10 21:46:00',1),(40,NULL,11,3,'2024-01-09 19:11:25','2024-01-10 21:46:00',1),(41,NULL,11,4,'2024-01-09 19:11:25','2024-01-10 21:46:00',1),(42,NULL,11,5,'2024-01-09 19:11:25','2024-01-10 21:46:00',1),(43,NULL,11,1,'2024-01-10 21:46:00','2024-01-10 21:48:20',1),(44,NULL,11,2,'2024-01-10 21:46:00','2024-01-10 21:48:20',1),(45,NULL,11,3,'2024-01-10 21:46:00','2024-01-10 21:48:20',1),(46,NULL,11,4,'2024-01-10 21:46:00','2024-01-10 21:48:20',1),(47,NULL,11,5,'2024-01-10 21:46:00','2024-01-10 21:48:20',1),(48,NULL,11,1,'2024-01-10 21:48:20','2024-01-10 21:48:20',0),(49,NULL,11,2,'2024-01-10 21:48:20','2024-01-10 21:48:20',0),(50,NULL,11,3,'2024-01-10 21:48:20','2024-01-10 21:48:20',0),(51,NULL,11,4,'2024-01-10 21:48:20','2024-01-10 21:48:20',0),(52,NULL,11,5,'2024-01-10 21:48:20','2024-01-10 21:48:20',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `first_visit`
--

LOCK TABLES `first_visit` WRITE;
/*!40000 ALTER TABLE `first_visit` DISABLE KEYS */;
INSERT INTO `first_visit` VALUES (1,2,1,13,1,1,'2024-01-18 13:00:00~13:30:00',NULL,NULL,NULL,20,'2024-01-18',4,'13:00:00','13:30:00',2,NULL,NULL,NULL,NULL,NULL,'2024-01-04 10:55:39','2024-01-09 19:37:20',0),(2,1,6,3,1,1,'2023-12-28 13:00:00~13:30:00',NULL,NULL,NULL,20,'2023-12-28',4,'13:00:00','13:30:00',8,1,1,NULL,'我太帅咯，很困扰',2,'2024-01-04 11:06:02','2024-01-07 15:25:57',0),(3,1,6,3,1,1,'2024-01-10 14:30:00~15:00:00',NULL,NULL,NULL,20,'2024-01-17',3,'15:00:00','15:30:00',2,NULL,NULL,NULL,NULL,NULL,'2024-01-06 13:56:08','2024-01-09 19:20:49',0),(4,3,1,3,1,1,'2024-01-17 14:30:00~15:00:00',NULL,NULL,NULL,20,'2024-01-17',3,'14:30:00','15:00:00',2,NULL,NULL,NULL,NULL,NULL,'2024-01-06 15:57:03','2024-01-11 11:48:41',0),(5,3,1,7,1,1,'2023-11-30 13:00:00~13:30:00',NULL,NULL,NULL,20,'2023-11-30',4,'13:00:00','13:30:00',8,1,1,NULL,'有抑郁倾向',2,'2024-01-06 19:55:01','2024-01-07 15:25:57',0),(6,NULL,6,NULL,1,1,NULL,NULL,NULL,NULL,20,NULL,NULL,NULL,NULL,8,NULL,NULL,NULL,NULL,NULL,'2024-01-07 12:05:52','2024-01-07 12:05:52',0),(7,3,12,7,1,1,'2023-12-21 13:00:00~13:30:00',NULL,NULL,NULL,20,'2023-12-21',4,'13:00:00','13:30:00',8,1,1,NULL,'相当炸裂',2,'2024-01-07 13:05:25','2024-01-10 18:34:55',0),(8,1,NULL,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-01-18',4,'13:00:00','13:30:00',3,NULL,NULL,NULL,NULL,NULL,'2024-01-08 16:48:22','2024-01-09 17:18:59',0),(9,3,NULL,8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-01-18',4,'13:00:00','13:30:00',3,NULL,NULL,NULL,NULL,NULL,'2024-01-08 16:48:22','2024-01-10 00:35:57',0),(10,1,11,3,1,1,NULL,NULL,NULL,NULL,NULL,'2024-01-11',4,'13:00:00','13:30:00',2,1,9,1,'吊人',2,'2024-01-08 17:37:40','2024-01-10 00:35:57',0),(11,NULL,1,NULL,1,1,'2024-01-23 15:00:00~15:30:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,NULL,'2024-01-09 17:33:31','2024-01-10 21:46:00',0),(12,NULL,1,NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,NULL,'2024-01-09 19:06:00','2024-01-10 17:00:16',0),(14,NULL,12,NULL,1,1,'2024-01-23 15:00:00~15:30:00',NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2024-01-10 10:10:05','2024-01-10 18:36:55',0);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
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
INSERT INTO `role` VALUES (1,'学生','学生用户',0,'2024-01-02 17:07:34','2024-01-03 17:16:45'),(2,'中心管理员','中心管理员',0,'2024-01-03 10:41:17','2024-01-03 10:41:17'),(3,'初访员','初访员',0,'2024-01-03 10:41:17','2024-01-03 10:41:17'),(4,'心理助理','心理助理',0,'2024-01-03 10:41:17','2024-01-03 10:41:17'),(5,'咨询员','咨询员',0,'2024-01-03 10:41:17','2024-01-03 10:41:17'),(6,'初访员，咨询员','伪双角色',0,'2024-01-04 09:09:35','2024-01-04 09:09:35');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_menu`
--

LOCK TABLES `role_menu` WRITE;
/*!40000 ALTER TABLE `role_menu` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=1742769620166811652 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,'东3-320',1,0,'2024-01-04 10:50:40','2024-01-11 11:30:39'),(2,'东3-318',1,0,'2024-01-04 12:47:11','2024-01-10 16:46:44'),(3,'东3-313',1,0,'2024-01-04 12:56:05','2024-01-10 16:46:44');
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
) ENGINE=InnoDB AUTO_INCREMENT=1742810934925238274 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
INSERT INTO `setting` VALUES (1,2,'2023秋季学期',30,60,'2023-09-04','2024-03-03','2024-01-04 11:11:19','2024-01-06 14:04:49',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_info`
--

LOCK TABLES `student_info` WRITE;
/*!40000 ALTER TABLE `student_info` DISABLE KEYS */;
INSERT INTO `student_info` VALUES (1,1,'2021-09-01',0,'物理学院','1330588116','大学本科','黄某人','13305063935','兄弟','532092252@qq.com','2024-01-05 11:12:21','2024-01-10 21:49:44',0),(2,6,'2021-09-01',1,'软件学院','13305088117','大学本科','黄某人','13305063935','兄弟','532092252@qq.com','2024-01-07 13:02:41','2024-01-07 13:02:41',0),(3,12,'2021-09-01',1,'电信学部','13305088118','大学本科','黄某人','13305063935','兄弟','532092252@qq.com','2024-01-07 13:02:41','2024-01-09 18:54:10',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_info`
--

LOCK TABLES `teacher_info` WRITE;
/*!40000 ALTER TABLE `teacher_info` DISABLE KEYS */;
INSERT INTO `teacher_info` VALUES (1,3,1,'blob:http://127.0.0.1:8081/d9c7b6db-b59d-4a37-8c6f-f584705b83dc','123','西安打胶大学1','超级大靓仔','2024-01-03 17:50:40','2024-01-10 00:25:03',0),(2,5,1,'/very/end','本科生','西安打胶大学','吊人','2024-01-05 16:57:54','2024-01-06 12:37:57',0),(3,7,1,'/very/end','副院长','西安交通大学','年轻人','2024-01-05 16:57:54','2024-01-06 12:37:57',0),(4,8,1,'/very/end','院长','西安交通大学','老年人','2024-01-05 16:57:54','2024-01-06 12:37:57',0),(5,10,1,'/very/end','教授','西安交通大学','中年人','2024-01-06 19:47:01','2024-01-06 19:47:01',0),(6,11,1,'/very/end','教授','西安交通大学','中年人','2024-01-06 19:47:01','2024-01-10 09:34:53',0),(7,13,1,'/very/end','教授','西安交通大学','老年人','2024-01-08 17:10:08','2024-01-10 09:24:41',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'stu1','123','卢鑫培','男','2002-11-06','2024-01-02 17:07:15','2024-01-09 20:24:06',0),(2,'admin','123456','黄俊凯','男','2003-04-11','2024-01-03 10:18:27','2024-01-04 11:35:25',0),(3,'num3','123456','牟展宏','男','2002-11-06','2024-01-03 17:48:49','2024-01-04 09:44:31',0),(4,'num4','123456','谢志成','男','2000-01-01','2024-01-03 17:48:49','2024-01-03 17:48:49',0),(5,'num5','123456','宋天鹏','男','2000-01-01','2024-01-03 17:48:49','2024-01-03 17:48:49',0),(6,'stu2','123456','杜小智','男','2003-04-11','2024-01-04 10:58:57','2024-01-04 10:59:43',0),(7,'first1','123456','祝继华','男','2000-01-01','2024-01-05 16:56:11','2024-01-05 16:56:11',0),(8,'first2','123456','原盛','男','2000-01-01','2024-01-05 16:56:11','2024-01-05 16:56:11',0),(10,'consult1','123456','饶元','男','2000-01-01','2024-01-06 19:45:36','2024-01-06 19:45:36',0),(11,'consult2','123456','宋永红','女','2000-01-01','2024-01-06 19:46:25','2024-01-06 19:46:25',0),(12,'stu3','123456','童粲程','男','2000-01-01','2024-01-07 13:01:32','2024-01-08 17:09:49',0),(13,'first3','123456','路璐','女','2000-01-01','2024-01-08 17:09:49','2024-01-08 17:09:49',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,1,1,'2024-01-02 17:07:46','2024-01-03 16:09:41',0),(2,2,2,'2024-01-03 11:52:07','2024-01-03 11:52:07',0),(3,3,3,'2024-01-03 17:49:05','2024-01-03 17:49:05',0),(4,4,4,'2024-01-03 17:49:05','2024-01-03 17:49:05',0),(5,5,5,'2024-01-03 17:49:05','2024-01-03 17:49:05',0),(7,6,1,'2024-01-04 11:00:03','2024-01-04 11:00:03',0),(8,7,3,'2024-01-05 16:56:26','2024-01-05 16:56:26',0),(9,8,3,'2024-01-05 16:56:26','2024-01-05 16:56:26',0),(10,10,5,'2024-01-06 19:47:26','2024-01-06 19:47:26',0),(11,11,5,'2024-01-06 19:47:26','2024-01-06 19:47:26',0),(12,12,1,'2024-01-08 17:10:34','2024-01-08 17:10:34',0),(13,13,3,'2024-01-08 17:10:34','2024-01-08 17:10:34',0);
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

-- Dump completed on 2024-01-11 14:11:24
