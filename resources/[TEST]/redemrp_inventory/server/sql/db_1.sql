-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Czas generowania: 20 Gru 2019, 14:00
-- Wersja serwera: 10.4.6-MariaDB
-- Wersja PHP: 7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `redemrp`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `character_inventory`
--

CREATE TABLE `character_inventory` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `characterid` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `metainfo` text COLLATE utf8mb4_bin NOT NULL DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE `items` (
  `itemid` int(11) NOT NULL,
  `name` varchar(16) COLLATE utf8mb4_bin NOT NULL,
  `description` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT ' ',
  `weight` int(11) NOT NULL DEFAULT 0,
  `imgsrc` varchar(28) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
