CREATE DATABASE  IF NOT EXISTS `comex` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `comex`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: comex
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `blocos_economicos`
--

DROP TABLE IF EXISTS `blocos_economicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blocos_economicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocos_economicos`
--

LOCK TABLES `blocos_economicos` WRITE;
/*!40000 ALTER TABLE `blocos_economicos` DISABLE KEYS */;
INSERT INTO `blocos_economicos` VALUES (1,'Mercosul'),(2,'União Europeia'),(3,'NAFTA'),(4,'BRICS');
/*!40000 ALTER TABLE `blocos_economicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cambios`
--

DROP TABLE IF EXISTS `cambios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cambios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `moeda_origem` int NOT NULL,
  `moeda_destino` int NOT NULL,
  `taxa_cambio` decimal(10,4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_cambio` (`data`,`moeda_origem`,`moeda_destino`),
  KEY `moeda_origem` (`moeda_origem`),
  KEY `moeda_destino` (`moeda_destino`),
  CONSTRAINT `cambios_ibfk_1` FOREIGN KEY (`moeda_origem`) REFERENCES `moedas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cambios_ibfk_2` FOREIGN KEY (`moeda_destino`) REFERENCES `moedas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cambios`
--

LOCK TABLES `cambios` WRITE;
/*!40000 ALTER TABLE `cambios` DISABLE KEYS */;
INSERT INTO `cambios` VALUES (1,'2020-03-15',1,2,4.5000),(2,'2020-07-20',3,2,5.2000),(3,'2020-10-05',4,1,0.1400),(4,'2021-02-10',1,2,5.3000),(5,'2021-06-18',3,2,6.1000),(6,'2021-09-30',4,3,0.1300),(7,'2022-01-25',1,2,5.0000),(8,'2022-08-14',3,1,1.0800),(9,'2023-04-12',1,3,0.9200),(10,'2023-11-22',2,1,0.1900);
/*!40000 ALTER TABLE `cambios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_produtos`
--

DROP TABLE IF EXISTS `categoria_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria_produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_produtos`
--

LOCK TABLES `categoria_produtos` WRITE;
/*!40000 ALTER TABLE `categoria_produtos` DISABLE KEYS */;
INSERT INTO `categoria_produtos` VALUES (1,'Commodities Agrícolas'),(2,'Energia'),(3,'Veículos e Máquinas'),(4,'Papel e Celulose'),(5,'Metalurgia');
/*!40000 ALTER TABLE `categoria_produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moedas`
--

DROP TABLE IF EXISTS `moedas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moedas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `pais` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moedas`
--

LOCK TABLES `moedas` WRITE;
/*!40000 ALTER TABLE `moedas` DISABLE KEYS */;
INSERT INTO `moedas` VALUES (1,'Dólar Americano','USA'),(2,'Real Brasileiro','BRA'),(3,'Euro','EUR'),(4,'Yuan Chinês','CHN');
/*!40000 ALTER TABLE `moedas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paises`
--

DROP TABLE IF EXISTS `paises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paises` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `codigo_iso` char(3) NOT NULL,
  `bloco_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_iso` (`codigo_iso`),
  KEY `bloco_id` (`bloco_id`),
  CONSTRAINT `paises_ibfk_1` FOREIGN KEY (`bloco_id`) REFERENCES `blocos_economicos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paises`
--

LOCK TABLES `paises` WRITE;
/*!40000 ALTER TABLE `paises` DISABLE KEYS */;
INSERT INTO `paises` VALUES (1,'Brasil','BRA',1),(2,'Estados Unidos','USA',3),(3,'China','CHN',4),(4,'Alemanha','DEU',2),(5,'França','FRA',2);
/*!40000 ALTER TABLE `paises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) NOT NULL,
  `categoria_id` int NOT NULL,
  `codigo_ncm` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_ncm` (`codigo_ncm`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `produtos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria_produtos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Soja',1,'12019000'),(2,'Petróleo Bruto',2,'27090010'),(3,'Automóveis',3,'87032390'),(4,'Celulose',4,'47032100'),(5,'Aço Laminado',5,'72083910');
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_transacoes`
--

DROP TABLE IF EXISTS `tipos_transacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_transacoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_transacoes`
--

LOCK TABLES `tipos_transacoes` WRITE;
/*!40000 ALTER TABLE `tipos_transacoes` DISABLE KEYS */;
INSERT INTO `tipos_transacoes` VALUES (1,'IMPORT'),(2,'EXPORT');
/*!40000 ALTER TABLE `tipos_transacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transacoes`
--

DROP TABLE IF EXISTS `transacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transacoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_id` int NOT NULL,
  `pais_origem` int NOT NULL,
  `pais_destino` int NOT NULL,
  `produto_id` int NOT NULL,
  `valor_monetario` decimal(15,2) NOT NULL,
  `quantidade` int NOT NULL,
  `transporte_id` int NOT NULL,
  `cambio_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_id` (`tipo_id`),
  KEY `pais_origem` (`pais_origem`),
  KEY `pais_destino` (`pais_destino`),
  KEY `produto_id` (`produto_id`),
  KEY `transporte_id` (`transporte_id`),
  KEY `cambio_id` (`cambio_id`),
  CONSTRAINT `transacoes_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_transacoes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transacoes_ibfk_2` FOREIGN KEY (`pais_origem`) REFERENCES `paises` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transacoes_ibfk_3` FOREIGN KEY (`pais_destino`) REFERENCES `paises` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transacoes_ibfk_4` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transacoes_ibfk_5` FOREIGN KEY (`transporte_id`) REFERENCES `transportes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transacoes_ibfk_6` FOREIGN KEY (`cambio_id`) REFERENCES `cambios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacoes`
--

LOCK TABLES `transacoes` WRITE;
/*!40000 ALTER TABLE `transacoes` DISABLE KEYS */;
INSERT INTO `transacoes` VALUES (1,2,1,2,1,4500000.00,12000,1,1),(2,1,2,1,3,7800000.00,6000,2,1),(3,2,3,4,5,9000000.00,3000,3,1),(4,1,4,5,2,5600000.00,4000,1,1),(5,2,5,3,4,7300000.00,5000,2,1),(6,2,1,3,2,8000000.00,4000,1,4),(7,1,2,4,5,9200000.00,5000,3,4),(8,2,3,5,3,11000000.00,7000,2,4),(9,1,4,1,1,5200000.00,3000,4,4),(10,2,5,2,4,7600000.00,4000,1,4),(11,2,1,5,3,10000000.00,6000,2,7),(12,1,2,3,4,8500000.00,5000,3,7),(13,2,3,2,1,4200000.00,2000,4,7),(14,1,4,1,5,9600000.00,4000,1,7),(15,2,5,4,2,8800000.00,4500,3,7),(16,2,1,4,1,6200000.00,3100,2,9),(17,1,2,5,3,7800000.00,4500,3,9),(18,2,3,1,2,8900000.00,5000,4,9),(19,1,4,2,4,7100000.00,3800,1,9),(20,2,5,3,5,9700000.00,5500,3,9);
/*!40000 ALTER TABLE `transacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transportes`
--

DROP TABLE IF EXISTS `transportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transportes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transportes`
--

LOCK TABLES `transportes` WRITE;
/*!40000 ALTER TABLE `transportes` DISABLE KEYS */;
INSERT INTO `transportes` VALUES (1,'Marítimo'),(2,'Rodoviário'),(3,'Aéreo'),(4,'Ferroviário');
/*!40000 ALTER TABLE `transportes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-07 23:30:23
