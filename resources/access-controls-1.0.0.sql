-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: yolojs-access-controls
-- ------------------------------------------------------
-- Server version	5.7.17

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
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `alert.email` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations`
--

LOCK TABLES `organizations` WRITE;
/*!40000 ALTER TABLE `organizations` DISABLE KEYS */;
INSERT INTO `organizations` VALUES (1,'Test','');
/*!40000 ALTER TABLE `organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations.spaces`
--

DROP TABLE IF EXISTS `organizations.spaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizations.spaces` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `this` int(10) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `organization` (`this`),
  CONSTRAINT `organizations.spaces_ibfk_1` FOREIGN KEY (`this`) REFERENCES `organizations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations.spaces`
--

LOCK TABLES `organizations.spaces` WRITE;
/*!40000 ALTER TABLE `organizations.spaces` DISABLE KEYS */;
INSERT INTO `organizations.spaces` VALUES (1,1,'Project 1');
/*!40000 ALTER TABLE `organizations.spaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations.spaces.clients`
--

DROP TABLE IF EXISTS `organizations.spaces.clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizations.spaces.clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `this` int(10) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `space` (`this`),
  CONSTRAINT `organizations.spaces.clients_ibfk_1` FOREIGN KEY (`this`) REFERENCES `organizations.spaces` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations.spaces.clients`
--

LOCK TABLES `organizations.spaces.clients` WRITE;
/*!40000 ALTER TABLE `organizations.spaces.clients` DISABLE KEYS */;
INSERT INTO `organizations.spaces.clients` VALUES (1,1,'API');
/*!40000 ALTER TABLE `organizations.spaces.clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization` int(10) unsigned NOT NULL,
  `type` varchar(128) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `identifier` varchar(128) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `action` varchar(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `organization` (`organization`),
  CONSTRAINT `permissions_ibfk_1` FOREIGN KEY (`organization`) REFERENCES `organizations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,1,'Entity','1','read');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization` int(10) unsigned NOT NULL,
  `space` int(10) unsigned DEFAULT NULL,
  `client` int(10) unsigned DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `organization` (`organization`),
  KEY `space` (`space`),
  KEY `client` (`client`),
  CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`organization`) REFERENCES `organizations` (`id`),
  CONSTRAINT `roles_ibfk_2` FOREIGN KEY (`space`) REFERENCES `organizations.spaces` (`id`),
  CONSTRAINT `roles_ibfk_3` FOREIGN KEY (`client`) REFERENCES `organizations.spaces.clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,1,NULL,NULL,'Admin');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles.permissions`
--

DROP TABLE IF EXISTS `roles.permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles.permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `this` int(10) unsigned NOT NULL,
  `permission` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `this` (`this`),
  KEY `right` (`permission`),
  CONSTRAINT `roles.permissions_ibfk_1` FOREIGN KEY (`permission`) REFERENCES `permissions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles.permissions`
--

