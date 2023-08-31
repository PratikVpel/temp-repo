-- --------------------------------------------------------
-- Host:                         192.168.0.241
-- Server version:               8.0.34-0ubuntu0.20.04.1 - (Ubuntu)
-- Server OS:                    Linux
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for vstdb
DROP DATABASE IF EXISTS `vstdb`;
CREATE DATABASE IF NOT EXISTS `vstdb` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vstdb`;

-- Dumping structure for table vstdb.address
DROP TABLE IF EXISTS `address`;
CREATE TABLE IF NOT EXISTS `address` (
  `address_pk` int NOT NULL AUTO_INCREMENT,
  `street` varchar(1000) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `house_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `zip_code` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`address_pk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.address: ~0 rows (approximately)

-- Dumping structure for table vstdb.charge_box
DROP TABLE IF EXISTS `charge_box`;
CREATE TABLE IF NOT EXISTS `charge_box` (
  `charge_box_pk` int NOT NULL AUTO_INCREMENT,
  `charge_box_id` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `endpoint_address` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ocpp_protocol` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `registration_status` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'Accepted',
  `charge_point_vendor` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `charge_point_model` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `charge_point_serial_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `charge_box_serial_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `fw_version` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `fw_update_status` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `fw_update_timestamp` timestamp(6) NULL DEFAULT NULL,
  `iccid` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `imsi` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meter_type` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meter_serial_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `diagnostics_status` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `diagnostics_timestamp` timestamp(6) NULL DEFAULT NULL,
  `last_heartbeat_timestamp` timestamp(6) NULL DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb3_unicode_ci,
  `note` mediumtext COLLATE utf8mb3_unicode_ci,
  `location_latitude` decimal(11,8) DEFAULT NULL,
  `location_longitude` decimal(11,8) DEFAULT NULL,
  `address_pk` int DEFAULT NULL,
  `admin_address` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `insert_connector_status_after_transaction_msg` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`charge_box_pk`),
  UNIQUE KEY `chargeBoxId_UNIQUE` (`charge_box_id`),
  KEY `chargebox_op_ep_idx` (`ocpp_protocol`,`endpoint_address`),
  KEY `FK_charge_box_address_apk` (`address_pk`),
  CONSTRAINT `FK_charge_box_address_apk` FOREIGN KEY (`address_pk`) REFERENCES `address` (`address_pk`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.charge_box: ~1 rows (approximately)
REPLACE INTO `charge_box` (`charge_box_pk`, `charge_box_id`, `endpoint_address`, `ocpp_protocol`, `registration_status`, `charge_point_vendor`, `charge_point_model`, `charge_point_serial_number`, `charge_box_serial_number`, `fw_version`, `fw_update_status`, `fw_update_timestamp`, `iccid`, `imsi`, `meter_type`, `meter_serial_number`, `diagnostics_status`, `diagnostics_timestamp`, `last_heartbeat_timestamp`, `description`, `note`, `location_latitude`, `location_longitude`, `address_pk`, `admin_address`, `insert_connector_status_after_transaction_msg`) VALUES
	(3, 'VPEL', NULL, 'ocpp1.6J', 'Accepted', 'VIRTUOSO', 'T2AC', 'VPEL', 'VPEL', '0.0.9.12', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '2023-08-29 10:13:59.894000', NULL, NULL, NULL, NULL, NULL, NULL, 0);

-- Dumping structure for table vstdb.charging_profile
DROP TABLE IF EXISTS `charging_profile`;
CREATE TABLE IF NOT EXISTS `charging_profile` (
  `charging_profile_pk` int NOT NULL AUTO_INCREMENT,
  `stack_level` int NOT NULL,
  `charging_profile_purpose` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `charging_profile_kind` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `recurrency_kind` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `valid_from` timestamp(6) NULL DEFAULT NULL,
  `valid_to` timestamp(6) NULL DEFAULT NULL,
  `duration_in_seconds` int DEFAULT NULL,
  `start_schedule` timestamp(6) NULL DEFAULT NULL,
  `charging_rate_unit` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `min_charging_rate` decimal(15,1) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`charging_profile_pk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.charging_profile: ~0 rows (approximately)

