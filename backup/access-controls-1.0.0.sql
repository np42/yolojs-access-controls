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
-- Table structure for table `constraints`
--

DROP TABLE IF EXISTS `constraints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `constraints` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization` int(10) unsigned NOT NULL,
  `space` int(10) unsigned DEFAULT NULL,
  `client` int(10) unsigned DEFAULT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `mode` enum('pass','block') COLLATE utf8_bin NOT NULL,
  `predicate` varchar(128) COLLATE utf8_bin NOT NULL,
  `payload` text COLLATE utf8_bin,
  PRIMARY KEY (`id`),
  KEY `organization` (`organization`),
  KEY `space` (`space`),
  KEY `client` (`client`),
  CONSTRAINT `constraints_ibfk_1` FOREIGN KEY (`organization`) REFERENCES `organizations` (`id`),
  CONSTRAINT `constraints_ibfk_2` FOREIGN KEY (`space`) REFERENCES `organizations.spaces` (`id`),
  CONSTRAINT `constraints_ibfk_3` FOREIGN KEY (`client`) REFERENCES `organizations.spaces.clients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `constraints`
--

LOCK TABLES `constraints` WRITE;
/*!40000 ALTER TABLE `constraints` DISABLE KEYS */;
/*!40000 ALTER TABLE `constraints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations`
--

LOCK TABLES `organizations` WRITE;
/*!40000 ALTER TABLE `organizations` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations.spaces`
--

LOCK TABLES `organizations.spaces` WRITE;
/*!40000 ALTER TABLE `organizations.spaces` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations.spaces.clients`
--

LOCK TABLES `organizations.spaces.clients` WRITE;
/*!40000 ALTER TABLE `organizations.spaces.clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizations.spaces.clients` ENABLE KEYS */;
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
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `organization` (`organization`),
  KEY `space` (`space`),
  KEY `client` (`client`),
  CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`organization`) REFERENCES `organizations` (`id`),
  CONSTRAINT `roles_ibfk_2` FOREIGN KEY (`space`) REFERENCES `organizations.spaces` (`id`),
  CONSTRAINT `roles_ibfk_3` FOREIGN KEY (`client`) REFERENCES `organizations.spaces.clients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
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
-- Table structure for table `roles.scopes`
--

DROP TABLE IF EXISTS `roles.scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles.scopes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `this` int(10) unsigned NOT NULL,
  `scope.attribute` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `this` (`this`),
  KEY `roles.scopes.this-scopes.attributes.id` (`scope.attribute`),
  CONSTRAINT `roles.scopes.this-scopes.attributes.id` FOREIGN KEY (`scope.attribute`) REFERENCES `scopes.attributes` (`id`),
  CONSTRAINT `roles.scopes_ibfk_1` FOREIGN KEY (`this`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles.scopes`
--

LOCK TABLES `roles.scopes` WRITE;
/*!40000 ALTER TABLE `roles.scopes` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles.scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rules`
--

DROP TABLE IF EXISTS `rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization` int(10) unsigned DEFAULT NULL,
  `space` int(10) unsigned DEFAULT NULL,
  `client` int(10) unsigned DEFAULT NULL,
  `user` int(10) unsigned DEFAULT NULL,
  `identity` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `organization` (`organization`),
  KEY `space` (`space`),
  KEY `client` (`client`),
  KEY `user` (`user`),
  KEY `identity` (`identity`),
  CONSTRAINT `rules_ibfk_1` FOREIGN KEY (`organization`) REFERENCES `organizations` (`id`),
  CONSTRAINT `rules_ibfk_2` FOREIGN KEY (`space`) REFERENCES `organizations.spaces` (`id`),
  CONSTRAINT `rules_ibfk_3` FOREIGN KEY (`client`) REFERENCES `organizations.spaces.clients` (`id`),
  CONSTRAINT `rules_ibfk_4` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `rules_ibfk_5` FOREIGN KEY (`identity`) REFERENCES `users.identities` (`id`)
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
-- Table structure for table `rules.constraints`
--

DROP TABLE IF EXISTS `rules.constraints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules.constraints` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `this` int(10) unsigned NOT NULL,
  `constraint` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `this` (`this`),
  KEY `rules.constraints.id-constraints.id` (`constraint`),
  CONSTRAINT `rules.constraints.id-constraints.id` FOREIGN KEY (`constraint`) REFERENCES `rules.constraints` (`id`),
  CONSTRAINT `rules.constraints_ibfk_1` FOREIGN KEY (`this`) REFERENCES `rules` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rules.constraints`
--

LOCK TABLES `rules.constraints` WRITE;
/*!40000 ALTER TABLE `rules.constraints` DISABLE KEYS */;
/*!40000 ALTER TABLE `rules.constraints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scopes`
--

DROP TABLE IF EXISTS `scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scopes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scopes`
--

LOCK TABLES `scopes` WRITE;
/*!40000 ALTER TABLE `scopes` DISABLE KEYS */;
/*!40000 ALTER TABLE `scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scopes.attributes`
--

DROP TABLE IF EXISTS `scopes.attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scopes.attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `this` int(10) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `scope` (`this`),
  CONSTRAINT `scopes.attributes_ibfk_1` FOREIGN KEY (`this`) REFERENCES `scopes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scopes.attributes`
--

LOCK TABLES `scopes.attributes` WRITE;
/*!40000 ALTER TABLE `scopes.attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `scopes.attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-21 18:00:30
