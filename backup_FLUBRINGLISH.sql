-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: databaseFLUBRINGLISH
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_customuser'),(22,'Can change user',6,'change_customuser'),(23,'Can delete user',6,'delete_customuser'),(24,'Can view user',6,'view_customuser'),(25,'Can add classroom',7,'add_classroom'),(26,'Can change classroom',7,'change_classroom'),(27,'Can delete classroom',7,'delete_classroom'),(28,'Can view classroom',7,'view_classroom'),(29,'Can add course',8,'add_course'),(30,'Can change course',8,'change_course'),(31,'Can delete course',8,'delete_course'),(32,'Can view course',8,'view_course'),(33,'Can add live lesson',9,'add_livelesson'),(34,'Can change live lesson',9,'change_livelesson'),(35,'Can delete live lesson',9,'delete_livelesson'),(36,'Can view live lesson',9,'view_livelesson'),(37,'Can add nivelamento',10,'add_nivelamento'),(38,'Can change nivelamento',10,'change_nivelamento'),(39,'Can delete nivelamento',10,'delete_nivelamento'),(40,'Can view nivelamento',10,'view_nivelamento'),(41,'Can add enrollment',11,'add_enrollment'),(42,'Can change enrollment',11,'change_enrollment'),(43,'Can delete enrollment',11,'delete_enrollment'),(44,'Can view enrollment',11,'view_enrollment'),(45,'Can add resultado teste',12,'add_resultadoteste'),(46,'Can change resultado teste',12,'change_resultadoteste'),(47,'Can delete resultado teste',12,'delete_resultadoteste'),(48,'Can view resultado teste',12,'view_resultadoteste'),(49,'Can add pedido matricula',13,'add_pedidomatricula'),(50,'Can change pedido matricula',13,'change_pedidomatricula'),(51,'Can delete pedido matricula',13,'delete_pedidomatricula'),(52,'Can view pedido matricula',13,'view_pedidomatricula'),(53,'Can add quiz resposta',14,'add_quizresposta'),(54,'Can change quiz resposta',14,'change_quizresposta'),(55,'Can delete quiz resposta',14,'delete_quizresposta'),(56,'Can view quiz resposta',14,'view_quizresposta'),(57,'Can add quiz pergunta',15,'add_quizpergunta'),(58,'Can change quiz pergunta',15,'change_quizpergunta'),(59,'Can delete quiz pergunta',15,'delete_quizpergunta'),(60,'Can view quiz pergunta',15,'view_quizpergunta'),(61,'Can add mensagem contato',16,'add_mensagemcontato'),(62,'Can change mensagem contato',16,'change_mensagemcontato'),(63,'Can delete mensagem contato',16,'delete_mensagemcontato'),(64,'Can view mensagem contato',16,'view_mensagemcontato'),(65,'Can add avaliacao professor',17,'add_avaliacaoprofessor'),(66,'Can change avaliacao professor',17,'change_avaliacaoprofessor'),(67,'Can delete avaliacao professor',17,'delete_avaliacaoprofessor'),(68,'Can view avaliacao professor',17,'view_avaliacaoprofessor'),(69,'Can add notificacao',18,'add_notificacao'),(70,'Can change notificacao',18,'change_notificacao'),(71,'Can delete notificacao',18,'delete_notificacao'),(72,'Can view notificacao',18,'view_notificacao'),(73,'Can add participacao aluno',19,'add_participacaoaluno'),(74,'Can change participacao aluno',19,'change_participacaoaluno'),(75,'Can delete participacao aluno',19,'delete_participacaoaluno'),(76,'Can view participacao aluno',19,'view_participacaoaluno'),(77,'Can add mensagem',20,'add_mensagem'),(78,'Can change mensagem',20,'change_mensagem'),(79,'Can delete mensagem',20,'delete_mensagem'),(80,'Can view mensagem',20,'view_mensagem'),(81,'Can add dados pagamento',21,'add_dadospagamento'),(82,'Can change dados pagamento',21,'change_dadospagamento'),(83,'Can delete dados pagamento',21,'delete_dadospagamento'),(84,'Can view dados pagamento',21,'view_dadospagamento'),(85,'Can add resposta aluno',22,'add_respostaaluno'),(86,'Can change resposta aluno',22,'change_respostaaluno'),(87,'Can delete resposta aluno',22,'delete_respostaaluno'),(88,'Can view resposta aluno',22,'view_respostaaluno'),(89,'Can add plano preco curso',23,'add_planoprecocurso'),(90,'Can change plano preco curso',23,'change_planoprecocurso'),(91,'Can delete plano preco curso',23,'delete_planoprecocurso'),(92,'Can view plano preco curso',23,'view_planoprecocurso'),(93,'Can add configuracao financeira',24,'add_configuracaofinanceira'),(94,'Can change configuracao financeira',24,'change_configuracaofinanceira'),(95,'Can delete configuracao financeira',24,'delete_configuracaofinanceira'),(96,'Can view configuracao financeira',24,'view_configuracaofinanceira'),(97,'Can add material didatico',25,'add_materialdidatico'),(98,'Can change material didatico',25,'change_materialdidatico'),(99,'Can delete material didatico',25,'delete_materialdidatico'),(100,'Can view material didatico',25,'view_materialdidatico');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_classroom`
--

