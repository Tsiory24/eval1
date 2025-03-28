
DROP TABLE IF EXISTS `absences`;

CREATE TABLE `absences` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `reason` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `start_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `medical_certificate` tinyint(1) DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `absences_user_id_foreign` (`user_id`),
  CONSTRAINT `absences_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


LOCK TABLES `absences` WRITE;

UNLOCK TABLES;



DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `log_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `causer_id` bigint(20) unsigned DEFAULT NULL,
  `causer_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `source_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `source_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `properties` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` bigint(20) unsigned DEFAULT NULL,
  `color` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `client_id` int(10) unsigned DEFAULT NULL,
  `start_at` timestamp NULL DEFAULT NULL,
  `end_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appointments_source_type_source_id_index` (`source_type`,`source_id`),
  KEY `appointments_user_id_foreign` (`user_id`),
  KEY `appointments_client_id_foreign` (`client_id`),
  CONSTRAINT `appointments_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_hours`
--

DROP TABLE IF EXISTS `business_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_hours` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `day` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `open_time` time DEFAULT NULL,
  `close_time` time DEFAULT NULL,
  `settings_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `business_hours_settings_id_foreign` (`settings_id`),
  CONSTRAINT `business_hours_settings_id_foreign` FOREIGN KEY (`settings_id`) REFERENCES `settings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_hours`
--

