CREATE DATABASE `monitoring` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `board` (
  `board_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `board_title` varchar(50) NOT NULL,
  `board_content` text,
  `board_writer` varchar(30) NOT NULL DEFAULT 'unkown',
  `board_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `board_filecheck` tinyint(1) NOT NULL DEFAULT '0',
  `board_category` varchar(15) DEFAULT '기타',
  PRIMARY KEY (`board_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `comment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `sort_id` int NOT NULL,
  `comment_sort` varchar(15) NOT NULL,
  `comment_parent` int NOT NULL DEFAULT '0',
  `comment_content` text,
  `comment_writer` varchar(30) NOT NULL DEFAULT 'unknown',
  `comment_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment_delete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `meeting` (
  `meeting_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `meeting_title` varchar(45) NOT NULL,
  `meeting_writer` varchar(30) NOT NULL,
  `meeting_start` datetime DEFAULT NULL,
  `meeting_end` datetime DEFAULT NULL,
  `meeting_place` varchar(100) DEFAULT NULL,
  `meeting_filecheck` tinyint(1) NOT NULL DEFAULT '0',
  `meeting_date` varchar(45) DEFAULT 'CURRENT_TIMESTAMP',
  `meeting_content` longtext,
  PRIMARY KEY (`meeting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `member` (
  `member_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL,
  `project_id` int NOT NULL,
  `member_right` int NOT NULL,
  `member_state` int DEFAULT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `project` (
  `project_id` int NOT NULL AUTO_INCREMENT,
  `project_name` varchar(50) NOT NULL,
  `project_content` text,
  `project_start` date NOT NULL,
  `project_end` date NOT NULL,
  `project_category` text,
  `project_cycle` int DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `request` (
  `full_request_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `request_id` varchar(20) NOT NULL,
  `request_name` text NOT NULL,
  `request_content` text,
  `request_date` int NOT NULL,
  `request_rank` varchar(3) NOT NULL,
  `request_stage` varchar(5) NOT NULL,
  `request_target` varchar(5) NOT NULL,
  `user_id` varchar(30) NOT NULL,
  `request_note` text,
  PRIMARY KEY (`full_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `schedule` (
  `schedule_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `schedule_title` varchar(50) DEFAULT NULL,
  `schedule_content` text,
  `schedule_start` datetime NOT NULL,
  `schedule_end` datetime NOT NULL,
  `schedule_alltime` tinyint(1) DEFAULT NULL,
  `schedule_color` varchar(45) DEFAULT NULL,
  `schedule_member` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`schedule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `userinfo` (
  `user_id` varchar(30) NOT NULL,
  `user_pw` varchar(30) NOT NULL,
  `user_name` varchar(10) NOT NULL,
  `user_birth` varchar(10) NOT NULL,
  `user_phone` varchar(13) NOT NULL,
  `user_state` tinyint(1) NOT NULL DEFAULT '0',
  `user_email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





