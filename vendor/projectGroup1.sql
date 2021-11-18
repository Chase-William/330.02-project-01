CREATE DATABASE  IF NOT EXISTS `facultyresearch` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `facultyresearch`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: facultyresearch
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `abstract`
--

DROP TABLE IF EXISTS `abstract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abstract` (
  `AbstractID` int NOT NULL,
  `Title` varchar(65) NOT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`AbstractID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abstract`
--

LOCK TABLES `abstract` WRITE;
/*!40000 ALTER TABLE `abstract` DISABLE KEYS */;
/*!40000 ALTER TABLE `abstract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `AuthorID` int NOT NULL,
  `FirstName` varchar(65) NOT NULL,
  `LastName` varchar(65) NOT NULL,
  PRIMARY KEY (`AuthorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorabstract`
--

DROP TABLE IF EXISTS `authorabstract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorabstract` (
  `AbstractID` int NOT NULL,
  `AuthorID` int NOT NULL,
  KEY `AuthorAbstract_Abstract_fk` (`AbstractID`),
  KEY `AuthorAbstract_Author_fk` (`AuthorID`),
  CONSTRAINT `AuthorAbstract_Abstract_fk` FOREIGN KEY (`AbstractID`) REFERENCES `abstract` (`AbstractID`) ON DELETE CASCADE,
  CONSTRAINT `AuthorAbstract_Author_fk` FOREIGN KEY (`AuthorID`) REFERENCES `author` (`AuthorID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorabstract`
--

LOCK TABLES `authorabstract` WRITE;
/*!40000 ALTER TABLE `authorabstract` DISABLE KEYS */;
/*!40000 ALTER TABLE `authorabstract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keyword`
--

DROP TABLE IF EXISTS `keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `keyword` (
  `KeywordID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`KeywordID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keyword`
--

LOCK TABLES `keyword` WRITE;
/*!40000 ALTER TABLE `keyword` DISABLE KEYS */;
/*!40000 ALTER TABLE `keyword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professor` (
  `BuildingNumber` int DEFAULT NULL,
  `OfficeNumber` int DEFAULT NULL,
  `Password` varchar(100) NOT NULL,
  `UserID` int NOT NULL,
  PRIMARY KEY (`UserID`),
  CONSTRAINT `Professor_User1_fk` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `UserID` int NOT NULL,
  PRIMARY KEY (`UserID`),
  CONSTRAINT `Student_User_fk` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (51),(52),(53),(54),(55),(56),(57),(58),(59),(60),(61),(62),(63),(64),(65),(66),(67),(68),(69),(70),(71),(72),(73),(74),(75),(76),(77),(78),(79),(80),(81),(82),(83),(84),(85),(86),(87),(88),(89),(90),(91),(92),(93),(94),(95),(96),(97),(98),(99),(100);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentkeyword`
--

DROP TABLE IF EXISTS `studentkeyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentkeyword` (
  `UserID` int NOT NULL,
  `Keyword_KeywordID` int NOT NULL,
  KEY `StudentKeyword_Student_fk` (`UserID`),
  KEY `StudentKeyword_Keyword_fk` (`Keyword_KeywordID`),
  CONSTRAINT `StudentKeyword_Keyword_fk` FOREIGN KEY (`Keyword_KeywordID`) REFERENCES `keyword` (`KeywordID`),
  CONSTRAINT `StudentKeyword_Student_fk` FOREIGN KEY (`UserID`) REFERENCES `student` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentkeyword`
--

LOCK TABLES `studentkeyword` WRITE;
/*!40000 ALTER TABLE `studentkeyword` DISABLE KEYS */;
/*!40000 ALTER TABLE `studentkeyword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Email` varchar(100) DEFAULT NULL,
  `LastName` varchar(65) DEFAULT NULL,
  `FirstName` varchar(65) DEFAULT NULL,
  `UserType` tinyint NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'lw533@g.rit.edu','West','Leon',0),(2,'kv6870@g.rit.edu','Valentine','Kristin',0),(3,'ld5126@g.rit.edu','Douglas','Leandro',0),(4,'rm8227@g.rit.edu','Meza','Rory',0),(5,'vh113@g.rit.edu','Holden','Virginia',0),(6,'cm6011@g.rit.edu','Mack','Conrad',0),(7,'lb2822@g.rit.edu','Burton','Leandro',0),(8,'ad5817@g.rit.edu','Douglas','Ansley',0),(9,'cy5495@g.rit.edu','Young','Cesar',0),(10,'ap2723@g.rit.edu','Pitts','Adonis',0),(11,'jp1636@g.rit.edu','Patel','Jaida',0),(12,'mb1378@g.rit.edu','Bennett','Michael',0),(13,'jh8511@g.rit.edu','Holden','Jaida',0),(14,'er3386@g.rit.edu','Roberson','Elianna',0),(15,'kd9983@g.rit.edu','Dominguez','Kristin',0),(16,'dh4664@g.rit.edu','Hayes','Danna',0),(17,'lb3756@g.rit.edu','Bell','Leon',0),(18,'dt5552@g.rit.edu','Taylor','Dayana',0),(19,'eo1422@g.rit.edu','Orr','Elise',0),(20,'js5412@g.rit.edu','Snyder','Jamison',0),(21,'lp8070@g.rit.edu','Pollard','Luciano',0),(22,'cb7325@g.rit.edu','Burton','Cesar',0),(23,'ka719@g.rit.edu','Anderson','Kendal',0),(24,'ss6304@g.rit.edu','Shelton','Sergio',0),(25,'ej4786@g.rit.edu','Jennings','Elise',0),(26,'am6406@g.rit.edu','Meza','Adonis',0),(27,'sl8406@g.rit.edu','Lindsey','Savannah',0),(28,'eh5584@g.rit.edu','Hawkins','Elliott',0),(29,'rw558@g.rit.edu','West','Regan',0),(30,'sn6589@g.rit.edu','Nolan','Sergio',0),(31,'av6465@g.rit.edu','Vang','Ansley',0),(32,'rd1429@g.rit.edu','Daniels','Rory',0),(33,'ah3695@g.rit.edu','Horn','Alfredo',0),(34,'jh6053@g.rit.edu','Hawkins','Jessica',0),(35,'cm9379@g.rit.edu','Mack','Clinton',0),(36,'ad8345@g.rit.edu','Duncan','Ansley',0),(37,'am6982@g.rit.edu','Melendez','Abbey',0),(38,'tc6887@g.rit.edu','Cantu','Taylor',0),(39,'ar9764@g.rit.edu','Riddle','Adalyn',0),(40,'ep3982@g.rit.edu','Phillips','Elise',0),(41,'bm5758@g.rit.edu','Mack','Bennett',0),(42,'cb4791@g.rit.edu','Bell','Casey',0),(43,'kc3366@g.rit.edu','Conley','Kendal',0),(44,'cd710@g.rit.edu','Dominguez','Catalina',0),(45,'jd5813@g.rit.edu','Daniels','Jaida',0),(46,'tp4440@g.rit.edu','Patel','Taylor',0),(47,'cp8615@g.rit.edu','Pollard','Casey',0),(48,'am3541@g.rit.edu','Mueller','Abbey',0),(49,'cr1311@g.rit.edu','Roberson','Clinton',0),(50,'ha9538@g.rit.edu','Anderson','Hugo',0),(51,'rs404@g.rit.edu','Suarez','Regan',1),(52,'eh6257@g.rit.edu','Holden','Elise',1),(53,'kb5499@g.rit.edu','Bennett','Kristin',1),(54,'ab6815@g.rit.edu','Bell','Abel',1),(55,'ad6626@g.rit.edu','Duncan','Ansley',1),(56,'dc887@g.rit.edu','Conley','Deven',1),(57,'sh3831@g.rit.edu','Humphrey','Sergio',1),(58,'ks6501@g.rit.edu','Shelton','Kamryn',1),(59,'ep1121@g.rit.edu','Pitts','Elliott',1),(60,'lr1386@g.rit.edu','Rich','Leon',1),(61,'mp5285@g.rit.edu','Pierce','Max',1),(62,'jb4917@g.rit.edu','Bennett','Jamison',1),(63,'jd2940@g.rit.edu','Daniels','Jamison',1),(64,'sm6585@g.rit.edu','Mack','Savannah',1),(65,'ca3937@g.rit.edu','Anderson','Casey',1),(66,'jd7886@g.rit.edu','Daniels','Joel',1),(67,'se5362@g.rit.edu','Everett','Savannah',1),(68,'ah139@g.rit.edu','Hayes','Adonis',1),(69,'tc1686@g.rit.edu','Cantu','Theresa',1),(70,'kn9316@g.rit.edu','Nolan','Kamryn',1),(71,'kh5360@g.rit.edu','Horn','Kimberly',1),(72,'aa4549@g.rit.edu','Anderson','Adonis',1),(73,'lp3468@g.rit.edu','Pierce','Luciano',1),(74,'cr5119@g.rit.edu','Rich','Catalina',1),(75,'ej7333@g.rit.edu','Jennings','Edgar',1),(76,'jh959@g.rit.edu','Holder','Juliana',1),(77,'ep1639@g.rit.edu','Parker','Elise',1),(78,'aa7688@g.rit.edu','Anderson','Abel',1),(79,'sh8170@g.rit.edu','Holder','Savannah',1),(80,'kh8025@g.rit.edu','Holden','Kimberly',1),(81,'cp5470@g.rit.edu','Phillips','Conrad',1),(82,'dp2544@g.rit.edu','Parker','Dangelo',1),(83,'cs1953@g.rit.edu','Snyder','Clinton',1),(84,'an8697@g.rit.edu','Nolan','Adalyn',1),(85,'mr3865@g.rit.edu','Roberson','Max',1),(86,'ss7887@g.rit.edu','Snyder','Sergio',1),(87,'ah3609@g.rit.edu','Holden','Abbey',1),(88,'ar4559@g.rit.edu','Rich','Adalyn',1),(89,'md7105@g.rit.edu','Douglas','Max',1),(90,'mh6172@g.rit.edu','Humphrey','Moses',1),(91,'ew2194@g.rit.edu','West','Elise',1),(92,'ed8160@g.rit.edu','Daniels','Elianna',1),(93,'sr3446@g.rit.edu','Roberson','Savannah',1),(94,'jv6057@g.rit.edu','Vang','Joel',1),(95,'tr6377@g.rit.edu','Roberson','Triston',1),(96,'ja8520@g.rit.edu','Anderson','Juliana',1),(97,'kb9530@g.rit.edu','Burton','Kamryn',1),(98,'lr4460@g.rit.edu','Rich','Luciano',1),(99,'es4452@g.rit.edu','Shelton','Elianna',1),(100,'rc5606@g.rit.edu','Cantu','Rory',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userabstract`
--

DROP TABLE IF EXISTS `userabstract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userabstract` (
  `UserID` int NOT NULL,
  `AbstractID` int NOT NULL,
  KEY `fk_UserAbstract_User1` (`UserID`),
  KEY `UserAbstract_Abstract_fk` (`AbstractID`),
  CONSTRAINT `fk_UserAbstract_User1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `UserAbstract_Abstract_fk` FOREIGN KEY (`AbstractID`) REFERENCES `abstract` (`AbstractID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userabstract`
--

LOCK TABLES `userabstract` WRITE;
/*!40000 ALTER TABLE `userabstract` DISABLE KEYS */;
/*!40000 ALTER TABLE `userabstract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'facultyresearch'
--
/*!50003 DROP PROCEDURE IF EXISTS `insertFaculty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertFaculty`(
  IN firstName VARCHAR(65),
  IN lastName VARCHAR(65),
  IN email VARCHAR(100),
  IN buildingNumber INT,
  IN officeNumber INT,
  IN password VARCHAR(100)
)
BEGIN
  
  CALL insertUser(firstName, lastName, email, 0, @id);

  INSERT
    INTO Faculty
      VALUES (@id, buildingNumber, officeNumber, password);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertStudent`(
  IN firstName VARCHAR(65),
  IN lastName VARCHAR(65),
  IN email VARCHAR(100)
)
BEGIN
  
  CALL insertUser(firstName, lastName, email, 1, @id);

  INSERT
    INTO Student
      VALUES (@id);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUser`(
  IN firstName VARCHAR(65),
  IN lastName VARCHAR(65),
  IN email VARCHAR(100),
  IN userType TINYINT,
  OUT id INT
)
BEGIN
  
  INSERT 
    INTO User (FirstName, LastName, Email, UserType) 
      VALUES (firstName, lastName, email, userType);

  
  SET id = @@identity;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-17 15:00:57
