-- MySQL dump 10.13  Distrib 5.5.24, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: tms_development
-- ------------------------------------------------------
-- Server version	5.5.24-0ubuntu0.12.04.1

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
-- Table structure for table `attendances`
--

DROP TABLE IF EXISTS `attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `attendance_date` date DEFAULT NULL,
  `present` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendances`
--

LOCK TABLES `attendances` WRITE;
/*!40000 ALTER TABLE `attendances` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comp_off_requests`
--

DROP TABLE IF EXISTS `comp_off_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comp_off_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `days` int(11) DEFAULT NULL,
  `reason` text COLLATE utf8_unicode_ci,
  `approved` tinyint(1) DEFAULT '0',
  `rejected` tinyint(1) DEFAULT '0',
  `applied_date` date DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comp_off_requests`
--

LOCK TABLES `comp_off_requests` WRITE;
/*!40000 ALTER TABLE `comp_off_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `comp_off_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `confirmations`
--

DROP TABLE IF EXISTS `confirmations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `confirmations`
--

LOCK TABLES `confirmations` WRITE;
/*!40000 ALTER TABLE `confirmations` DISABLE KEYS */;
INSERT INTO `confirmations` VALUES (1,'Confirmed','2015-05-19 16:12:50','2015-05-19 16:12:50'),(2,'Extended','2015-05-19 16:12:50','2015-05-19 16:12:50'),(3,'Probation','2015-05-19 16:12:50','2015-05-19 16:12:50'),(4,'NA','2015-05-19 16:12:50','2015-05-19 16:12:50');
/*!40000 ALTER TABLE `confirmations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `designations`
--

DROP TABLE IF EXISTS `designations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `designations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `designations`
--

LOCK TABLES `designations` WRITE;
/*!40000 ALTER TABLE `designations` DISABLE KEYS */;
INSERT INTO `designations` VALUES (1,'Account Manager','2015-05-19 16:12:47','2015-05-19 16:12:47'),(2,'Accounts Executive','2015-05-19 16:12:47','2015-05-19 16:12:47'),(3,'Analyst','2015-05-19 16:12:47','2015-05-19 16:12:47'),(4,'Assistant Manager - HR','2015-05-19 16:12:48','2015-05-19 16:12:48'),(5,'Associate Software Engineer','2015-05-19 16:12:48','2015-05-19 16:12:48'),(6,'Business Analyst - Data Services','2015-05-19 16:12:48','2015-05-19 16:12:48'),(7,'Business Operation Manager','2015-05-19 16:12:48','2015-05-19 16:12:48'),(8,'Campaign Developer','2015-05-19 16:12:48','2015-05-19 16:12:48'),(9,'Campaign Manager','2015-05-19 16:12:48','2015-05-19 16:12:48'),(10,'Contractor','2015-05-19 16:12:48','2015-05-19 16:12:48'),(11,'Data Analyst','2015-05-19 16:12:48','2015-05-19 16:12:48'),(12,'Delivery Manager','2015-05-19 16:12:48','2015-05-19 16:12:48'),(13,'Digital Market Team Lead','2015-05-19 16:12:48','2015-05-19 16:12:48'),(14,'Director – India Delivery Center','2015-05-19 16:12:48','2015-05-19 16:12:48'),(15,'Director - Managed Business Service Unit','2015-05-19 16:12:48','2015-05-19 16:12:48'),(16,'HR Executive','2015-05-19 16:12:48','2015-05-19 16:12:48'),(17,'Inside Sales Executive','2015-05-19 16:12:48','2015-05-19 16:12:48'),(18,'Internet Marketing Team lead','2015-05-19 16:12:48','2015-05-19 16:12:48'),(19,'Manager - Finance','2015-05-19 16:12:48','2015-05-19 16:12:48'),(20,'Manager - HR','2015-05-19 16:12:48','2015-05-19 16:12:48'),(21,'Manager Resourcing','2015-05-19 16:12:48','2015-05-19 16:12:48'),(22,'Managing Partner','2015-05-19 16:12:48','2015-05-19 16:12:48'),(23,'Operations Manager','2015-05-19 16:12:48','2015-05-19 16:12:48'),(24,'Project Coordinator','2015-05-19 16:12:48','2015-05-19 16:12:48'),(25,'Project Lead','2015-05-19 16:12:48','2015-05-19 16:12:48'),(26,'Project Manager','2015-05-19 16:12:48','2015-05-19 16:12:48'),(27,'Quality Analyst','2015-05-19 16:12:49','2015-05-19 16:12:49'),(28,'Senior Analyst','2015-05-19 16:12:49','2015-05-19 16:12:49'),(29,'Senior Recruiter','2015-05-19 16:12:49','2015-05-19 16:12:49'),(30,'Senior Resercher','2015-05-19 16:12:49','2015-05-19 16:12:49'),(31,'Senior Software Engineer','2015-05-19 16:12:49','2015-05-19 16:12:49'),(32,'Senior Sys Admin','2015-05-19 16:12:49','2015-05-19 16:12:49'),(33,'Senior Technical Writer','2015-05-19 16:12:49','2015-05-19 16:12:49'),(34,'SEO/SMO Analyst','2015-05-19 16:12:49','2015-05-19 16:12:49'),(35,'Software Engineer','2015-05-19 16:12:49','2015-05-19 16:12:49'),(36,'Sr Business Development Executive','2015-05-19 16:12:49','2015-05-19 16:12:49'),(37,'Sr. Business Analyst','2015-05-19 16:12:49','2015-05-19 16:12:49'),(38,'Sr. DBA','2015-05-19 16:12:49','2015-05-19 16:12:49'),(39,'Sr. Engagement Manager – AML','2015-05-19 16:12:49','2015-05-19 16:12:49'),(40,'Sr. Executive - Resourcing','2015-05-19 16:12:49','2015-05-19 16:12:49'),(41,'Sr. Inside Sales Executive','2015-05-19 16:12:49','2015-05-19 16:12:49'),(42,'Sr. IT Manager','2015-05-19 16:12:49','2015-05-19 16:12:49'),(43,'Sr. Marketing Executive','2015-05-19 16:12:49','2015-05-19 16:12:49'),(44,'Sr. Technical Architect','2015-05-19 16:12:49','2015-05-19 16:12:49'),(45,'Sr. Technical Recruiter','2015-05-19 16:12:49','2015-05-19 16:12:49'),(46,'Team Lead','2015-05-19 16:12:49','2015-05-19 16:12:49'),(47,'Team Lead - Data Entry','2015-05-19 16:12:50','2015-05-19 16:12:50'),(48,'Tech Lead','2015-05-19 16:12:50','2015-05-19 16:12:50'),(49,'Tech Writer','2015-05-19 16:12:50','2015-05-19 16:12:50'),(50,'Technical Architect','2015-05-19 16:12:50','2015-05-19 16:12:50'),(51,'Technical Content Writer','2015-05-19 16:12:50','2015-05-19 16:12:50'),(52,'Technical Manager','2015-05-19 16:12:50','2015-05-19 16:12:50'),(53,'Technical Recruiter','2015-05-19 16:12:50','2015-05-19 16:12:50'),(54,'Trainee','2015-05-19 16:12:50','2015-05-19 16:12:50');
/*!40000 ALTER TABLE `designations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_types`
--

DROP TABLE IF EXISTS `emp_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emp_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_types`
--

LOCK TABLES `emp_types` WRITE;
/*!40000 ALTER TABLE `emp_types` DISABLE KEYS */;
INSERT INTO `emp_types` VALUES (1,'Full time','2015-05-19 16:12:50','2015-05-19 16:12:50'),(2,'Contractor','2015-05-19 16:12:50','2015-05-19 16:12:50');
/*!40000 ALTER TABLE `emp_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genders`
--

DROP TABLE IF EXISTS `genders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genders`
--

LOCK TABLES `genders` WRITE;
/*!40000 ALTER TABLE `genders` DISABLE KEYS */;
INSERT INTO `genders` VALUES (1,'Male','2015-05-19 16:12:51','2015-05-19 16:12:51'),(2,'Female','2015-05-19 16:12:51','2015-05-19 16:12:51');
/*!40000 ALTER TABLE `genders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades`
--

DROP TABLE IF EXISTS `grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades`
--

LOCK TABLES `grades` WRITE;
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
INSERT INTO `grades` VALUES (1,'L1','2015-05-19 16:12:50','2015-05-19 16:12:50'),(2,'L2','2015-05-19 16:12:50','2015-05-19 16:12:50'),(3,'L3','2015-05-19 16:12:50','2015-05-19 16:12:50'),(4,'L4','2015-05-19 16:12:50','2015-05-19 16:12:50'),(5,'L5','2015-05-19 16:12:50','2015-05-19 16:12:50');
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holidays`
--

DROP TABLE IF EXISTS `holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `holidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `day_shift` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holidays`
--

LOCK TABLES `holidays` WRITE;
/*!40000 ALTER TABLE `holidays` DISABLE KEYS */;
INSERT INTO `holidays` VALUES (1,'Independence Day','2014-08-15',1,'2015-05-19 16:12:52','2015-05-19 16:12:52');
/*!40000 ALTER TABLE `holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave_credits`
--

DROP TABLE IF EXISTS `leave_credits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leave_credits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `leave_id` int(11) DEFAULT NULL,
  `attendance_id` int(11) DEFAULT NULL,
  `leave_info_id` int(11) DEFAULT NULL,
  `leave_credited_date` date DEFAULT NULL,
  `consumed` tinyint(1) DEFAULT '0',
  `half_day_leave` tinyint(1) DEFAULT '0',
  `is_first_half` tinyint(1) DEFAULT NULL,
  `other_half_leave_id` int(11) DEFAULT NULL,
  `comp_off_request_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_credits`
--

LOCK TABLES `leave_credits` WRITE;
/*!40000 ALTER TABLE `leave_credits` DISABLE KEYS */;
INSERT INTO `leave_credits` VALUES (1,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(2,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(3,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(4,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(5,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(6,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(7,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(8,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(9,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(10,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(11,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(12,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(13,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(14,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(15,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(16,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(17,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(18,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(19,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(20,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(21,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(22,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(23,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(24,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(25,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(26,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(27,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(28,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(29,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(30,7,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(31,7,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(32,7,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(33,7,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(34,7,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(35,7,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(36,9,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(37,9,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(38,9,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(39,9,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(40,9,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(41,9,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(42,11,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(43,11,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(44,11,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(45,11,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(46,11,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(47,11,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(48,11,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(49,11,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(50,12,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(51,12,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(52,12,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(53,12,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(54,12,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(55,12,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(56,12,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(57,12,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(58,12,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(59,12,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(60,12,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(61,13,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(62,13,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(63,13,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(64,13,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(65,13,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(66,13,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(67,13,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(68,13,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(69,13,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(70,13,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(71,13,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(72,13,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(73,13,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(74,13,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(75,13,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(76,13,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(77,14,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(78,14,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(79,14,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(80,14,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(81,14,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(82,14,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(83,14,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(84,14,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(85,15,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(86,15,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(87,15,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(88,15,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(89,15,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(90,15,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(91,15,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(92,15,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(93,15,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(94,15,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(95,15,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(96,15,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(97,15,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(98,16,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(99,16,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(100,16,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(101,16,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(102,16,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(103,16,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(104,16,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(105,16,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(106,16,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(107,16,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(108,16,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(109,16,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(110,17,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(111,17,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(112,17,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(113,17,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(114,17,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(115,17,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(116,17,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(117,17,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(118,17,2,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(119,17,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(120,17,1,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(121,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(122,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(123,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(124,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(125,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(126,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(127,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(128,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(129,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(130,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(131,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(132,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(133,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(134,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(135,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(136,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(137,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(138,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(139,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(140,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(141,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(142,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(143,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(144,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(145,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(146,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(147,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(148,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(149,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(150,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(151,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(152,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(153,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(154,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21'),(155,6,3,NULL,NULL,'2015-05-19',0,0,NULL,NULL,NULL,'2015-05-19 17:12:21','2015-05-19 17:12:21');
/*!40000 ALTER TABLE `leave_credits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave_infos`
--

DROP TABLE IF EXISTS `leave_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leave_infos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `leave_applied_date` date DEFAULT NULL,
  `leave_approved_date` date DEFAULT NULL,
  `approved` tinyint(1) DEFAULT '0',
  `rejected` tinyint(1) DEFAULT '0',
  `cancelled` tinyint(1) DEFAULT '0',
  `cancel_request` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_infos`
--

LOCK TABLES `leave_infos` WRITE;
/*!40000 ALTER TABLE `leave_infos` DISABLE KEYS */;
/*!40000 ALTER TABLE `leave_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaves`
--

DROP TABLE IF EXISTS `leaves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leaves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaves`
--

LOCK TABLES `leaves` WRITE;
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
INSERT INTO `leaves` VALUES (1,'Sick Leave','2015-05-19 16:12:51','2015-05-19 16:12:51'),(2,'Casual Leave','2015-05-19 16:12:51','2015-05-19 16:12:51'),(3,'Earned Leave','2015-05-19 16:12:51','2015-05-19 16:12:51'),(4,'Maternity Leave','2015-05-19 16:12:51','2015-05-19 16:12:51'),(5,'Present But Card Not Shown','2015-05-19 16:12:51','2015-05-19 16:12:51'),(6,'On Office Duty/Client Side','2015-05-19 16:12:51','2015-05-19 16:12:51'),(7,'Compensatory Off','2015-05-19 16:12:51','2015-05-19 16:12:51');
/*!40000 ALTER TABLE `leaves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Chandigarh','2015-05-19 16:12:51','2015-05-19 16:12:51'),(2,'Gurgaon','2015-05-19 16:12:51','2015-05-19 16:12:51');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loss_of_pay_infos`
--

DROP TABLE IF EXISTS `loss_of_pay_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loss_of_pay_infos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loss_of_pay_id` int(11) DEFAULT NULL,
  `attendance_id` int(11) DEFAULT NULL,
  `leave_info_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loss_of_pay_infos`
--

LOCK TABLES `loss_of_pay_infos` WRITE;
/*!40000 ALTER TABLE `loss_of_pay_infos` DISABLE KEYS */;
/*!40000 ALTER TABLE `loss_of_pay_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loss_of_pays`
--

DROP TABLE IF EXISTS `loss_of_pays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loss_of_pays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loss_of_pays`
--

LOCK TABLES `loss_of_pays` WRITE;
/*!40000 ALTER TABLE `loss_of_pays` DISABLE KEYS */;
INSERT INTO `loss_of_pays` VALUES (1,'LOP','2015-05-19 16:12:51','2015-05-19 16:12:51'),(2,'LOP Refund','2015-05-19 16:12:51','2015-05-19 16:12:51');
/*!40000 ALTER TABLE `loss_of_pays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lta_options`
--

DROP TABLE IF EXISTS `lta_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lta_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lta_options`
--

LOCK TABLES `lta_options` WRITE;
/*!40000 ALTER TABLE `lta_options` DISABLE KEYS */;
INSERT INTO `lta_options` VALUES (1,'Monthly','2015-05-19 16:12:51','2015-05-19 16:12:51'),(2,'Annual','2015-05-19 16:12:51','2015-05-19 16:12:51');
/*!40000 ALTER TABLE `lta_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marital_statuses`
--

DROP TABLE IF EXISTS `marital_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marital_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marital_statuses`
--

LOCK TABLES `marital_statuses` WRITE;
/*!40000 ALTER TABLE `marital_statuses` DISABLE KEYS */;
INSERT INTO `marital_statuses` VALUES (1,'Married','2015-05-19 16:12:51','2015-05-19 16:12:51'),(2,'Single','2015-05-19 16:12:51','2015-05-19 16:12:51');
/*!40000 ALTER TABLE `marital_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `med_reimb_options`
--

DROP TABLE IF EXISTS `med_reimb_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `med_reimb_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `med_reimb_options`
--

LOCK TABLES `med_reimb_options` WRITE;
/*!40000 ALTER TABLE `med_reimb_options` DISABLE KEYS */;
INSERT INTO `med_reimb_options` VALUES (1,'Monthly','2015-05-19 16:12:51','2015-05-19 16:12:51'),(2,'Quarerly','2015-05-19 16:12:51','2015-05-19 16:12:51');
/*!40000 ALTER TABLE `med_reimb_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_users`
--

DROP TABLE IF EXISTS `project_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_users`
--

LOCK TABLES `project_users` WRITE;
/*!40000 ALTER TABLE `project_users` DISABLE KEYS */;
INSERT INTO `project_users` VALUES (1,2,7,'2015-05-19 17:06:38','2015-05-19 17:06:38'),(2,3,8,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(3,4,9,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(4,1,10,'2015-05-19 17:06:39','2015-05-19 17:06:39'),(5,6,11,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(6,6,12,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(7,8,13,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(8,4,14,'2015-05-19 17:06:40','2015-05-19 17:06:40'),(9,8,15,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(10,11,16,'2015-05-19 17:06:41','2015-05-19 17:06:41'),(11,12,17,'2015-05-19 17:06:41','2015-05-19 17:06:41');
/*!40000 ALTER TABLE `project_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'HR','2015-05-19 16:12:51','2015-05-19 16:12:51'),(2,'BDG','2015-05-19 16:12:52','2015-05-19 16:12:52'),(3,'ISO','2015-05-19 16:12:52','2015-05-19 16:12:52'),(4,'FINANCE','2015-05-19 16:12:52','2015-05-19 16:12:52'),(5,'HR','2015-05-19 16:12:52','2015-05-19 16:12:52'),(6,'CAN','2015-05-19 16:12:52','2015-05-19 16:12:52'),(7,'CAN','2015-05-19 16:12:52','2015-05-19 16:12:52'),(8,'MARKETLIVE','2015-05-19 16:12:52','2015-05-19 16:12:52'),(9,'Finance','2015-05-19 16:12:52','2015-05-19 16:12:52'),(10,'MARKETLIVE','2015-05-19 16:12:52','2015-05-19 16:12:52'),(11,'IT','2015-05-19 16:12:52','2015-05-19 16:12:52'),(12,'Google','2015-05-19 16:12:52','2015-05-19 16:12:52');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20140807094948'),('20140807111853'),('20140807111906'),('20140807111918'),('20140807111930'),('20140807112002'),('20140807112020'),('20140807112033'),('20140807112143'),('20140807112229'),('20140807112254'),('20140807133749'),('20140808052429'),('20140808052753'),('20140808053210'),('20140808060233'),('20140812072800'),('20140825063006'),('20140825063116'),('20140923142203'),('20140925103545'),('20150122082045'),('20150122082912'),('20150519065212');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statuses`
--

DROP TABLE IF EXISTS `statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statuses`
--

LOCK TABLES `statuses` WRITE;
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;
INSERT INTO `statuses` VALUES (1,'Active','2015-05-19 16:12:50','2015-05-19 16:12:50'),(2,'Left','2015-05-19 16:12:50','2015-05-19 16:12:50'),(3,'Unpaid Leave','2015-05-19 16:12:51','2015-05-19 16:12:51');
/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ecode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `emp_type_id` int(11) DEFAULT NULL,
  `designation_id` int(11) DEFAULT NULL,
  `grade_id` int(11) DEFAULT NULL,
  `date_of_joining` datetime DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `bu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_exp` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trantor_exp` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prior_exp` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmation_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `current_contact` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `emergency_contact_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `gender_id` int(11) DEFAULT NULL,
  `blood_group` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marital_status_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marriage_anniv_date` datetime DEFAULT NULL,
  `pan` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank_ac_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ifsc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lta_option_id` int(11) DEFAULT NULL,
  `contractual_ecode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pf_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `esi_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_no` int(11) DEFAULT NULL,
  `day_shift` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `role` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (6,'nidhi.ayri','E00015','Nidhi Ayri',1,20,3,'2012-04-16 00:00:00',NULL,'Support',NULL,NULL,'8','nidhi.ayri@trantorinc.com',1,1,NULL,'9803083292','9041393292','1980-11-22 00:00:00',2,'B+','1','2005-11-18 00:00:00','BFTPS8845G',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,6205802,NULL,1,NULL,2,'2015-05-19 17:12:04','2015-05-19 17:06:59','192.168.176.55','192.168.176.55','2015-05-19 17:06:29','2015-05-19 17:12:04','admin'),(7,'raman.bedi','E00031','Raman Bedi',1,35,5,'2012-07-02 00:00:00',6,'Technology',NULL,NULL,'0','raman.bedi@trantorinc.com',1,1,NULL,'9855091006','9814904231','1989-11-18 00:00:00',1,'O+',NULL,NULL,'BLAPB2591R',NULL,NULL,NULL,NULL,1,'',NULL,NULL,6205802,NULL,1,NULL,0,NULL,NULL,NULL,NULL,'2015-05-19 17:06:38','2015-05-19 17:06:38','employee'),(8,'Ritika.Arora','EC0049','Ritika Arora',NULL,10,4,'2012-09-24 00:00:00',6,'Support',NULL,NULL,'5.83','ritika.arora@trantorinc.com',1,1,NULL,'9888899502','8295353602','1984-09-11 00:00:00',2,'B+',NULL,NULL,'ALNPA3150D',NULL,NULL,NULL,NULL,1,'',NULL,NULL,6609047,NULL,1,NULL,0,NULL,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39','employee'),(9,'Kamal.Sharma','E00057','Kamal Sharma',1,19,3,'2012-11-05 00:00:00',6,'Support',NULL,NULL,'18','kamal.sharma@trantorinc.com',1,1,NULL,'9876629265','9872209265','1970-02-16 00:00:00',1,'A+','1','0097-11-29 23:59:52','AYJPS3511P',NULL,NULL,NULL,NULL,1,'',NULL,NULL,2003608,NULL,1,NULL,0,NULL,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39','manager'),(10,'Priya.Bajaj','EC0060','Priya Bajaj',NULL,10,5,'2012-12-17 00:00:00',6,'Support',NULL,NULL,'4.25','priya.bajaj@trantorinc.com',1,1,NULL,'9646930185','0172-2591728','1986-02-23 00:00:00',2,'AB+',NULL,NULL,'ARKPB8101A',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,1359770,NULL,1,NULL,0,NULL,NULL,NULL,NULL,'2015-05-19 17:06:39','2015-05-19 17:06:39','employee'),(11,'Vivek.Angra','E00098','Vivek Angra',1,35,5,'2013-04-10 00:00:00',6,'Technology',NULL,NULL,'1.67','vivek.angra@trantorinc.com',1,1,NULL,'9988088337','01975-286007','1989-12-25 00:00:00',1,'B+',NULL,NULL,'AUKPA7114M',NULL,NULL,NULL,NULL,1,'EC0013',NULL,NULL,9944015,NULL,1,NULL,0,NULL,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40','employee'),(12,'prashant.sahni','E00139','Prashant Sahni',1,31,4,'2013-10-23 00:00:00',6,'Technology',NULL,NULL,'4.47','prashant.sahni@trantorinc.com',1,1,NULL,'9013597734','9412372678','1984-12-05 00:00:00',1,'B+',NULL,NULL,'BZCPS2029F',NULL,NULL,NULL,NULL,1,'',NULL,NULL,6209131,NULL,1,NULL,0,NULL,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40','employee'),(13,'rajesh.thakur','E00145','Rajesh Thakur',1,46,3,'2013-12-16 00:00:00',6,'Technology',NULL,NULL,'12.75','rajesh.thakur@trantorinc.com',1,1,NULL,'8699009700','8699009700','1980-11-21 00:00:00',1,'A+','1','0013-06-11 23:59:52','AFLPT7111F',NULL,NULL,NULL,NULL,1,'EC0014',NULL,NULL,8691393,NULL,1,NULL,0,NULL,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40','admin'),(14,'Ajay.Kumar','E00157','Ajay Kumar',1,2,5,'2014-01-04 00:00:00',9,'Support',NULL,NULL,'0','ajay.kumar@trantorinc.com',3,1,NULL,'','','1989-01-16 00:00:00',1,'',NULL,NULL,'CCBPK2225C',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,6217603,NULL,1,NULL,0,NULL,NULL,NULL,NULL,'2015-05-19 17:06:40','2015-05-19 17:06:40','employee'),(15,'Sakshi.Duggal','E00274','Sakshi Duggal',1,5,5,'2014-12-01 00:00:00',9,'Technology',NULL,NULL,'0.5','sakshi.duggal@chd.trantorinc.com',3,1,NULL,'8262880282','8262880282','1992-04-28 00:00:00',2,'AB+',NULL,NULL,'Not_Provided',NULL,NULL,NULL,NULL,1,'',NULL,NULL,5722884,NULL,1,NULL,0,NULL,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41','employee'),(16,'Atul.Guleria','E00332','Atul Guleria',1,NULL,5,'2015-03-24 00:00:00',9,'Support',NULL,NULL,'0','atul.guleria@chd.trantorinc.com',3,1,NULL,'9646617688','9646617688','1986-01-28 00:00:00',1,'A+',NULL,NULL,'BKQPG7735R',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,6597146,NULL,1,NULL,0,NULL,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41','employee'),(17,'Vivek.Beentiak','E00355','Vivek Beentiak',1,35,5,'2015-04-27 00:00:00',9,'Technology',NULL,NULL,'5.17','vivek.beentiak@chd.trantorinc.com',3,1,NULL,'9779880351','9779880351','1990-11-09 00:00:00',1,'B+',NULL,NULL,'CJUPS7950J',NULL,NULL,NULL,NULL,1,'',NULL,NULL,1195725,NULL,1,NULL,0,NULL,NULL,NULL,NULL,'2015-05-19 17:06:41','2015-05-19 17:06:41','employee');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-19 17:23:00
