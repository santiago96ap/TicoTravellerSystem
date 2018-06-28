-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: sql9.freemysqlhosting.net    Database: sql9233493
-- ------------------------------------------------------
-- Server version	5.5.58-0ubuntu0.14.04.1

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
-- Table structure for table `tb_value_destinations`
--

DROP TABLE IF EXISTS `tb_value_destinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_value_destinations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(100) NOT NULL,
  `price` char(1) NOT NULL DEFAULT 'z',
  `preference_place` char(1) NOT NULL DEFAULT 'z',
  `destination_type` char(1) NOT NULL DEFAULT 'z',
  `travel_time` char(1) NOT NULL DEFAULT 'z',
  `road_type` char(1) NOT NULL DEFAULT 'z',
  `id_destination` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_destination` (`id_destination`),
  CONSTRAINT `tb_value_destinations_ibfk_1` FOREIGN KEY (`id_destination`) REFERENCES `tb_destinations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_value_destinations`
--

LOCK TABLES `tb_value_destinations` WRITE;
/*!40000 ALTER TABLE `tb_value_destinations` DISABLE KEYS */;
INSERT INTO `tb_value_destinations` VALUES (1,'natural','e','r','b','a','v',1),(2,'natural','i','u','y','c','p',1),(3,'natural','i','u','b','c','v',1),(4,'natural','e','r','b','c','p',1),(5,'natural','c','r','y','c','v',1),(6,'natural','i','u','b','b','p',1),(7,'natural','i','u','y','c','v',1),(8,'hotel','c','r','b','a','p',2),(9,'hotel','i','u','y','c','v',2),(10,'hotel','e','u','b','c','p',2),(11,'hotel','c','u','b','c','p',2),(12,'hotel','e','u','b','c','p',2),(13,'hotel','c','r','y','c','p',2),(14,'hotel','c','r','y','a','p',2),(15,'natural','e','r','b','a','p',3),(16,'natural','c','r','y','b','v',3),(17,'natural','c','r','y','a','p',3),(18,'natural','c','r','y','b','v',3),(19,'natural','i','r','b','a','p',3),(20,'natural','e','u','b','a','p',3),(21,'natural','e','u','b','a','p',3),(22,'paradero','e','u','b','a','v',4),(23,'paradero','i','r','y','c','p',4),(24,'paradero','c','u','b','a','v',4),(25,'paradero','e','r','y','c','p',4),(26,'paradero','e','u','y','a','p',4),(27,'paradero','e','u','b','a','v',5),(28,'paradero','e','r','b','c','v',5),(29,'paradero','c','r','b','b','p',5),(30,'paradero','c','r','y','a','v',5),(31,'paradero','c','u','y','c','p',5),(32,'restaurante','c','r','b','b','v',6),(33,'restaurante','c','u','b','c','p',6),(34,'restaurante','c','r','b','b','v',6),(35,'restaurante','c','u','y','c','p',6),(36,'restaurante','i','u','b','b','p',6),(37,'restaurante','e','r','y','c','v',6),(38,'paradero','e','r','b','a','p',7),(39,'paradero','i','r','y','b','v',7),(40,'paradero','i','r','y','c','v',7),(41,'paradero','c','u','b','c','p',7),(42,'paradero','e','u','y','a','v',7),(43,'paradero','c','r','y','a','v',7),(44,'hotel','c','r','b','b','p',8),(45,'hotel','e','u','b','a','v',8),(46,'hotel','c','u','y','a','p',8),(47,'hotel','c','r','b','b','p',8),(48,'hotel','e','u','b','a','p',8),(49,'hotel','e','r','y','b','p',8),(50,'hotel','c','r','b','a','p',9),(51,'hotel','i','u','y','a','p',9),(52,'hotel','e','u','b','a','v',9),(53,'hotel','i','u','b','c','v',9),(54,'hotel','c','u','y','a','p',9),(55,'hotel','c','u','b','a','v',9),(56,'restaurante','e','r','b','a','p',10),(57,'restaurante','e','u','b','b','v',10),(58,'restaurante','c','r','y','c','p',10),(59,'restaurante','e','r','y','b','p',10),(60,'restaurante','e','u','b','a','p',10),(61,'restaurante','e','r','b','c','v',10),(62,'restaurante','c','r','b','a','v',11),(63,'restaurante','i','r','b','b','v',11),(64,'restaurante','c','u','y','c','v',11),(65,'restaurante','e','r','b','a','p',11),(66,'restaurante','i','u','b','c','p',11),(67,'restaurante','c','u','b','b','p',11),(68,'hotel','c','r','b','b','p',12),(69,'hotel','c','r','b','b','v',12),(70,'hotel','e','r','b','b','p',12),(71,'hotel','c','u','y','a','v',12),(72,'hotel','e','u','y','c','p',12),(73,'hotel','e','u','b','b','p',12),(74,'paradero','e','r','b','a','v',13),(75,'paradero','c','r','y','c','v',13),(76,'paradero','c','u','b','b','p',13),(77,'paradero','e','u','b','a','v',13),(78,'paradero','e','r','y','b','v',13),(79,'paradero','e','r','y','a','p',13),(80,'restaurante','c','u','b','a','v',14),(81,'restaurante','e','u','b','c','v',14),(82,'restaurante','e','u','y','b','p',14),(83,'restaurante','i','u','b','a','p',14),(84,'restaurante','i','u','y','c','v',14),(85,'restaurante','c','u','y','b','v',14),(86,'paradero','i','u','b','a','v',15),(87,'paradero','c','r','b','b','p',15),(88,'paradero','i','r','b','c','p',15),(89,'paradero','i','r','y','b','v',15),(90,'paradero','i','r','y','c','v',15),(91,'paradero','c','r','y','b','p',15),(92,'natural','e','r','b','b','p',16),(93,'natural','i','u','y','b','p',16),(94,'natural','i','r','b','c','v',16),(95,'natural','e','r','b','c','v',16),(96,'natural','c','u','y','a','v',16),(97,'natural','i','u','b','a','v',16),(98,'paradero','c','r','b','b','v',17),(99,'paradero','c','r','b','b','p',17),(100,'paradero','i','r','b','a','p',17),(101,'paradero','e','r','y','b','v',17),(102,'paradero','c','u','y','c','p',17),(103,'paradero','e','r','b','c','p',17),(104,'paradero','i','r','b','b','p',18),(105,'paradero','c','u','b','a','p',18),(106,'paradero','i','u','y','a','v',18),(107,'paradero','i','u','b','a','v',18),(108,'paradero','i','r','y','a','v',18),(109,'natural','e','r','b','b','p',19),(110,'natural','e','r','b','c','v',19),(111,'natural','c','r','y','c','v',19),(112,'natural','c','u','y','b','p',19),(113,'natural','i','r','b','b','p',19),(114,'hotel','c','r','b','a','v',20),(115,'hotel','i','u','b','c','p',20),(116,'hotel','c','u','y','c','v',20),(117,'hotel','e','u','y','a','v',20),(118,'hotel','c','u','y','c','v',21),(119,'hotel','c','r','b','b','p',21),(120,'hotel','c','u','y','c','v',21),(121,'hotel','i','u','y','b','v',21),(122,'hotel','c','u','b','a','v',21),(123,'hotel','c','u','y','c','v',22),(124,'hotel','e','u','y','a','v',22),(125,'hotel','c','r','b','c','v',22),(126,'hotel','c','r','b','b','v',22),(127,'hotel','c','r','b','c','v',22),(128,'hotel','c','u','y','c','v',23),(129,'hotel','e','r','b','a','v',23),(130,'hotel','c','u','y','b','v',23),(131,'hotel','e','u','b','b','p',23),(132,'hotel','c','r','b','a','v',23),(133,'hotel','c','u','b','a','v',24),(134,'hotel','i','r','y','c','p',24),(135,'hotel','e','r','b','c','p',24),(136,'hotel','e','u','y','b','p',24),(137,'hotel','c','u','y','p','p',24),(138,'restaurante','i','u','b','b','v',25),(139,'restaurante','c','r','b','c','v',25),(140,'restaurante','e','u','b','b','v',25),(141,'restaurante','e','r','y','c','p',25),(142,'restaurante','e','u','b','c','v',25),(143,'paradero','e','r','b','c','p',26),(144,'paradero','e','r','b','a','v',26),(145,'paradero','e','r','b','a','v',26),(146,'paradero','i','u','b','c','v',26),(147,'paradero','i','r','y','a','v',26),(148,'paradero','i','r','b','a','p',27),(149,'paradero','i','r','y','a','v',27),(150,'paradero','c','u','b','a','v',27),(151,'paradero','e','u','y','a','p',27),(152,'paradero','i','u','b','c','v',27),(153,'paradero','e','u','b','b','v',28),(154,'paradero','e','u','y','a','p',28),(155,'paradero','i','u','b','a','v',28),(156,'paradero','i','r','y','b','v',28),(157,'paradero','c','r','b','b','v',28),(158,'paradero','c','r','b','c','v',29),(159,'paradero','i','r','b','b','p',29),(160,'paradero','i','r','y','c','p',29),(161,'paradero','i','u','b','a','v',29),(162,'paradero','c','u','y','a','p',29),(163,'hotel','e','u','b','c','v',30),(164,'hotel','i','u','y','a','v',30),(165,'hotel','i','r','y','c','v',30),(166,'hotel','c','u','y','b','v',30),(167,'hotel','i','u','b','b','v',30),(168,'hotel','i','u','b','a','p',31),(169,'hotel','e','r','y','b','p',31),(170,'hotel','c','u','b','b','p',31),(171,'hotel','i','r','b','c','p',31),(172,'hotel','e','u','y','c','p',31),(173,'restaurante','i','u','b','b','v',32),(174,'restaurante','e','u','y','b','p',32),(175,'restaurante','e','u','y','c','p',32),(176,'restaurante','c','u','y','a','v',32),(177,'restaurante','i','r','y','c','p',32),(178,'hotel','c','r','b','a','p',33),(179,'hotel','e','r','y','c','p',33),(180,'hotel','c','r','b','a','p',33),(181,'hotel','e','r','b','b','p',33),(182,'hotel','i','u','y','b','v',33),(183,'hotel','e','u','b','a','p',34),(184,'hotel','c','r','y','a','v',34),(185,'hotel','i','r','y','b','p',34),(186,'hotel','i','r','y','c','v',34),(187,'hotel','c','r','b','a','v',34),(188,'restaurante','c','r','b','b','v',35),(189,'restaurante','e','u','b','b','v',35),(190,'restaurante','i','u','b','c','v',35),(191,'restaurante','c','u','y','c','v',35),(192,'restaurante','i','r','b','c','p',35),(195,'natural','e','r','y','a','p',38),(197,'natural','e','u','b','a','v',40),(198,'natural','e','r','y','a','v',41);
/*!40000 ALTER TABLE `tb_value_destinations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-28 13:07:54
