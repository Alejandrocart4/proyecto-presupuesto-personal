/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: presupuesto_personal
-- ------------------------------------------------------
-- Server version	12.0.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `categoria`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(100) DEFAULT NULL,
  `descripcion_categoria` varchar(255) DEFAULT NULL,
  `tipo_categoria` varchar(100) DEFAULT NULL,
  `nombre_iconoui_categoria` varchar(100) DEFAULT NULL,
  `colorhexa_categoria` varchar(10) DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `creado_en` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `modificado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meta_ahorro`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `meta_ahorro` (
  `id_meta_ahorro` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `id_subcategoria` int(11) DEFAULT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `monto_total` decimal(10,2) DEFAULT NULL,
  `monto_ahorrado` decimal(10,2) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_objetivo` date DEFAULT NULL,
  `prioridad` int(11) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `creado_en` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `modificado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_meta_ahorro`),
  KEY `fk_meta_usuario` (`id_usuario`),
  KEY `fk_meta_subcategoria` (`id_subcategoria`),
  CONSTRAINT `fk_meta_subcategoria` FOREIGN KEY (`id_subcategoria`) REFERENCES `subcategoria` (`id_subcategoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_meta_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `obligacion_fija`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `obligacion_fija` (
  `id_obligacion_fija` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `id_subcategoria` int(11) DEFAULT NULL,
  `nombre_obligacion` varchar(150) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `monto_fijo_mensual` decimal(10,2) DEFAULT NULL,
  `dia_vencimiento` int(11) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_finalizacion` date DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `creado_en` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `modificado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_obligacion_fija`),
  UNIQUE KEY `id_subcategoria` (`id_subcategoria`),
  KEY `fk_obligacion_usuario` (`id_usuario`),
  CONSTRAINT `fk_obligacion_subcategoria` FOREIGN KEY (`id_subcategoria`) REFERENCES `subcategoria` (`id_subcategoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_obligacion_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `presupuesto`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `presupuesto` (
  `id_presupuesto` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `nombre_presupuesto` varchar(150) DEFAULT NULL,
  `anio_inicio` int(11) DEFAULT NULL,
  `mes_inicio` int(11) DEFAULT NULL,
  `anio_fin` int(11) DEFAULT NULL,
  `mes_fin` int(11) DEFAULT NULL,
  `total_ingresos` decimal(10,2) DEFAULT NULL,
  `total_gastos` decimal(10,2) DEFAULT NULL,
  `total_ahorro` decimal(10,2) DEFAULT NULL,
  `fecha_hora_creacion` datetime DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `creado_en` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `modificado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_presupuesto`),
  KEY `fk_presupuesto_usuario` (`id_usuario`),
  CONSTRAINT `fk_presupuesto_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `presupuesto_detalle`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `presupuesto_detalle` (
  `id_presupuesto_detalle` int(11) NOT NULL AUTO_INCREMENT,
  `id_presupuesto` int(11) DEFAULT NULL,
  `id_subcategoria` int(11) DEFAULT NULL,
  `monto_mensual` decimal(10,2) DEFAULT NULL,
  `observacion` varchar(255) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `creado_en` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `modificado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_presupuesto_detalle`),
  KEY `fk_detalle_presupuesto` (`id_presupuesto`),
  KEY `fk_detalle_subcategoria` (`id_subcategoria`),
  CONSTRAINT `fk_detalle_presupuesto` FOREIGN KEY (`id_presupuesto`) REFERENCES `presupuesto` (`id_presupuesto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detalle_subcategoria` FOREIGN KEY (`id_subcategoria`) REFERENCES `subcategoria` (`id_subcategoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subcategoria`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategoria` (
  `id_subcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` int(11) DEFAULT NULL,
  `nombre_subcategoria` varchar(100) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `auto` tinyint(1) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `creado_en` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `modificado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_subcategoria`),
  KEY `fk_subcategoria_categoria` (`id_categoria`),
  CONSTRAINT `fk_subcategoria_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaccion`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaccion` (
  `id_transaccion` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `id_presupuesto` int(11) DEFAULT NULL,
  `id_subcategoria` int(11) DEFAULT NULL,
  `id_obligacion_fija` int(11) DEFAULT NULL,
  `tipo_transaccion` varchar(50) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `metodo_pago` varchar(100) DEFAULT NULL,
  `numero_factura` varchar(100) DEFAULT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  `fecha_hora_registro` datetime DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `creado_en` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `modificado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_transaccion`),
  KEY `fk_transaccion_usuario` (`id_usuario`),
  KEY `fk_transaccion_presupuesto` (`id_presupuesto`),
  KEY `fk_transaccion_subcategoria` (`id_subcategoria`),
  KEY `fk_transaccion_obligacion` (`id_obligacion_fija`),
  CONSTRAINT `fk_transaccion_obligacion` FOREIGN KEY (`id_obligacion_fija`) REFERENCES `obligacion_fija` (`id_obligacion_fija`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_transaccion_presupuesto` FOREIGN KEY (`id_presupuesto`) REFERENCES `presupuesto` (`id_presupuesto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_transaccion_subcategoria` FOREIGN KEY (`id_subcategoria`) REFERENCES `subcategoria` (`id_subcategoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_transaccion_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `primer_nombre` varchar(100) DEFAULT NULL,
  `segundo_nombre` varchar(100) DEFAULT NULL,
  `primer_apellido` varchar(100) DEFAULT NULL,
  `segundo_apellido` varchar(100) DEFAULT NULL,
  `correo` varchar(150) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT NULL,
  `salario_mensual_base` decimal(10,2) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `creado_en` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `modificado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'presupuesto_personal'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-11-12 14:13:32
