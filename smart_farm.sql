-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 21 Sep 2024 pada 10.05
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
(1, 'DHT', 19, 'dht11', 'active', '2024-09-19 16:48:30'),
(2, 'soil1', 34, 'moisture', 'active', '2024-09-19 16:48:30'),
(3, 'soil2', 0, 'moisture', 'inactive', '2024-09-19 16:48:30'),
(4, 'soil3', 0, 'moisture', 'inactive', '2024-09-19 16:48:30'),
(5, 'soil4', 0, 'moisture', 'inactive', '2024-09-19 16:48:30'),
(6, 'soil5', 0, 'moisture', 'inactive', '2024-09-19 16:48:30'),
(7, 'soil6', 0, 'moisture', 'inactive', '2024-09-19 16:48:30'),
(8, 'soil7', 0, 'moisture', 'inactive', '2024-09-19 16:48:30'),
(9, 'soil8', 0, 'moisture', 'inactive', '2024-09-19 16:48:30'),
(10, 'soil9', 0, 'moisture', 'inactive', '2024-09-19 16:48:30'),
(11, 'soil10', 0, 'moisture', 'inactive', '2024-09-19 16:48:30'),
(12, 'pump1', 4, 'pump', 'active', '2024-09-21 14:21:28'),
(13, 'pump2', 0, 'pump', 'inactive', '2024-09-21 14:21:28'),
(14, 'pump3', 0, 'pump', 'inactive', '2024-09-21 14:21:28'),
(15, 'pump4', 0, 'pump', 'inactive', '2024-09-21 14:21:28'),
(16, 'pump5', 0, 'pump', 'inactive', '2024-09-21 14:21:28'),
(17, 'pump6', 0, 'pump', 'inactive', '2024-09-21 14:21:28'),
(18, 'pump7', 0, 'pump', 'inactive', '2024-09-21 14:21:28'),
(19, 'pump8', 0, 'pump', 'inactive', '2024-09-21 14:21:28'),
(20, 'pump9', 0, 'pump', 'inactive', '2024-09-21 14:21:28'),
(21, 'pump10', 0, 'pump', 'inactive', '2024-09-21 14:21:28'),
(22, 'fan1', 5, 'fan', 'active', '2024-09-21 14:22:55'),
(23, 'fan2', 0, 'fan', 'inactive', '2024-09-21 14:22:55'),
(24, 'fan3', 0, 'fan', 'inactive', '2024-09-21 14:22:55'),
(25, 'fan4', 0, 'fan', 'inactive', '2024-09-21 14:22:55'),
(26, 'fan5', 0, 'fan', 'inactive', '2024-09-21 14:22:55'),
(27, 'fan6', 0, 'fan', 'inactive', '2024-09-21 14:22:55'),
(28, 'fan7', 0, 'fan', 'inactive', '2024-09-21 14:22:55'),
(29, 'fan8', 0, 'fan', 'inactive', '2024-09-21 14:22:55'),
(30, 'fan9', 0, 'fan', 'inactive', '2024-09-21 14:22:55'),
(31, 'fan10', 0, 'fan', 'inactive', '2024-09-21 14:22:55');

-- --------------------------------------------------------

--
-- Struktur dari tabel `devices_relay`
--