-- Dumping structure for table vstdb.charging_schedule_period
DROP TABLE IF EXISTS `charging_schedule_period`;
CREATE TABLE IF NOT EXISTS `charging_schedule_period` (
  `charging_profile_pk` int NOT NULL,
  `start_period_in_seconds` int NOT NULL,
  `power_limit` decimal(15,1) NOT NULL,
  `number_phases` int DEFAULT NULL,
  UNIQUE KEY `UQ_charging_schedule_period` (`charging_profile_pk`,`start_period_in_seconds`),
  CONSTRAINT `FK_charging_schedule_period_charging_profile_pk` FOREIGN KEY (`charging_profile_pk`) REFERENCES `charging_profile` (`charging_profile_pk`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.charging_schedule_period: ~0 rows (approximately)

-- Dumping structure for table vstdb.connector
DROP TABLE IF EXISTS `connector`;
CREATE TABLE IF NOT EXISTS `connector` (
  `connector_pk` int unsigned NOT NULL AUTO_INCREMENT,
  `charge_box_id` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `connector_id` int NOT NULL,
  PRIMARY KEY (`connector_pk`),
  UNIQUE KEY `connector_pk_UNIQUE` (`connector_pk`),
  UNIQUE KEY `connector_cbid_cid_UNIQUE` (`charge_box_id`,`connector_id`),
  CONSTRAINT `FK_connector_charge_box_cbid` FOREIGN KEY (`charge_box_id`) REFERENCES `charge_box` (`charge_box_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=416 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.connector: ~2 rows (approximately)
REPLACE INTO `connector` (`connector_pk`, `charge_box_id`, `connector_id`) VALUES
	(359, 'VPEL', 0),
	(360, 'VPEL', 1);

-- Dumping structure for table vstdb.connector_charging_profile
DROP TABLE IF EXISTS `connector_charging_profile`;
CREATE TABLE IF NOT EXISTS `connector_charging_profile` (
  `connector_pk` int unsigned NOT NULL,
  `charging_profile_pk` int NOT NULL,
  UNIQUE KEY `UQ_connector_charging_profile` (`connector_pk`,`charging_profile_pk`),
  KEY `FK_connector_charging_profile_charging_profile_pk` (`charging_profile_pk`),
  CONSTRAINT `FK_connector_charging_profile_charging_profile_pk` FOREIGN KEY (`charging_profile_pk`) REFERENCES `charging_profile` (`charging_profile_pk`),
  CONSTRAINT `FK_connector_charging_profile_connector_pk` FOREIGN KEY (`connector_pk`) REFERENCES `connector` (`connector_pk`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.connector_charging_profile: ~0 rows (approximately)

-- Dumping structure for table vstdb.connector_meter_value
DROP TABLE IF EXISTS `connector_meter_value`;
CREATE TABLE IF NOT EXISTS `connector_meter_value` (
  `connector_pk` int unsigned NOT NULL,
  `transaction_pk` int unsigned DEFAULT NULL,
  `value_timestamp` timestamp(6) NULL DEFAULT NULL,
  `value` text COLLATE utf8mb3_unicode_ci,
  `reading_context` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `format` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `measurand` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `unit` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phase` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  KEY `FK_cm_pk_idx` (`connector_pk`),
  KEY `FK_tid_cm_idx` (`transaction_pk`),
  KEY `cmv_value_timestamp_idx` (`value_timestamp`),
  CONSTRAINT `FK_pk_cm` FOREIGN KEY (`connector_pk`) REFERENCES `connector` (`connector_pk`) ON DELETE CASCADE,
  CONSTRAINT `FK_tid_cm` FOREIGN KEY (`transaction_pk`) REFERENCES `transaction_start` (`transaction_pk`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.connector_meter_value: ~4 rows (approximately)
REPLACE INTO `connector_meter_value` (`connector_pk`, `transaction_pk`, `value_timestamp`, `value`, `reading_context`, `format`, `measurand`, `location`, `unit`, `phase`) VALUES
	(360, 15, '2023-08-29 15:51:37.000000', '189.200012', 'Transaction.Begin', NULL, 'Energy.Active.Import.Register', NULL, 'Wh', NULL),
	(360, 15, '2023-08-29 15:51:52.000000', '189.500015', 'Transaction.End', NULL, 'Energy.Active.Import.Register', NULL, 'Wh', NULL),
	(360, 16, '2023-08-29 15:52:44.000000', '189.600021', 'Transaction.Begin', NULL, 'Energy.Active.Import.Register', NULL, 'Wh', NULL),
	(360, 16, '2023-08-29 15:53:15.000000', '189.800018', 'Transaction.End', NULL, 'Energy.Active.Import.Register', NULL, 'Wh', NULL);

-- Dumping structure for table vstdb.connector_status
DROP TABLE IF EXISTS `connector_status`;
CREATE TABLE IF NOT EXISTS `connector_status` (
  `connector_pk` int unsigned NOT NULL,
  `status_timestamp` timestamp(6) NULL DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `error_code` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `error_info` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `vendor_id` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `vendor_error_code` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  KEY `FK_cs_pk_idx` (`connector_pk`),
  KEY `connector_status_cpk_st_idx` (`connector_pk`,`status_timestamp`),
  CONSTRAINT `FK_cs_pk` FOREIGN KEY (`connector_pk`) REFERENCES `connector` (`connector_pk`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.connector_status: ~16 rows (approximately)
REPLACE INTO `connector_status` (`connector_pk`, `status_timestamp`, `status`, `error_code`, `error_info`, `vendor_id`, `vendor_error_code`) VALUES
	(359, '2023-08-29 14:45:54.000000', 'Available', 'NoError', 'NoError', 'VIRTUOSO', '0'),
	(360, '2023-08-29 14:45:56.000000', 'Available', 'NoError', 'NoError', 'VIRTUOSO', '0'),
	(359, '2023-08-29 14:49:57.000000', 'Available', 'NoError', 'NoError', 'VIRTUOSO', '0'),
	(360, '2023-08-29 14:50:31.000000', 'Faulted', 'GroundFailure', 'NoError', 'VIRTUOSO', '0'),
	(360, '2023-08-29 14:50:37.000000', 'Available', 'GroundFailure', 'NoError', 'VIRTUOSO', '0'),
	(360, '2023-08-29 14:51:14.000000', 'Faulted', 'GroundFailure', 'NoError', 'VIRTUOSO', '0'),
	(360, '2023-08-29 14:51:24.000000', 'Available', 'GroundFailure', 'NoError', 'VIRTUOSO', '0'),
	(359, '2023-08-29 15:44:01.000000', 'Available', 'NoError', 'NoError', 'VIRTUOSO', '0'),
	(360, '2023-08-29 15:44:04.000000', 'Available', 'NoError', 'NoError', 'VIRTUOSO', '0'),
	(359, '2023-08-29 15:46:57.000000', 'Available', 'NoError', 'NoError', 'VIRTUOSO', '0'),
	(360, '2023-08-29 15:51:39.000000', 'Charging', 'NoError', 'NoError', 'VIRTUOSO', '0'),
	(360, '2023-08-29 15:51:54.000000', 'Finishing', 'NoError', 'NoError', 'VIRTUOSO', '0'),
	(360, '2023-08-29 15:51:56.000000', 'Available', 'NoError', 'NoError', 'VIRTUOSO', '0'),
	(360, '2023-08-29 15:52:47.000000', 'Charging', 'NoError', 'NoError', 'VIRTUOSO', '0'),
	(360, '2023-08-29 15:53:17.000000', 'Finishing', 'NoError', 'NoError', 'VIRTUOSO', '0'),
	(360, '2023-08-29 15:53:20.000000', 'Available', 'NoError', 'NoError', 'VIRTUOSO', '0');

-- Dumping structure for table vstdb.ocpp_tag
DROP TABLE IF EXISTS `ocpp_tag`;
CREATE TABLE IF NOT EXISTS `ocpp_tag` (
  `ocpp_tag_pk` int NOT NULL AUTO_INCREMENT,
  `id_tag` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `parent_id_tag` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `expiry_date` timestamp(6) NULL DEFAULT NULL,
  `max_active_transaction_count` int NOT NULL DEFAULT '1',
  `note` mediumtext COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`ocpp_tag_pk`),
  UNIQUE KEY `idTag_UNIQUE` (`id_tag`),
  KEY `user_expiryDate_idx` (`expiry_date`),
  KEY `FK_ocpp_tag_parent_id_tag` (`parent_id_tag`),
  CONSTRAINT `FK_ocpp_tag_parent_id_tag` FOREIGN KEY (`parent_id_tag`) REFERENCES `ocpp_tag` (`id_tag`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.ocpp_tag: ~1 rows (approximately)
REPLACE INTO `ocpp_tag` (`ocpp_tag_pk`, `id_tag`, `parent_id_tag`, `expiry_date`, `max_active_transaction_count`, `note`) VALUES
	(17, '1', NULL, '2023-10-30 18:30:00.000000', 1, NULL);

-- Dumping structure for view vstdb.ocpp_tag_activity
DROP VIEW IF EXISTS `ocpp_tag_activity`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `ocpp_tag_activity` (
	`ocpp_tag_pk` INT(10) NOT NULL,
	`id_tag` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_unicode_ci',
	`parent_id_tag` VARCHAR(255) NULL COLLATE 'utf8mb3_unicode_ci',
	`expiry_date` TIMESTAMP(6) NULL,
	`max_active_transaction_count` INT(10) NOT NULL,
	`note` MEDIUMTEXT NULL COLLATE 'utf8mb3_unicode_ci',
	`active_transaction_count` BIGINT(19) NOT NULL,
	`in_transaction` INT(10) NOT NULL,
	`blocked` INT(10) NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for table vstdb.reservation
DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `reservation_pk` int unsigned NOT NULL AUTO_INCREMENT,
  `connector_pk` int unsigned NOT NULL,
  `transaction_pk` int unsigned DEFAULT NULL,
  `id_tag` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `expiry_datetime` datetime DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`reservation_pk`),
  UNIQUE KEY `reservation_pk_UNIQUE` (`reservation_pk`),
  UNIQUE KEY `transaction_pk_UNIQUE` (`transaction_pk`),
  KEY `FK_idTag_r_idx` (`id_tag`),
  KEY `reservation_start_idx` (`start_datetime`),
  KEY `reservation_expiry_idx` (`expiry_datetime`),
  KEY `reservation_status_idx` (`status`),
  KEY `FK_connector_pk_reserv_idx` (`connector_pk`),
  CONSTRAINT `FK_connector_pk_reserv` FOREIGN KEY (`connector_pk`) REFERENCES `connector` (`connector_pk`) ON DELETE CASCADE,
  CONSTRAINT `FK_reservation_ocpp_tag_id_tag` FOREIGN KEY (`id_tag`) REFERENCES `ocpp_tag` (`id_tag`) ON DELETE CASCADE,
  CONSTRAINT `FK_transaction_pk_r` FOREIGN KEY (`transaction_pk`) REFERENCES `transaction_start` (`transaction_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.reservation: ~0 rows (approximately)

-- Dumping structure for table vstdb.schema_version
DROP TABLE IF EXISTS `schema_version`;
CREATE TABLE IF NOT EXISTS `schema_version` (
  `installed_rank` int NOT NULL,
  `version` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `description` varchar(200) COLLATE utf8mb3_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `script` varchar(1000) COLLATE utf8mb3_unicode_ci NOT NULL,
  `checksum` int DEFAULT NULL,
  `installed_by` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  KEY `schema_version_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.schema_version: ~35 rows (approximately)
REPLACE INTO `schema_version` (`installed_rank`, `version`, `description`, `type`, `script`, `checksum`, `installed_by`, `installed_on`, `execution_time`, `success`) VALUES
	(1, '0.6.6', 'inital', 'SQL', 'V0_6_6__inital.sql', -1139003720, 'vst', '2023-08-08 16:17:34', 648, 1),
	(2, '0.6.7', 'update', 'SQL', 'V0_6_7__update.sql', -1516276887, 'vst', '2023-08-08 16:17:34', 101, 1),
	(3, '0.6.8', 'update', 'SQL', 'V0_6_8__update.sql', 1153526272, 'vst', '2023-08-08 16:17:34', 24, 1),
	(4, '0.6.9', 'update', 'SQL', 'V0_6_9__update.sql', 684651776, 'vst', '2023-08-08 16:17:34', 53, 1),
	(5, '0.7.0', 'update', 'SQL', 'V0_7_0__update.sql', -1304612786, 'vst', '2023-08-08 16:17:34', 76, 1),
	(6, '0.7.1', 'update', 'SQL', 'V0_7_1__update.sql', 2010441416, 'vst', '2023-08-08 16:17:34', 156, 1),
	(7, '0.7.2', 'update', 'SQL', 'V0_7_2__update.sql', 1942726372, 'vst', '2023-08-08 16:17:34', 38, 1),
	(8, '0.7.3', 'update', 'SQL', 'V0_7_3__update.sql', -914877656, 'vst', '2023-08-08 16:17:35', 35, 1),
	(9, '0.7.6', 'update', 'SQL', 'V0_7_6__update.sql', 1847569673, 'vst', '2023-08-08 16:17:35', 54, 1),
	(10, '0.7.7', 'update', 'SQL', 'V0_7_7__update.sql', -1987713944, 'vst', '2023-08-08 16:17:38', 3056, 1),
	(11, '0.7.8', 'update', 'SQL', 'V0_7_8__update.sql', 1734849553, 'vst', '2023-08-08 16:17:38', 27, 1),
	(12, '0.7.9', 'update', 'SQL', 'V0_7_9__update.sql', -1187991930, 'vst', '2023-08-08 16:17:38', 254, 1),
	(13, '0.8.0', 'update', 'SQL', 'V0_8_0__update.sql', -463816886, 'vst', '2023-08-08 16:17:38', 114, 1),
	(14, '0.8.1', 'update', 'SQL', 'V0_8_1__update.sql', 1213582250, 'vst', '2023-08-08 16:17:40', 1993, 1),
	(15, '0.8.2', 'update', 'SQL', 'V0_8_2__update.sql', -1417404311, 'vst', '2023-08-08 16:17:40', 20, 1),
	(16, '0.8.4', 'update', 'SQL', 'V0_8_4__update.sql', -1620751535, 'vst', '2023-08-08 16:17:42', 1486, 1),
	(17, '0.8.5', 'update', 'SQL', 'V0_8_5__update.sql', -1961223140, 'vst', '2023-08-08 16:17:42', 333, 1),
	(18, '0.8.6', 'update', 'SQL', 'V0_8_6__update.sql', -599908031, 'vst', '2023-08-08 16:17:49', 6768, 1),
	(19, '0.8.7', 'update', 'SQL', 'V0_8_7__update.sql', 817528938, 'vst', '2023-08-08 16:17:49', 37, 1),
	(20, '0.8.8', 'update', 'SQL', 'V0_8_8__update.sql', -1218381409, 'vst', '2023-08-08 16:17:49', 25, 1),
	(21, '0.8.9', 'update', 'SQL', 'V0_8_9__update.sql', 467917572, 'vst', '2023-08-08 16:17:49', 13, 1),
	(22, '0.9.0', 'update', 'SQL', 'V0_9_0__update.sql', -156261502, 'vst', '2023-08-08 16:17:50', 1034, 1),
	(23, '0.9.1', 'update', 'SQL', 'V0_9_1__update.sql', 554940430, 'vst', '2023-08-08 16:17:50', 25, 1),
	(24, '0.9.2', 'update', 'SQL', 'V0_9_2__update.sql', -1162599634, 'vst', '2023-08-08 16:17:51', 49, 1),
	(25, '0.9.3', 'update', 'SQL', 'V0_9_3__update.sql', 967813954, 'vst', '2023-08-08 16:17:51', 20, 1),
	(26, '0.9.4', 'update', 'SQL', 'V0_9_4__update.sql', 1698316188, 'vst', '2023-08-08 16:17:51', 6, 1),
	(27, '0.9.5', 'update', 'SQL', 'V0_9_5__update.sql', -1980845887, 'vst', '2023-08-08 16:17:51', 36, 1),
	(28, '0.9.6', 'update', 'SQL', 'V0_9_6__update.sql', -619431009, 'vst', '2023-08-08 16:17:51', 241, 1),
	(29, '0.9.7', 'update', 'SQL', 'V0_9_7__update.sql', -1352017997, 'vst', '2023-08-08 16:17:52', 1513, 1),
	(30, '0.9.8', 'update', 'SQL', 'V0_9_8__update.sql', 1465629204, 'vst', '2023-08-08 16:17:53', 264, 1),
	(31, '0.9.9', 'update', 'SQL', 'V0_9_9__update.sql', 1154327139, 'vst', '2023-08-08 16:17:53', 95, 1),
	(32, '1.0.0', 'update', 'SQL', 'V1_0_0__update.sql', -589444344, 'vst', '2023-08-08 16:17:53', 21, 1),
	(33, '1.0.1', 'update', 'SQL', 'V1_0_1__update.sql', -1119099309, 'vst', '2023-08-08 16:17:53', 70, 1),
	(34, '1.0.2', 'update', 'SQL', 'V1_0_2__update.sql', 1724842041, 'vst', '2023-08-08 16:17:53', 40, 1),
	(35, '1.0.3', 'update', 'SQL', 'V1_0_3__update.sql', 1680705266, 'vst', '2023-08-08 16:17:53', 17, 1);

-- Dumping structure for table vstdb.settings
DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `app_id` varchar(40) COLLATE utf8mb3_unicode_ci NOT NULL,
  `heartbeat_interval_in_seconds` int DEFAULT NULL,
  `hours_to_expire` int DEFAULT NULL,
  `mail_enabled` tinyint(1) DEFAULT '0',
  `mail_host` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `mail_username` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `mail_password` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `mail_from` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `mail_protocol` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT 'smtp',
  `mail_port` int DEFAULT '25',
  `mail_recipients` text COLLATE utf8mb3_unicode_ci COMMENT 'comma separated list of email addresses',
  `notification_features` text COLLATE utf8mb3_unicode_ci COMMENT 'comma separated list',
  PRIMARY KEY (`app_id`),
  UNIQUE KEY `settings_id_UNIQUE` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.settings: ~1 rows (approximately)
REPLACE INTO `settings` (`app_id`, `heartbeat_interval_in_seconds`, `hours_to_expire`, `mail_enabled`, `mail_host`, `mail_username`, `mail_password`, `mail_from`, `mail_protocol`, `mail_port`, `mail_recipients`, `notification_features`) VALUES
	('U3RlY2tkb3NlblZlcndhbHR1bmc=', 14400, 1, 1, 'smtp.gmail.com', 'vst.message@gmail.com', 'bmnaahzkykxczulf', 'vst.message@gmail.com', 'smtp', 587, 'pratik.pingale@virtuososofttech.com,yogesh.dev@vpel.in', 'OcppStationBooted');

-- Dumping structure for view vstdb.transaction
DROP VIEW IF EXISTS `transaction`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `transaction` (
	`transaction_pk` INT(10) UNSIGNED NOT NULL,
	`connector_pk` INT(10) UNSIGNED NOT NULL,
	`id_tag` VARCHAR(255) NOT NULL COLLATE 'utf8mb3_unicode_ci',
	`start_event_timestamp` TIMESTAMP(6) NOT NULL,
	`start_timestamp` TIMESTAMP(6) NULL,
	`start_value` VARCHAR(255) NULL COLLATE 'utf8mb3_unicode_ci',
	`stop_event_actor` ENUM('station','manual') NULL COLLATE 'utf8mb3_unicode_ci',
	`stop_event_timestamp` TIMESTAMP(6) NULL,
	`stop_timestamp` TIMESTAMP(6) NULL,
	`stop_value` VARCHAR(255) NULL COLLATE 'utf8mb3_unicode_ci',
	`stop_reason` VARCHAR(255) NULL COLLATE 'utf8mb3_unicode_ci'
) ENGINE=MyISAM;

-- Dumping structure for table vstdb.transaction_start
DROP TABLE IF EXISTS `transaction_start`;
CREATE TABLE IF NOT EXISTS `transaction_start` (
  `transaction_pk` int unsigned NOT NULL AUTO_INCREMENT,
  `event_timestamp` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `connector_pk` int unsigned NOT NULL,
  `id_tag` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `start_timestamp` timestamp(6) NULL DEFAULT NULL,
  `start_value` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`transaction_pk`),
  UNIQUE KEY `transaction_pk_UNIQUE` (`transaction_pk`),
  KEY `idTag_idx` (`id_tag`),
  KEY `connector_pk_idx` (`connector_pk`),
  KEY `transaction_start_idx` (`start_timestamp`),
  CONSTRAINT `FK_connector_pk_t` FOREIGN KEY (`connector_pk`) REFERENCES `connector` (`connector_pk`) ON DELETE CASCADE,
  CONSTRAINT `FK_transaction_ocpp_tag_id_tag` FOREIGN KEY (`id_tag`) REFERENCES `ocpp_tag` (`id_tag`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.transaction_start: ~2 rows (approximately)
REPLACE INTO `transaction_start` (`transaction_pk`, `event_timestamp`, `connector_pk`, `id_tag`, `start_timestamp`, `start_value`) VALUES
	(15, '2023-08-29 10:21:37.796000', 360, '1', '2023-08-29 15:51:35.000000', '189'),
	(16, '2023-08-29 10:22:45.159000', 360, '1', '2023-08-29 15:52:42.000000', '189');

-- Dumping structure for table vstdb.transaction_stop
DROP TABLE IF EXISTS `transaction_stop`;
CREATE TABLE IF NOT EXISTS `transaction_stop` (
  `transaction_pk` int unsigned NOT NULL,
  `event_timestamp` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `event_actor` enum('station','manual') COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `stop_timestamp` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `stop_value` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `stop_reason` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`transaction_pk`,`event_timestamp`),
  CONSTRAINT `FK_transaction_stop_transaction_pk` FOREIGN KEY (`transaction_pk`) REFERENCES `transaction_start` (`transaction_pk`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.transaction_stop: ~2 rows (approximately)
REPLACE INTO `transaction_stop` (`transaction_pk`, `event_timestamp`, `event_actor`, `stop_timestamp`, `stop_value`, `stop_reason`) VALUES
	(15, '2023-08-29 10:21:53.486000', 'station', '2023-08-29 15:51:51.000000', '189', 'Remote'),
	(16, '2023-08-29 10:23:17.047000', 'station', '2023-08-29 15:53:15.000000', '189', 'Remote');

-- Dumping structure for table vstdb.transaction_stop_failed
DROP TABLE IF EXISTS `transaction_stop_failed`;
CREATE TABLE IF NOT EXISTS `transaction_stop_failed` (
  `transaction_pk` int DEFAULT NULL,
  `event_timestamp` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `event_actor` enum('station','manual') COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `stop_timestamp` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `stop_value` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `stop_reason` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `fail_reason` text COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.transaction_stop_failed: ~0 rows (approximately)

-- Dumping structure for table vstdb.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_pk` int NOT NULL AUTO_INCREMENT,
  `ocpp_tag_pk` int DEFAULT NULL,
  `address_pk` int DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `birth_day` date DEFAULT NULL,
  `sex` char(1) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `e_mail` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`user_pk`),
  KEY `FK_user_ocpp_tag_otpk` (`ocpp_tag_pk`),
  KEY `FK_user_address_apk` (`address_pk`),
  CONSTRAINT `FK_user_address_apk` FOREIGN KEY (`address_pk`) REFERENCES `address` (`address_pk`) ON DELETE SET NULL,
  CONSTRAINT `FK_user_ocpp_tag_otpk` FOREIGN KEY (`ocpp_tag_pk`) REFERENCES `ocpp_tag` (`ocpp_tag_pk`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Dumping data for table vstdb.user: ~0 rows (approximately)

-- Dumping structure for view vstdb.ocpp_tag_activity
DROP VIEW IF EXISTS `ocpp_tag_activity`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `ocpp_tag_activity`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `ocpp_tag_activity` AS select `ocpp_tag`.`ocpp_tag_pk` AS `ocpp_tag_pk`,`ocpp_tag`.`id_tag` AS `id_tag`,`ocpp_tag`.`parent_id_tag` AS `parent_id_tag`,`ocpp_tag`.`expiry_date` AS `expiry_date`,`ocpp_tag`.`max_active_transaction_count` AS `max_active_transaction_count`,`ocpp_tag`.`note` AS `note`,coalesce(`tx_activity`.`active_transaction_count`,0) AS `active_transaction_count`,(case when (`tx_activity`.`active_transaction_count` > 0) then true else false end) AS `in_transaction`,(case when (`ocpp_tag`.`max_active_transaction_count` = 0) then true else false end) AS `blocked` from (`ocpp_tag` left join (select `transaction`.`id_tag` AS `id_tag`,count(`transaction`.`id_tag`) AS `active_transaction_count` from `transaction` where ((`transaction`.`stop_timestamp` is null) and (`transaction`.`stop_value` is null)) group by `transaction`.`id_tag`) `tx_activity` on((`ocpp_tag`.`id_tag` = `tx_activity`.`id_tag`)));

-- Dumping structure for view vstdb.transaction
DROP VIEW IF EXISTS `transaction`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `transaction`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `transaction` AS select `tx1`.`transaction_pk` AS `transaction_pk`,`tx1`.`connector_pk` AS `connector_pk`,`tx1`.`id_tag` AS `id_tag`,`tx1`.`event_timestamp` AS `start_event_timestamp`,`tx1`.`start_timestamp` AS `start_timestamp`,`tx1`.`start_value` AS `start_value`,`tx2`.`event_actor` AS `stop_event_actor`,`tx2`.`event_timestamp` AS `stop_event_timestamp`,`tx2`.`stop_timestamp` AS `stop_timestamp`,`tx2`.`stop_value` AS `stop_value`,`tx2`.`stop_reason` AS `stop_reason` from (`transaction_start` `tx1` left join (select `s1`.`transaction_pk` AS `transaction_pk`,`s1`.`event_timestamp` AS `event_timestamp`,`s1`.`event_actor` AS `event_actor`,`s1`.`stop_timestamp` AS `stop_timestamp`,`s1`.`stop_value` AS `stop_value`,`s1`.`stop_reason` AS `stop_reason` from `transaction_stop` `s1` where (`s1`.`event_timestamp` = (select max(`s2`.`event_timestamp`) from `transaction_stop` `s2` where (`s1`.`transaction_pk` = `s2`.`transaction_pk`))) group by `s1`.`transaction_pk`,`s1`.`event_timestamp`) `tx2` on((`tx1`.`transaction_pk` = `tx2`.`transaction_pk`)));

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
