-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 19 Sep 2024 pada 07.36
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smart_farm`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `account`
--

CREATE TABLE `account` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` varchar(200) NOT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `devices_manager`
--

CREATE TABLE `devices_manager` (
  `id` int(11) NOT NULL,
  `device_name` varchar(200) NOT NULL,
  `pin` int(11) NOT NULL,
  `type` varchar(200) NOT NULL,
  `kondisi` varchar(200) NOT NULL,
  `update_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `devices_manager`
--

INSERT INTO `devices_manager` (`id`, `device_name`, `pin`, `type`, `kondisi`, `update_at`) VALUES
(1, 'dht1', 19, 'DHT11', 'Baik', '2024-09-19 10:10:02'),
(4, 'dht2', 0, 'DHT11', 'Baik', '2024-09-19 12:01:59'),
(6, 'dht3', 0, 'DHT11', 'Baik', '2024-09-19 12:02:33'),
(7, 'dht4', 0, 'DHT11', 'Baik', '2024-09-19 12:02:45'),
(8, 'dht5', 0, 'DHT11', 'Baik', '2024-09-19 12:03:03'),
(9, 'dht6', 0, 'DHT11', 'Baik', '2024-09-19 12:03:18'),
(10, 'dht7', 0, 'DHT11', 'Baik', '2024-09-19 12:03:30'),
(11, 'dht8', 0, 'DHT11', 'Baik', '2024-09-19 12:03:51'),
(12, 'dht9', 0, 'DHT11', 'Baik', '2024-09-19 12:04:03'),
(13, 'dht10', 0, 'DHT11', 'Baik', '2024-09-19 12:04:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `smart_farm_data`
--

CREATE TABLE `smart_farm_data` (
  `id` int(11) NOT NULL,
  `temperature` float NOT NULL,
  `humidity` float NOT NULL,
  `moisture` int(11) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `smart_farm_data`
--

INSERT INTO `smart_farm_data` (`id`, `temperature`, `humidity`, `moisture`, `datetime`) VALUES
(1, 30.2, 59, 0, '2024-09-19 12:36:14'),
(2, 30.2, 59, 0, '2024-09-19 12:36:19'),
(3, 30.2, 59, 0, '2024-09-19 12:36:25'),
(4, 30.2, 59, 0, '2024-09-19 12:36:30'),
(5, 30.2, 59, 0, '2024-09-19 12:36:36'),
(6, 30.2, 58, 0, '2024-09-19 12:36:41');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `devices_manager`
--
ALTER TABLE `devices_manager`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `smart_farm_data`
--
ALTER TABLE `smart_farm_data`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `account`
--
ALTER TABLE `account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `devices_manager`
--
ALTER TABLE `devices_manager`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `smart_farm_data`
--
ALTER TABLE `smart_farm_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
