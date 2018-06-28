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
-- Table structure for table `tb_destinations`
--

DROP TABLE IF EXISTS `tb_destinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_destinations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `address` varchar(500) NOT NULL,
  `description` varchar(800) DEFAULT NULL,
  `x` varchar(50) DEFAULT NULL,
  `y` varchar(50) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_destinations`
--

LOCK TABLES `tb_destinations` WRITE;
/*!40000 ALTER TABLE `tb_destinations` DISABLE KEYS */;
INSERT INTO `tb_destinations` VALUES (1,'Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg'),(2,'Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.','9.881494','-83.627633','public/img/2.jpg'),(3,'Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg'),(4,'Paradero Turistico San Buenaventura','Turrialba, Cartago','El Paradero Turistico San Buenaventura se encuentra alejado del ruido y rodeado de naturaleza.','9.873350','-83.645082','public/img/4.jpg'),(5,'Jardin Botanico CATIE','Turrialba, Cartago','Un lugar especial para el descanso, rodeado del canto de las aves, el susurro del gigantesco arbol de Guanacaste.','9.896788','-83.657440','public/img/3.jpg'),(6,'Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg'),(7,'Centro Turistico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg'),(8,'Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg'),(9,'Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg'),(10,'Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg'),(11,'Turrialtico Lodge','Pavones, Turrialba, Cartago','Turrialtico Lodge esta construido con hermosa madera rustica. El balcon del hotel ofrece las mejores vistas panoramicas del valle de Turrialba.','9.895085','-83.637209','public/img/11.jpg'),(12,'Rancho Naturalista','Tuis, Turrialba, Cartago','El principal hotel de observacion de aves en Costa Rica, Rancho Naturalista es uno de los mejores lodges de observacion de aves en America Central.','9.833345','-83.563900','public/img/12.jpg'),(13,'Piojos Pool','La Suiza, Turrialba, Cartago','Paradero Turistico','9.853222','-83.611430','public/img/13.jpg'),(14,'Adrianos Restaurant','Canada, Turrialba, Cartago','Restaurante','9.860241','-83.622591','public/img/14.jpg'),(15,'Complejo Deportivo el Varon','Turrialba, Cartago','Un lugar completamente distinto a cualquier otro complejo, pues cuenta con una vista panoramica del valle de Turrialba.','9.934150','-83.693036','public/img/15.jpg'),(16,'Rio Pejibaye','Pejibaye, Jimenez, Cartago','Apto para la practica de rafting, posee rapidos que personas de cualquier edad pueden disfrutar plenamente.','9.793242','-83.690331','public/img/16.jpeg'),(17,'Parapente Turrialba','Santa Cruz, Turrialba, Cartago','En Santa Cruz de Turrialba encontramos una zona de vuelo privilegiada. Con una buenisima superficie para el despegue y una excelente vista.','9.960460','-83.749607','public/img/17.jpg'),(18,'Finca Vialig','Pacayitas, Turrialba, Cartago','El Centro Operacional de Finca ViaLig se encuentra ubicado en una hermosa comunidad, donde las personas son amables y con la esperanza de ser cada dia mejor.','9.882631','-83.582302','public/img/18.jpg'),(19,'Aquiares Waterfall','Aquiares, Turrialba, Cartago','Belleza pura. Todas las grandes cosas en una. Desde increibles vistas, hasta las hermosas cascadas y las piscinas naturales de los rios.','9.941796','-83.720544','public/img/19.jpg'),(20,'Siloe Lodge','La Suiza, Turrialba, Cartago','Un lugar lleno de Paz y tranquilidad,muy seguro, rodeado de areas verdes. Habitaciones limpias y frescas muy aseadas y confortables.','9.868452','-83.633771','public/img/20.jpg'),(21,'Hotel Maribu Caribe','Puerto Limon, Limon','Es un hotel de primera clase, ubicado en una exuberante zona tropical de Costa Rica donde se pueden apreciar maravillosos y relajantes paisajes.','10.013473','-83.049977','public/img/21.jpg'),(22,'Hotel Playa Bonita','Playa Bonita, Limon','El Hotel esta estrategicamente ubicado, donde usted puede visitar lugares con gran valor historico.','10.009726','-83.062047','public/img/22.jpg'),(23,'Hotel Oasys del Caribe','Puerto Limon, Limon','Nuestro hotel esta ubicado a pocos minutos del centro de la ciudad de Limon y cerca de la playa.','10.009298','-83.048853','public/img/23.jpg'),(24,'Hotel Wagelia','Turrialba, Cartago','Hermoso Hotel en el centro de Turrialba.','9.903657','-83.670802','public/img/24.png'),(25,'Restaurante La Flor','Turrialba, Cartago','Restaurante con deliciosa comida casera','9.903657','-83.67802','public/img/24.png'),(26,'Atreus','Turrialba, Cartago','Mariposario','9.903657','-83.670802','public/img/24.png'),(27,'Rancho San Rafael','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png'),(28,'La Esperanza','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png'),(29,'Rancho el Sol','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png'),(30,'Rancho Monteverde','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png'),(31,'Rancho el Veroliz','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png'),(32,'El manantial','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png'),(33,'Mountain Hotel','Turrialba, Cartago','Hotel / Restaurante','9.903657','-83.670802','public/img/24.png'),(34,'Hotel Patito','Turrialba, Cartago','Hotel','9.903.657','-83.670802','public/img/24.png'),(35,'La Pastora','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png'),(38,'Las Colonias Waterfall','La Suiza, Turrialba','Bello','9.855402999999999','-83.61089600000003','public/img/26.jpeg'),(40,'Parque central Turrialba','Turrilaba, Cartago, Costa Rica','Parque ','9.9062623','-83.68420470000001','public/img/28.jpeg'),(41,'xxx','xxxx','xxxx','10.0162938','-83.7648792','public/img/29.jpeg');
/*!40000 ALTER TABLE `tb_destinations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-28 13:07:29
