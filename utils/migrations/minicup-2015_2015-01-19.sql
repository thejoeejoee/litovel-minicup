-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Počítač: localhost
-- Vytvořeno: Pon 19. led 2015, 20:43
-- Verze serveru: 5.5.40-0ubuntu1
-- Verze PHP: 5.5.12-2ubuntu4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databáze: `minicup-2015`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `category`
--

CREATE TABLE IF NOT EXISTS `category` (
`id` int(11) NOT NULL,
  `name` char(30) COLLATE utf8_czech_ci NOT NULL,
  `slug` char(30) COLLATE utf8_czech_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `category`
--

INSERT INTO `category` (`id`, `name`, `slug`) VALUES
(1, 'mladší', 'mladsi'),
(2, 'starší', 'starsi');

-- --------------------------------------------------------

--
-- Struktura tabulky `day`
--

CREATE TABLE IF NOT EXISTS `day` (
`id` int(11) NOT NULL,
  `day` date NOT NULL,
  `year_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `day`
--

INSERT INTO `day` (`id`, `day`, `year_id`) VALUES
(77, '2015-05-23', 1),
(78, '2015-05-24', 1),
(79, '2015-05-25', 1);

-- --------------------------------------------------------

--
-- Struktura tabulky `match`
--

CREATE TABLE IF NOT EXISTS `match` (
`id` int(11) NOT NULL,
  `match_term_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `home_team_info_id` int(11) NOT NULL,
  `away_team_info_id` int(11) NOT NULL,
  `score_home` int(11) DEFAULT NULL,
  `score_away` int(11) DEFAULT NULL,
  `confirmed` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=1438 DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `match_term`
--

CREATE TABLE IF NOT EXISTS `match_term` (
`id` int(11) NOT NULL,
  `start` time NOT NULL,
  `end` time NOT NULL,
  `day_id` int(11) NOT NULL,
  `location` varchar(50) COLLATE utf8_czech_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=587 DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `match_term`
--

INSERT INTO `match_term` (`id`, `start`, `end`, `day_id`, `location`) VALUES
(554, '13:00:00', '13:30:00', 77, ''),
(555, '13:30:00', '14:00:00', 77, ''),
(556, '14:00:00', '14:30:00', 77, ''),
(557, '14:30:00', '15:00:00', 77, ''),
(558, '15:00:00', '15:30:00', 77, ''),
(559, '15:30:00', '16:00:00', 77, ''),
(560, '16:00:00', '16:30:00', 77, ''),
(561, '16:30:00', '17:00:00', 77, ''),
(562, '17:00:00', '17:30:00', 77, ''),
(563, '09:00:00', '09:30:00', 78, ''),
(564, '09:30:00', '10:00:00', 78, ''),
(565, '10:00:00', '10:30:00', 78, ''),
(566, '10:30:00', '11:00:00', 78, ''),
(567, '11:00:00', '11:30:00', 78, ''),
(568, '11:30:00', '12:00:00', 78, ''),
(569, '12:00:00', '12:30:00', 78, ''),
(570, '12:30:00', '13:00:00', 78, ''),
(571, '13:00:00', '13:30:00', 78, ''),
(572, '13:30:00', '14:00:00', 78, ''),
(573, '14:00:00', '14:30:00', 78, ''),
(574, '14:30:00', '15:00:00', 78, ''),
(575, '15:00:00', '15:30:00', 78, ''),
(576, '09:00:00', '09:30:00', 79, ''),
(577, '09:30:00', '10:00:00', 79, ''),
(578, '10:00:00', '10:30:00', 79, ''),
(579, '10:30:00', '11:00:00', 79, ''),
(580, '11:00:00', '11:30:00', 79, ''),
(581, '11:30:00', '12:00:00', 79, ''),
(582, '12:00:00', '12:30:00', 79, ''),
(583, '12:30:00', '13:00:00', 79, ''),
(584, '13:00:00', '13:30:00', 79, ''),
(585, '13:30:00', '14:00:00', 79, ''),
(586, '14:00:00', '14:30:00', 79, '');

-- --------------------------------------------------------

--
-- Struktura tabulky `online_report`
--

CREATE TABLE IF NOT EXISTS `online_report` (
`id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `message` text COLLATE utf8_czech_ci NOT NULL,
  `type` char(20) COLLATE utf8_czech_ci NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `added` datetime NOT NULL,
  `author` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `team`
--

CREATE TABLE IF NOT EXISTS `team` (
`id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `team_info_id` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `scored` int(11) NOT NULL,
  `received` int(11) NOT NULL,
  `inserted` datetime NOT NULL,
  `is_actual` int(11) NOT NULL DEFAULT '0',
  `after_match_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Spouště `team`
--
DELIMITER //
CREATE TRIGGER `team_bi` BEFORE INSERT ON `team`
 FOR EACH ROW SET NEW.inserted = NOW()
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabulky `team_info`
--

CREATE TABLE IF NOT EXISTS `team_info` (
`id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` char(30) COLLATE utf8_czech_ci NOT NULL,
  `slug` char(30) COLLATE utf8_czech_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `user`
--

CREATE TABLE IF NOT EXISTS `user` (
`id` int(11) NOT NULL,
  `username` text COLLATE utf8_czech_ci NOT NULL,
  `password_hash` text COLLATE utf8_czech_ci NOT NULL,
  `role` text COLLATE utf8_czech_ci NOT NULL,
  `fullname` text COLLATE utf8_czech_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `user`
--

INSERT INTO `user` (`id`, `username`, `password_hash`, `role`, `fullname`) VALUES
(1, 'joe', '$2y$10$HZGTs1GzZB70Bbpc2HLnFeyBYdaudLWW/gOd7CVEcpf8C4nURUVRi', 'admin', 'Joe Kolář');

-- --------------------------------------------------------

--
-- Struktura tabulky `year`
--

CREATE TABLE IF NOT EXISTS `year` (
`id` int(11) NOT NULL,
  `year` year(4) NOT NULL,
  `name` text COLLATE utf8_czech_ci,
  `actual` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `year`
--

INSERT INTO `year` (`id`, `year`, `name`, `actual`) VALUES
(1, 2015, NULL, 1);

--
-- Klíče pro exportované tabulky
--

--
-- Klíče pro tabulku `category`
--
ALTER TABLE `category`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `slug` (`slug`);

--
-- Klíče pro tabulku `day`
--
ALTER TABLE `day`
 ADD PRIMARY KEY (`id`), ADD KEY `year_id` (`year_id`);

--
-- Klíče pro tabulku `match`
--
ALTER TABLE `match`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`), ADD KEY `AI_id` (`id`), ADD KEY `home_team_id` (`home_team_info_id`), ADD KEY `away_team_id` (`away_team_info_id`), ADD KEY `match_term_id` (`match_term_id`), ADD KEY `category_id` (`category_id`);

--
-- Klíče pro tabulku `match_term`
--
ALTER TABLE `match_term`
 ADD PRIMARY KEY (`id`), ADD KEY `day_id` (`day_id`);

--
-- Klíče pro tabulku `online_report`
--
ALTER TABLE `online_report`
 ADD PRIMARY KEY (`id`), ADD KEY `match_id` (`match_id`), ADD KEY `author` (`author`);

--
-- Klíče pro tabulku `team`
--
ALTER TABLE `team`
 ADD PRIMARY KEY (`id`), ADD KEY `category_id` (`category_id`), ADD KEY `team_info_id` (`team_info_id`), ADD KEY `after_match_id` (`after_match_id`);

--
-- Klíče pro tabulku `team_info`
--
ALTER TABLE `team_info`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `category_id_name_slug` (`category_id`,`name`,`slug`);

--
-- Klíče pro tabulku `user`
--
ALTER TABLE `user`
 ADD PRIMARY KEY (`id`);

--
-- Klíče pro tabulku `year`
--
ALTER TABLE `year`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `category`
--
ALTER TABLE `category`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pro tabulku `day`
--
ALTER TABLE `day`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=80;
--
-- AUTO_INCREMENT pro tabulku `match`
--
ALTER TABLE `match`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1438;
--
-- AUTO_INCREMENT pro tabulku `match_term`
--
ALTER TABLE `match_term`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=587;
--
-- AUTO_INCREMENT pro tabulku `online_report`
--
ALTER TABLE `online_report`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pro tabulku `team`
--
ALTER TABLE `team`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=106;
--
-- AUTO_INCREMENT pro tabulku `team_info`
--
ALTER TABLE `team_info`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT pro tabulku `user`
--
ALTER TABLE `user`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pro tabulku `year`
--
ALTER TABLE `year`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `day`
--
ALTER TABLE `day`
ADD CONSTRAINT `day_ibfk_1` FOREIGN KEY (`year_id`) REFERENCES `year` (`id`);

--
-- Omezení pro tabulku `match`
--
ALTER TABLE `match`
ADD CONSTRAINT `match_ibfk_6` FOREIGN KEY (`away_team_info_id`) REFERENCES `team_info` (`id`),
ADD CONSTRAINT `match_ibfk_1` FOREIGN KEY (`match_term_id`) REFERENCES `match_term` (`id`),
ADD CONSTRAINT `match_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
ADD CONSTRAINT `match_ibfk_5` FOREIGN KEY (`home_team_info_id`) REFERENCES `team_info` (`id`);

--
-- Omezení pro tabulku `match_term`
--
ALTER TABLE `match_term`
ADD CONSTRAINT `day_id` FOREIGN KEY (`day_id`) REFERENCES `day` (`id`);

--
-- Omezení pro tabulku `online_report`
--
ALTER TABLE `online_report`
ADD CONSTRAINT `online_report_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `match` (`id`),
ADD CONSTRAINT `online_report_ibfk_3` FOREIGN KEY (`author`) REFERENCES `user` (`id`);

--
-- Omezení pro tabulku `team`
--
ALTER TABLE `team`
ADD CONSTRAINT `team_ibfk_1` FOREIGN KEY (`team_info_id`) REFERENCES `team_info` (`id`),
ADD CONSTRAINT `team_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
ADD CONSTRAINT `team_ibfk_3` FOREIGN KEY (`after_match_id`) REFERENCES `match` (`id`);

--
-- Omezení pro tabulku `team_info`
--
ALTER TABLE `team_info`
ADD CONSTRAINT `team_info_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
