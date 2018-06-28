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
-- Table structure for table `tb_destinations_probabilities`
--

DROP TABLE IF EXISTS `tb_destinations_probabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_destinations_probabilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_name` varchar(100) DEFAULT NULL,
  `attribute_value` varchar(100) DEFAULT NULL,
  `repetition` int(11) DEFAULT NULL,
  `probability` decimal(19,7) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_destinations_probabilities`
--

LOCK TABLES `tb_destinations_probabilities` WRITE;
/*!40000 ALTER TABLE `tb_destinations_probabilities` DISABLE KEYS */;
INSERT INTO `tb_destinations_probabilities` VALUES (1,'price','e',12,0.4141414,'natural'),(2,'preference_place','r',17,0.5909091,'natural'),(3,'destination_type','b',16,0.5606061,'natural'),(4,'travel_time','a',11,0.3712121,'natural'),(5,'road_type','v',14,0.5000000,'natural'),(6,'price','i',9,0.3232323,'natural'),(7,'preference_place','u',11,0.4090909,'natural'),(8,'destination_type','y',12,0.4393939,'natural'),(9,'travel_time','c',9,0.3106061,'natural'),(10,'road_type','p',14,0.5000000,'natural'),(11,'price','c',7,0.2626263,'natural'),(12,'travel_time','b',8,0.2803030,'natural'),(13,'price','c',34,0.4819820,'hotel'),(14,'preference_place','r',30,0.4391892,'hotel'),(15,'destination_type','b',38,0.5472973,'hotel'),(16,'travel_time','a',25,0.3547297,'hotel'),(17,'road_type','p',36,0.5202703,'hotel'),(18,'price','e',21,0.3063063,'hotel'),(19,'price','i',14,0.2117117,'hotel'),(20,'preference_place','u',39,0.5608108,'hotel'),(21,'destination_type','y',31,0.4527027,'hotel'),(22,'travel_time','b',20,0.2871622,'hotel'),(23,'travel_time','c',23,0.3277027,'hotel'),(24,'road_type','v',33,0.4797297,'hotel'),(25,'price','e',19,0.3229167,'paradero'),(26,'preference_place','u',23,0.3984375,'paradero'),(27,'destination_type','b',33,0.5546875,'paradero'),(28,'travel_time','a',28,0.4570313,'paradero'),(29,'road_type','v',34,0.5703125,'paradero'),(30,'price','c',18,0.3072917,'paradero'),(31,'price','i',22,0.3697917,'paradero'),(32,'preference_place','r',36,0.6015625,'paradero'),(33,'destination_type','y',26,0.4453125,'paradero'),(34,'travel_time','b',15,0.2539063,'paradero'),(35,'travel_time','c',16,0.2695313,'paradero'),(36,'road_type','p',25,0.4296875,'paradero'),(37,'price','c',14,0.3560606,'restaurante'),(38,'preference_place','r',15,0.3977273,'restaurante'),(39,'destination_type','b',25,0.6250000,'restaurante'),(40,'travel_time','b',15,0.3693182,'restaurante'),(41,'road_type','v',22,0.5568182,'restaurante'),(42,'price','e',15,0.3787879,'restaurante'),(43,'price','i',10,0.2651515,'restaurante'),(44,'preference_place','u',24,0.6022727,'restaurante'),(45,'destination_type','y',14,0.3750000,'restaurante'),(46,'travel_time','a',7,0.1875000,'restaurante'),(47,'travel_time','c',17,0.4147727,'restaurante'),(48,'road_type','p',17,0.4431818,'restaurante'),(49,'travel_time','p',1,0.0304054,'hotel'),(50,'travel_time','p',0,0.0378788,'natural'),(51,'travel_time','p',0,0.0195313,'paradero'),(52,'travel_time','p',0,0.0284091,'restaurante');
/*!40000 ALTER TABLE `tb_destinations_probabilities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-28 13:07:46
