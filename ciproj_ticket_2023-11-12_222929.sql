/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
DROP TABLE IF EXISTS auth_groups_users;
CREATE TABLE `auth_groups_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `group` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_groups_users_user_id_foreign` (`user_id`),
  CONSTRAINT `auth_groups_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS auth_identities;
CREATE TABLE `auth_identities` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `secret` varchar(255) NOT NULL,
  `secret2` varchar(255) DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `extra` text DEFAULT NULL,
  `force_reset` tinyint(1) NOT NULL DEFAULT 0,
  `last_used_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_secret` (`type`,`secret`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `auth_identities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS auth_logins;
CREATE TABLE `auth_logins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(255) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `id_type` varchar(255) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `date` datetime NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_type_identifier` (`id_type`,`identifier`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS auth_permissions_users;
CREATE TABLE `auth_permissions_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `permission` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_permissions_users_user_id_foreign` (`user_id`),
  CONSTRAINT `auth_permissions_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS auth_remember_tokens;
CREATE TABLE `auth_remember_tokens` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `selector` varchar(255) NOT NULL,
  `hashedValidator` varchar(255) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `expires` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `selector` (`selector`),
  KEY `auth_remember_tokens_user_id_foreign` (`user_id`),
  CONSTRAINT `auth_remember_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS auth_token_logins;
CREATE TABLE `auth_token_logins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(255) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `id_type` varchar(255) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `date` datetime NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_type_identifier` (`id_type`,`identifier`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS migrations;
CREATE TABLE `migrations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS office;
CREATE TABLE `office` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `office_name` varchar(100) NOT NULL,
  `office_code` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `office_code` (`office_code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS settings;
CREATE TABLE `settings` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `class` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `type` varchar(31) NOT NULL DEFAULT 'string',
  `context` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS ticket;
CREATE TABLE `ticket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `office_id` int(5) NOT NULL,
  `severity` varchar(5) NOT NULL,
  `description` text NOT NULL,
  `state` varchar(50) NOT NULL DEFAULT 'PENDING',
  `remarks` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_user_id_foreign` (`user_id`),
  KEY `ticket_office_id_foreign` (`office_id`),
  CONSTRAINT `ticket_office_id_foreign` FOREIGN KEY (`office_id`) REFERENCES `office` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ticket_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user_details` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS users;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `status_message` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `last_active` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS user_details;
CREATE TABLE `user_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) unsigned NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `birthdate` date NOT NULL,
  `role` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `user_details_account_id_foreign` (`account_id`),
  CONSTRAINT `user_details_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `auth_identities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO auth_groups_users(id,user_id,group,created_at) VALUES('1','1','\'admin\'','\'2023-11-11 09:00:39\''),('2','2','\'user\'','\'2023-11-11 13:39:08\'');

INSERT INTO auth_identities(id,user_id,type,name,secret,secret2,expires,extra,force_reset,last_used_at,created_at,updated_at) VALUES('1','1','\'email_password\'','NULL','\'kurtleones13@gmail.com\'','\'$2y$12$YD2w7zWM8yxiIKKAYrkAZeq1bfoiUEI34gfMIr1hYxYUAWIlEd9lS\'','NULL','NULL','0','\'2023-11-12 12:25:38\'','\'2023-11-11 09:00:39\'','\'2023-11-12 12:25:38\''),('2','2','\'email_password\'','NULL','\'kurt_leones@yahoo.com\'','\'$2y$12$.dqtgdpEiBjpvDTwAqFwFuGRWXyUiSHQ1Zg04RwPusHleSdS39FU.\'','NULL','NULL','0','\'2023-11-11 14:52:07\'','\'2023-11-11 13:39:08\'','\'2023-11-11 14:52:07\'');

INSERT INTO auth_logins(id,ip_address,user_agent,id_type,identifier,user_id,date,success) VALUES('1','\'::1\'','\'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36 OPR/102.0.0.0\'','\'email_password\'','\'kurtleones13@gmail.com\'','1','\'2023-11-11 09:02:44\'','1'),('2','\'::1\'','\'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36 OPR/102.0.0.0\'','\'email_password\'','\'kurtleones13@gmail.com\'','1','\'2023-11-11 14:51:47\'','1'),('3','\'::1\'','\'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36 OPR/102.0.0.0\'','\'email_password\'','\'kurt_leones@yahoo.com\'','2','\'2023-11-11 14:52:07\'','1'),('4','\'::1\'','\'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36 OPR/102.0.0.0\'','\'email_password\'','\'kurtleones13@gmail.com\'','1','\'2023-11-11 23:43:42\'','1'),('5','\'::1\'','\'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36 OPR/102.0.0.0\'','\'email_password\'','\'kurtleones13@gmail.com\'','1','\'2023-11-12 12:25:38\'','1');


INSERT INTO auth_remember_tokens(id,selector,hashedValidator,user_id,expires,created_at,updated_at) VALUES('1','\'a9412e6022392c0bd32860e2\'','\'65296c71ba5acc42ce59f9e160f592499c74b64734dce8d4a8a3b347b8d41bd1\'','1','\'2023-12-12 09:52:45\'','\'2023-11-11 23:43:42\'','\'2023-11-12 09:52:45\'');


INSERT INTO migrations(id,version,class,group,namespace,time,batch) VALUES('1','\'2020-12-28-223112\'','\'CodeIgniter\\\\Shield\\\\Database\\\\Migrations\\\\CreateAuthTables\'','\'default\'','\'CodeIgniter\\\\Shield\'','1699690621','1'),('2','\'2021-07-04-041948\'','\'CodeIgniter\\\\Settings\\\\Database\\\\Migrations\\\\CreateSettingsTable\'','\'default\'','\'CodeIgniter\\\\Settings\'','1699690621','1'),('3','\'2021-11-14-143905\'','\'CodeIgniter\\\\Settings\\\\Database\\\\Migrations\\\\AddContextColumn\'','\'default\'','\'CodeIgniter\\\\Settings\'','1699690621','1'),('4','\'2023-11-11-024249\'','\'App\\\\Database\\\\Migrations\\\\Office\'','\'default\'','\'App\'','1699691390','2'),('5','\'2023-11-11-024831\'','\'App\\\\Database\\\\Migrations\\\\User\'','\'default\'','\'App\'','1699692778','3'),('6','\'2023-11-11-024836\'','\'App\\\\Database\\\\Migrations\\\\Ticket\'','\'default\'','\'App\'','1699692778','3'),('7','\'2023-11-11-024837\'','\'App\\\\Database\\\\Migrations\\\\Ticket\'','\'default\'','\'App\'','1699746042','4');

INSERT INTO office(id,office_name,office_code,description,created_at,updated_at) VALUES('1','\'OFFICE OF THE MUNICIPAL TREASURER\'','\'MTO\'','\'OFFICE OF THE MUNICIPAL TREASURER\'','\'2023-11-11 15:21:18\'','\'2023-11-11 15:21:18\''),('2','\'OFFICE OF THE MUNICIPAL MAYOR\'','\'MMO\'','\'OFFICE OF THE MUNICIPAL MAYOR\'','\'2023-11-11 22:57:56\'','\'2023-11-11 22:57:56\''),('3','\'OFFICE OF THE MUNICIPAL ENGINEER\'','\'MEO\'','\'OFFICE OF THE MUNICIPAL ENGINEER\'','\'2023-11-11 22:58:12\'','\'2023-11-11 22:58:12\''),('4','\'OFFICE OF THE MUNICIPAL BUDGET OFFICER\'','\'MEOM\'','\'OFFICE OF THE MUNICIPAL BUDGET OFFICER\'','\'2023-11-12 12:06:54\'','\'2023-11-12 12:24:46\''),('6','\'OFFICE OF THE MUNICIPAL ASSESSOR\'','\'MAO\'','\'OFFICE OF THE MUNICIPAL ASSESSOR\'','\'2023-11-12 12:20:52\'','\'2023-11-12 12:20:52\'');


INSERT INTO ticket(id,user_id,office_id,severity,description,state,remarks,created_at,updated_at) VALUES('1','1','2','\'C\'','X\'4e4f20494e5445524e4554\'','\'PENDING\'','X\'\'','\'0000-00-00 00:00:00\'','\'0000-00-00 00:00:00\''),('2','1','6','\'H\'','X\'4e4f2046414345424f4f4b\'','\'PENDING\'','X\'\'','\'0000-00-00 00:00:00\'','\'0000-00-00 00:00:00\'');

INSERT INTO users(id,username,status,status_message,active,last_active,created_at,updated_at,deleted_at) VALUES('1','\'admin\'','NULL','NULL','1','NULL','\'2023-11-11 09:00:39\'','\'2023-11-11 09:00:39\'','NULL'),('2','\'exkurt\'','NULL','NULL','1','NULL','\'2023-11-11 13:39:08\'','\'2023-11-11 13:39:08\'','NULL');
INSERT INTO user_details(id,account_id,first_name,last_name,email,birthdate,role,created_at,updated_at) VALUES('1','1','\'KURT\'','\'LEONES\'','\'kurtleones13@gmail.com\'','\'2023-11-08\'','\'admin\'','\'2023-11-11 14:14:11\'','\'2023-11-12 12:25:19\''),('3','2','\'MANUEL\'','\'LEONES\'','\'kurt_leones@yahoo.com\'','\'2023-11-08\'','\'user\'','\'2023-11-12 12:06:43\'','\'2023-11-12 12:06:43\'');