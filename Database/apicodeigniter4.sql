-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2024 at 05:05 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apicodeigniter4`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sampah`
--

CREATE TABLE `sampah` (
  `id_sampah` int(35) NOT NULL,
  `jenis_sampah` enum('Organik','Anorganik','B3') NOT NULL,
  `nama_sampah` varchar(100) NOT NULL,
  `berat_sampah` double NOT NULL,
  `jenis_angkutan` varchar(100) NOT NULL,
  `koin` int(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sampah`
--

INSERT INTO `sampah` (`id_sampah`, `jenis_sampah`, `nama_sampah`, `berat_sampah`, `jenis_angkutan`, `koin`) VALUES
(37, 'Organik', 'Sisa makanan', 2, 'Gerobak Sampah', 10000),
(42, 'Organik', 'Kulit buah', 1, 'Motor Sampah', 5000),
(44, 'B3', 'Baterai', 1, 'Truk Sampah', 20000),
(45, 'Anorganik', 'Botol Plastik', 2, 'Motor Sampah', 14000);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `no_hp` varchar(100) NOT NULL,
  `alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `no_hp`, `alamat`) VALUES
(6, 'annas', '$2y$10$OCMdtsThPCv202x4HIFA1.LAVzwU35zndqTA7dP35xYFitOat3H3q', '08123456789', 'Bojonegoro'),
(10, 'holan', '$2y$10$lTaHsq6PRezFhr/OZvEElejKZNsBIHO8Ak.s2OWP0ovnWT.YRs9fq', '08987654321', 'Mojoranu'),
(13, 'shofia', '$2y$10$ubnq.kvrlrbd1ZSNlxDEvuAXVp4EcBCgD/qtpcCLMrrMH313AGkrm', '083133615263', 'Ds. Ngumpakdalem, Dander'),
(14, 'Dimas', '$2y$10$f8HuawoRkOyqDna4wRUj9.EBOimTNUOBK1pFhEu6kxRDfHbr6EOS.', '082337591474', 'jl letnan sugiono');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sampah`
--
ALTER TABLE `sampah`
  ADD PRIMARY KEY (`id_sampah`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`no_hp`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sampah`
--
ALTER TABLE `sampah`
  MODIFY `id_sampah` int(35) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
