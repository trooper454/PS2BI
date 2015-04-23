-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: ps2bi.net    Database: ps2bi_etl
-- ------------------------------------------------------
-- Server version	5.5.5-10.0.15-MariaDB-log

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
-- Current Database: `ps2bi_etl`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ps2bi_etl` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ps2bi_etl`;

--
-- Table structure for table `etl_detail`
--

DROP TABLE IF EXISTS `etl_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etl_detail` (
  `run_id` int(11) NOT NULL,
  `detail_id` int(11) NOT NULL,
  `stage_desc` varchar(45) DEFAULT NULL,
  `step_desc` varchar(45) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`detail_id`,`run_id`),
  KEY `etl_header_fk_idx` (`run_id`),
  CONSTRAINT `etl_header_fk` FOREIGN KEY (`run_id`) REFERENCES `etl_header` (`run_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_header`
--

DROP TABLE IF EXISTS `etl_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etl_header` (
  `run_id` int(11) NOT NULL AUTO_INCREMENT,
  `etl_date` date DEFAULT NULL,
  `master_start` datetime DEFAULT NULL,
  `extract_start` datetime DEFAULT NULL,
  `extract_end` datetime DEFAULT NULL,
  `staging_start` datetime DEFAULT NULL,
  `staging_end` datetime DEFAULT NULL,
  `dwh_load_start` datetime DEFAULT NULL,
  `dwh_load_end` datetime DEFAULT NULL,
  `dwh_agg_start` datetime DEFAULT NULL,
  `dwh_agg_end` datetime DEFAULT NULL,
  `master_end` datetime DEFAULT NULL,
  PRIMARY KEY (`run_id`),
  UNIQUE KEY `idetl_header_UNIQUE` (`run_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'ps2bi_etl'
--

--
-- Dumping routines for database 'ps2bi_etl'
--

--
-- Current Database: `dgc_extract`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dgc_extract` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `dgc_extract`;

--
-- Table structure for table `character`
--

DROP TABLE IF EXISTS `character`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character` (
  `first` varchar(50) DEFAULT NULL,
  `first_lower` varchar(50) DEFAULT NULL,
  `battle_rank` varchar(50) DEFAULT NULL,
  `character_id` varchar(50) NOT NULL,
  `faction_id` varchar(50) DEFAULT NULL,
  `creation` varchar(50) DEFAULT NULL,
  `last_login` varchar(50) DEFAULT NULL,
  `last_save` varchar(50) DEFAULT NULL,
  `login_count` varchar(50) DEFAULT NULL,
  `minutes_played` varchar(50) DEFAULT NULL,
  `world_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`character_id`),
  UNIQUE KEY `character_id` (`character_id`),
  KEY `world_id` (`world_id`),
  KEY `faction_id` (`faction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_id`
--

DROP TABLE IF EXISTS `character_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_id` (
  `character_id` varchar(50) NOT NULL,
  PRIMARY KEY (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `death`
--

DROP TABLE IF EXISTS `death`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `death` (
  `attacker_character_id` varchar(45) NOT NULL,
  `attacker_vehicle_id` varchar(45) DEFAULT NULL,
  `attacker_weapon_id` varchar(45) DEFAULT NULL,
  `character_id` varchar(45) NOT NULL,
  `is_critical` varchar(45) DEFAULT NULL,
  `is_headshot` varchar(45) DEFAULT NULL,
  `timestamp` varchar(45) NOT NULL,
  `world_id` varchar(45) DEFAULT NULL,
  `zone_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`attacker_character_id`,`character_id`,`timestamp`),
  KEY `idx_weapon_id` (`attacker_weapon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faction`
--

DROP TABLE IF EXISTS `faction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faction` (
  `name_en` varchar(50) DEFAULT NULL,
  `code_tag` varchar(50) DEFAULT NULL,
  `faction_id` varchar(50) NOT NULL,
  PRIMARY KEY (`faction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `name_en` varchar(45) DEFAULT NULL,
  `faction_id` varchar(45) DEFAULT NULL,
  `is_default_attachment` varchar(45) DEFAULT NULL,
  `is_vehicle_weapon` varchar(45) DEFAULT NULL,
  `item_category_id` varchar(45) DEFAULT NULL,
  `item_id` varchar(45) NOT NULL,
  `item_type_id` varchar(45) DEFAULT NULL,
  `max_stack_size` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `idx_item_category_id` (`item_category_id`),
  KEY `idx_item_type_id` (`item_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_category`
--

DROP TABLE IF EXISTS `item_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_category` (
  `name_en` varchar(45) DEFAULT NULL,
  `item_category_id` varchar(45) NOT NULL,
  PRIMARY KEY (`item_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_type`
--

DROP TABLE IF EXISTS `item_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_type` (
  `name` varchar(45) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `item_type_id` varchar(45) NOT NULL,
  PRIMARY KEY (`item_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `outfit`
--

DROP TABLE IF EXISTS `outfit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outfit` (
  `name` varchar(50) DEFAULT NULL,
  `alias` varchar(50) DEFAULT NULL,
  `leader_character_id` varchar(50) DEFAULT NULL,
  `member_count` varchar(50) DEFAULT NULL,
  `outfit_id` varchar(50) NOT NULL,
  `time_created` varchar(50) DEFAULT NULL,
  `faction_id` varchar(45) DEFAULT NULL,
  `world_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`outfit_id`),
  UNIQUE KEY `ixd_outfir` (`outfit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `outfit_member`
--

DROP TABLE IF EXISTS `outfit_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outfit_member` (
  `character_id` varchar(50) NOT NULL DEFAULT '',
  `member_since` varchar(50) DEFAULT NULL,
  `outfit_id` varchar(50) DEFAULT NULL,
  `rank` varchar(50) DEFAULT NULL,
  `rank_ordinal` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`character_id`),
  UNIQUE KEY `character_id` (`character_id`),
  KEY `idx_outfit` (`outfit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `world`
--

DROP TABLE IF EXISTS `world`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `world` (
  `name_en` varchar(50) DEFAULT NULL,
  `world_id` varchar(50) NOT NULL,
  PRIMARY KEY (`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'dgc_extract'
--

--
-- Dumping routines for database 'dgc_extract'
--

--
-- Current Database: `ps2bi_stg`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ps2bi_stg` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ps2bi_stg`;

--
-- Table structure for table `stg_dim_character`
--

DROP TABLE IF EXISTS `stg_dim_character`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_dim_character` (
  `character_id` varchar(45) NOT NULL,
  `character_name` varchar(45) DEFAULT NULL,
  `world_id` int(11) DEFAULT NULL,
  `world_desc` varchar(45) DEFAULT NULL,
  `faction_id` int(11) DEFAULT NULL,
  `faction_desc` varchar(45) DEFAULT NULL,
  `faction_tag` varchar(45) DEFAULT NULL,
  `outfit_id` varchar(45) DEFAULT NULL,
  `outfit_name` varchar(60) DEFAULT NULL,
  `outfit_tag` varchar(45) DEFAULT NULL,
  `outfit_rank` int(11) DEFAULT NULL,
  `outfit_rank_desc` varchar(45) DEFAULT NULL,
  `outfit_join_date` int(10) unsigned DEFAULT NULL,
  `create_date` int(10) unsigned DEFAULT NULL,
  `last_login_date` int(10) unsigned DEFAULT NULL,
  `last_save_date` int(10) unsigned DEFAULT NULL,
  `battle_rank` int(11) DEFAULT NULL,
  `login_count` int(11) DEFAULT NULL,
  `minutes_played` int(11) DEFAULT NULL,
  PRIMARY KEY (`character_id`),
  UNIQUE KEY `character_id_UNIQUE` (`character_id`),
  KEY `idx_outfit_id` (`outfit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stg_dim_item`
--

DROP TABLE IF EXISTS `stg_dim_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_dim_item` (
  `item_id` int(11) NOT NULL,
  `item_desc` varchar(50) DEFAULT NULL,
  `faction_id` int(11) DEFAULT NULL,
  `faction_desc` varchar(50) DEFAULT NULL,
  `faction_tag` varchar(50) DEFAULT NULL,
  `item_category_id` int(11) DEFAULT NULL,
  `item_category_desc` varchar(50) DEFAULT NULL,
  `item_type_id` int(11) DEFAULT NULL,
  `item_type_desc` varchar(50) DEFAULT NULL,
  `is_vehicle_weapon` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stg_dim_outfit`
--

DROP TABLE IF EXISTS `stg_dim_outfit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_dim_outfit` (
  `outfit_id` varchar(45) NOT NULL,
  `outfit_name` varchar(60) NOT NULL,
  `outfit_tag` varchar(6) NOT NULL,
  `world_id` int(11) NOT NULL,
  `world_desc` varchar(45) NOT NULL,
  `faction_id` int(11) NOT NULL,
  `faction_desc` varchar(45) NOT NULL,
  `member_count` int(11) NOT NULL,
  `create_date` int(11) unsigned NOT NULL,
  PRIMARY KEY (`outfit_id`),
  UNIQUE KEY `outfit_id_UNIQUE` (`outfit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stg_fct_playtime`
--

DROP TABLE IF EXISTS `stg_fct_playtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_fct_playtime` (
  `date_key` int(11) NOT NULL,
  `character_key` int(11) NOT NULL,
  `logins` int(11) DEFAULT NULL,
  `playtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`date_key`,`character_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'ps2bi_stg'
--

--
-- Dumping routines for database 'ps2bi_stg'
--
/*!50003 DROP PROCEDURE IF EXISTS `stg_dim_character_load` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`trooper`@`%` PROCEDURE `stg_dim_character_load`()
BEGIN

truncate table `ps2bi_stg`.`stg_dim_character`;

INSERT INTO `ps2bi_stg`.`stg_dim_character`
(`character_id`,
`character_name`,
`world_id`,
`world_desc`,
`faction_id`,
`faction_desc`,
`faction_tag`,
`outfit_id`,
`outfit_name`,
`outfit_tag`,
`outfit_rank`,
`outfit_rank_desc`,
`outfit_join_date`,
`create_date`,
`last_login_date`,
`last_save_date`,
`battle_rank`,
`login_count`,
`minutes_played`)

Select
`character`.`character_id`,
`character`.`first`,
`character`.`world_id`,
`world`.`name_en`,
`character`.`faction_id`,
`faction`.`name_en`,
`faction`.`code_tag`,
`outfit_member`.`outfit_id`,
`outfit`.`name`,
`outfit`.`alias`,
`outfit_member`.`rank_ordinal`,
`outfit_member`.`rank`,
`outfit_member`.`member_since`,
`character`.`creation`,
`character`.`last_login`,
`character`.`last_save`,
`character`.`battle_rank`,
`character`.`login_count`,
`character`.`minutes_played`

From
`dgc_extract`.`character`
join `dgc_extract`.`world`
on `character`.`world_id` = `world`.`world_id`
join `dgc_extract`.`faction`
on `character`.`faction_id` = `faction`.`faction_id`
left join `dgc_extract`.`outfit_member`
on `character`.`character_id` = `outfit_member`.`character_id`
left join `dgc_extract`.`outfit`
on `outfit_member`.`outfit_id` = `outfit`.`outfit_id`;

INSERT INTO `ps2bi_stg`.`stg_dim_character`
(`character_id`,
`outfit_id`,
`outfit_name`,
`outfit_tag`,
`outfit_rank`,
`outfit_rank_desc`,
`outfit_join_date`)

select
`outfit_member`.`character_id`,
`outfit`.`outfit_id`,
`outfit`.`name`,
`outfit`.`alias`,
`outfit_member`.`rank_ordinal`,
`outfit_member`.`rank`,
`outfit_member`.`member_since`

From
`dgc_extract`.`outfit_member`
left join `dgc_extract`.`character`
on `outfit_member`.`character_id` = `character`.`character_id`
join `dgc_extract`.`outfit`
on `outfit_member`.`outfit_id` = `outfit`.`outfit_id`

where `character`.`character_id` is null;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stg_dim_item_load` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`trooper`@`localhost` PROCEDURE `stg_dim_item_load`()
BEGIN

truncate table ps2bi_stg.stg_dim_item;

INSERT INTO `ps2bi_stg`.`stg_dim_item`
(`item_id`,
`item_desc`,
`faction_id`,
`faction_desc`,
`faction_tag`,
`item_category_id`,
`item_category_desc`,
`item_type_id`,
`item_type_desc`,
`is_vehicle_weapon`)

SELECT
`item`.`item_id`,
`item`.`name_en`,
case when `item`.`faction_id` = '' then '0' else `item`.`faction_id` end,
`faction`.`name_en`,
`faction`.`code_tag`,
`item`.`item_category_id`,
`item_category`.`name_en`,
`item`.`item_type_id`,
`item_type`.`name`,
`item`.`is_vehicle_weapon`

FROM
`dgc_extract`.`item`
join `dgc_extract`.`item_category`
on `item`.`item_category_id` = `item_category`.`item_category_id`
join `dgc_extract`.`item_type`
on `item`.`item_type_id` = `item_type`.`item_type_id`
left join `dgc_extract`.`faction`
on case when `item`.`faction_id` = '' then 0 else `item`.`faction_id` end = `faction`.`faction_id`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stg_dim_outfit_load` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`trooper`@`%` PROCEDURE `stg_dim_outfit_load`()
BEGIN
TRUNCATE TABLE `ps2bi_stg`.`stg_dim_outfit`;

INSERT INTO `ps2bi_stg`.`stg_dim_outfit`
(`outfit_id`,
`outfit_name`,
`outfit_tag`,
`world_id`,
`world_desc`,
`faction_id`,
`faction_desc`,
`member_count`,
`create_date`)

SELECT 
`outfit`.`outfit_id`,
`outfit`.`name`,
`outfit`.`alias`,
`outfit`.`world_id`,
`world`.`name_en`,
`outfit`.`faction_id`,
`faction`.`name_en`,
`outfit`.`member_count`,
`outfit`.`time_created`

FROM `dgc_extract`.`outfit`
join `dgc_extract`.`world`
on `outfit`.`world_id` = `world`.`world_id`
join `dgc_extract`.`faction`
on  `outfit`.`faction_id` = `faction`.`faction_id`

where alias != '';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stg_fct_playtime_load` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`trooper`@`localhost` PROCEDURE `stg_fct_playtime_load`()
BEGIN

TRUNCATE TABLE `ps2bi_stg`.`stg_fct_playtime`;

INSERT INTO `ps2bi_stg`.`stg_fct_playtime`
(`date_key`,
`character_key`,
`logins`,
`playtime`)

Select
date_key,
dc.character_key,
sc.login_count - dc.login_count as logins,
sc.minutes_played - dc.minutes_played as playtime

from
`ps2bi_dwh`.`dim_character` dc
join `ps2bi_stg`.`stg_dim_character` sc
on dc.character_id = sc.character_id,
`ps2bi_dwh`.`dim_date`

where
date_field = date_sub(curdate(),interval 1 day)
and sc.login_count is not null
and dc.login_count is not null
and sc.minutes_played is not null
and dc.minutes_played is not null
and (sc.login_count - dc.login_count > 0
or sc.minutes_played - dc.minutes_played > 0);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `ps2bi_dwh`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ps2bi_dwh` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ps2bi_dwh`;

--
-- Table structure for table `dim_character`
--

DROP TABLE IF EXISTS `dim_character`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_character` (
  `character_key` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` varchar(45) NOT NULL,
  `character_name` varchar(45) NOT NULL,
  `world_id` int(11) NOT NULL,
  `world_desc` varchar(45) NOT NULL,
  `faction_id` int(11) NOT NULL,
  `faction_desc` varchar(45) NOT NULL,
  `faction_tag` varchar(45) DEFAULT NULL,
  `outfit_key` int(11) DEFAULT NULL,
  `outfit_name` varchar(60) DEFAULT NULL,
  `outfit_tag` varchar(45) DEFAULT NULL,
  `outfit_rank` int(11) DEFAULT NULL,
  `outfit_rank_desc` varchar(45) DEFAULT NULL,
  `outfit_join_date` int(11) DEFAULT NULL,
  `create_date` int(10) unsigned NOT NULL,
  `last_login_date` int(10) unsigned NOT NULL,
  `last_save_date` int(10) unsigned NOT NULL,
  `battle_rank` int(11) NOT NULL,
  `login_count` int(11) NOT NULL,
  `minutes_played` int(11) NOT NULL,
  `bi_date` date NOT NULL,
  PRIMARY KEY (`character_key`),
  UNIQUE KEY `character_key_UNIQUE` (`character_key`),
  UNIQUE KEY `character_id_UNIQUE` (`character_id`),
  KEY `idx_outfit_key` (`outfit_key`)
) ENGINE=InnoDB AUTO_INCREMENT=1531744 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_date`
--

DROP TABLE IF EXISTS `dim_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_date` (
  `date_key` int(11) NOT NULL AUTO_INCREMENT,
  `date_field` date DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `month_in_year` int(11) DEFAULT NULL,
  `month_desc` varchar(45) DEFAULT NULL,
  `week_in_year` int(11) DEFAULT NULL,
  `week_in_month` int(11) DEFAULT NULL,
  `day_in_week` int(11) DEFAULT NULL,
  `timestamp_start` int(10) unsigned DEFAULT NULL,
  `timestamp_end` int(10) unsigned DEFAULT NULL,
  `week_start_key` int(11) DEFAULT NULL,
  `week_end_key` int(11) DEFAULT NULL,
  `month_start_key` int(11) DEFAULT NULL,
  `month_end_key` int(11) DEFAULT NULL,
  PRIMARY KEY (`date_key`),
  UNIQUE KEY `date_key_UNIQUE` (`date_key`),
  UNIQUE KEY `date_field_UNIQUE` (`date_field`)
) ENGINE=InnoDB AUTO_INCREMENT=996 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_item`
--

DROP TABLE IF EXISTS `dim_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_item` (
  `item_key` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `item_desc` varchar(50) DEFAULT NULL,
  `faction_id` int(11) DEFAULT NULL,
  `faction_desc` varchar(50) DEFAULT NULL,
  `faction_tag` varchar(50) DEFAULT NULL,
  `item_category_id` int(11) DEFAULT NULL,
  `item_category_desc` varchar(50) DEFAULT NULL,
  `item_type_id` int(11) DEFAULT NULL,
  `item_type_desc` varchar(50) DEFAULT NULL,
  `is_vehicle_weapon` int(11) DEFAULT NULL,
  `bi_date` date DEFAULT NULL,
  PRIMARY KEY (`item_key`),
  UNIQUE KEY `item_key` (`item_key`),
  UNIQUE KEY `item_id` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16721 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_outfit`
--

DROP TABLE IF EXISTS `dim_outfit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_outfit` (
  `outfit_key` int(11) NOT NULL AUTO_INCREMENT,
  `outfit_id` varchar(45) NOT NULL,
  `outfit_name` varchar(60) NOT NULL,
  `outfit_tag` varchar(6) NOT NULL,
  `world_id` int(11) NOT NULL,
  `world_desc` varchar(45) NOT NULL,
  `faction_id` int(11) NOT NULL,
  `faction_desc` varchar(45) NOT NULL,
  `member_count` int(11) NOT NULL,
  `create_date` int(11) unsigned NOT NULL,
  `bi_date` date NOT NULL,
  PRIMARY KEY (`outfit_key`),
  UNIQUE KEY `idx_outfit_id` (`outfit_id`),
  UNIQUE KEY `outfit_key` (`outfit_key`)
) ENGINE=InnoDB AUTO_INCREMENT=51200 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fct_playtime`
--

DROP TABLE IF EXISTS `fct_playtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fct_playtime` (
  `date_key` int(11) NOT NULL,
  `character_key` int(11) NOT NULL,
  `logins` int(11) NOT NULL,
  `playtime` int(11) NOT NULL,
  `bi_date` date NOT NULL,
  PRIMARY KEY (`date_key`,`character_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'ps2bi_dwh'
--

--
-- Dumping routines for database 'ps2bi_dwh'
--
/*!50003 DROP PROCEDURE IF EXISTS `dim_character_load` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`trooper`@`%` PROCEDURE `dim_character_load`()
BEGIN

/*Blank out outfit records*/
UPDATE `ps2bi_dwh`.`dim_character`

SET
`outfit_key` = null,
`outfit_name` = null,
`outfit_tag` = null,
`outfit_rank` = null,
`outfit_rank_desc` = null,
`outfit_join_date` = null;

/*update outfit data*/
UPDATE `ps2bi_dwh`.`dim_character`
join `ps2bi_stg`.`stg_dim_character`
on `dim_character`.`character_id` = `stg_dim_character`.`character_id`
left join `ps2bi_dwh`.`dim_outfit`
on `stg_dim_character`.`outfit_id` = `dim_outfit`.`outfit_id`

SET
`dim_character`.`outfit_key` = `dim_outfit`.`outfit_key`,
`dim_character`.`outfit_name` = `stg_dim_character`.`outfit_name`,
`dim_character`.`outfit_tag` = `stg_dim_character`.`outfit_tag`,
`dim_character`.`outfit_rank` = `stg_dim_character`.`outfit_rank`,
`dim_character`.`outfit_rank_desc` = `stg_dim_character`.`outfit_rank_desc`,
`dim_character`.`outfit_join_date` = `stg_dim_character`.`outfit_join_date`,
`dim_character`.`bi_date` = curdate()

WHERE `stg_dim_character`.`outfit_id` is not null
and `stg_dim_character`.`character_name` is null;

/*update non-outfit data*/
UPDATE `ps2bi_dwh`.`dim_character`
join `ps2bi_stg`.`stg_dim_character`
on `dim_character`.`character_id` = `stg_dim_character`.`character_id`

SET
`dim_character`.`character_id` = `stg_dim_character`.`character_id`,
`dim_character`.`character_name` = `stg_dim_character`.`character_name`,
`dim_character`.`world_id` = `stg_dim_character`.`world_id`,
`dim_character`.`world_desc` = `stg_dim_character`.`world_desc`,
`dim_character`.`faction_id` = `stg_dim_character`.`faction_id`,
`dim_character`.`faction_desc` = `stg_dim_character`.`faction_desc`,
`dim_character`.`faction_tag` = `stg_dim_character`.`faction_tag`,
`dim_character`.`create_date` = `stg_dim_character`.`create_date`,
`dim_character`.`last_login_date` = `stg_dim_character`.`last_login_date`,
`dim_character`.`last_save_date` = `stg_dim_character`.`last_save_date`,
`dim_character`.`battle_rank` = `stg_dim_character`.`battle_rank`,
`dim_character`.`login_count` = `stg_dim_character`.`login_count`,
`dim_character`.`minutes_played` = `stg_dim_character`.`minutes_played`,
`dim_character`.`bi_date` = curdate()

WHERE `stg_dim_character`.`character_name` is not null;

/*insert new records*/
INSERT INTO `ps2bi_dwh`.`dim_character`
(`character_id`,
`character_name`,
`world_id`,
`world_desc`,
`faction_id`,
`faction_desc`,
`faction_tag`,
`outfit_key`,
`outfit_name`,
`outfit_tag`,
`outfit_rank`,
`outfit_rank_desc`,
`outfit_join_date`,
`create_date`,
`last_login_date`,
`last_save_date`,
`battle_rank`,
`login_count`,
`minutes_played`,
`bi_date`)

SELECT 
`stg_dim_character`.`character_id`,
`stg_dim_character`.`character_name`,
`stg_dim_character`.`world_id`,
`stg_dim_character`.`world_desc`,
`stg_dim_character`.`faction_id`,
`stg_dim_character`.`faction_desc`,
`stg_dim_character`.`faction_tag`,
`dim_character`.`outfit_key`,
`stg_dim_character`.`outfit_name`,
`stg_dim_character`.`outfit_tag`,
`stg_dim_character`.`outfit_rank`,
`stg_dim_character`.`outfit_rank_desc`,
`stg_dim_character`.`outfit_join_date`,
`stg_dim_character`.`create_date`,
`stg_dim_character`.`last_login_date`,
`stg_dim_character`.`last_save_date`,
`stg_dim_character`.`battle_rank`,
`stg_dim_character`.`login_count`,
`stg_dim_character`.`minutes_played`,
curdate()

FROM `ps2bi_stg`.`stg_dim_character`
left join `ps2bi_dwh`.`dim_character`
on `stg_dim_character`.`character_id` = `dim_character`.`character_id`
left join `ps2bi_dwh`.`dim_outfit`
on `stg_dim_character`.`outfit_id` = `dim_outfit`.`outfit_id`

where `dim_character`.`character_id` is null
and `stg_dim_character`.`character_name` is not null;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dim_date_load` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`trooper`@`localhost` PROCEDURE `dim_date_load`()
BEGIN

declare n int;
declare max_date date;

set n = 0;

while n < 750 do
	
	set n = n + 1;
	
	set max_date = (select max(date_field) From dim_date);

	INSERT INTO `ps2bi_dwh`.`dim_date`
	(`date_field`,
	`year`,
	`month_in_year`,
	`month_desc`,
	`week_in_year`,
	`day_in_week`,
	`timestamp_start`,
	`timestamp_end`)

	Select
	max_date + interval 1 day,
	year(max_date + interval 1 day),
	month(max_date + interval 1 day),
	monthname(max_date + interval 1 day),
	week(max_date + interval 1 day),
	weekday(max_date + interval 1 day),
	unix_timestamp(max_date + interval 1 day),
	unix_timestamp(max_date + interval 1 day) + 86399;

End While;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dim_item_load` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`trooper`@`%` PROCEDURE `dim_item_load`()
BEGIN

UPDATE `ps2bi_dwh`.`dim_item`
join `ps2bi_stg`.`stg_dim_item`
on `dim_item`.`item_id` = `stg_dim_item`.`item_id`

SET
`dim_item`.`item_id` = `stg_dim_item`.`item_id`,
`dim_item`.`item_desc` = `stg_dim_item`.`item_desc`,
`dim_item`.`faction_id` = `stg_dim_item`.`faction_id`,
`dim_item`.`faction_desc` = `stg_dim_item`.`faction_desc`,
`dim_item`.`faction_tag` = `stg_dim_item`.`faction_tag`,
`dim_item`.`item_category_id` = `stg_dim_item`.`item_category_id`,
`dim_item`.`item_category_desc` = `stg_dim_item`.`item_category_desc`,
`dim_item`.`item_type_id` = `stg_dim_item`.`item_type_id`,
`dim_item`.`item_type_desc` = `stg_dim_item`.`item_type_desc`,
`dim_item`.`is_vehicle_weapon` = `stg_dim_item`.`is_vehicle_weapon`,
`dim_item`.`bi_date` = current_date();

INSERT INTO `ps2bi_dwh`.`dim_item`
(`item_id`,
`item_desc`,
`faction_id`,
`faction_desc`,
`faction_tag`,
`item_category_id`,
`item_category_desc`,
`item_type_id`,
`item_type_desc`,
`is_vehicle_weapon`,
`bi_date`)

SELECT 
`stg_dim_item`.`item_id`,
`stg_dim_item`.`item_desc`,
`stg_dim_item`.`faction_id`,
`stg_dim_item`.`faction_desc`,
`stg_dim_item`.`faction_tag`,
`stg_dim_item`.`item_category_id`,
`stg_dim_item`.`item_category_desc`,
`stg_dim_item`.`item_type_id`,
`stg_dim_item`.`item_type_desc`,
`stg_dim_item`.`is_vehicle_weapon`,
current_date()

FROM `ps2bi_stg`.`stg_dim_item`
LEFT JOIN `ps2bi_dwh`.`dim_item`
on `stg_dim_item`.`item_id` = `dim_item`.`item_id`

where `dim_item`.`item_id` is null;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dim_outfit_load` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`trooper`@`%` PROCEDURE `dim_outfit_load`()
BEGIN

UPDATE `ps2bi_dwh`.`dim_outfit`
join `ps2bi_stg`.`stg_dim_outfit`
on `dim_outfit`.`outfit_id` = `stg_dim_outfit`.`outfit_id`

SET
`dim_outfit`.`outfit_id` = `stg_dim_outfit`.`outfit_id`,
`dim_outfit`.`outfit_name` = `stg_dim_outfit`.`outfit_name`,
`dim_outfit`.`outfit_tag` = `stg_dim_outfit`.`outfit_tag`,
`dim_outfit`.`world_id` = `stg_dim_outfit`.`world_id`,
`dim_outfit`.`world_desc` = `stg_dim_outfit`.`world_desc`,
`dim_outfit`.`faction_id` = `stg_dim_outfit`.`faction_id`,
`dim_outfit`.`faction_desc` = `stg_dim_outfit`.`faction_desc`,
`dim_outfit`.`member_count` = `stg_dim_outfit`.`member_count`,
`dim_outfit`.`create_date` = `stg_dim_outfit`.`create_date`,
`bi_date` = curdate()

WHERE `stg_dim_outfit`.`outfit_id` is not null;

INSERT INTO `ps2bi_dwh`.`dim_outfit`
(`outfit_id`,
`outfit_name`,
`outfit_tag`,
`world_id`,
`world_desc`,
`faction_id`,
`faction_desc`,
`member_count`,
`create_date`,
`bi_date`)

SELECT 
`stg_dim_outfit`.`outfit_id`,
`stg_dim_outfit`.`outfit_name`,
`stg_dim_outfit`.`outfit_tag`,
`stg_dim_outfit`.`world_id`,
`stg_dim_outfit`.`world_desc`,
`stg_dim_outfit`.`faction_id`,
`stg_dim_outfit`.`faction_desc`,
`stg_dim_outfit`.`member_count`,
date(from_unixtime(`stg_dim_outfit`.`create_date`)),
curdate()

FROM `ps2bi_stg`.`stg_dim_outfit`
left join `ps2bi_dwh`.`dim_outfit`
on `stg_dim_outfit`.`outfit_id` = `dim_outfit`.`outfit_id`

where `dim_outfit`.`outfit_id` is null;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fct_playtime_load` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`trooper`@`localhost` PROCEDURE `fct_playtime_load`()
BEGIN

UPDATE `ps2bi_dwh`.`fct_playtime`
join `ps2bi_stg`.`stg_fct_playtime`
on `fct_playtime`.`date_key` = `stg_fct_playtime`.`date_key` 
and `fct_playtime`.`character_key` = `stg_fct_playtime`.`character_key`

SET
`fct_playtime`.`date_key` = `stg_fct_playtime`.`date_key`,
`fct_playtime`.`character_key` = `stg_fct_playtime`.`character_key`,
`fct_playtime`.`logins` = `fct_playtime`.`logins` + `stg_fct_playtime`.`logins`,
`fct_playtime`.`playtime` = `fct_playtime`.`playtime` + `stg_fct_playtime`.`playtime`,
`fct_playtime`.`bi_date` = curdate();

INSERT INTO `ps2bi_dwh`.`fct_playtime`
(`date_key`,
`character_key`,
`logins`,
`playtime`,
`bi_date`)

SELECT 
`stg_fct_playtime`.`date_key`,
`stg_fct_playtime`.`character_key`,
`stg_fct_playtime`.`logins`,
`stg_fct_playtime`.`playtime`,
curdate()

FROM `ps2bi_stg`.`stg_fct_playtime`
left join `ps2bi_dwh`.`fct_playtime`
on `stg_fct_playtime`.`date_key` = `fct_playtime`.`date_key`
and `stg_fct_playtime`.`character_key` = `fct_playtime`.`character_key`

where `fct_playtime`.`date_key` is null
and `fct_playtime`.`character_key` is null;

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

-- Dump completed on 2015-04-22 20:38:00