DROP TABLE IF EXISTS `classroom_classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom_classroom` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nivel` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titulo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_inicio` date NOT NULL,
  `data_fim` date NOT NULL,
  `criado_em` datetime(6) NOT NULL,
  `curso_id` bigint NOT NULL,
  `professor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_classroom_curso_id_fd5f569f_fk_courses_course_id` (`curso_id`),
  KEY `classroom_classroom_professor_id_35946d56_fk_users_customuser_id` (`professor_id`),
  CONSTRAINT `classroom_classroom_curso_id_fd5f569f_fk_courses_course_id` FOREIGN KEY (`curso_id`) REFERENCES `courses_course` (`id`),
  CONSTRAINT `classroom_classroom_professor_id_35946d56_fk_users_customuser_id` FOREIGN KEY (`professor_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_classroom`
--

LOCK TABLES `classroom_classroom` WRITE;
/*!40000 ALTER TABLE `classroom_classroom` DISABLE KEYS */;
INSERT INTO `classroom_classroom` VALUES (5,'intermedio','Sky','','2025-07-05','2025-07-08','2025-07-02 20:09:30.957288',5,1),(8,'iniciante','Godness','','2025-07-16','2025-07-24','2025-07-09 00:41:38.606420',4,1);
/*!40000 ALTER TABLE `classroom_classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_classroom_alunos`
--

DROP TABLE IF EXISTS `classroom_classroom_alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom_classroom_alunos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `classroom_id` bigint NOT NULL,
  `customuser_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `classroom_classroom_alun_classroom_id_customuser__ea376833_uniq` (`classroom_id`,`customuser_id`),
  KEY `classroom_classroom__customuser_id_157c39a3_fk_users_cus` (`customuser_id`),
  CONSTRAINT `classroom_classroom__classroom_id_253d8401_fk_classroom` FOREIGN KEY (`classroom_id`) REFERENCES `classroom_classroom` (`id`),
  CONSTRAINT `classroom_classroom__customuser_id_157c39a3_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_classroom_alunos`
--

LOCK TABLES `classroom_classroom_alunos` WRITE;
/*!40000 ALTER TABLE `classroom_classroom_alunos` DISABLE KEYS */;
INSERT INTO `classroom_classroom_alunos` VALUES (1,5,6),(7,8,6);
/*!40000 ALTER TABLE `classroom_classroom_alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comunicacao_avaliacaoprofessor`
--

DROP TABLE IF EXISTS `comunicacao_avaliacaoprofessor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comunicacao_avaliacaoprofessor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comentario` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `nota` int NOT NULL,
  `data` datetime(6) NOT NULL,
  `aluno_id` bigint NOT NULL,
  `professor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comunicacao_avaliaca_aluno_id_0fd1ce98_fk_users_cus` (`aluno_id`),
  KEY `comunicacao_avaliaca_professor_id_2bd3fcc0_fk_users_cus` (`professor_id`),
  CONSTRAINT `comunicacao_avaliaca_aluno_id_0fd1ce98_fk_users_cus` FOREIGN KEY (`aluno_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `comunicacao_avaliaca_professor_id_2bd3fcc0_fk_users_cus` FOREIGN KEY (`professor_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comunicacao_avaliacaoprofessor`
--

LOCK TABLES `comunicacao_avaliacaoprofessor` WRITE;
/*!40000 ALTER TABLE `comunicacao_avaliacaoprofessor` DISABLE KEYS */;
INSERT INTO `comunicacao_avaliacaoprofessor` VALUES (1,'gostei muito',10,'2025-07-09 00:04:27.912398',6,1);
/*!40000 ALTER TABLE `comunicacao_avaliacaoprofessor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comunicacao_mensagem`
--

DROP TABLE IF EXISTS `comunicacao_mensagem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comunicacao_mensagem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tipo` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conteudo` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `arquivo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lida` tinyint(1) NOT NULL,
  `criada_em` datetime(6) NOT NULL,
  `destinatario_id` bigint NOT NULL,
  `remetente_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comunicacao_mensagem_destinatario_id_83cd1e5b_fk_users_cus` (`destinatario_id`),
  KEY `comunicacao_mensagem_remetente_id_fffac1f0_fk_users_cus` (`remetente_id`),
  CONSTRAINT `comunicacao_mensagem_destinatario_id_83cd1e5b_fk_users_cus` FOREIGN KEY (`destinatario_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `comunicacao_mensagem_remetente_id_fffac1f0_fk_users_cus` FOREIGN KEY (`remetente_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comunicacao_mensagem`
--

LOCK TABLES `comunicacao_mensagem` WRITE;
/*!40000 ALTER TABLE `comunicacao_mensagem` DISABLE KEYS */;
INSERT INTO `comunicacao_mensagem` VALUES (1,'imagem','oiii','mensagens/Captura_de_Ecrã_3.png',0,'2025-07-05 13:07:00.765564',1,6),(2,'texto','oi','',0,'2025-07-05 13:07:25.208334',1,6),(3,'texto','oiii','',0,'2025-07-06 05:20:08.152390',1,6),(4,'texto','oiiii','',0,'2025-07-06 21:31:56.365260',1,6),(5,'texto','oiiii','',0,'2025-07-06 21:31:58.831231',1,6),(6,'texto','oiiii mana','',0,'2025-07-06 21:33:47.503653',6,1),(7,'texto','mana','',0,'2025-07-06 21:37:04.418617',1,6),(8,'texto','mana','',0,'2025-07-06 21:37:04.700053',1,6);
/*!40000 ALTER TABLE `comunicacao_mensagem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comunicacao_mensagemcontato`
--

DROP TABLE IF EXISTS `comunicacao_mensagemcontato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comunicacao_mensagemcontato` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `assunto` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mensagem` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `lida` tinyint(1) NOT NULL,
  `data_envio` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comunicacao_mensagemcontato`
--

LOCK TABLES `comunicacao_mensagemcontato` WRITE;
/*!40000 ALTER TABLE `comunicacao_mensagemcontato` DISABLE KEYS */;
INSERT INTO `comunicacao_mensagemcontato` VALUES (1,'Natacha Ndoji','natachasabi@gmail.com','sistema caIU','VEJAM BEM O SITEMA',1,'2025-07-08 04:19:53.748231');
/*!40000 ALTER TABLE `comunicacao_mensagemcontato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_course`
--

DROP TABLE IF EXISTS `courses_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses_course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `criado_em` datetime(6) NOT NULL,
  `professor_id` bigint DEFAULT NULL,
  `imagem` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`),
  KEY `courses_course_professor_id_a3488048_fk_users_customuser_id` (`professor_id`),
  CONSTRAINT `courses_course_professor_id_a3488048_fk_users_customuser_id` FOREIGN KEY (`professor_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_course`
--

LOCK TABLES `courses_course` WRITE;
/*!40000 ALTER TABLE `courses_course` DISABLE KEYS */;
INSERT INTO `courses_course` VALUES (4,'Inglês','Curso de Inglês','2025-07-02 18:16:03.114168',NULL,'cursos/imagens/ingles_capa.png'),(5,'Português','Curso de Português adaptado a cultura da língua portugêsa e comunidade estrangeira em geral','2025-07-02 18:16:04.576534',NULL,'cursos/imagens/portuges_capa.png');
/*!40000 ALTER TABLE `courses_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_course_alunos`
--

DROP TABLE IF EXISTS `courses_course_alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses_course_alunos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course_id` bigint NOT NULL,
  `customuser_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_course_alunos_course_id_customuser_id_a707108a_uniq` (`course_id`,`customuser_id`),
  KEY `courses_course_aluno_customuser_id_2702c008_fk_users_cus` (`customuser_id`),
  CONSTRAINT `courses_course_aluno_customuser_id_2702c008_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `courses_course_alunos_course_id_8e32ac65_fk_courses_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_course_alunos`
--

LOCK TABLES `courses_course_alunos` WRITE;
/*!40000 ALTER TABLE `courses_course_alunos` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_course_alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_dadospagamento`
--

DROP TABLE IF EXISTS `courses_dadospagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses_dadospagamento` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `banco` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titular` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conta` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `iban` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instrucoes_extra` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_dadospagamento`
--

LOCK TABLES `courses_dadospagamento` WRITE;
/*!40000 ALTER TABLE `courses_dadospagamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_dadospagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_enrollment`
--

DROP TABLE IF EXISTS `courses_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses_enrollment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `data_matricula` datetime(6) NOT NULL,
  `aluno_id` bigint NOT NULL,
  `curso_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_enrollment_aluno_id_curso_id_1621de83_uniq` (`aluno_id`,`curso_id`),
  KEY `courses_enrollment_curso_id_fd57b4d4_fk_courses_course_id` (`curso_id`),
  CONSTRAINT `courses_enrollment_aluno_id_fda5bfc6_fk_users_customuser_id` FOREIGN KEY (`aluno_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `courses_enrollment_curso_id_fd57b4d4_fk_courses_course_id` FOREIGN KEY (`curso_id`) REFERENCES `courses_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_enrollment`
--

LOCK TABLES `courses_enrollment` WRITE;
/*!40000 ALTER TABLE `courses_enrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_planoprecocurso`
--

DROP TABLE IF EXISTS `courses_planoprecocurso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses_planoprecocurso` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `frequencia` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duracao` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `curso_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_planoprecocurso_curso_id_fa0476c5_fk_courses_course_id` (`curso_id`),
  CONSTRAINT `courses_planoprecocurso_curso_id_fa0476c5_fk_courses_course_id` FOREIGN KEY (`curso_id`) REFERENCES `courses_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_planoprecocurso`
--

LOCK TABLES `courses_planoprecocurso` WRITE;
/*!40000 ALTER TABLE `courses_planoprecocurso` DISABLE KEYS */;
INSERT INTO `courses_planoprecocurso` VALUES (1,'1x','30min',8000.00,4),(2,'1x','1h',10000.00,4),(3,'2x','30min',16000.00,4),(4,'2x','1h',20000.00,4),(6,'3x','30min',24000.00,4),(7,'3x','1h',30000.00,4);
/*!40000 ALTER TABLE `courses_planoprecocurso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-06-30 22:49:40.980362','1','Cláudia Sabi',2,'[{\"changed\": {\"fields\": [\"Active\", \"User permissions\", \"Especialidade\", \"\\u00c9 administrador\"]}}]',6,5);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(7,'classroom','classroom'),(17,'comunicacao','avaliacaoprofessor'),(20,'comunicacao','mensagem'),(16,'comunicacao','mensagemcontato'),(4,'contenttypes','contenttype'),(8,'courses','course'),(21,'courses','dadospagamento'),(11,'courses','enrollment'),(23,'courses','planoprecocurso'),(24,'financeiro','configuracaofinanceira'),(9,'lessons','livelesson'),(25,'lessons','materialdidatico'),(19,'lessons','participacaoaluno'),(10,'nivelamento','nivelamento'),(13,'nivelamento','pedidomatricula'),(15,'nivelamento','quizpergunta'),(14,'nivelamento','quizresposta'),(22,'nivelamento','respostaaluno'),(12,'nivelamento','resultadoteste'),(18,'notificacoes','notificacao'),(5,'sessions','session'),(6,'users','customuser');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-06-20 22:26:49.073326'),(2,'contenttypes','0002_remove_content_type_name','2025-06-20 22:26:57.983218'),(3,'auth','0001_initial','2025-06-20 22:27:15.983067'),(4,'auth','0002_alter_permission_name_max_length','2025-06-20 22:27:18.867728'),(5,'auth','0003_alter_user_email_max_length','2025-06-20 22:27:19.059750'),(6,'auth','0004_alter_user_username_opts','2025-06-20 22:27:19.372661'),(7,'auth','0005_alter_user_last_login_null','2025-06-20 22:27:19.601636'),(8,'auth','0006_require_contenttypes_0002','2025-06-20 22:27:19.745641'),(9,'auth','0007_alter_validators_add_error_messages','2025-06-20 22:27:19.828642'),(10,'auth','0008_alter_user_username_max_length','2025-06-20 22:27:19.950594'),(11,'auth','0009_alter_user_last_name_max_length','2025-06-20 22:27:20.169573'),(12,'auth','0010_alter_group_name_max_length','2025-06-20 22:27:20.698505'),(13,'auth','0011_update_proxy_permissions','2025-06-20 22:27:20.969497'),(14,'auth','0012_alter_user_first_name_max_length','2025-06-20 22:27:21.170496'),(15,'users','0001_initial','2025-06-20 22:27:35.345757'),(16,'admin','0001_initial','2025-06-20 22:27:43.333807'),(17,'admin','0002_logentry_remove_auto_add','2025-06-20 22:27:43.593771'),(18,'admin','0003_logentry_add_action_flag_choices','2025-06-20 22:27:43.963727'),(19,'sessions','0001_initial','2025-06-20 22:27:51.033888'),(20,'courses','0001_initial','2025-06-21 11:45:58.124745'),(21,'classroom','0001_initial','2025-06-21 11:46:08.736670'),(22,'lessons','0001_initial','2025-06-21 11:46:13.359161'),(23,'nivelamento','0001_initial','2025-06-21 12:03:20.390532'),(24,'classroom','0002_alter_classroom_alunos','2025-06-21 12:26:46.170312'),(25,'courses','0002_enrollment','2025-06-21 12:27:11.673285'),(26,'courses','0003_course_alunos_alter_course_professor','2025-06-30 13:24:20.171214'),(27,'comunicacao','0001_initial','2025-06-30 20:17:22.894353'),(28,'nivelamento','0002_quizpergunta_quizresposta_resultadoteste_and_more','2025-06-30 20:18:01.067499'),(29,'notificacoes','0001_initial','2025-06-30 20:44:34.408058'),(30,'classroom','0003_alter_classroom_alunos_alter_classroom_professor','2025-07-01 01:22:54.599397'),(31,'lessons','0002_participacaoaluno','2025-07-03 03:27:01.562563'),(32,'comunicacao','0002_mensagem','2025-07-05 13:05:15.811139'),(33,'courses','0004_dadospagamento_course_imagem_course_preco','2025-07-07 00:24:18.878008'),(34,'nivelamento','0003_pedidomatricula_avaliado_pagamento_em_and_more','2025-07-07 00:24:21.659211'),(35,'nivelamento','0004_respostaaluno','2025-07-07 16:06:09.108816'),(36,'courses','0005_planoprecocurso','2025-07-07 21:20:25.345657'),(37,'financeiro','0001_initial','2025-07-07 21:20:26.205011'),(38,'nivelamento','0005_pedidomatricula_plano','2025-07-07 21:20:29.736253'),(39,'courses','0006_alter_planoprecocurso_curso_and_more','2025-07-07 22:37:55.867799'),(40,'courses','0007_remove_course_preco','2025-07-08 02:25:18.892468'),(41,'comunicacao','0003_alter_avaliacaoprofessor_nota','2025-07-08 12:55:48.682828'),(42,'lessons','0003_materialdidatico','2025-07-09 10:55:21.747270');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('9eqf1hxis5slf7tyf805mlx24us7l7ql','e30:1uSyPu:l_PB7op5B8oAg38CmIAj0LDEMcRYZieEzRWVbH5Uar8','2025-07-05 13:37:58.742795'),('z0zagwch4fvjs32m0b8fjlbxvs6hb5dw','.eJxVjEEOwiAQRe_C2pBOwRZcuu8ZyAwzSNVAUtqV8e7apAvd_vfef6mA25rD1mQJM6uLGtTpdyOMDyk74DuWW9WxlnWZSe-KPmjTU2V5Xg_37yBjy9-aEvYCiSSRkeSEaOSuH0WiAQTxQ2RLnQMHFh2iMRCRzmzYRibvWb0_OdE50A:1uWRUo:Ib4GsCIqHFol9Tbk67iHF2B3kQxNDWy7kG_3vyx7Ldk','2025-07-15 03:17:22.926140'),('zupi6miedjmxndulvnmr0ww5q9kt46bp','.eJxVjjsOwjAQRO_iGlnZjQ02JT1nsNbezQciR4qTCnF3HJECminm8zQvFWhbh7AVWcLI6qpAnX69SOkpeQ_4QbmfdZrzuoxR7xV9pEXfZ5bpdnT_AAOVoa7RAnXGi0XXAHMLQCZCQoeGffQtgklWIJ2NOMfexK5z5JM1zQVR0FXo90CYqm7US4VKVu8PHj8_Fg:1uXSl0:adrG0Cos6f2w_b02OkhoNhLn7PARLi4VYMcJDIbY4Oc','2025-07-17 22:50:18.340192');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financeiro_configuracaofinanceira`
--

DROP TABLE IF EXISTS `financeiro_configuracaofinanceira`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financeiro_configuracaofinanceira` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome_banco` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titular_conta` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_conta` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `iban` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `swift` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instrucao_extra` longtext COLLATE utf8mb4_unicode_ci,
  `ultima_atualizacao` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financeiro_configuracaofinanceira`
--

LOCK TABLES `financeiro_configuracaofinanceira` WRITE;
/*!40000 ALTER TABLE `financeiro_configuracaofinanceira` DISABLE KEYS */;
INSERT INTO `financeiro_configuracaofinanceira` VALUES (1,'BANCO BAI','Cláudia Sabi','1111111','004000009688451010186','','Para pagamentos por Express ou internacionais por favor contacte o admin via feedback','2025-07-08 01:25:38.112956');
/*!40000 ALTER TABLE `financeiro_configuracaofinanceira` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lessons_livelesson`
--

DROP TABLE IF EXISTS `lessons_livelesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lessons_livelesson` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `horario` datetime(6) NOT NULL,
  `slug_sala` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `criado_em` datetime(6) NOT NULL,
  `classroom_id` bigint NOT NULL,
  `criado_por_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug_sala` (`slug_sala`),
  KEY `lessons_livelesson_classroom_id_59b552c2_fk_classroom` (`classroom_id`),
  KEY `lessons_livelesson_criado_por_id_609fdc9d_fk_users_customuser_id` (`criado_por_id`),
  CONSTRAINT `lessons_livelesson_classroom_id_59b552c2_fk_classroom` FOREIGN KEY (`classroom_id`) REFERENCES `classroom_classroom` (`id`),
  CONSTRAINT `lessons_livelesson_criado_por_id_609fdc9d_fk_users_customuser_id` FOREIGN KEY (`criado_por_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lessons_livelesson`
--

LOCK TABLES `lessons_livelesson` WRITE;
/*!40000 ALTER TABLE `lessons_livelesson` DISABLE KEYS */;
INSERT INTO `lessons_livelesson` VALUES (15,'Aula1','nova','2025-07-25 00:58:00.000000','5-aula1-42f1e07492','2025-07-04 00:58:31.265751',5,1),(16,'Aula2','nova aula','2025-08-01 19:07:00.000000','5-aula2-6eb6fff9a2','2025-07-09 14:07:11.073570',5,1);
/*!40000 ALTER TABLE `lessons_livelesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lessons_materialdidatico`
--

DROP TABLE IF EXISTS `lessons_materialdidatico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lessons_materialdidatico` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `arquivo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `criado_em` datetime(6) NOT NULL,
  `aula_id` bigint NOT NULL,
  `criado_por_id` bigint NOT NULL,
  `sala_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lessons_materialdida_aula_id_8aed4908_fk_lessons_l` (`aula_id`),
  KEY `lessons_materialdida_criado_por_id_797d24b4_fk_users_cus` (`criado_por_id`),
  KEY `lessons_materialdida_sala_id_8e272727_fk_classroom` (`sala_id`),
  CONSTRAINT `lessons_materialdida_aula_id_8aed4908_fk_lessons_l` FOREIGN KEY (`aula_id`) REFERENCES `lessons_livelesson` (`id`),
  CONSTRAINT `lessons_materialdida_criado_por_id_797d24b4_fk_users_cus` FOREIGN KEY (`criado_por_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `lessons_materialdida_sala_id_8e272727_fk_classroom` FOREIGN KEY (`sala_id`) REFERENCES `classroom_classroom` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lessons_materialdidatico`
--

LOCK TABLES `lessons_materialdidatico` WRITE;
/*!40000 ALTER TABLE `lessons_materialdidatico` DISABLE KEYS */;
INSERT INTO `lessons_materialdidatico` VALUES (1,'Livro de Ingles 1','materiais/6243_informática_básica_final_j3hpJ9z.pdf','material','2025-07-09 14:58:49.860863',15,1,5),(2,'Livro de Ingles 1','materiais/6243_informática_básica_final_3j6gSYo.pdf','material','2025-07-09 15:07:43.106739',15,1,5);
/*!40000 ALTER TABLE `lessons_materialdidatico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lessons_participacaoaluno`
--

DROP TABLE IF EXISTS `lessons_participacaoaluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lessons_participacaoaluno` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `presente` tinyint(1) NOT NULL,
  `avaliacao` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `criado_em` datetime(6) NOT NULL,
  `aluno_id` bigint NOT NULL,
  `aula_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lessons_participacaoaluno_aula_id_aluno_id_815a99dd_uniq` (`aula_id`,`aluno_id`),
  KEY `lessons_participacao_aluno_id_093d5f63_fk_users_cus` (`aluno_id`),
  CONSTRAINT `lessons_participacao_aluno_id_093d5f63_fk_users_cus` FOREIGN KEY (`aluno_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `lessons_participacao_aula_id_31a09945_fk_lessons_l` FOREIGN KEY (`aula_id`) REFERENCES `lessons_livelesson` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lessons_participacaoaluno`
--

LOCK TABLES `lessons_participacaoaluno` WRITE;
/*!40000 ALTER TABLE `lessons_participacaoaluno` DISABLE KEYS */;
INSERT INTO `lessons_participacaoaluno` VALUES (2,1,NULL,'2025-07-08 22:59:56.477522',6,15);
/*!40000 ALTER TABLE `lessons_participacaoaluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nivelamento_nivelamento`
--

DROP TABLE IF EXISTS `nivelamento_nivelamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nivelamento_nivelamento` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pergunta` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `opcoes` json NOT NULL,
  `resposta_correta` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `curso_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nivelamento_nivelamento_curso_id_49f744b1_fk_courses_course_id` (`curso_id`),
  CONSTRAINT `nivelamento_nivelamento_curso_id_49f744b1_fk_courses_course_id` FOREIGN KEY (`curso_id`) REFERENCES `courses_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nivelamento_nivelamento`
--

LOCK TABLES `nivelamento_nivelamento` WRITE;
/*!40000 ALTER TABLE `nivelamento_nivelamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `nivelamento_nivelamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nivelamento_pedidomatricula`
--

DROP TABLE IF EXISTS `nivelamento_pedidomatricula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nivelamento_pedidomatricula` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `aprovado` tinyint(1) NOT NULL,
  `avaliado` tinyint(1) NOT NULL,
  `data_solicitacao` datetime(6) NOT NULL,
  `aluno_id` bigint NOT NULL,
  `curso_id` bigint NOT NULL,
  `resultado_teste_id` bigint NOT NULL,
  `avaliado_pagamento_em` datetime(6) DEFAULT NULL,
  `comprovativo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagamento_enviado` tinyint(1) NOT NULL,
  `plano_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nivelamento_pedidoma_aluno_id_2ce19b2e_fk_users_cus` (`aluno_id`),
  KEY `nivelamento_pedidoma_curso_id_7da4730a_fk_courses_c` (`curso_id`),
  KEY `nivelamento_pedidoma_resultado_teste_id_0a62693a_fk_nivelamen` (`resultado_teste_id`),
  KEY `nivelamento_pedidoma_plano_id_9c4eedb7_fk_courses_p` (`plano_id`),
  CONSTRAINT `nivelamento_pedidoma_aluno_id_2ce19b2e_fk_users_cus` FOREIGN KEY (`aluno_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `nivelamento_pedidoma_curso_id_7da4730a_fk_courses_c` FOREIGN KEY (`curso_id`) REFERENCES `courses_course` (`id`),
  CONSTRAINT `nivelamento_pedidoma_plano_id_9c4eedb7_fk_courses_p` FOREIGN KEY (`plano_id`) REFERENCES `courses_planoprecocurso` (`id`),
  CONSTRAINT `nivelamento_pedidoma_resultado_teste_id_0a62693a_fk_nivelamen` FOREIGN KEY (`resultado_teste_id`) REFERENCES `nivelamento_resultadoteste` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nivelamento_pedidomatricula`
--

LOCK TABLES `nivelamento_pedidomatricula` WRITE;
/*!40000 ALTER TABLE `nivelamento_pedidomatricula` DISABLE KEYS */;
INSERT INTO `nivelamento_pedidomatricula` VALUES (1,0,1,'2025-07-02 21:43:30.211305',6,4,3,NULL,NULL,0,NULL),(2,1,1,'2025-07-02 21:52:27.138023',6,5,4,NULL,NULL,0,NULL),(3,1,1,'2025-07-07 06:35:34.458692',6,4,5,'2025-07-07 12:56:35.153910','pagamentos/comprovativos/_ORÇAMENTO_GERAL_PARA_ABERTURA_DE_GRÁFICA_EM_LUANDA.pdf',1,NULL),(4,1,1,'2025-07-08 21:50:36.815437',6,4,6,'2025-07-08 21:55:48.237652','pagamentos/comprovativos/_ORÇAMENTO_GERAL_PARA_ABERTURA_DE_GRÁFICA_EM_LUANDA_p0WNhj0.pdf',1,1),(5,1,1,'2025-07-09 00:33:46.301356',6,4,7,'2025-07-09 00:34:57.176561','pagamentos/comprovativos/_ORÇAMENTO_GERAL_PARA_ABERTURA_DE_GRÁFICA_EM_LUANDA_wSd4oik.pdf',1,3),(6,1,1,'2025-07-09 00:43:23.816719',6,4,8,'2025-07-09 00:43:49.609405','pagamentos/comprovativos/_ORÇAMENTO_GERAL_PARA_ABERTURA_DE_GRÁFICA_EM_LUANDA_WKOHzre.pdf',1,2);
/*!40000 ALTER TABLE `nivelamento_pedidomatricula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nivelamento_quizpergunta`
--

DROP TABLE IF EXISTS `nivelamento_quizpergunta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nivelamento_quizpergunta` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nivel` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pergunta` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `curso_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nivelamento_quizpergunta_curso_id_9a05645b_fk_courses_course_id` (`curso_id`),
  CONSTRAINT `nivelamento_quizpergunta_curso_id_9a05645b_fk_courses_course_id` FOREIGN KEY (`curso_id`) REFERENCES `courses_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nivelamento_quizpergunta`
--

LOCK TABLES `nivelamento_quizpergunta` WRITE;
/*!40000 ALTER TABLE `nivelamento_quizpergunta` DISABLE KEYS */;
INSERT INTO `nivelamento_quizpergunta` VALUES (14,'iniciante','What is the plural of \'mouse\'?',4),(15,'iniciante','She ___ a doctor.',4),(16,'iniciante','How do you say \'olá\' in English?',4),(17,'iniciante','Qual o plural de \'pão\'?',5),(18,'iniciante','Complete: Ele ___ à escola ontem.',5),(19,'iniciante','O feminino de \'ator\' é ___',5),(20,'intermedio','Which of the following is a correct question tag: \'You are coming, ___?\'',4),(21,'intermedio','Qual frase está corretamente acentuada?',5),(22,'intermedio','Choose the correct sentence:',4),(23,'intermedio','Qual das palavras abaixo é um advérbio?',5),(24,'intermedio','What does \'used to\' express?',4),(25,'iniciante','What color is the sky on a clear day?',4),(26,'iniciante','Como se escreve corretamente: \'a gente vai\' ou \'agente vai\'?',5),(27,'intermedio','Which sentence is correct?',4),(28,'avancado','Qual a classificação da palavra \'rapidamente\'?',5),(29,'avancado','Choose the correct passive voice: \'They built a house.\'',4),(30,'fluente','Em qual oração o uso da vírgula está incorreto?',5),(31,'fluente','What is the meaning of \'Nevertheless\'?',4),(32,'iniciante','Qual destas palavras é um verbo?',5),(33,'iniciante','How do you say \'bom dia\' in English?',4),(34,'intermedio','Qual frase tem sentido figurado?',5),(35,'iniciante','What color is the sky on a clear day?',4),(36,'iniciante','Como se escreve corretamente: \'a gente vai\' ou \'agente vai\'?',5),(37,'intermedio','Which sentence is correct?',4),(38,'avancado','Qual a classificação da palavra \'rapidamente\'?',5),(39,'avancado','Choose the correct passive voice: \'They built a house.\'',4),(40,'fluente','Em qual oração o uso da vírgula está incorreto?',5),(41,'fluente','What is the meaning of \'Nevertheless\'?',4),(42,'iniciante','Qual destas palavras é um verbo?',5),(43,'iniciante','How do you say \'bom dia\' in English?',4),(44,'intermedio','Qual frase tem sentido figurado?',5),(45,'avancado','Choose the correct passive voice: \'They built a house.\'',4);
/*!40000 ALTER TABLE `nivelamento_quizpergunta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nivelamento_quizresposta`
--

DROP TABLE IF EXISTS `nivelamento_quizresposta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nivelamento_quizresposta` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `texto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correta` tinyint(1) NOT NULL,
  `pergunta_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nivelamento_quizresp_pergunta_id_544e5677_fk_nivelamen` (`pergunta_id`),
  CONSTRAINT `nivelamento_quizresp_pergunta_id_544e5677_fk_nivelamen` FOREIGN KEY (`pergunta_id`) REFERENCES `nivelamento_quizpergunta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nivelamento_quizresposta`
--

LOCK TABLES `nivelamento_quizresposta` WRITE;
/*!40000 ALTER TABLE `nivelamento_quizresposta` DISABLE KEYS */;
INSERT INTO `nivelamento_quizresposta` VALUES (53,'mouses',0,14),(54,'mices',0,14),(55,'mice',1,14),(56,'mouse',0,14),(57,'am',0,15),(58,'is',1,15),(59,'are',0,15),(60,'be',0,15),(61,'Goodbye',0,16),(62,'Hi',1,16),(63,'Yes',0,16),(64,'No',0,16),(65,'pãos',0,17),(66,'pães',1,17),(67,'pãoses',0,17),(68,'pãones',0,17),(69,'foi',1,18),(70,'vai',0,18),(71,'irá',0,18),(72,'vaiu',0,18),(73,'atora',0,19),(74,'atriz',1,19),(75,'atorz',0,19),(76,'atores',0,19),(77,'isn’t it',0,20),(78,'aren’t you',1,20),(79,'are you',0,20),(80,'don’t you',0,20),(81,'Eles têm muitas idéias.',0,21),(82,'Ele tem muitas idéias.',0,21),(83,'Eles têm muitas ideias.',1,21),(84,'Eles tem muitas ideias.',0,21),(85,'He don’t like pizza.',0,22),(86,'He doesn’t likes pizza.',0,22),(87,'He doesn’t like pizza.',1,22),(88,'He no like pizza.',0,22),(89,'rápido',0,23),(90,'rapidamente',1,23),(91,'rapidez',0,23),(92,'rápida',0,23),(93,'A present habit',0,24),(94,'A past habit',1,24),(95,'A future plan',0,24),(96,'A permission',0,24),(97,'Blue',1,25),(98,'Green',0,25),(99,'Red',0,25),(100,'Yellow',0,25),(101,'agente vai',0,26),(102,'a gente vai',1,26),(103,'a gente vaih',0,26),(104,'agentevai',0,26),(105,'She can sings very well.',0,27),(106,'She can sing very well.',1,27),(107,'She can to sing very well.',0,27),(108,'She sings can very well.',0,27),(109,'adjetivo',0,28),(110,'verbo',0,28),(111,'advérbio',1,28),(112,'substantivo',0,28),(113,'A house was built.',1,29),(114,'They was built a house.',0,29),(115,'The house builded.',0,29),(116,'Was built a house by them.',0,29),(117,'João, meu irmão, chegou ontem.',0,30),(118,'Se chover, não sairemos.',0,30),(119,'Comprei pão, leite, e queijo.',1,30),(120,'Maria, embora cansada, saiu.',0,30),(121,'Consequently',0,31),(122,'Despite that',1,31),(123,'Moreover',0,31),(124,'Instead',0,31),(125,'correr',1,32),(126,'feliz',0,32),(127,'verde',0,32),(128,'menina',0,32),(129,'Good morning',1,33),(130,'Good night',0,33),(131,'Goodbye',0,33),(132,'Hello',0,33),(133,'Ela é uma pedra.',1,34),(134,'A pedra está no chão.',0,34),(135,'Comprei uma pedra.',0,34),(136,'Peguei a pedra.',0,34),(137,'Blue',1,35),(138,'Green',0,35),(139,'Red',0,35),(140,'Yellow',0,35),(141,'agente vai',0,36),(142,'a gente vai',1,36),(143,'a gente vaih',0,36),(144,'agentevai',0,36),(145,'She can sings very well.',0,37),(146,'She can sing very well.',1,37),(147,'She can to sing very well.',0,37),(148,'She sings can very well.',0,37),(149,'adjetivo',0,38),(150,'verbo',0,38),(151,'advérbio',1,38),(152,'substantivo',0,38),(153,'A house was built.',1,39),(154,'They was built a house.',0,39),(155,'The house builded.',0,39),(156,'Was built a house by them.',0,39),(157,'João, meu irmão, chegou ontem.',0,40),(158,'Se chover, não sairemos.',0,40),(159,'Comprei pão, leite, e queijo.',1,40),(160,'Maria, embora cansada, saiu.',0,40),(161,'Consequently',0,41),(162,'Despite that',1,41),(163,'Moreover',0,41),(164,'Instead',0,41),(165,'correr',1,42),(166,'feliz',0,42),(167,'verde',0,42),(168,'menina',0,42),(169,'Good morning',1,43),(170,'Good night',0,43),(171,'Goodbye',0,43),(172,'Hello',0,43),(173,'Ela é uma pedra.',1,44),(174,'A pedra está no chão.',0,44),(175,'Comprei uma pedra.',0,44),(176,'Peguei a pedra.',0,44),(177,'A house was built.',1,45),(178,'They was built a house.',0,45),(179,'The house builded.',0,45),(180,'Was built a house by them.',0,45);
/*!40000 ALTER TABLE `nivelamento_quizresposta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nivelamento_respostaaluno`
--

DROP TABLE IF EXISTS `nivelamento_respostaaluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nivelamento_respostaaluno` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pergunta_id` bigint NOT NULL,
  `resposta_escolhida_id` bigint DEFAULT NULL,
  `resultado_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nivelamento_resposta_pergunta_id_2618e48b_fk_nivelamen` (`pergunta_id`),
  KEY `nivelamento_resposta_resposta_escolhida_i_9ca5b3eb_fk_nivelamen` (`resposta_escolhida_id`),
  KEY `nivelamento_resposta_resultado_id_41ce9ea7_fk_nivelamen` (`resultado_id`),
  CONSTRAINT `nivelamento_resposta_pergunta_id_2618e48b_fk_nivelamen` FOREIGN KEY (`pergunta_id`) REFERENCES `nivelamento_quizpergunta` (`id`),
  CONSTRAINT `nivelamento_resposta_resposta_escolhida_i_9ca5b3eb_fk_nivelamen` FOREIGN KEY (`resposta_escolhida_id`) REFERENCES `nivelamento_quizresposta` (`id`),
  CONSTRAINT `nivelamento_resposta_resultado_id_41ce9ea7_fk_nivelamen` FOREIGN KEY (`resultado_id`) REFERENCES `nivelamento_resultadoteste` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nivelamento_respostaaluno`
--

LOCK TABLES `nivelamento_respostaaluno` WRITE;
/*!40000 ALTER TABLE `nivelamento_respostaaluno` DISABLE KEYS */;
/*!40000 ALTER TABLE `nivelamento_respostaaluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nivelamento_resultadoteste`
--

DROP TABLE IF EXISTS `nivelamento_resultadoteste`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nivelamento_resultadoteste` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pontuacao` int NOT NULL,
  `nivel_atribuido` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` datetime(6) NOT NULL,
  `aluno_id` bigint NOT NULL,
  `curso_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nivelamento_resultad_aluno_id_97aa40d5_fk_users_cus` (`aluno_id`),
  KEY `nivelamento_resultad_curso_id_9c0d49ea_fk_courses_c` (`curso_id`),
  CONSTRAINT `nivelamento_resultad_aluno_id_97aa40d5_fk_users_cus` FOREIGN KEY (`aluno_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `nivelamento_resultad_curso_id_9c0d49ea_fk_courses_c` FOREIGN KEY (`curso_id`) REFERENCES `courses_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nivelamento_resultadoteste`
--

LOCK TABLES `nivelamento_resultadoteste` WRITE;
/*!40000 ALTER TABLE `nivelamento_resultadoteste` DISABLE KEYS */;
INSERT INTO `nivelamento_resultadoteste` VALUES (3,6,'avancado','2025-07-02 21:42:05.652021',6,4),(4,5,'intermedio','2025-07-02 21:52:03.630316',6,5),(5,6,'avancado','2025-07-07 00:28:05.561763',6,4),(6,5,'intermedio','2025-07-08 15:28:14.942509',6,4),(7,5,'intermedio','2025-07-09 00:32:23.300471',6,4),(8,4,'intermedio','2025-07-09 00:42:39.155040',6,4);
/*!40000 ALTER TABLE `nivelamento_resultadoteste` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificacoes_notificacao`
--

DROP TABLE IF EXISTS `notificacoes_notificacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificacoes_notificacao` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mensagem` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `lida` tinyint(1) NOT NULL,
  `data` datetime(6) NOT NULL,
  `url_destino` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usuario_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notificacoes_notific_usuario_id_808d460a_fk_users_cus` (`usuario_id`),
  CONSTRAINT `notificacoes_notific_usuario_id_808d460a_fk_users_cus` FOREIGN KEY (`usuario_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificacoes_notificacao`
--

LOCK TABLES `notificacoes_notificacao` WRITE;
/*!40000 ALTER TABLE `notificacoes_notificacao` DISABLE KEYS */;
INSERT INTO `notificacoes_notificacao` VALUES (1,'🚫 A tua conta foi desativada pelo administrador.',1,'2025-06-30 22:36:07.173579',NULL,1),(2,'📝 A sala \'Betesda\' foi atualizada. Verifica os detalhes no painel.',0,'2025-07-01 01:25:01.032727','/painel-salas/',1),(3,'📝 A sala \'Jardím do Éden\' foi atualizada. Verifica os detalhes no painel.',0,'2025-07-01 01:47:57.933300','/painel-salas/',3),(4,'🧠 Teste de nível finalizado! Teu nível atribuído para o curso \'Curso de Inglês\' foi: INICIANTE',1,'2025-07-01 03:38:38.937524','/nivelamento/resultado/1/',6),(5,'🧠 Teste de nível finalizado! Teu nível atribuído para o curso \'Curso de Inglês\' foi: INICIANTE',1,'2025-07-01 07:29:15.635405','/nivelamento/resultado/2/',6),(6,'⚠️ O curso \'Curso de Inglês\' foi removido da plataforma.',0,'2025-07-02 20:05:12.645009','/painel-salas/',1),(7,'⚠️ O curso \'Curso de Inglês\' foi removido da plataforma.',0,'2025-07-02 20:05:14.011443','/painel-salas/',3),(8,'⚠️ O curso \'Curso de Inglês\' foi removido da plataforma.',0,'2025-07-02 20:05:14.459838','/painel_aluno/',4),(9,'⚠️ O curso \'Curso de Inglês\' foi removido da plataforma.',0,'2025-07-02 20:05:14.684007','/painel-salas/',5),(10,'⚠️ O curso \'Curso de Inglês\' foi removido da plataforma.',1,'2025-07-02 20:05:14.892764','/painel_aluno/',6),(11,'⚠️ O curso \'Curso de Português\' foi removido da plataforma.',0,'2025-07-02 20:07:29.352396','/painel-salas/',1),(12,'⚠️ O curso \'Curso de Português\' foi removido da plataforma.',0,'2025-07-02 20:07:29.753744','/painel-salas/',3),(13,'⚠️ O curso \'Curso de Português\' foi removido da plataforma.',0,'2025-07-02 20:07:29.949960','/painel_aluno/',4),(14,'⚠️ O curso \'Curso de Português\' foi removido da plataforma.',0,'2025-07-02 20:07:30.332420','/painel-salas/',5),(15,'⚠️ O curso \'Curso de Português\' foi removido da plataforma.',1,'2025-07-02 20:07:30.621276','/painel_aluno/',6),(16,'🔧 O curso \'Português\' foi atualizado, confira as novidades.',0,'2025-07-02 20:07:42.628945','/painel-salas/',1),(17,'🔧 O curso \'Português\' foi atualizado, confira as novidades.',0,'2025-07-02 20:07:42.930775','/painel-salas/',3),(18,'🔧 O curso \'Português\' foi atualizado, confira as novidades.',0,'2025-07-02 20:07:43.049346','/painel_aluno/',4),(19,'🔧 O curso \'Português\' foi atualizado, confira as novidades.',0,'2025-07-02 20:07:43.149270','/painel-salas/',5),(20,'🔧 O curso \'Português\' foi atualizado, confira as novidades.',1,'2025-07-02 20:07:43.266735','/painel_aluno/',6),(21,'👨‍🏫 Foste atribuído(a) à sala \'Flowers\' para o curso Inglês.',0,'2025-07-02 20:09:01.301316','/painel-salas/',1),(22,'👨‍🏫 Foste atribuído(a) à sala \'Sky\' para o curso Português.',0,'2025-07-02 20:09:31.260011','/painel-salas/',3),(23,'🧠 Teste de nível finalizado! Teu nível atribuído para o curso \'Inglês\' foi: AVANCADO',1,'2025-07-02 21:42:06.510243','/nivelamento/resultado/3/',6),(24,'📩 Novo pedido de matrícula para o curso \'Inglês\' por Natacha Sabi',0,'2025-07-02 21:43:30.675168','/painel-admin/',1),(25,'✅ Pedido de matrícula enviado com sucesso para o curso \'Inglês\'. Aguarde aprovação.',1,'2025-07-02 21:43:31.114030','/painel-aluno/',6),(26,'🧠 Teste de nível finalizado! Teu nível atribuído para o curso \'Português\' foi: INTERMEDIO',1,'2025-07-02 21:52:03.925847','/nivelamento/resultado/4/',6),(27,'📩 Novo pedido de matrícula para o curso \'Português\' por Natacha Sabi',0,'2025-07-02 21:52:27.636742','/painel-admin/',1),(28,'✅ Pedido de matrícula enviado com sucesso para o curso \'Português\'. Aguarde aprovação.',1,'2025-07-02 21:52:28.070816','/painel-aluno/',6),(29,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:13:34.669017','/painel_aluno/',6),(30,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:22:14.348337','/painel_aluno/',6),(31,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:27:02.115038','/painel_aluno/',6),(32,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:27:33.691362','/painel_aluno/',6),(33,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:30:28.097351','/painel_aluno/',6),(34,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:31:07.036983','/painel_aluno/',6),(35,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:31:44.013873','/painel_aluno/',6),(36,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:37:30.244917','/painel_aluno/',6),(37,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:37:45.750846','/painel_aluno/',6),(38,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:39:29.003232','/painel_aluno/',6),(39,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:39:45.004758','/painel_aluno/',6),(40,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:39:50.951521','/painel_aluno/',6),(41,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:41:53.886285','/painel_aluno/',6),(42,'❌ O teu pedido de matrícula no curso \'Inglês\' foi rejeitado.',1,'2025-07-02 22:50:37.257735','/painel_aluno/',6),(43,'✅ O teu pedido de matrícula foi aprovado e estás agora na sala \'Sky\'.',1,'2025-07-02 22:54:15.257378','/painel_aluno/',6),(44,'📝 A sala \'Flowers\' foi atualizada. Verifica os detalhes no painel.',0,'2025-07-04 00:47:47.870003','/painel-salas/',3),(45,'📝 A sala \'Sky\' foi atualizada. Verifica os detalhes no painel.',0,'2025-07-04 00:48:06.438714','/painel-salas/',1),(46,'⚠️ A sala \'Sky\' da qual fazes parte foi atualizada.',0,'2025-07-04 00:48:07.130168','/painel_aluno/',6),(47,'📢 Nova aula criada: \'Aula 3\' na sala \'Sky\'.',0,'2025-07-04 00:49:31.591473','/aulas/painel/aluno/',6),(48,'📢 Nova aula criada: \'Aula1\' na sala \'Sky\'.',0,'2025-07-04 00:58:31.692655','/aulas/painel/aluno/',6),(49,'🧠 Teste de nível finalizado! Teu nível atribuído para o curso \'Inglês\' foi: AVANCADO',0,'2025-07-07 00:28:11.821111','/nivelamento/resultado/5/',6),(50,'📥 Novo comprovativo de pagamento submetido para o curso \'Inglês\' por Natacha Sabi',0,'2025-07-07 06:35:43.640858','/painel-admin/',1),(51,'📨 Comprovativo de pagamento submetido com sucesso. Aguarde validação.',0,'2025-07-07 06:35:44.946465','/painel_aluno/',6),(52,'❌ Pagamento recusado. Corrija e tente novamente.',0,'2025-07-07 12:37:16.470215','/painel_aluno/',6),(53,'❌ Pagamento recusado. Corrija e tente novamente.',0,'2025-07-07 12:39:12.463499','/painel_aluno/',6),(54,'✅ Matrícula aprovada e alocado na sala \'Flowers\'',0,'2025-07-07 12:53:36.949100','/painel_aluno/',6),(55,'✅ Matrícula aprovada e alocado na sala \'Flowers\'',0,'2025-07-07 12:53:52.120941','/painel_aluno/',6),(56,'❌ Pagamento recusado. Corrija e tente novamente.',0,'2025-07-07 12:53:58.236785','/painel_aluno/',6),(57,'❌ Pagamento recusado. Corrija e tente novamente.',0,'2025-07-07 12:56:24.267814','/painel_aluno/',6),(58,'✅ Matrícula aprovada e alocado na sala \'Flowers\'',0,'2025-07-07 12:56:35.373694','/painel_aluno/',6),(59,'📚 Um novo curso \'Mandarirn\' foi criado e já está disponível para matrícula.',0,'2025-07-08 02:44:53.343581','/painel-salas/',1),(60,'📚 Um novo curso \'Mandarirn\' foi criado e já está disponível para matrícula.',0,'2025-07-08 02:44:53.691236','/painel-salas/',3),(61,'📚 Um novo curso \'Mandarirn\' foi criado e já está disponível para matrícula.',0,'2025-07-08 02:44:53.938683','/painel_aluno/',4),(62,'📚 Um novo curso \'Mandarirn\' foi criado e já está disponível para matrícula.',0,'2025-07-08 02:44:54.105256','/painel-salas/',5),(63,'📚 Um novo curso \'Mandarirn\' foi criado e já está disponível para matrícula.',0,'2025-07-08 02:44:54.315183','/painel_aluno/',6),(64,'📚 Um novo curso \'Mandarirn 2\' foi criado e já está disponível para matrícula.',0,'2025-07-08 03:29:23.312888','/painel-salas/',1),(65,'📚 Um novo curso \'Mandarirn 2\' foi criado e já está disponível para matrícula.',0,'2025-07-08 03:29:23.564858','/painel-salas/',3),(66,'📚 Um novo curso \'Mandarirn 2\' foi criado e já está disponível para matrícula.',0,'2025-07-08 03:29:23.790882','/painel_aluno/',4),(67,'📚 Um novo curso \'Mandarirn 2\' foi criado e já está disponível para matrícula.',0,'2025-07-08 03:29:24.024802','/painel-salas/',5),(68,'📚 Um novo curso \'Mandarirn 2\' foi criado e já está disponível para matrícula.',0,'2025-07-08 03:29:24.366763','/painel_aluno/',6),(69,'🔧 O curso \'Mandarirn 3\' foi atualizado, confira as novidades.',0,'2025-07-08 03:30:01.082352','/painel-salas/',1),(70,'🔧 O curso \'Mandarirn 3\' foi atualizado, confira as novidades.',0,'2025-07-08 03:30:01.871209','/painel-salas/',3),(71,'🔧 O curso \'Mandarirn 3\' foi atualizado, confira as novidades.',0,'2025-07-08 03:30:02.359083','/painel_aluno/',4),(72,'🔧 O curso \'Mandarirn 3\' foi atualizado, confira as novidades.',0,'2025-07-08 03:30:02.617047','/painel-salas/',5),(73,'🔧 O curso \'Mandarirn 3\' foi atualizado, confira as novidades.',0,'2025-07-08 03:30:02.924015','/painel_aluno/',6),(74,'⚠️ O curso \'Mandarirn 3\' foi removido da plataforma.',0,'2025-07-08 03:30:23.769456','/painel-salas/',1),(75,'⚠️ O curso \'Mandarirn 3\' foi removido da plataforma.',0,'2025-07-08 03:30:23.951427','/painel-salas/',3),(76,'⚠️ O curso \'Mandarirn 3\' foi removido da plataforma.',0,'2025-07-08 03:30:24.110411','/painel_aluno/',4),(77,'⚠️ O curso \'Mandarirn 3\' foi removido da plataforma.',0,'2025-07-08 03:30:24.267396','/painel-salas/',5),(78,'⚠️ O curso \'Mandarirn 3\' foi removido da plataforma.',0,'2025-07-08 03:30:24.452425','/painel_aluno/',6),(79,'👨‍🏫 Foste atribuído(a) à sala \'Ligth\' para o curso Mandarirn.',0,'2025-07-08 03:31:38.761868','/painel-salas/',1),(80,'🔧 O curso \'Inglês\' foi atualizado, confira as novidades.',0,'2025-07-08 13:05:15.061455','/painel-salas/',1),(81,'🔧 O curso \'Inglês\' foi atualizado, confira as novidades.',0,'2025-07-08 13:05:15.537762','/painel-salas/',3),(82,'🔧 O curso \'Inglês\' foi atualizado, confira as novidades.',0,'2025-07-08 13:05:15.879042','/painel_aluno/',4),(83,'🔧 O curso \'Inglês\' foi atualizado, confira as novidades.',0,'2025-07-08 13:05:15.986702','/painel-salas/',5),(84,'🔧 O curso \'Inglês\' foi atualizado, confira as novidades.',0,'2025-07-08 13:05:16.188167','/painel_aluno/',6),(85,'🔧 O curso \'Português\' foi atualizado, confira as novidades.',0,'2025-07-08 13:06:03.999209','/painel-salas/',1),(86,'🔧 O curso \'Português\' foi atualizado, confira as novidades.',0,'2025-07-08 13:06:04.305400','/painel-salas/',3),(87,'🔧 O curso \'Português\' foi atualizado, confira as novidades.',0,'2025-07-08 13:06:04.476694','/painel_aluno/',4),(88,'🔧 O curso \'Português\' foi atualizado, confira as novidades.',0,'2025-07-08 13:06:04.672812','/painel-salas/',5),(89,'🔧 O curso \'Português\' foi atualizado, confira as novidades.',0,'2025-07-08 13:06:04.905086','/painel_aluno/',6),(90,'⚠️ O curso \'Mandarirn\' foi removido da plataforma.',0,'2025-07-08 13:06:47.932083','/painel-salas/',1),(91,'⚠️ O curso \'Mandarirn\' foi removido da plataforma.',0,'2025-07-08 13:06:48.549532','/painel-salas/',3),(92,'⚠️ O curso \'Mandarirn\' foi removido da plataforma.',0,'2025-07-08 13:06:48.791617','/painel_aluno/',4),(93,'⚠️ O curso \'Mandarirn\' foi removido da plataforma.',0,'2025-07-08 13:06:48.974971','/painel-salas/',5),(94,'⚠️ O curso \'Mandarirn\' foi removido da plataforma.',0,'2025-07-08 13:06:49.122717','/painel_aluno/',6),(95,'👨‍🏫 Foste atribuído(a) à sala \'White Ligth\' para o curso Inglês.',0,'2025-07-08 13:08:45.584982','/painel-salas/',1),(96,'❌ Aula cancelada: \'Aula 3\' foi removida da sala \'Sky\'.',0,'2025-07-08 13:31:05.176975','/aulas/painel/aluno/',6),(97,'🧠 Teste de nível finalizado! Teu nível atribuído para o curso \'Inglês\' foi: INTERMEDIO',0,'2025-07-08 15:28:16.514660','/nivelamento/resultado/6/',6),(98,'💳 Novo pagamento enviado para o curso Inglês (Inglês | 30 minutos | 1 vez por semana - 8000.00 Kz)',0,'2025-07-08 21:50:40.219613','/nivelamento/pedidos/',1),(99,'✅ Matrícula aprovada e alocado na sala \'Flowers\'',0,'2025-07-08 21:55:49.337789','/painel_aluno/',6),(100,'🧠 Teste de nível finalizado! Teu nível atribuído para o curso \'Inglês\' foi: INTERMEDIO',0,'2025-07-09 00:32:24.502201','/nivelamento/resultado/7/',6),(101,'💳 Novo pagamento enviado para o curso Inglês (Inglês | 30 minutos | 2 vezes por semana - 16000.00 Kz)',0,'2025-07-09 00:33:46.912023','/nivelamento/pedidos/',1),(102,'✅ Matrícula aprovada e alocado na sala \'Flowers\'',0,'2025-07-09 00:34:58.432888','/painel_aluno/',6),(103,'❌ A sala \'Flowers\' atribuída a ti foi excluída pelo administrador.',0,'2025-07-09 00:38:31.689715','/painel-salas/',3),(104,'⚠️ A sala \'Flowers\' onde estavas matriculado foi excluída.',0,'2025-07-09 00:38:32.090744','/painel_aluno/',6),(105,'❌ A sala \'White Ligth\' atribuída a ti foi excluída pelo administrador.',0,'2025-07-09 00:40:46.878083','/painel-salas/',1),(106,'👨‍🏫 Foste atribuído(a) à sala \'Godness\' para o curso Inglês.',0,'2025-07-09 00:41:38.934596','/painel-salas/',1),(107,'🧠 Teste de nível finalizado! Teu nível atribuído para o curso \'Inglês\' foi: INTERMEDIO',0,'2025-07-09 00:42:39.354558','/nivelamento/resultado/8/',6),(108,'💳 Novo pagamento enviado para o curso Inglês (Inglês | 1 hora | 1 vez por semana - 10000.00 Kz)',0,'2025-07-09 00:43:23.923761','/nivelamento/pedidos/',1),(109,'✅ Matrícula aprovada e alocado na sala \'Godness\'',0,'2025-07-09 00:43:49.939712','/painel_aluno/',6),(110,'📢 Nova aula criada: \'Aula2\' na sala \'Sky\'.',0,'2025-07-09 14:07:13.659993','/aulas/painel/aluno/',6);
/*!40000 ALTER TABLE `notificacoes_notificacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser`
--

DROP TABLE IF EXISTS `users_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_customuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto_perfil` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` longtext COLLATE utf8mb4_unicode_ci,
  `categoria` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `grau_academico` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `especialidade` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_acesso` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser`
--

LOCK TABLES `users_customuser` WRITE;
/*!40000 ALTER TABLE `users_customuser` DISABLE KEYS */;
INSERT INTO `users_customuser` VALUES (1,'pbkdf2_sha256$1000000$Gk90wABHLTRanVcBA40c61$mOzGsIv6O1XqtcJH3xe7EgFtEyu3wRHawF8ClwNzhgA=','2025-06-30 22:50:36.870997',1,'Given1995','Cláudia','Sabi',1,1,'2025-06-20 22:47:31.000000','estevaolumingo@gmail.com','',NULL,'','professor','universitario','Ensino da língua inglesa','disponivel','admin',1),(3,'pbkdf2_sha256$1000000$qKhImUdlT8mrBmBYOW9cAk$rHQD2IeYwpz7N13WyXVGiGD/p6XkzzJBQklFXwJVgUo=','2025-06-21 14:22:43.995534',0,'Lumingu_M','Lumingu','Estevão Macundi',0,1,'2025-06-21 14:09:47.822035','lumingoestevao-m@hotmail.com','',NULL,NULL,'professor','licenciado','Engenharia de Software','disponivel','professor',0),(4,'pbkdf2_sha256$1000000$oA3zosa6XNk4vvtFqy0lWH$MVa2yuXQJsmjE0WtymtB+kKfEUFsfxH5unJj3aceSck=',NULL,0,'Jorge_Manuel','Jorge','Manuel',0,1,'2025-06-30 13:59:44.784348','JorgeManuel@gmail.com','',NULL,NULL,'estudante','universitario','','disponivel','padrao',0),(5,'pbkdf2_sha256$1000000$0m0z9bheA6EqjIXhWfNoB9$6ye+tK2WpSFmA6JjKDqOiuhcoN2pbH8SSIgahtLQ3a4=','2025-06-30 22:44:01.772394',1,'Macundi','','',1,1,'2025-06-30 22:42:48.243303','macundi@gmail.com','',NULL,NULL,'','',NULL,'disponivel','padrao',0),(6,'pbkdf2_sha256$1000000$Gu0uMhLMBmLo0fTRt4Fe9l$XGAR97ABJgIUpZovmiVtTR/i5bmDjKHg3TZjRpEO8u0=','2025-07-01 03:17:22.283985',0,'Natacha1','Natacha','Ndoji',0,1,'2025-07-01 03:17:14.516183','natachasabi@gmail.com','fotos_perfil/Imagem_WhatsApp_2025-07-07_às_19.11.16_5aa7723d.jpg',NULL,'','estudante','licenciado',NULL,'disponivel','padrao',0);
/*!40000 ALTER TABLE `users_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser_groups`
--

DROP TABLE IF EXISTS `users_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_customuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_customuser_groups_customuser_id_group_id_76b619e3_uniq` (`customuser_id`,`group_id`),
  KEY `users_customuser_groups_group_id_01390b14_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_customuser_gro_customuser_id_958147bf_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `users_customuser_groups_group_id_01390b14_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser_groups`
--

LOCK TABLES `users_customuser_groups` WRITE;
/*!40000 ALTER TABLE `users_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser_user_permissions`
--

DROP TABLE IF EXISTS `users_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_customuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_customuser_user_pe_customuser_id_permission_7a7debf6_uniq` (`customuser_id`,`permission_id`),
  KEY `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_customuser_use_customuser_id_5771478b_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser_user_permissions`
--

LOCK TABLES `users_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_customuser_user_permissions` DISABLE KEYS */;
INSERT INTO `users_customuser_user_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45),(46,1,46),(47,1,47),(48,1,48),(49,1,49),(50,1,50),(51,1,51),(52,1,52),(53,1,53),(54,1,54),(55,1,55),(56,1,56),(57,1,57),(58,1,58),(59,1,59),(60,1,60),(61,1,61),(62,1,62),(63,1,63),(64,1,64),(65,1,65),(66,1,66),(67,1,67),(68,1,68),(69,1,69),(70,1,70),(71,1,71),(72,1,72);
/*!40000 ALTER TABLE `users_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-09 17:03:14
