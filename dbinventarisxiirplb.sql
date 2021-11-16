-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 16, 2021 at 01:50 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbinventarisxiirplb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `batal_keluar` (`id_barang` INT, `jml_keluar` INT)  BEGIN
 UPDATE stok SET
stok.jml_keluar=(stok.jml_keluar-jml_keluar),
stok.total_barang=(stok.total_barang+jml_keluar)
WHERE stok.id_barang=id_barang;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `batal_masuk` (`id_barang` INT, `jml_masuk` INT)  BEGIN
 UPDATE stok SET
stok.jml_masuk=(stok.jml_masuk-jml_masuk),
stok.total_barang=(stok.total_barang-jml_masuk)
WHERE stok.id_barang=id_barang;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kembali` (`id_barang` INT, `jml` INT)  BEGIN
 UPDATE stok SET
stok.total_barang=(stok.total_barang+jml)
WHERE stok.id_barang=id_barang;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pinjam` (IN `id_barang` INT, IN `jml` INT)  BEGIN
UPDATE stok SET
	stok.total_barang=(stok.total_barang-jml)
    WHERE stok.id_barang=id_barang;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_keluar` (`id_barang` INT, `jml_keluar` INT)  BEGIN
 UPDATE stok SET
stok.jml_keluar = (stok.jml_keluar+jml_keluar),
stok.total_barang=(stok.total_barang-jml_keluar)
WHERE stok.id_barang=id_barang;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_masuk` (`id_barang` INT, `jml_masuk` INT)  BEGIN
 UPDATE stok SET
stok.jml_masuk=(stok.jml_masuk+jml_masuk),
stok.total_barang=(stok.total_barang+jml_masuk)
WHERE stok.id_barang=id_barang;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `spesifikasi` text NOT NULL,
  `lokasi` varchar(50) NOT NULL,
  `kondisi` varchar(20) NOT NULL,
  `jumlah_barang` int(11) NOT NULL,
  `sumber_dana` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `barang`
--
DELIMITER $$
CREATE TRIGGER `del_stok` AFTER DELETE ON `barang` FOR EACH ROW BEGIN
DELETE FROM stok WHERE stok.id_barang=OLD.id_barang;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ins_stok` AFTER INSERT ON `barang` FOR EACH ROW BEGIN
INSERT INTO stok (id_barang,nama_barang)values
(NEW.id_barang,NEW.nama_barang);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `upt_stok` AFTER UPDATE ON `barang` FOR EACH ROW UPDATE stok SET stok.nama_barang=NEW.nama_barang WHERE
stok.id_barang=OLD.id_barang
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `barang_keluar`
--

CREATE TABLE `barang_keluar` (
  `id_barang` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `tgl_keluar` date DEFAULT NULL,
  `jml_keluar` int(11) NOT NULL,
  `id_supplier` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id_barang` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `tgl_masuk` date DEFAULT NULL,
  `jml_masuk` int(11) NOT NULL,
  `id_supplier` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pinjam_barang`
--

CREATE TABLE `pinjam_barang` (
  `id_pinjam` int(11) NOT NULL,
  `peminjam` varchar(50) NOT NULL,
  `tgl_pinjam` date DEFAULT NULL,
  `id_barang` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `jml_barang` int(11) NOT NULL,
  `tgl_kembali` date DEFAULT NULL,
  `kondisi` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `stok`
--

CREATE TABLE `stok` (
  `id_barang` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `jml_masuk` int(11) NOT NULL,
  `jml_keluar` int(11) NOT NULL,
  `total_barang` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` int(11) NOT NULL,
  `nama_supplier` varchar(50) NOT NULL,
  `alamat_supplier` varchar(100) NOT NULL,
  `telp_supplier` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `nama_supplier`, `alamat_supplier`, `telp_supplier`) VALUES
(1, 'STMIK Bani Saleh', '', ''),
(2, 'STIKES BANI SALEH', '-', '88345064'),
(3, 'STAI BANI SALEH', '-', '88343360');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `level` char(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `nama`, `username`, `password`, `level`) VALUES
(1, 'Teknik Komputer', 'tk', 'tk', 'peminjam'),
(2, 'Manajemen Informasi', 'mi', 'mi', 'peminjam'),
(3, 'Komputer Akuntansi', 'ka', 'ka', 'peminjam'),
(4, 'Sistem Informasi', 'si', 'si', 'manajemen'),
(5, 'Teknik Informatika', 'ti', 'ti', 'administrator');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indexes for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indexes for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indexes for table `pinjam_barang`
--
ALTER TABLE `pinjam_barang`
  ADD PRIMARY KEY (`id_pinjam`);

--
-- Indexes for table `stok`
--
ALTER TABLE `stok`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_supplier`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