CREATE TABLE `devices_relay` (
  `id` int(11) NOT NULL,
  `device_name` varchar(200) NOT NULL,
  `device_type` varchar(200) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `update_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `devices_relay`
--

INSERT INTO `devices_relay` (`id`, `device_name`, `device_type`, `status`, `update_at`) VALUES
(1, 'pump1', 'pump', 1, '2024-09-21 14:25:11'),
(2, 'fan1', 'fan', 0, '2024-09-21 14:25:27'),
(3, 'pump1', 'pump', 0, '2024-09-21 14:25:30'),
(4, 'fan1', 'fan', 1, '2024-09-21 14:25:35'),
(5, 'pump1', 'pump', 0, '2024-09-21 14:34:59'),
(6, 'pump1', 'pump', 1, '2024-09-21 14:35:02'),
(7, 'pump1', 'pump', 0, '2024-09-21 14:35:19'),
(8, 'pump1', 'pump', 1, '2024-09-21 14:35:47'),
(9, 'pump1', 'pump', 0, '2024-09-21 14:35:51'),
(10, 'pump1', 'pump', 1, '2024-09-21 14:36:25'),
(11, 'pump1', 'pump', 0, '2024-09-21 14:39:44'),
(12, 'pump1', 'pump', 1, '2024-09-21 14:39:52'),
(13, 'pump1', 'pump', 0, '2024-09-21 14:40:01'),
(14, 'pump1', 'pump', 1, '2024-09-21 14:40:10'),
(15, 'pump1', 'pump', 0, '2024-09-21 14:40:25'),
(16, 'fan1', 'fan', 0, '2024-09-21 14:40:34'),
(17, 'pump1', 'pump', 1, '2024-09-21 14:41:15'),
(18, 'pump1', 'pump', 0, '2024-09-21 14:41:28'),
(19, 'pump1', 'pump', 1, '2024-09-21 14:52:49'),
(20, 'pump1', 'pump', 0, '2024-09-21 14:52:52'),
(21, 'pump1', 'pump', 1, '2024-09-21 14:52:53'),
(22, 'pump1', 'pump', 0, '2024-09-21 14:52:55'),
(23, 'pump1', 'pump', 1, '2024-09-21 14:52:57'),
(24, 'pump1', 'pump', 1, '2024-09-21 14:52:59'),
(25, 'pump1', 'pump', 0, '2024-09-21 14:53:01'),
(26, 'pump1', 'pump', 1, '2024-09-21 14:53:04'),
(27, 'pump1', 'pump', 0, '2024-09-21 14:53:06'),
(28, 'pump1', 'pump', 1, '2024-09-21 14:53:07'),
(29, 'pump1', 'pump', 0, '2024-09-21 14:53:12'),
(30, 'pump1', 'pump', 1, '2024-09-21 14:53:17'),
(31, 'pump1', 'pump', 0, '2024-09-21 14:53:19'),
(32, 'pump1', 'pump', 1, '2024-09-21 14:53:32'),
(33, 'pump1', 'pump', 0, '2024-09-21 14:53:40'),
(34, 'pump1', 'pump', 1, '2024-09-21 14:53:44'),
(35, 'pump1', 'pump', 0, '2024-09-21 14:54:06'),
(36, 'pump1', 'pump', 1, '2024-09-21 14:58:03'),
(37, 'pump1', 'pump', 0, '2024-09-21 14:58:08'),
(38, 'pump1', 'pump', 1, '2024-09-21 14:58:09'),
(39, 'pump1', 'pump', 0, '2024-09-21 14:58:12'),
(40, 'pump1', 'pump', 1, '2024-09-21 14:58:35'),
(41, 'pump1', 'pump', 0, '2024-09-21 14:58:39'),
(42, 'pump1', 'pump', 1, '2024-09-21 14:58:44'),
(43, 'pump1', 'pump', 0, '2024-09-21 14:58:46'),
(44, 'pump1', 'pump', 1, '2024-09-21 14:59:12'),
(45, 'pump1', 'pump', 0, '2024-09-21 14:59:50'),
(46, 'pump1', 'pump', 1, '2024-09-21 15:02:38'),
(47, 'pump1', 'pump', 0, '2024-09-21 15:02:42'),
(48, 'pump1', 'pump', 1, '2024-09-21 15:02:52'),
(49, 'pump1', 'pump', 0, '2024-09-21 15:02:54'),
(50, 'pump1', 'pump', 1, '2024-09-21 15:03:41'),
(51, 'pump1', 'pump', 0, '2024-09-21 15:03:49');

-- --------------------------------------------------------

--
-- Struktur dari tabel `farm_operation`
--

CREATE TABLE `farm_operation` (
  `id` int(11) NOT NULL,
  `system` varchar(200) NOT NULL,
  `updated_by` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `otomatic_op`
--

CREATE TABLE `otomatic_op` (
  `id` int(11) NOT NULL,
  `temperature_mid` int(11) NOT NULL,
  `humidity_mid` int(11) NOT NULL,
  `moisture_mid` int(11) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `schedule_op`
--

CREATE TABLE `schedule_op` (
  `id` int(11) NOT NULL,
  `loops` int(11) NOT NULL DEFAULT 3,
  `duration_start` int(11) NOT NULL,
  `start1` int(11) NOT NULL,
  `start2` int(11) NOT NULL,
  `start3` int(11) NOT NULL,
  `updated_by` varchar(200) NOT NULL DEFAULT 'admin'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sheet1`
--

CREATE TABLE `sheet1` (
  `Column_1` varchar(10) DEFAULT NULL,
  `Column_2` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `sheet1`
--

INSERT INTO `sheet1` (`Column_1`, `Column_2`) VALUES
('Terbaru   ', ''),
('`smart_far', ''),
('`smart_far', ''),
('`smart_far', ''),
('`smart_far', ''),
('`smart_far', ''),
('', ''),
('Favorit   ', ''),
('', ''),
('', ''),
('', ''),
('', ''),
('Baru', ''),
('', ''),
('', ''),
('informatio', ''),
('', ''),
('', ''),
('mysql', ''),
('', ''),
('', ''),
('performanc', ''),
('', ''),
('', ''),
('smart_farm', ''),
('', ''),
('', ''),
('sys', ''),
('', ''),
('', ''),
('test', ''),
('', ''),
('Panel navi', ''),
('Panel navi', ''),
('Server', ''),
('Basis data', ''),
('Tabel', ''),
('Panel navi', ''),
('Atur tampi', ''),
('Panel navi', ''),
('Tampilkan ', ''),
('Link ke pa', ''),
('Tampilkan ', ''),
('URL tautan', ''),
('Sasaran ta', 'main      '),
('Aktifkan p', ''),
('Item maksi', ''),
('Jumlah min', ''),
('Tabel yang', ''),
('Tabel favo', ''),
('Lebar pane', ''),
('Panel navi', ''),
('Atur panel', ''),
('Panel navi', ''),
('Item maksi', ''),
('Item Group', ''),
('Bolehkan p', ''),
('Tampilkan ', ''),
('Tampilkan ', ''),
('Tampilkan ', ''),
('Tampilkan ', ''),
('Tunjukkan ', ''),
('Expand sin', ''),
('Server', ''),
('Opsi tampi', ''),
('Server ', ''),
('Tampilkan ', ''),
('Tampilkan ', ''),
('Basis data', ''),
('Opsi tampi', ''),
('Basis data', ''),
('Jumlah min', ''),
('Pemisah hi', ''),
('Tabel', ''),
('Opsi tampi', ''),
('Tabel ', ''),
('Target iko', 'Struktur  '),
('Target bua', 'Struktur  '),
('Pemisah hi', ''),
('Kedalaman ', ''),
('Letakkan b', ''),
('SQL upload', ''),
('', ''),
('Tampilkan ', ''),
('Tutup ', ''),
('Buat tampi', ''),
('Kirim     ', ''),
('Your brows', ''),
('Ya        ', ''),
('Javascript', ''),
('', ''),
('1. Server:', ''),
('', ''),
(' Basis dat', ''),
(' SQL ', ''),
(' Status ', ''),
(' Akun peng', ''),
(' Ekspor ', ''),
(' Impor ', ''),
(' Pengatura', ''),
(' Replikasi', ''),
(' Variabel ', ''),
(' Set Karak', ''),
(' Mesin ', ''),
('', ''),
('Konsol ', ''),
('Bersihkan ', ''),
('Riwayat ', ''),
('Opsi ', ''),
('Men-Debug ', ''),
('Tekan Ctrl', ''),
('ascending ', ''),
('descending', ''),
('Order: ', ''),
('Men-Debug ', ''),
('Jumlah ', ''),
('Execution ', ''),
('Time taken', ''),
('Order by: ', ''),
('Group quer', ''),
('Ungroup qu', ''),
('Tampilkan ', ''),
('Opsi ', ''),
('Kembalikan', ''),
('FALSE', ''),
('FALSE', ''),
('FALSE', ''),
('FALSE', ''),
('FALSE', ''),
('Tampilkan ', ''),
('Memproses', ''),
('Tutup ', ''),
('Editor ENU', ''),
('Kirim     ', ''),
('Buat tampi', ''),
('Kirim     ', ''),
('phpMyAdmin', ''),
('index.php:', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `smart_farm_data`
--

CREATE TABLE `smart_farm_data` (
  `id` int(11) NOT NULL,
  `temperature` float NOT NULL,
  `humidity` float NOT NULL,
  `moisture1` int(11) NOT NULL,
  `moisture2` int(11) NOT NULL,
  `moisture3` int(11) NOT NULL,
  `moisture4` int(11) NOT NULL,
  `moisture5` int(11) NOT NULL,
  `moisture6` int(11) NOT NULL,
  `moisture7` int(11) NOT NULL,
  `moisture8` int(11) NOT NULL,
  `moisture9` int(11) NOT NULL,
  `moisture10` int(11) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `devices_relay`
--
ALTER TABLE `devices_relay`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `farm_operation`
--
ALTER TABLE `farm_operation`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `otomatic_op`
--
ALTER TABLE `otomatic_op`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `schedule_op`
--
ALTER TABLE `schedule_op`
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
-- AUTO_INCREMENT untuk tabel `devices_relay`
--
ALTER TABLE `devices_relay`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT untuk tabel `farm_operation`
--
ALTER TABLE `farm_operation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `otomatic_op`
--
ALTER TABLE `otomatic_op`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `schedule_op`
--
ALTER TABLE `schedule_op`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `smart_farm_data`
--
ALTER TABLE `smart_farm_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