LOCK TABLES `roles.permissions` WRITE;
/*!40000 ALTER TABLE `roles.permissions` DISABLE KEYS */;
INSERT INTO `roles.permissions` VALUES (1,1,1);
/*!40000 ALTER TABLE `roles.permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles.roles`
--

DROP TABLE IF EXISTS `roles.roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles.roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `this` int(10) unsigned NOT NULL,
  `role` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `this` (`this`),
  KEY `role` (`role`),
  CONSTRAINT `roles.roles_ibfk_1` FOREIGN KEY (`this`) REFERENCES `roles` (`id`),
  CONSTRAINT `roles.roles_ibfk_2` FOREIGN KEY (`role`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles.roles`
--

LOCK TABLES `roles.roles` WRITE;
/*!40000 ALTER TABLE `roles.roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles.roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rules`
--

DROP TABLE IF EXISTS `rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization` int(10) unsigned NOT NULL,
  `space` int(10) unsigned DEFAULT NULL,
  `client` int(10) unsigned DEFAULT NULL,
  `user` int(10) unsigned DEFAULT NULL,
  `identity` int(10) unsigned DEFAULT NULL,
  `role` int(10) unsigned DEFAULT NULL,
  `permission` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `organization` (`organization`),
  KEY `space` (`space`),
  KEY `client` (`client`),
  KEY `user` (`user`),
  KEY `identity` (`identity`),
  KEY `role` (`role`),
  KEY `right` (`permission`),
  CONSTRAINT `rules_ibfk_1` FOREIGN KEY (`organization`) REFERENCES `organizations` (`id`),
  CONSTRAINT `rules_ibfk_2` FOREIGN KEY (`space`) REFERENCES `organizations.spaces` (`id`),
  CONSTRAINT `rules_ibfk_3` FOREIGN KEY (`client`) REFERENCES `organizations.spaces.clients` (`id`),
  CONSTRAINT `rules_ibfk_4` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `rules_ibfk_5` FOREIGN KEY (`identity`) REFERENCES `users.identities` (`id`),
  CONSTRAINT `rules_ibfk_6` FOREIGN KEY (`role`) REFERENCES `roles` (`id`),
  CONSTRAINT `rules_ibfk_7` FOREIGN KEY (`permission`) REFERENCES `permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rules`
--

LOCK TABLES `rules` WRITE;
/*!40000 ALTER TABLE `rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rules#actions`
--

DROP TABLE IF EXISTS `rules#actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules#actions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rules#actions`
--

LOCK TABLES `rules#actions` WRITE;
/*!40000 ALTER TABLE `rules#actions` DISABLE KEYS */;
INSERT INTO `rules#actions` VALUES (1,'pass'),(2,'block'),(3,'log'),(4,'alert');
/*!40000 ALTER TABLE `rules#actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rules.actions`
--

DROP TABLE IF EXISTS `rules.actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules.actions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `method` varchar(128) COLLATE utf8_bin NOT NULL,
  `payload` text COLLATE utf8_bin,
  `action` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `action` (`action`),
  CONSTRAINT `rules.actions_ibfk_1` FOREIGN KEY (`action`) REFERENCES `rules#actions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rules.actions`
--

LOCK TABLES `rules.actions` WRITE;
/*!40000 ALTER TABLE `rules.actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `rules.actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization.space` int(10) unsigned NOT NULL,
  `identifier` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `space` (`organization.space`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`organization.space`) REFERENCES `organizations.spaces` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'eb283372-1105-40d5-8bd2-f02309512e5a');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users.identities`
--

DROP TABLE IF EXISTS `users.identities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users.identities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `this` int(10) unsigned NOT NULL,
  `identity` varchar(128) COLLATE utf8_bin NOT NULL,
  `secret` varchar(256) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`this`),
  CONSTRAINT `users.identities_ibfk_1` FOREIGN KEY (`this`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users.identities`
--

LOCK TABLES `users.identities` WRITE;
/*!40000 ALTER TABLE `users.identities` DISABLE KEYS */;
/*!40000 ALTER TABLE `users.identities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users.roles`
--

DROP TABLE IF EXISTS `users.roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users.roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `this` int(10) unsigned NOT NULL,
  `role` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `this` (`this`),
  KEY `role` (`role`),
  CONSTRAINT `users.roles_ibfk_1` FOREIGN KEY (`this`) REFERENCES `users` (`id`),
  CONSTRAINT `users.roles_ibfk_2` FOREIGN KEY (`role`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users.roles`
--

LOCK TABLES `users.roles` WRITE;
/*!40000 ALTER TABLE `users.roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `users.roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users.sessions`
--

DROP TABLE IF EXISTS `users.sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users.sessions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `this` int(10) unsigned NOT NULL,
  `client` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `token` varchar(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `used` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `this` (`this`),
  KEY `client` (`client`),
  CONSTRAINT `users.sessions_ibfk_1` FOREIGN KEY (`this`) REFERENCES `users` (`id`),
  CONSTRAINT `users.sessions_ibfk_2` FOREIGN KEY (`client`) REFERENCES `organizations.spaces.clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users.sessions`
--

LOCK TABLES `users.sessions` WRITE;
/*!40000 ALTER TABLE `users.sessions` DISABLE KEYS */;
INSERT INTO `users.sessions` VALUES (1,1,1,'2017-03-24 11:40:38','c5a44663e53dac32b0b27c7400a7d38fd47967486d771be114fb676d723baef1',0);
/*!40000 ALTER TABLE `users.sessions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-24 12:00:19
