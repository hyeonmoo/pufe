-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: pufe_db
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_email` varchar(30) NOT NULL,
  `user_pw` varchar(20) NOT NULL,
  `user_name` varchar(10) NOT NULL,
  `gender` char(1) NOT NULL,
  `user_tel` char(11) NOT NULL,
  `user_type` char(1) NOT NULL,
  `prod_name` varchar(10) DEFAULT NULL,
  `buy_date` date DEFAULT NULL,
  `squat` smallint DEFAULT '0',
  `benchpress` smallint DEFAULT '0',
  `deadlift` smallint DEFAULT '0',
  PRIMARY KEY (`user_email`),
  UNIQUE KEY `user_tel` (`user_tel`),
  KEY `prod_name` (`prod_name`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`prod_name`) REFERENCES `product` (`prod_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('kang0825@naver.com','qwer1234','강현무','M','01021298198','A',NULL,NULL,90,70,110),('trainer1@naver.com','0000','트레이너1','M','01022220001','T',NULL,NULL,180,150,220),('trainer2@naver.com','0000','트레이너2','F','01022220002','T',NULL,NULL,70,40,80),('user1@naver.com','0000','일반유저1','M','01011110001','U',NULL,NULL,70,45,75),('user2@naver.com','0000','일반유저2','F','01011110002','U',NULL,NULL,60,30,70),('user3@naver.com','0000','일반유저3','M','01011110003','U',NULL,NULL,250,190,285);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-09  9:33:46
