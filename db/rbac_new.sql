-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: thunder
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.14.04.1

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
-- Table structure for table `thunder_cloud_domain`
--

DROP TABLE IF EXISTS `thunder_cloud_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thunder_cloud_domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thunder_cloud_domain`
--

LOCK TABLES `thunder_cloud_domain` WRITE;
/*!40000 ALTER TABLE `thunder_cloud_domain` DISABLE KEYS */;
INSERT INTO `thunder_cloud_domain` VALUES (1,'Everything',1);
/*!40000 ALTER TABLE `thunder_cloud_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thunder_cloud_domain_map`
--

DROP TABLE IF EXISTS `thunder_cloud_domain_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thunder_cloud_domain_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cloud_id` int(11) NOT NULL,
  `domain_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `thunder_cloud_domain_map_abc7588b` (`cloud_id`),
  KEY `thunder_cloud_domain_map_662cbf12` (`domain_id`),
  CONSTRAINT `thunder_cloud_domai_cloud_id_dfed449cd65dc74_fk_thunder_cloud_id` FOREIGN KEY (`cloud_id`) REFERENCES `thunder_cloud` (`id`),
  CONSTRAINT `thunder_cl_domain_id_7659d7deaa3e43fc_fk_thunder_cloud_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `thunder_cloud_domain` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thunder_cloud_domain_map`
--

LOCK TABLES `thunder_cloud_domain_map` WRITE;
/*!40000 ALTER TABLE `thunder_cloud_domain_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `thunder_cloud_domain_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thunder_domain_role`
--

DROP TABLE IF EXISTS `thunder_domain_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thunder_domain_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `thunder_domain_role_662cbf12` (`domain_id`),
  KEY `thunder_domain_role_8373b171` (`permission_id`),
  CONSTRAINT `D57b6acd5ade8e1da6a28cab65c30d4a` FOREIGN KEY (`permission_id`) REFERENCES `thunder_domain_role_permission` (`id`),
  CONSTRAINT `thunder_do_domain_id_46440d90174d4745_fk_thunder_cloud_domain_id` FOREIGN KEY (`domain_id`) REFERENCES `thunder_cloud_domain` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thunder_domain_role`
--

LOCK TABLES `thunder_domain_role` WRITE;
/*!40000 ALTER TABLE `thunder_domain_role` DISABLE KEYS */;
INSERT INTO `thunder_domain_role` VALUES (1,'ThunderAdmin',1,1),(2,'CloudAdmin',1,2),(3,'Engineer',1,3),(4,'User',1,4);
/*!40000 ALTER TABLE `thunder_domain_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thunder_domain_role_permission`
--

DROP TABLE IF EXISTS `thunder_domain_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thunder_domain_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thunder_domain_role_permission`
--

LOCK TABLES `thunder_domain_role_permission` WRITE;
/*!40000 ALTER TABLE `thunder_domain_role_permission` DISABLE KEYS */;
INSERT INTO `thunder_domain_role_permission` VALUES (1,'ThunderAdmin','Individual Cloud or Thunder ( all clouds)'),(2,'CloudAdmin','View, change configurations or deploy'),(3,'Engineer','View or change cloud configurations'),(4,'User','View cloud configurations only');
/*!40000 ALTER TABLE `thunder_domain_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thunder_user_role_mapping`
--

DROP TABLE IF EXISTS `thunder_user_role_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thunder_user_role_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `thunder_user_role_mapping_84566833` (`role_id`),
  KEY `thunder_user_role_mapping_e8701ad4` (`user_id`),
  CONSTRAINT `thunder_user_role_mappi_user_id_50b761b626e61146_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `thunder_user_r_role_id_4b34bec9a5d22a9_fk_thunder_domain_role_id` FOREIGN KEY (`role_id`) REFERENCES `thunder_domain_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thunder_user_role_mapping`
--

LOCK TABLES `thunder_user_role_mapping` WRITE;
/*!40000 ALTER TABLE `thunder_user_role_mapping` DISABLE KEYS */;
INSERT INTO `thunder_user_role_mapping` VALUES (1,1,1);
/*!40000 ALTER TABLE `thunder_user_role_mapping` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-12 20:44:09