LOCK TABLES `business_hours` WRITE;
/*!40000 ALTER TABLE `business_hours` DISABLE KEYS */;
INSERT INTO `business_hours` VALUES (1,'monday','09:00:00','18:00:00',1,'2025-03-21 17:39:59','2025-03-21 17:39:59'),(2,'tuesday','09:00:00','18:00:00',1,'2025-03-21 17:39:59','2025-03-21 17:39:59'),(3,'wednesday','09:00:00','18:00:00',1,'2025-03-21 17:39:59','2025-03-21 17:39:59'),(4,'thursday','09:00:00','18:00:00',1,'2025-03-21 17:39:59','2025-03-21 17:39:59'),(5,'friday','09:00:00','18:00:00',1,'2025-03-21 17:39:59','2025-03-21 17:39:59'),(6,'saturday','09:00:00','18:00:00',1,'2025-03-21 17:39:59','2025-03-21 17:39:59'),(7,'sunday','09:00:00','18:00:00',1,'2025-03-21 17:39:59','2025-03-21 17:39:59');
/*!40000 ALTER TABLE `business_hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `vat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `client_number` bigint(20) DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `industry_id` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clients_user_id_foreign` (`user_id`),
  KEY `clients_industry_id_foreign` (`industry_id`),
  CONSTRAINT `clients_industry_id_foreign` FOREIGN KEY (`industry_id`) REFERENCES `industries` (`id`),
  CONSTRAINT `clients_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `source_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `source_id` bigint(20) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_source_type_source_id_index` (`source_type`,`source_id`),
  KEY `comments_user_id_foreign` (`user_id`),
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `primary_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `secondary_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `is_primary` tinyint(1) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contacts_client_id_foreign` (`client_id`),
  CONSTRAINT `contacts_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_user`
--

DROP TABLE IF EXISTS `department_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `department_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `department_user_department_id_foreign` (`department_id`),
  KEY `department_user_user_id_foreign` (`user_id`),
  CONSTRAINT `department_user_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `department_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_user`
--

LOCK TABLES `department_user` WRITE;
/*!40000 ALTER TABLE `department_user` DISABLE KEYS */;
INSERT INTO `department_user` VALUES (1,1,1,NULL,NULL),(2,1,2,NULL,NULL),(3,1,3,NULL,NULL),(4,1,4,NULL,NULL),(5,1,5,NULL,NULL),(6,1,6,NULL,NULL),(7,1,7,NULL,NULL),(8,1,8,NULL,NULL),(9,1,9,NULL,NULL),(10,1,10,NULL,NULL),(11,1,11,NULL,NULL),(12,1,12,NULL,NULL),(13,1,13,NULL,NULL),(14,1,14,NULL,NULL),(15,1,15,NULL,NULL),(16,1,16,NULL,NULL),(17,1,17,NULL,NULL),(18,1,18,NULL,NULL),(19,1,19,NULL,NULL),(20,1,20,NULL,NULL),(21,1,21,NULL,NULL),(22,1,22,NULL,NULL),(23,1,23,NULL,NULL),(24,1,24,NULL,NULL),(25,1,25,NULL,NULL),(26,1,26,NULL,NULL),(27,1,27,NULL,NULL),(28,1,28,NULL,NULL),(29,1,29,NULL,NULL),(30,1,30,NULL,NULL),(31,1,31,NULL,NULL),(32,1,32,NULL,NULL),(33,1,33,NULL,NULL),(34,1,34,NULL,NULL),(35,1,35,NULL,NULL),(36,1,36,NULL,NULL),(37,1,37,NULL,NULL),(38,1,38,NULL,NULL),(39,1,39,NULL,NULL),(40,1,40,NULL,NULL),(41,1,41,NULL,NULL),(42,1,42,NULL,NULL),(43,1,43,NULL,NULL),(44,1,44,NULL,NULL),(45,1,45,NULL,NULL),(46,1,46,NULL,NULL),(47,1,47,NULL,NULL),(48,1,48,NULL,NULL),(49,1,49,NULL,NULL),(50,1,50,NULL,NULL),(51,1,51,NULL,NULL),(52,1,52,NULL,NULL),(53,1,53,NULL,NULL),(54,1,54,NULL,NULL),(55,1,55,NULL,NULL),(56,1,56,NULL,NULL),(57,1,57,NULL,NULL),(58,1,58,NULL,NULL),(59,1,59,NULL,NULL),(60,1,60,NULL,NULL),(61,1,61,NULL,NULL),(62,1,62,NULL,NULL),(63,1,63,NULL,NULL),(64,1,64,NULL,NULL),(65,1,65,NULL,NULL),(66,1,66,NULL,NULL),(67,1,67,NULL,NULL),(68,1,68,NULL,NULL),(69,1,69,NULL,NULL),(70,1,70,NULL,NULL),(71,1,71,NULL,NULL),(72,1,72,NULL,NULL),(73,1,73,NULL,NULL),(74,1,74,NULL,NULL),(75,1,75,NULL,NULL),(76,1,76,NULL,NULL),(77,1,77,NULL,NULL),(78,1,78,NULL,NULL),(79,1,79,NULL,NULL),(80,1,80,NULL,NULL),(81,1,81,NULL,NULL),(82,1,82,NULL,NULL),(83,1,83,NULL,NULL),(84,1,84,NULL,NULL),(85,1,85,NULL,NULL),(86,1,86,NULL,NULL),(87,1,87,NULL,NULL),(88,1,88,NULL,NULL),(89,1,89,NULL,NULL),(90,1,90,NULL,NULL),(91,1,91,NULL,NULL),(92,1,92,NULL,NULL),(93,1,93,NULL,NULL),(94,1,94,NULL,NULL),(95,1,95,NULL,NULL),(96,1,96,NULL,NULL),(97,1,97,NULL,NULL),(98,1,98,NULL,NULL),(99,1,99,NULL,NULL),(100,1,100,NULL,NULL),(101,1,101,NULL,NULL),(102,1,102,NULL,NULL),(103,1,103,NULL,NULL),(104,1,104,NULL,NULL),(105,1,105,NULL,NULL),(106,1,106,NULL,NULL),(107,1,107,NULL,NULL),(108,1,108,NULL,NULL),(109,1,109,NULL,NULL),(110,1,110,NULL,NULL),(111,1,111,NULL,NULL),(112,1,112,NULL,NULL),(113,1,113,NULL,NULL),(114,1,114,NULL,NULL),(115,1,115,NULL,NULL),(116,1,116,NULL,NULL);
/*!40000 ALTER TABLE `department_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'7624b2e9-8683-46df-bd7d-5d185414cbd7','Management',NULL,'2025-03-21 17:39:59','2025-03-21 17:39:59'),(2,'42ba600e-83d1-458e-9a77-57a79c039c78','Nerds',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(3,'a5b07c27-eb5f-4466-9370-5870a1ff2cca','Genius',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `size` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `original_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mime` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `integration_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `integration_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `source_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `source_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_source_type_source_id_index` (`source_type`,`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `industries`
--

DROP TABLE IF EXISTS `industries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `industries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `industries`
--

LOCK TABLES `industries` WRITE;
/*!40000 ALTER TABLE `industries` DISABLE KEYS */;
INSERT INTO `industries` VALUES (1,'f039b8d2-1f54-4480-b340-bca9e0885aa9','Accommodations'),(2,'bdcb3d48-7483-4ca1-b443-db175d950150','Accounting'),(3,'93587dfd-3648-4859-b953-3f71fbfaefbb','Auto'),(4,'db7e1687-2453-40c8-b369-37a450ae1768','Beauty & Cosmetics'),(5,'8fc10e71-f417-48d3-a728-4e58e08958ad','Carpenter'),(6,'f92b00dc-d455-4f18-aa3d-957f79f589ca','Communications'),(7,'bbff23a0-0e56-4f91-9a24-20c4739dadd4','Computer & IT'),(8,'4269d0c4-b994-4e8a-90c6-44f6a26c23dd','Construction'),(9,'538abc94-9557-473a-9290-0d475fff1548','Consulting'),(10,'89c4c0be-c827-4d95-8e45-25deef4e7fec','Education'),(11,'6516136a-95bc-4d34-b848-c4c02cd24bdc','Electronics'),(12,'ed970244-7432-4eac-929d-2bb611e1e360','Entertainment'),(13,'1bb5f1b8-dceb-4d4a-a60c-30c58d1570a6','Food & Beverages'),(14,'2745498a-5640-4cb3-97d7-839329499935','Legal Services'),(15,'7004b433-55b6-43e1-95b2-200369300994','Marketing'),(16,'f9a42a41-7d7c-4cd3-9ee6-7a6d9682b8dc','Real Estate'),(17,'43f8b782-67ff-4653-8b89-1dd805615769','Retail'),(18,'1decc650-05e5-4a1d-a5ce-c466ea187805','Sports'),(19,'34b83525-687a-4801-b6eb-65d54fa8831c','Technology'),(20,'b5f7470e-54cc-42e3-9903-76d47fe5eab2','Tourism'),(21,'ace5078f-c5af-435b-9eb8-d6ae552be31f','Transportation'),(22,'49f65999-a18d-456d-811e-5140764c4141','Travel'),(23,'38fa0ce8-e224-4873-840d-31e03a16b887','Utilities'),(24,'16609abb-602f-4d5d-9764-1dc728ffb159','Web Services'),(25,'7d42a977-060e-4b67-82c2-b55bde685522','Other');
/*!40000 ALTER TABLE `industries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integrations`
--

DROP TABLE IF EXISTS `integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_secret` int(11) DEFAULT NULL,
  `api_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `api_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `org_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrations`
--

LOCK TABLES `integrations` WRITE;
/*!40000 ALTER TABLE `integrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `integrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_lines`
--

DROP TABLE IF EXISTS `invoice_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_lines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `invoice_id` int(10) unsigned DEFAULT NULL,
  `offer_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `product_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_lines_offer_id_foreign` (`offer_id`),
  KEY `invoice_lines_invoice_id_foreign` (`invoice_id`),
  CONSTRAINT `invoice_lines_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoice_lines_offer_id_foreign` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_lines`
--

LOCK TABLES `invoice_lines` WRITE;
/*!40000 ALTER TABLE `invoice_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `invoice_number` bigint(20) DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `due_at` datetime DEFAULT NULL,
  `integration_invoice_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `integration_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `offer_id` int(10) unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoices_client_id_foreign` (`client_id`),
  KEY `invoices_source_type_source_id_index` (`source_type`,`source_id`),
  KEY `invoices_offer_id_foreign` (`offer_id`),
  CONSTRAINT `invoices_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoices_offer_id_foreign` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leads`
--

DROP TABLE IF EXISTS `leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `user_assigned_id` int(10) unsigned NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `user_created_id` int(10) unsigned NOT NULL,
  `qualified` tinyint(1) NOT NULL DEFAULT '0',
  `result` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deadline` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `leads_status_id_foreign` (`status_id`),
  KEY `leads_user_assigned_id_foreign` (`user_assigned_id`),
  KEY `leads_client_id_foreign` (`client_id`),
  KEY `leads_user_created_id_foreign` (`user_created_id`),
  KEY `leads_qualified_index` (`qualified`),
  CONSTRAINT `leads_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `leads_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  CONSTRAINT `leads_user_assigned_id_foreign` FOREIGN KEY (`user_assigned_id`) REFERENCES `users` (`id`),
  CONSTRAINT `leads_user_created_id_foreign` FOREIGN KEY (`user_created_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leads`
--

LOCK TABLES `leads` WRITE;
/*!40000 ALTER TABLE `leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `leads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mails`
--

DROP TABLE IF EXISTS `mails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mails` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `send_at` timestamp NULL DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mails_user_id_foreign` (`user_id`),
  CONSTRAINT `mails_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mails`
--

LOCK TABLES `mails` WRITE;
/*!40000 ALTER TABLE `mails` DISABLE KEYS */;
/*!40000 ALTER TABLE `mails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2015_06_04_124835_create_industries_table',1),(4,'2015_10_15_143830_create_status_table',1),(5,'2015_12_28_163028_create_clients_table',1),(6,'2015_12_29_154026_create_invocies_table',1),(7,'2015_12_29_204031_projects_table',1),(8,'2015_12_29_204031_tasks_table',1),(9,'2016_01_10_204413_create_comments_table',1),(10,'2016_01_18_113656_create_leads_table',1),(11,'2016_01_23_144854_settings',1),(12,'2016_01_26_003903_documents',1),(13,'2016_01_31_211926_invoice_lines_table',1),(14,'2016_03_21_171847_create_department_table',1),(15,'2016_03_21_172416_create_department_user_table',1),(16,'2016_04_06_230504_integrations',1),(17,'2016_05_21_205532_create_activities_table',1),(18,'2016_08_26_205017_entrust_setup_tables',1),(19,'2016_11_04_200855_create_notifications_table',1),(20,'2017_10_28_131549_create_contacts_table',1),(21,'2019_05_03_000001_create_customer_columns',1),(22,'2019_05_03_000002_create_subscriptions_table',1),(23,'2019_11_29_092917_add_vat_and_currency',1),(24,'2019_11_29_111929_add_invoice_number_to_invoice',1),(25,'2019_12_09_201950_create_mails_table',1),(26,'2019_12_19_200049_add_billing_integration_id_to_invoices',1),(27,'2020_01_06_203615_create_payments_table',1),(28,'2020_01_10_120239_create_credit_notes_table',1),(29,'2020_01_10_121248_create_credit_lines_table',1),(30,'2020_01_28_195156_add_language_options',1),(31,'2020_02_20_192015_alter_leads_table_support_qualified',1),(32,'2020_03_30_163030_create_appointments_table',1),(33,'2020_04_06_075838_create_business_hours_table',1),(34,'2020_04_08_070242_create_absences_table',1),(35,'2020_05_09_113503_add_cascading_for_tables',1),(36,'2020_09_29_173256_add_soft_delete_to_tables',1),(37,'2021_01_09_102659_add_cascading_for_appointments',1),(38,'2021_02_10_153102_create_offers_table',1),(39,'2021_02_11_161257_alter_invoices_table_add_source',1),(40,'2021_02_11_162602_create_products_table',1),(41,'2021_03_02_132033_alter_comments_table_add_long_text',1),(42,'2021_04_15_073908_remove_qualified_from_leads',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text COLLATE utf8_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sent_at` datetime DEFAULT NULL,
  `source_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `offers_source_type_source_id_index` (`source_type`,`source_id`),
  KEY `offers_client_id_foreign` (`client_id`),
  CONSTRAINT `offers_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `amount` int(11) NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payment_source` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payment_date` date NOT NULL,
  `integration_payment_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `integration_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `invoice_id` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_invoice_id_foreign` (`invoice_id`),
  CONSTRAINT `payments_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_role`
--

DROP TABLE IF EXISTS `permission_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_role` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_role_id_foreign` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_role`
--

LOCK TABLES `permission_role` WRITE;
/*!40000 ALTER TABLE `permission_role` DISABLE KEYS */;
INSERT INTO `permission_role` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(41,1),(1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),(10,2),(11,2),(12,2),(13,2),(14,2),(15,2),(16,2),(17,2),(18,2),(19,2),(20,2),(21,2),(22,2),(23,2),(24,2),(25,2),(26,2),(27,2),(28,2),(29,2),(30,2),(31,2),(32,2),(33,2),(34,2),(35,2),(36,2),(37,2),(38,2),(39,2),(40,2),(41,2);
/*!40000 ALTER TABLE `permission_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `grouping` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'','payment-create','Add payment','Be able to add a new payment on a invoice','payment','2025-03-21 17:39:58','2025-03-21 17:39:58'),(2,'','payment-delete','Delete payment','Be able to delete a payment','payment','2025-03-21 17:39:58','2025-03-21 17:39:58'),(3,'','calendar-view','View calendar','Be able to view the calendar for appointments','appointment','2025-03-21 17:39:58','2025-03-21 17:39:58'),(4,'','appointment-create','Add appointment','Be able to create a new appointment for a user','appointment','2025-03-21 17:39:58','2025-03-21 17:39:58'),(5,'','appointment-edit','Edit appointment','Be able to edit appointment such as times and title','appointment','2025-03-21 17:39:58','2025-03-21 17:39:58'),(6,'','appointment-delete','Delete appointment','Be able to delete an appointment','appointment','2025-03-21 17:39:58','2025-03-21 17:39:58'),(7,'','absence-manage','Manage absences','Be able to manage absences for all users','hr','2025-03-21 17:39:58','2025-03-21 17:39:58'),(8,'','absence-view','View absences','Be able to view absences for all users and see who is absent today on the dashboard','hr','2025-03-21 17:39:58','2025-03-21 17:39:58'),(9,'','offer-create','Add offer','Be able to create an offer','offer','2025-03-21 17:39:59','2025-03-21 17:39:59'),(10,'','offer-edit','Edit offer','Be able to edit an offer','offer','2025-03-21 17:39:59','2025-03-21 17:39:59'),(11,'','offer-delete','Delete offer','Be able to delete an offer','offer','2025-03-21 17:39:59','2025-03-21 17:39:59'),(12,'','product-create','Add product','Be able to create an product','product','2025-03-21 17:39:59','2025-03-21 17:39:59'),(13,'','product-edit','Edit product','Be able to edit an product','product','2025-03-21 17:39:59','2025-03-21 17:39:59'),(14,'','product-delete','Delete product','Be able to delete an product','product','2025-03-21 17:39:59','2025-03-21 17:39:59'),(15,'','user-create','Create user','Be able to create a new user','user','2025-03-21 17:39:59','2025-03-21 17:39:59'),(16,'','user-update','Update user','Be able to update a user\'s information','user','2025-03-21 17:39:59','2025-03-21 17:39:59'),(17,'','user-delete','Delete user','Be able to delete a user','user','2025-03-21 17:39:59','2025-03-21 17:39:59'),(18,'','client-create','Create client','Permission to create client','client','2025-03-21 17:39:59','2025-03-21 17:39:59'),(19,'','client-update','Update client','Permission to update client','client','2025-03-21 17:39:59','2025-03-21 17:39:59'),(20,'','client-delete','Delete client','Permission to delete client','client','2025-03-21 17:39:59','2025-03-21 17:39:59'),(21,'','document-delete','Delete document','Permission to delete a document associated with a client','document','2025-03-21 17:39:59','2025-03-21 17:39:59'),(22,'','document-upload','Upload document','Be able to upload a document associated with a client','document','2025-03-21 17:39:59','2025-03-21 17:39:59'),(23,'','task-create','Create task','Permission to create task','task','2025-03-21 17:39:59','2025-03-21 17:39:59'),(24,'','task-update-status','Update task status','Permission to update task status','task','2025-03-21 17:39:59','2025-03-21 17:39:59'),(25,'','task-update-deadline','Change task deadline','Permission to update a tasks deadline','task','2025-03-21 17:39:59','2025-03-21 17:39:59'),(26,'','can-assign-new-user-to-task','Change assigned user','Permission to change the assigned user on a task','task','2025-03-21 17:39:59','2025-03-21 17:39:59'),(27,'','task-update-linked-project','Changed linked project','Be able to change the project which is linked to a task','task','2025-03-21 17:39:59','2025-03-21 17:39:59'),(28,'','task-upload-files','Upload files to task','Allowed to upload files for a task','task','2025-03-21 17:39:59','2025-03-21 17:39:59'),(29,'','modify-invoice-lines','Modify invoice lines on a invoice / task','Permission to create and update invoice lines on task, and invoices','invoice','2025-03-21 17:39:59','2025-03-21 17:39:59'),(30,'','invoice-see','See invoices and it\'s invoice lines','Permission to see invoices on customer, and it\'s associated task','invoice','2025-03-21 17:39:59','2025-03-21 17:39:59'),(31,'','invoice-send','Send invoices to clients','Be able to set an invoice as send to an customer (Or Send it if billing integration is active)','invoice','2025-03-21 17:39:59','2025-03-21 17:39:59'),(32,'','invoice-pay','Set an invoice as paid','Be able to set an invoice as paid or not paid','invoice','2025-03-21 17:39:59','2025-03-21 17:39:59'),(33,'','lead-create','Create lead','Permission to create lead','lead','2025-03-21 17:39:59','2025-03-21 17:39:59'),(34,'','lead-update-status','Update lead status','Permission to update lead status','lead','2025-03-21 17:39:59','2025-03-21 17:39:59'),(35,'','lead-update-deadline','Change lead deadline','Permission to update a lead deadline','lead','2025-03-21 17:39:59','2025-03-21 17:39:59'),(36,'','can-assign-new-user-to-lead','Change assigned user','Permission to change the assigned user on a lead','lead','2025-03-21 17:39:59','2025-03-21 17:39:59'),(37,'','project-create','Create project','Permission to create project','project','2025-03-21 17:39:59','2025-03-21 17:39:59'),(38,'','project-update-status','Update project status','Permission to update project status','project','2025-03-21 17:39:59','2025-03-21 17:39:59'),(39,'','project-update-deadline','Change project deadline','Permission to update a projects deadline','project','2025-03-21 17:39:59','2025-03-21 17:39:59'),(40,'','can-assign-new-user-to-project','Change assigned user','Permission to change the assigned user on a project','project','2025-03-21 17:39:59','2025-03-21 17:39:59'),(41,'','project-upload-files','Upload files to project','Allowed to upload files for a project','project','2025-03-21 17:39:59','2025-03-21 17:39:59');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `default_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `archived` tinyint(1) NOT NULL,
  `integration_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `integration_id` bigint(20) unsigned DEFAULT NULL,
  `price` int(11) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_integration_type_integration_id_index` (`integration_type`,`integration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `user_assigned_id` int(10) unsigned NOT NULL,
  `user_created_id` int(10) unsigned NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `invoice_id` int(10) unsigned DEFAULT NULL,
  `deadline` date NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_status_id_foreign` (`status_id`),
  KEY `projects_user_assigned_id_foreign` (`user_assigned_id`),
  KEY `projects_user_created_id_foreign` (`user_created_id`),
  KEY `projects_client_id_foreign` (`client_id`),
  KEY `projects_invoice_id_foreign` (`invoice_id`),
  CONSTRAINT `projects_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `projects_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`),
  CONSTRAINT `projects_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  CONSTRAINT `projects_user_assigned_id_foreign` FOREIGN KEY (`user_assigned_id`) REFERENCES `users` (`id`),
  CONSTRAINT `projects_user_created_id_foreign` FOREIGN KEY (`user_created_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_user` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_user_role_id_foreign` (`role_id`),
  CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_user`
--

LOCK TABLES `role_user` WRITE;
/*!40000 ALTER TABLE `role_user` DISABLE KEYS */;
INSERT INTO `role_user` VALUES (1,1);
/*!40000 ALTER TABLE `role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'91006f69-5d29-4eab-82b9-5acd48366a40','owner','Owner','Owner','2025-03-21 17:39:59','2025-03-21 17:39:59'),(2,'e9caad46-aab3-4cc5-b724-17610c319b02','administrator','Administrator','System Administrator','2025-03-21 17:39:59','2025-03-21 17:39:59'),(3,'b39c3796-4c03-42b8-bad4-581b51851d82','manager','Manager','System Manager','2025-03-21 17:39:59','2025-03-21 17:39:59'),(4,'d0e0b9f6-e819-4f40-8c01-bee0a498ca0f','employee','Employee','Employee','2025-03-21 17:39:59','2025-03-21 17:39:59');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_number` int(11) NOT NULL,
  `invoice_number` int(11) NOT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'USD',
  `vat` smallint(6) NOT NULL DEFAULT '725',
  `max_users` int(11) NOT NULL,
  `language` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'EN',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,10000,10000,'en','Media','USD',725,10,'EN',NULL,NULL);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statuses`
--

DROP TABLE IF EXISTS `statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `source_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '#000000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statuses`
--

LOCK TABLES `statuses` WRITE;
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;
INSERT INTO `statuses` VALUES (1,'f55ab3f7-1377-4909-8fcd-de8420d0d603','Open','App\\Models\\Task','#2FA599','2025-03-21 17:39:59','2025-03-21 17:39:59'),(2,'07cf8898-a032-41ee-96f2-2a9950fd892b','In-progress','App\\Models\\Task','#2FA55E','2025-03-21 17:39:59','2025-03-21 17:39:59'),(3,'16bf77de-af7f-4a13-b355-538446d6f8e6','Pending','App\\Models\\Task','#EFAC57','2025-03-21 17:39:59','2025-03-21 17:39:59'),(4,'a0ead99c-a7e8-4a6f-98c4-c96ab0cca665','Waiting client','App\\Models\\Task','#60C0DC','2025-03-21 17:39:59','2025-03-21 17:39:59'),(5,'a6588980-6105-46ac-9ff7-d5a72652ad0d','Blocked','App\\Models\\Task','#E6733E','2025-03-21 17:39:59','2025-03-21 17:39:59'),(6,'18285e1a-252b-4a8a-a516-94e971f2e4d6','Closed','App\\Models\\Task','#D75453','2025-03-21 17:39:59','2025-03-21 17:39:59'),(7,'065cf21e-21a3-46b7-a627-7b4a68132367','Open','App\\Models\\Lead','#2FA599','2025-03-21 17:39:59','2025-03-21 17:39:59'),(8,'d17cf7bf-5196-4aae-b8b5-20382664b0ed','Pending','App\\Models\\Lead','#EFAC57','2025-03-21 17:39:59','2025-03-21 17:39:59'),(9,'4f795347-8550-4990-bf52-d71ad1d242cb','Waiting client','App\\Models\\Lead','#60C0DC','2025-03-21 17:39:59','2025-03-21 17:39:59'),(10,'e4773ab8-e509-4444-8a04-d5ef55653074','Closed','App\\Models\\Lead','#D75453','2025-03-21 17:39:59','2025-03-21 17:39:59'),(11,'afb87725-8d92-46dc-b213-5c884ccbcac5','Open','App\\Models\\Project','#2FA599','2025-03-21 17:39:59','2025-03-21 17:39:59'),(12,'49ec3c7c-ef38-4e85-92ae-4466f0b27858','In-progress','App\\Models\\Project','#3CA3BA','2025-03-21 17:39:59','2025-03-21 17:39:59'),(13,'08bef826-52a0-4a3a-8ce5-07e531943fdf','Blocked','App\\Models\\Project','#60C0DC','2025-03-21 17:39:59','2025-03-21 17:39:59'),(14,'3702a366-05bf-40e7-a481-65905d12fce6','Cancelled','App\\Models\\Project','#821414','2025-03-21 17:39:59','2025-03-21 17:39:59'),(15,'5236e54b-1c5a-4a80-9ce3-0ab8fb46a0a0','Completed','App\\Models\\Project','#D75453','2025-03-21 17:39:59','2025-03-21 17:39:59');
/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `stripe_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `stripe_status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `stripe_plan` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscriptions_user_id_stripe_status_index` (`user_id`,`stripe_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `user_assigned_id` int(10) unsigned NOT NULL,
  `user_created_id` int(10) unsigned NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `project_id` int(10) unsigned DEFAULT NULL,
  `deadline` date NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_status_id_foreign` (`status_id`),
  KEY `tasks_user_assigned_id_foreign` (`user_assigned_id`),
  KEY `tasks_user_created_id_foreign` (`user_created_id`),
  KEY `tasks_client_id_foreign` (`client_id`),
  KEY `tasks_project_id_foreign` (`project_id`),
  CONSTRAINT `tasks_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tasks_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  CONSTRAINT `tasks_user_assigned_id_foreign` FOREIGN KEY (`user_assigned_id`) REFERENCES `users` (`id`),
  CONSTRAINT `tasks_user_created_id_foreign` FOREIGN KEY (`user_created_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `primary_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `secondary_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'EN',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'35757fb6-9430-4ea6-b4da-3b132240187c','Admin','admin@admin.com','$2y$10$XeS91T0YLmyVoFLbLChgaOV2hI7vqM0dE7Xz0D6rddpmUoPRdly6y','',NULL,NULL,'',NULL,'EN',NULL,'2016-06-04 13:42:19','2016-06-04 13:42:19'),(2,'e14ba2bb-3f38-30ee-a96e-e46a5f028c07','Jaquan Koepp','ukovacek@prosacco.com','$2y$10$u1yXIr.QsQvWKLUjjeBh6ewbJdHF9fMS6jsPtd5fO.0J9NeD6ejlu','Suite 431','4924444','2553600',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(3,'0bb5ff31-9145-352b-aca2-72dff0218059','Keeley O\'Reilly','makenzie37@gmail.com','$2y$10$uaZ8iaGDl6EJbXVig0KMi.GNrfEWXspUD6DE7MGcxPqA8xiC/0qWy','Suite 821','87710615','81031699',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(4,'4ce98e05-774b-3122-a7e3-27f04364a3e0','Aglae Shields','vdamore@gmail.com','$2y$10$JcBb7UkfaHfAYq2OqKTWqeh3p0sK3liD6MKxesR4d/ugeFd4N6qOC','Apt. 331','76400818','91122524',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(5,'e4085cf9-d1bd-3fa7-82ef-4557e43daebb','Ms. Lou Treutel','dfisher@gaylord.com','$2y$10$QSWy2CVsbXGyJMwVL/qN9uoFm9RAHqJnKh98QFtXtq/L4vp2DS96m','Suite 521','26814427','20766554',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(6,'a68f5e06-dcbd-3685-bfcd-6deb36179b85','Vallie Lueilwitz','jenkins.josephine@lueilwitz.com','$2y$10$tJE9eTHTGxAIJv9gnG5uSejr9.YC35jWP4wmdDu3O02b19tkfqDMO','Suite 975','67637639','54230045',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(7,'13e70fca-add7-3338-ae59-01f29ca6d2ff','Miss Alisa Schmeler','cormier.cloyd@yahoo.com','$2y$10$gp2IV9wKXlrDeN/petaFo.avEWOUUf1K.95uv1CgJNkJ0SXZIc.Ai','Suite 585','1170279','49590589',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(8,'05519f73-6263-367d-9593-c4329651b07e','Chelsie Rolfson DDS','mayra27@wolf.info','$2y$10$DO9dthDwsJ02tAXJ71UTTurcyWOl.L658z8OrMPVAmrxxUXgLxh22','Suite 086','54985127','80634079',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(9,'0359e47f-5560-346e-a48c-93f78c8dcfdc','Mr. Laron Franecki V','jackeline66@nicolas.com','$2y$10$1fzwlGuAr2MW.WzAHO1Spe7D2xLWiIQhGfLX0wdt5kZPx.plAjDwq','Suite 788','90506841','28464185',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(10,'5dd6a29e-979a-36b5-9b9f-4759a2379b4d','Mr. Helmer Zboncak','qwill@wyman.com','$2y$10$k2NUBGkG/3uIArhSR0ASXeuq39JRvCCc7RoOL3j2avkkriwHMcn7S','Apt. 196','58837352','74625188',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(11,'c6b527dd-2c50-31d2-a3e3-ed4eac3485a8','Era Nienow','nikko54@yahoo.com','$2y$10$Z56VYsjZRY/xSgOat6h6z.Z06HXdURFvXY4bjaRWKUbEvtsIFnKk.','Suite 821','44131022','15306939',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(12,'85944f9b-c4de-3f1f-9c63-724719edc97b','Christa Turcotte V','estefania.bauch@gmail.com','$2y$10$lTG3PJjaq7W7qw6FDeQ7mu25cfCgVLmMZaOHzj0TYZjANBNeHTB0O','Suite 303','3267034','61789123',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(13,'c1df76ae-833f-369a-8ce8-af7b1affca5e','Leilani Oberbrunner MD','ehilpert@conroy.net','$2y$10$r0BuYuOnyjyMcIuCSXAEU.pdJPEe1wzVEY1niKi6IbKnmWvnyErvm','Apt. 367','88815849','57627985',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(14,'5a074974-7dc6-3fc8-8767-4c4c07c01539','Yasmeen Gaylord','abbie74@hotmail.com','$2y$10$hikL4XJeG8/WfJ3h0eH4juppoiPyvBKPd17Jbq3qfuQcN7EtMA8Pa','Suite 720','64133894','94480818',NULL,NULL,'en',NULL,'2025-03-21 17:40:00','2025-03-21 17:40:00'),(15,'8475753e-a188-3d9b-9602-b01cdaac9e64','Dr. Janet Schmitt','margot.durgan@kunze.com','$2y$10$KKEAWljcSmg9pXwaVq.zCupcASWlMLDi9gNVurnMaFIprWay8vO8C','Suite 882','54493159','48442239',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(16,'ddac585d-8399-3730-a2ed-e3dfbdefb282','Prof. Suzanne Ziemann','ohuels@hotmail.com','$2y$10$omNtLbx01GYQzHU3MIxmQenh9xs4ZoB8CANdxEaDnc14XSyBDpLSy','Apt. 459','70839424','72325348',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(17,'35b2d471-4465-318b-9828-eb991984481f','Thaddeus Hauck','brittany19@lubowitz.com','$2y$10$nObcl5RhL5KdgofMgbEOteq3ul5GzorPg2DH9WtQpkwPcR5AtpbKS','Suite 814','67216','6470638',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(18,'ec3bda45-cb38-3995-b5a9-86aa2152b632','Issac Rohan V','rashad90@quigley.com','$2y$10$mHeOLRrkXJhTvVB0sdQjO.o8WszkOpWRPAj1dHqxX7bPW5zK.SCEK','Suite 735','7842592','78479109',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(19,'b1ebe0eb-780d-3037-ab59-42da11d0044d','Retha Spencer','andreanne.stroman@yahoo.com','$2y$10$NIAaadIKg7eiQmUsKYR.3OsucDU4X3SUVoutaNCo1kHUcGuvf9Z7i','Apt. 374','38453198','9553649',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(20,'76fe33cd-5fc0-3150-9868-f1c3902919b4','Myra Howell','tomas.pagac@parisian.org','$2y$10$qNUrf.2ia/x2EkETbt3e2.mmPbLtEoYXx20aeOwOE7ItfEKzM3rF2','Apt. 102','21447222','78090585',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(21,'28d0a889-6179-3280-b0de-d1dec4983328','Palma Fadel I','isaiah93@yahoo.com','$2y$10$hnuhC8GqdnnPwzXGkKOeA.2GrOR6HeWJuRwNVN2qjuaMnGdcbbUh2','Apt. 448','45533228','81907046',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(22,'83e0adb1-987a-3474-bf2b-e2b298214bcb','Vanessa Lindgren IV','pierce.howell@okuneva.com','$2y$10$qjnI15XYfPBlvSYK3Fx6kueQz1/uGnTGbeqxqfXYnfV76WS5w1HLa','Suite 625','3323238','76420019',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(23,'28ed8480-6616-320e-a4a3-40bbc7c400f8','Ephraim Hartmann','iweimann@hartmann.com','$2y$10$hrwGFjyyuqhox8vf6BYeiu8eBpSTMv/LAqEoOUtPN9g9DKIzJwMhC','Suite 222','12765145','43647792',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(24,'c1ddbd8b-8ece-3ad2-a4fb-5f3e684ed18b','Ansley McGlynn PhD','tromp.maurine@gmail.com','$2y$10$X2SwQK.49RPUAIDGwot4.O0/.Vty/Et2BOULuizWtKN44oNj/I2OO','Apt. 042','37084199','35888006',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(25,'c9bf62e5-73f6-3ce5-b4a7-5942cb31f404','Prof. Thad McLaughlin IV','pcruickshank@mosciski.com','$2y$10$7qJG3OWugk06gdtL.Ogqle/nZDuEfb4K2TdVpKg67lXrZo7I.bXuW','Suite 524','67666382','43396414',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(26,'d0851912-97da-3f91-b8a6-59264bef391d','Rasheed Veum','nicolette64@ledner.info','$2y$10$prOa0uY1nQiXZAZu5whpM.GJYeRou4dNjptBhpsaplUnnyfuoIWzq','Suite 245','17874450','36722934',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(27,'e84bd597-8042-38e2-b521-d926f9b42018','Rodrick Conroy','jody.mayert@hotmail.com','$2y$10$eyiws/ZI0R8BQ5MmBZY4Bu9GvRwnHN4pCNfKFhr/FzqgGqfz3/6Wu','Apt. 277','96061071','80024911',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(28,'b193e0d1-e303-3361-909d-c6b52bcfdef9','Maxime Roberts','crooks.marjolaine@armstrong.com','$2y$10$rv5w28rcA2FAyWFYGmo1I.xqDq6FHEMj08FIifLfEjmBVjQ/sPe1K','Apt. 784','1754492','55709100',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(29,'f6739faa-b4ec-3164-9a03-67098ffa5898','Prof. Filomena Altenwerth DDS','gmueller@prosacco.com','$2y$10$J/Obe8MeIe5B57keO4NoyehiNn84pjourcaUdiDtN2Bs4y.Ce4Ut.','Suite 335','90363376','93262649',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(30,'9789997d-b0ec-3467-b4ca-8b97e193d66b','Prof. Selmer Kohler PhD','golda99@gmail.com','$2y$10$dsPQxuj7AyMCocwl0jvRse9XwvgaGOsRPJTPLghQ9.RVj1SLSV1ce','Apt. 132','82342044','40266165',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(31,'06fa16d8-e093-3cf7-8ace-56f27ae46ac8','Max Hills','bayer.ashlee@crona.com','$2y$10$sCn8hc4IjUi1u5.iHWH2E.abdEXP686KZgbAzfATUG6rbC/NRTes6','Apt. 538','5381133','3255082',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(32,'baf5430d-379d-39b2-9d55-362b19ca1f2e','Ford Dickens','jessyca83@yahoo.com','$2y$10$nNEbCIAXHwHRXMThWJB59OWf29aDU7n3BMzMbrfXeKEb3AmsfHTD6','Apt. 760','14412165','2299575',NULL,NULL,'en',NULL,'2025-03-21 17:40:01','2025-03-21 17:40:01'),(33,'19b99818-ef7d-3c5e-a91a-0f1a257edba1','Mr. Rory Carter DDS','carlos28@yahoo.com','$2y$10$petm9YOT528eFFx8LTCUkeQMlAQAwCrq7If9xhFTfaBHw.6WG30Qu','Apt. 799','77409012','14505509',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(34,'a4635a34-83db-3e1d-a4fe-becc15cf0e67','Greta Beer','ikoelpin@hotmail.com','$2y$10$38yMrdx4dawiLFFYL74sZOS1orPzOvDvt4CwPaQHXWgTviBcHmvra','Suite 786','66425437','60462800',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(35,'9403b68d-2026-38e9-8082-221b4a53620f','Prof. Sierra Altenwerth','jvon@hotmail.com','$2y$10$jW6qf.NpEezZzpWO3E/RTeVIBVoZwJjPfWLwkQc2opcuAStN.eY.e','Suite 578','56978746','48676157',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(36,'56514382-e239-3081-974c-b14fab5960e3','Dessie Emmerich','tmacejkovic@hotmail.com','$2y$10$juhYwqcl/ZlXarc0qVaDreOslAPwxlQMcjPle3cBdh2hsUIW3G5S6','Suite 885','31151774','550809',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(37,'843c11d6-cfb7-3fc1-bd64-9c88cc8b5c70','Samara Wunsch PhD','vwelch@hettinger.net','$2y$10$IrcF3OJ.f939cu4DE3AJnOTq2gBCCWf65tRWUZBLDeywMZhGQNEFi','Apt. 961','32346892','58709745',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(38,'96b325d3-2081-3422-ab93-400247541fe9','Felicia Murazik','blanca43@hotmail.com','$2y$10$uQcq/xKADF40FUUS5JZLteQyOCkTr2cEpR0GkNCf0Am7Q0UToQ4Xq','Suite 135','99101280','66051828',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(39,'203909b4-5f8f-3d12-9f54-3390c606130e','Guido Conroy II','zgerlach@hotmail.com','$2y$10$gOLDXQhwOMfr0WowAE9zs..7M9KXIsLhLKNVzIu8d3yktf5mPukoa','Suite 242','13194018','99770858',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(40,'92e902f2-2c08-39ec-a580-68b7f1122487','Viviane Bradtke','sven.feil@schowalter.com','$2y$10$zj3IigqmJe7kW.01aFnG0ei/xL/K9TKMQWe04X8NEgm/gOV5Mn4OK','Suite 366','8545108','64422129',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(41,'a4f8587c-5cab-325b-8ac1-cb90ec1345e0','Pamela Marquardt','tom.reilly@yahoo.com','$2y$10$TON.OY5QZHpSJLxgUkqBb.z8n7Emfh.RZ7.YfzZthxffYmV440rsa','Suite 090','81575358','48623766',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(42,'ae713005-e531-3a18-8197-9c16afc6af3e','Skyla Cummerata','opollich@greenfelder.info','$2y$10$XrogPLYmlCuaOSNWIXmvBOJJblEfCGQdYI1Dr5/G5.xTj2K6FMRCu','Suite 482','82281724','45125621',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(43,'6d1096c9-71fa-3661-b1a2-d72011ff528a','Lenora Wehner','lesch.zoey@hotmail.com','$2y$10$GgUHSUrgNEz89BigOpHMie7xf6xaQBfHbrXhheX8Z1SysPzwcaZQW','Apt. 538','24748193','2336694',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(44,'e9274deb-c7d3-3f92-af33-2598f03df6b8','Evans Crooks','easter60@gmail.com','$2y$10$3PN/KgUf4p8SCi3SOGWvw.4tLVgSr4CpRnOPoO9BvsD8rARPtfkUK','Suite 621','88747525','69537883',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(45,'07c643e2-9fac-357f-9427-253bbefcef3c','Mrs. Kitty Kris','isaac.veum@hotmail.com','$2y$10$fAbnWACmlIujviQ8Ww5Zzer5zHDknz5Txufs4P.UreVH0UvVV7bAO','Suite 390','41305083','39733632',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(46,'ddb7772b-b253-3528-9318-03e4aa060af1','Scot Abbott','elva66@gmail.com','$2y$10$geS5mCXpSgLBmPZAa80p1O2IX82dk4OltbkZwyoXvPKamSm684bS2','Suite 904','3591009','14558820',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(47,'44a7eb11-be66-3828-b538-f5b497e8a754','Courtney Runolfsdottir','yortiz@yahoo.com','$2y$10$S06H6dpJbm24/pFQiU9aqeL.FeRu9qzuNgO.o6IdGcukXLxKDQpf.','Apt. 975','67138692','67829801',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(48,'28fe8856-b79f-38fe-aa33-b37c6fd40652','Domenico McDermott','gladys23@yahoo.com','$2y$10$HQ.leyfUYT11Vme25Iff1ecrBSmCf2zGQn0arNn/SAlPm3.HKakRG','Apt. 378','70971265','96071104',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(49,'9988eae9-cf79-3bea-8afe-fe6e7ba8c5fe','Cayla Bauch','jairo.wolf@leffler.com','$2y$10$XHeOabABPwTJ/81ZtdeKketHjYHVy.KmaCUJWCMNyZfiwNRVqOpTC','Suite 649','12371862','49462806',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(50,'cf8af6aa-5787-3a28-8a45-bc8d67024515','Maximus Quitzon Sr.','ullrich.letha@vandervort.com','$2y$10$yCMjQNIxpJT.QHtIhKG4R.CKKmUJukQORyJKKY.C7bB37n823drBy','Apt. 653','11830890','36853380',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(51,'9a754f82-546b-3ecf-baf5-00fbd9568d99','Beverly Kovacek PhD','friesen.erica@gmail.com','$2y$10$uITDJB4bMOfeDEiL/VMp1e7hkTMDNIwWO9NgU2XIKtKmr3jUlE4VW','Apt. 751','97738887','34627197',NULL,NULL,'en',NULL,'2025-03-21 17:40:02','2025-03-21 17:40:02'),(52,'c34442cf-200c-3b3c-ba34-787355ccc941','Dr. Wilber Gerhold','glover.humberto@hotmail.com','$2y$10$mzghqrjYM1ivpuaco0K7ceE5Ix13ejjNA/f0i5H0rjCHOV6FLQGV.','Suite 234','85565461','33037747',NULL,NULL,'en',NULL,'2025-03-21 17:40:03','2025-03-21 17:40:03'),(53,'914b76b9-5806-3af5-97ed-4dc8a2cb3a12','Eric McCullough','zola69@gmail.com','$2y$10$6QuaiezbBQiZna7JHgiZOub8jL5vcNLvBhdYGME1eyvK4kW3TD5Im','Apt. 529','4433120','83632643',NULL,NULL,'en',NULL,'2025-03-21 17:40:03','2025-03-21 17:40:03'),(54,'1c9fc4ee-0bba-3bcf-bb7e-a892b06697a0','Giovanny Jacobi','tara91@yahoo.com','$2y$10$66m2qisAKkkqY0jf01r/HupqMaxPkkzSQae1umzk7d99b/GwmkiqW','Suite 586','37093940','99294841',NULL,NULL,'en',NULL,'2025-03-21 17:40:03','2025-03-21 17:40:03'),(55,'b2bd2cbf-cd3a-3ad6-ac6f-df7124056ef8','Rhianna Treutel','reba42@gmail.com','$2y$10$ajeubOZYMth0DFDsko3ZrO.cEO7wr4cNZz2/zYCiXWTmSS7ZiRD26','Suite 033','9868487','31181202',NULL,NULL,'en',NULL,'2025-03-21 17:40:03','2025-03-21 17:40:03'),(56,'6c65ea34-f7b4-3c9b-bcd6-e1c89d024c60','Fredrick Schowalter','iswaniawski@grimes.info','$2y$10$.bFRwhvvSwjQCbmdQE8G7.bOyk.khtPbvm6/0/Y9pAwbnKrCkJf3i','Apt. 438','54720731','91941808',NULL,NULL,'en',NULL,'2025-03-21 17:40:03','2025-03-21 17:40:03'),(57,'55bda20e-c525-3b41-9b56-68feaef95502','Amy Schaden','vmoore@casper.com','$2y$10$KI7HPaxdSCH7TwXD1ycoTeKIjCH6HONrrkK532A2VywBS0IYmHDeu','Apt. 674','49615344','425640',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(58,'eca0450d-615d-3fe6-aae1-794976588ad7','Elliot Streich','umarquardt@hotmail.com','$2y$10$o6ageuIq7cRW0xMztk0wou4ZhlVDoXzLiHYeCGHve2t2kpt9yAUmy','Apt. 215','84410581','8729605',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(59,'d200d291-3289-376b-8d75-8cd584fa616d','Brenna Ortiz','ursula.torp@yahoo.com','$2y$10$Mi6GWe.7fGA0nr6RPsKTlOo5KmLmg1AoM88w3bA49b65/HNGkQ8d6','Apt. 348','90206351','63765873',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(60,'c5406e76-f9d9-309a-be05-90218b4c5e9a','Lenna Torp Jr.','lbernhard@haag.com','$2y$10$MbLaWJFjLO3ubuPYgsvvVOMM9oa43BCCZQhr27m/75Vzk9orVdZ9G','Apt. 285','77636316','26864463',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(61,'df870ec0-d62e-3b0d-ac06-f4e16fdfefa9','Lula Schultz I','harmony66@yahoo.com','$2y$10$wkoa17jLUKnVcWLOIrnBQu8deJ1pCEQAZKgIcspOWuuaTp54R2tza','Suite 019','15335128','59497414',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(62,'0814fca5-91eb-3444-81c6-fd70d8c401bc','Allen Quigley','tiara79@gmail.com','$2y$10$qJZl0.l6fGQ9RFclB/SlZeA/IFKR.A8kqx3ajumUaKzfku84K39me','Suite 796','94703138','30750987',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(63,'13fe4689-0810-3d78-85c0-9473a9d4241f','Dr. Ed Larson','micheal19@frami.info','$2y$10$THml9eZ6f40.k7L/UXGzTe0xMk5Elcnq3yK6UvMdnRbFzCDXE9MC2','Suite 782','43811883','81374723',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(64,'41d33e8c-c038-3579-87ac-0aae24462cc6','Dr. Elenora Price PhD','ehermiston@buckridge.com','$2y$10$GyopDg6UbsmjSWDSkXjXueWP7KZWSOgYGRYIWuhs7N2T.s5F6iZSG','Apt. 754','23366316','28785094',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(65,'c668cf10-78e6-3e5c-b795-284d0aa73359','Tomas Collins','humberto.zboncak@yahoo.com','$2y$10$33RIzFjtNWQ8qGtegtC2v.Ryn98VPHJ5vVNYn9/ekGfc8INSaDJrm','Suite 657','11396378','98639090',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(66,'5217d5dc-a3a0-3ae6-afad-2210327eb14d','Nikita Lindgren','zgreenfelder@hotmail.com','$2y$10$mUPgYIXPJmx4UfrkwopL6OeKy58jea7jWQu6AHaRHoUiW/1VvC1gu','Suite 722','25487359','80920488',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(67,'2012d69f-99ae-3070-9e94-32373d6eb3d2','Gilda Fisher','kuhn.porter@medhurst.com','$2y$10$TXfxXh4hboeXQSd437wYbut2D.lbT2.kwOtlfPGZ4Vt2eDmZfSm7m','Suite 488','76062662','30582610',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(68,'219472f5-feb0-3c2a-bcfc-9ec6753f4528','Gregg Emard','abshire.gia@cummerata.net','$2y$10$koqyFkcUHVMltuDcnSMaxu0ecadzKA0llSmi/vIv0xomNF1DhZcWu','Suite 748','25246202','71754738',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(69,'1728d2da-1b47-33f1-8984-1fc1e404297e','Shirley Rosenbaum Jr.','nwyman@anderson.info','$2y$10$kNZBS9BLmWWlu792AZ7XR.L/EX7Zs709cTzOeJLEztyJYXqqBBVqK','Suite 502','10216770','58577322',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(70,'d82ff3bd-1508-30dd-8ed8-23c0d4c7bfa9','Khalil Huel III','blakin@sporer.org','$2y$10$PCfm1t03MNILYp6lQ3uHPejGsYcKKMxsxkSepjUy0zM078oRAucgK','Suite 680','28587440','81091448',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(71,'3875fb37-2171-3571-b3d9-aaa13be5abd5','Sammie Gaylord','elmo52@mosciski.com','$2y$10$F50/nyhNAjtzAvSGKvM4FudnzVTXFAeLmDTHG9Tw.YQ9wEF03UYjK','Suite 964','37302904','55967644',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(72,'7fd06054-e957-3346-94e0-a1cc4fa14a99','Akeem Fahey','donnell87@rau.com','$2y$10$btHHba6pHj0L0m9z4qnyCuT8.NCmvbPwOt4nLxs4HUyYKx.WmrP1C','Suite 664','96442604','3836992',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(73,'61853fed-fd72-3506-b554-42dca477aef2','Ms. Francesca Collins','cullen.ortiz@daniel.org','$2y$10$yPjIOadyXHYwDyDSnfFSiueUygQYxglhb6IdSfRUgQcueJ5tmJYAO','Apt. 684','76220747','49456159',NULL,NULL,'en',NULL,'2025-03-21 17:40:04','2025-03-21 17:40:04'),(74,'a594d09f-455d-3ca0-a72b-4a401b3ba06f','Boris Stanton','elody.renner@yahoo.com','$2y$10$BBgl3GyHyahCoyL9HoCFCeomsu2skbT8BflpVa7Xgw/EYwBrq.lLG','Apt. 129','17944974','73101419',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(75,'6d79821e-b125-3d64-9c22-079fc6df4c69','Betty Hermiston','miller.geovany@armstrong.info','$2y$10$C/x952IzQG7QEQmwZmZifeF0sZfXk6ozCsfbLFCuSuZkw1EFV4glG','Apt. 948','98981401','83328333',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(76,'f9a4e4dc-42ef-3bd9-b679-e43ac1bf07ca','Prof. Bernadette Hahn','isabell34@yahoo.com','$2y$10$QIIZ9oYNS2e0bOyd1kSyPegV5MIRqpVxqUjrEpT8mbRy6QKtmJjqC','Suite 164','48098287','65076335',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(77,'473b752d-87f8-3690-a507-4da48b2221f4','Marge Becker','pkrajcik@gorczany.net','$2y$10$gHKMJxbbxDtQOLmofZUXPezwZC5CbmoPzdCQvf6t0cf9k3bWyVZMa','Suite 725','60920112','21118615',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(78,'dfce6f05-3369-3e7d-85b2-afc225da1ede','Mrs. Anastasia Bogan III','boehm.suzanne@kuvalis.org','$2y$10$HVv6KgUi3PtebPooczmReeuAcnaNwULk/55skh6E/xa8nq.YiIMeq','Apt. 591','35785751','44620425',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(79,'dfd65628-5bb9-31da-94a6-468f98a1ed35','Dr. Julio Walsh','fweber@auer.com','$2y$10$yUJDmaqaNys0wsxqJjvJBOf1REGSRsywz5SkWGJsg1pi6Wd2xQpxy','Suite 071','96676997','91593554',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(80,'36399f5d-fdf9-38f8-a395-47dc93d9d633','Carolyn Bartoletti','ischmitt@hotmail.com','$2y$10$VUE8hM803ncm9fz88mUd4eSlFjg4kMgM7Fzh0bKiJyq67qTgitrpe','Apt. 629','97054954','11455057',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(81,'20c5e81e-2563-3880-9882-4a39d26a73f3','Travon Kuhic','orie08@harber.com','$2y$10$H1yqyympEd4wnGj8inWLhufO4GxBt9RBsMju1/2uKnmuXO35vLcSS','Suite 724','77825312','55128335',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(82,'9eb21a2c-fdde-3437-9608-48bbf7e433cc','Samantha VonRueden V','margie.hudson@yahoo.com','$2y$10$xiq9z.HX.2V8W8oZT9laF.EQtGTnJgyZ.63SmzbU15RWIqD9Hkg2O','Apt. 217','12123923','83820262',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(83,'46cc240a-d04b-386e-8ccc-1c49a074c266','Stephania Kuhn','lkovacek@witting.net','$2y$10$lcRDK3DWTge/Aq0iDCqmH.3BvZoH7pL8hr/M0Kyd.EA4PMIe4J8NC','Suite 240','69895421','25091993',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(84,'a0cfff1d-2b10-361a-83bc-e00a6054b69d','Aletha Deckow','jed07@rohan.com','$2y$10$XZ2iAxyUb2bUgBR5WkNskeGjkBe4mU1/MY/MLHZwtZRCgBK5zpl4u','Suite 281','8203763','52226790',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(85,'973182c2-b96c-3bde-b9fd-7b5f99a9f761','Pearlie Dach Sr.','feest.alivia@johnson.com','$2y$10$vebtkAGPmTUkVYd.56E2FODA4zzYY15jiDl6rPtOhW8.gqBfT1iQq','Apt. 001','49322568','14056818',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(86,'7365b791-4a1a-36b9-a8a9-e2405f0dc605','Maci Kris','melvina13@hirthe.com','$2y$10$jlMzJHlCLPKGg0.v8KlUuuLHGdBswlsTIaFWp0i1hYPGDumiTgHMS','Apt. 700','11192406','99172109',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(87,'987314f4-1eff-3f2a-937a-5cf000ae2b51','Jakayla Fritsch','swift.buck@gmail.com','$2y$10$luPmNf9CQN.ho8KG35xzveSyCraFo2byrmgGx7UEjj627.h2G/8oa','Suite 347','99327288','24909102',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(88,'2f3c4b38-d48c-3544-9188-1add066550dd','Kristina Kiehn','ross.kertzmann@hotmail.com','$2y$10$qIxzcMxwmYBNScmD1ufD5.u4qhK0SbdJQPHgalZVNerx1nl6h01tC','Apt. 623','59383305','24333396',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(89,'58007444-86bf-38a5-be8b-57a3b5988a13','Kurt Lindgren','sedrick.huels@yahoo.com','$2y$10$QywiS5snhi0npxLk4v3rh.z1iVPH1fzSx9mLAdYeaGKHVEmDH09Lq','Apt. 268','67287589','52610341',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(90,'03f4a876-ea70-3c90-acfd-483d357d4003','Adrianna Bruen','lilian.powlowski@gmail.com','$2y$10$IOPftZrWlX.puG2Ai4FjMe3GYR5gGrbrXCrwn9dc.IAq7vL.zYwzK','Suite 036','48514358','62644122',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(91,'fa58cfbf-9cfe-3efe-b274-8479c351e76c','Fernando Schoen','adonis79@hettinger.com','$2y$10$TEKjJJGT.MtrD0zQqLdUZ.rxmAfXzi6FCPcHmdpRQ9Z0Bk9a77Rce','Apt. 962','64211265','42640537',NULL,NULL,'en',NULL,'2025-03-21 17:40:05','2025-03-21 17:40:05'),(92,'a5cffff7-f99b-3138-8cff-6f7b538feea2','Anastacio Gaylord Jr.','hoppe.luna@gmail.com','$2y$10$cRAiH49nHYlvzbSdkKmw9OIQQ39L850wmrQF6xMBrxQ0C56IOaIUe','Suite 816','35619977','92040512',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(93,'9b85ecdd-07af-332d-915b-4d448f33e785','Nakia Gleichner','caleigh.boyer@yahoo.com','$2y$10$YPP87u3dYBWI7uYoW1nSsO.wb7i0bGBLIsiwBqAqHj5zcy7Tt.N0m','Apt. 689','81336147','23567678',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(94,'344be3db-cac7-38c1-9a9b-e2caa0e9fc12','Reed Deckow','eladio.morissette@runolfsson.com','$2y$10$TW73Uq8YcuFGm3CD4LJxOutpNA6rBnpr8gl1SKvgtmOPES9sQRszW','Apt. 012','71058593','74519133',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(95,'32837e67-c9ac-37c4-9a23-5f26f6a6451d','Forrest Treutel PhD','barrows.candido@yahoo.com','$2y$10$KpNbnGB0qZtJVls4hS6IqOmLxFXlcoH4fdcFUh02FfcD3WrsMGEeq','Suite 649','78052703','85913342',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(96,'08b315b3-cf36-3305-a950-ef57d11817e2','Danyka Moore','tillman.freda@hotmail.com','$2y$10$sCPUgLBA.Vdubamx9/aQz.pc3W1Dre2HTtyIs6E8F/8yNj.wvAOf6','Apt. 841','50229155','45547073',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(97,'6b20a182-5b3e-3668-823a-3e7ccd7d0e02','Aracely Hodkiewicz','qjast@hotmail.com','$2y$10$S/7MO7q4eD40o6UR4G7JG.sUC8zM8zJ/SSLdzX1Z2QzGbo/K4qPki','Apt. 505','5563761','68357131',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(98,'3e971556-cef2-3646-9ec8-897eb88b1a34','Armand Turner III','zolson@little.com','$2y$10$OGoNnF7NnoFxJrrv/36WGOHOrNJaEVwEQbuxySFhhsnLNpObGS4du','Apt. 094','18466596','94658347',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(99,'5c198ff7-9320-30ba-9cec-d30f8af324c4','Jennyfer Wisoky Jr.','thompson.brook@gmail.com','$2y$10$DTI.e/IeIJZIMYwndDedbOnTUlAoG8Y1vGjuvX79F7ffKrypQ607O','Apt. 202','2296915','97974579',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(100,'73959333-02a6-3fdf-bcd8-7b34c25e6b97','Prof. Kaylie Hilpert Sr.','melvina11@yahoo.com','$2y$10$nFeFFkBt7OFIzp9u/r63rurtH/78Czz.FUf20Hj28WeiVr0b.DGm.','Apt. 579','905037','50735195',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(101,'df464dfc-1455-3bee-8abf-99c38b30a73c','Dylan Wilderman','delia.willms@hotmail.com','$2y$10$4L.T9bfyt.5QZAJ0e3qPOeJHMzcObwjwGmdA3ZhutFqGWLNYd./GC','Apt. 674','86299623','75017642',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(102,'6b261b9f-23af-3dfd-9345-a157f354f55d','Zander Corkery','eldora27@gmail.com','$2y$10$ZvRJvkVXz7lMm0W63G7.T./9kPRB60LS7rGMOczvm6BIFRkA3PS2.','Apt. 245','57538632','89903229',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(103,'2db76db3-0c47-3c8a-867e-5df1dfdb647f','Roslyn Johnson','juanita18@yahoo.com','$2y$10$nFtqPu6dEegrf/YUPnyzOuNlrVEC5r3gc3sSWBbLeRDy2gHlAmAZK','Apt. 308','88274279','43114963',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(104,'63569427-b2a2-3ed7-99fd-2aa565a73e9e','Jaylen Lubowitz','leffler.jett@wilkinson.com','$2y$10$p4N4wayDPEKJSbmy90FzDepgzKf44/GNUqQd25ua71VZvxrx3aJze','Suite 926','58911980','63295435',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(105,'9e49db69-be8b-3451-86cb-8b4348363c59','Miss Mikayla Spencer MD','rickey09@gmail.com','$2y$10$VFyTQ90VQfbXAfYlvGKkfu3v/CmJuFO25Ye4PlwSKXrBMcb/VxU2u','Apt. 587','35736263','26742943',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(106,'ef1f388b-35c1-37af-843d-5ad2e962177b','Mrs. Phyllis Wolf','ashley.deckow@hessel.info','$2y$10$zZ4AwY7TAuswxIOqZdaZhORqrU1AJw8wopmPzomTpNNKUmLoYX2NO','Suite 688','78931992','92831286',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(107,'2c19d5cc-25ba-385d-b44c-88f8b75a82eb','Alf Ankunding','meagan.welch@yahoo.com','$2y$10$ONJqixrrcAZPczneZkZpceNWkLfA0poez5QfnBKAGu./rnooLfg3m','Apt. 356','78072911','24875071',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(108,'0a28c1b0-23ca-3fc4-860d-cb4449ed4971','Mr. Carlo Parker','itzel49@yahoo.com','$2y$10$t1cq7Ywukf4aFg/AG/VgGOIyiACiJVZTGM/QL402rYTI8n5vx58yu','Suite 677','39605766','39733486',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(109,'fa4e198a-dcfc-3333-b4b4-84d6d5034824','Abigayle Hegmann','rosalee77@gmail.com','$2y$10$4UTwJWVQzkALDUvExWsF6.JgEdvKqVM9ky1o5o56/Hb1wkd91IaB6','Apt. 515','93645226','52507169',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(110,'fc72cb34-0483-32b8-bad6-4400f260155f','Camilla Ruecker','hintz.ilene@luettgen.com','$2y$10$YZ6p22uIDMi8FmIKZeW22uRNI8b/6kc2TePC4.nA/0Em1bOlyanL.','Suite 407','85251692','79746857',NULL,NULL,'en',NULL,'2025-03-21 17:40:06','2025-03-21 17:40:06'),(111,'7a28be5d-e457-380d-b84c-eb395fe427fb','Sigurd Bailey','ngreenfelder@hotmail.com','$2y$10$MkWke9BTjjYY07a7ztm1JeNnxJMPN8HKsUxGKvdK8HtkWr/WxfBMW','Suite 108','44502790','15481228',NULL,NULL,'en',NULL,'2025-03-21 17:40:07','2025-03-21 17:40:07'),(112,'1413b72e-a0f8-33f5-b854-34b8d570bcbb','Dr. Leonel Jaskolski I','chaim.kautzer@hotmail.com','$2y$10$lQZtplEw6sFTDLPUnb1b4O5eUHdApxC5era1yZl5eEDz0LBEO4HnC','Apt. 983','26339609','30053845',NULL,NULL,'en',NULL,'2025-03-21 17:40:07','2025-03-21 17:40:07'),(113,'2f6fd0ad-1c39-34a0-9b33-c75b4a0dc041','Francesca Batz','rempel.luisa@bogisich.com','$2y$10$rWJBHApK2.BynwPheNetcOFpUrMZPuUgchkbIPUjKtN4FiEGVG.l2','Apt. 515','11131080','30780692',NULL,NULL,'en',NULL,'2025-03-21 17:40:07','2025-03-21 17:40:07'),(114,'bc42ccea-5f3f-36a0-a790-641f62601e9b','Margarett Hermiston','rau.newton@cole.com','$2y$10$fnN1ypz9jfv5pxh0HUe9ReQ/fy0mn14OIbmWhpcBz0An4E3ig0Nzu','Suite 296','3769203','1305968',NULL,NULL,'en',NULL,'2025-03-21 17:40:07','2025-03-21 17:40:07'),(115,'4202b7c9-749e-3089-9f63-45fc11a58d43','Dr. Caroline Hartmann','rstokes@brekke.org','$2y$10$oNLrJIf6QneTfZknLqkCKeU6V8vcvrPjCA6KNltQ6I5ry1.GLUcAa','Suite 191','19761860','24621232',NULL,NULL,'en',NULL,'2025-03-21 17:40:07','2025-03-21 17:40:07'),(116,'f60d3379-d28a-396d-bc61-31a0547c93f5','Saul Olson','ekshlerin@yahoo.com','$2y$10$7qz43XtDl6aF.0M1MDUCCeUGcVIk63GZBsF77UAkTZYHAnABv/ESa','Apt. 862','1998790','10444705',NULL,NULL,'en',NULL,'2025-03-21 17:40:07','2025-03-21 17:40:07');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-21 18:01:00
