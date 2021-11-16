-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 16, 2021 at 01:49 AM
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
-- Database: `db_inventaris_rplb_1920_02_akmaliatrias`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pinjam_barang` (`in_idpeminjam` CHAR(8), `in_idbarangpinjam` CHAR(8), `in_jmlpinjam` INT)  BEGIN
	DECLARE stok_barang_pinjam INT DEFAULT 0;
    DECLARE total_akhir INT DEFAULT 0;
    	#isi total_barang
    SELECT jumlah_barang INTO stok_barang_pinjam FROM barang
    WHERE id_barang = in_idbarangpinjam;
    
     #apakah stok memenuhi?
    IF stok_barang_pinjam > in_jmlpinjam THEN
    	#input ke tabel pinjam
    	INSERT INTO pinjam_barang 
        (peminjam, tgl_pinjam, barang_pinjam, jml_pinjam, kondisi)
        VALUES 
        (in_idpeminjam, NOW(), in_idbarangpinjam, in_jmlpinjam, 'Baik');
        
        #update tabel stok
        UPDATE stok
        SET stok.total_barang = stok.total_barang - in_jmlpinjam
        WHERE id_barang = in_idbarangpinjam;

        #masukan total akhir
        SELECT total_barang INTO total_akhir FROM stok
        WHERE id_barang = in_idbarangpinjam;
        
        #update table barang
        UPDATE barang 
        SET barang.jumlah_barang = total_akhir
        WHERE id_barang = in_idbarangpinjam;
        
        ELSE SELECT "hai kamu gagal";
        END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_barangmasuk` (`in_idbarang` CHAR(8), `in_jmlmasuk` INT(11), `in_idsupplier` CHAR(8))  BEGIN
	DECLARE total_seluruh INT DEFAULT 0;
	INSERT INTO barang_masuk (id_barang, tgl_masuk, jml_masuk, supplier)
    VALUES (in_idbarang, NOW(), in_jmlmasuk, in_idsupplier);
    UPDATE stok SET stok.jml_masuk = stok.jml_masuk + in_jmlmasuk, 
    				stok.total_barang = stok.jml_masuk - stok.jml_keluar
    	WHERE id_barang = in_idbarang;
    SELECT stok.total_barang INTO total_seluruh FROM stok 
    	WHERE id_barang = in_idbarang;
    UPDATE barang SET barang.jumlah_barang = total_seluruh 
    	WHERE id_barang = in_idbarang;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `newkodebarang` () RETURNS CHAR(8) CHARSET utf8mb4 BEGIN
	DECLARE kode_lama CHARACTER(8) DEFAULT 'BRG10001';
    DECLARE ambil_angka INT DEFAULT 0;
    DECLARE kode_baru CHARACTER(8) DEFAULT 'BRG10001';
    SELECT MAX(id_barang) INTO kode_lama FROM barang;
    SET ambil_angka = SUBSTR(kode_lama,4,8);
    SET ambil_angka = ambil_angka + 1;
    SET kode_baru = CONCAT('BRG',ambil_angka);
 
    RETURN kode_baru;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `newkodesupplier` () RETURNS CHAR(8) CHARSET utf8mb4 BEGIN
    DECLARE kode_lama CHARACTER(8) DEFAULT 'SPR001';
    DECLARE ambil_angka INT DEFAULT 0;
    DECLARE kode_baru CHARACTER(8) DEFAULT 'SPR001';
    SELECT MAX(id_supplier) INTO kode_lama FROM supplier;
    SET ambil_angka = SUBSTR(kode_lama,4,6);
    SET ambil_angka = ambil_angka + 1;
    
    IF ambil_angka >= 10 THEN
    SET kode_baru = CONCAT('SPR0',ambil_angka);
    ELSE SET kode_baru = CONCAT('SPR00', ambil_angka);
    END IF;
    RETURN kode_baru;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` char(8) NOT NULL,
  `nama_barang` varchar(225) NOT NULL,
  `spesifikasi` text NOT NULL,
  `lokasi` char(4) NOT NULL,
  `kondisi` varchar(20) NOT NULL,
  `jumlah_barang` int(11) NOT NULL,
  `sumber_dana` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `spesifikasi`, `lokasi`, `kondisi`, `jumlah_barang`, `sumber_dana`) VALUES
('BRG10001', 'Kursi Siswa', 'Bantalan Merah\r\nAlumunium', 'R001', 'Baik', 36, 'S001'),
('BRG10002', 'Kursi Lipat Siswa', 'Kursi Lipat\r\nMerk Informa\r\nBantalan Hitam', 'R002', 'Baik', 36, 'S001'),
('BRG10003', 'Meja Siswa', 'Meja Alumunium Plastik', 'R003', 'Baik', 33, 'S005'),
('BRG20001', 'Laptop Acer Aspire E1-471', 'Acer Aspire E1-471\r\nCore i3, RAM 4GB, HDD 500GB', 'R002', 'Baik', 30, 'S002'),
('BRG20002', 'Laptop Lenovo E550', 'Laptop Lenovo E550\r\nIntel Core i7, RAM 8GB, HDD 1TB', 'R002', 'Baik', 23, 'S003'),
('BRG20003', 'PC Rakitan i7', 'Intel Core i7, \r\nRAM 16GB, \r\nSSD 512GB', 'R001', 'Baik', 12, 'S004'),
('BRG20004', 'Camera DSLR D60', 'DSLR Canon D60', 'R005', 'Baik', 16, 'S003'),
('BRG30001', 'Lighting Set', 'stand light tronik 2\r\nlighting tronik 2 100watt\r\n', 'R005', 'Baik', 2, 'S005'),
('BRG30002', 'Tripod Kamera', 'Takara Tripod', 'R005', 'Baik', 4, 'S002'),
('BRG30003', 'Keyboard Jellybean Round', '', 'R002', 'Baik', 10, 'S002');

--
-- Triggers `barang`
--
DELIMITER $$
CREATE TRIGGER `triger_insert_barang_stok_akmal_xiirplb` AFTER INSERT ON `barang` FOR EACH ROW BEGIN
	INSERT INTO stok (id_barang,jml_masuk,total_barang) VALUES(new.id_barang, new.jumlah_barang, new.jumlah_barang);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `triger_log_delete_barang_akmal_xiirplb` AFTER DELETE ON `barang` FOR EACH ROW BEGIN
	INSERT INTO barang_log (nama_event,nama_barang,spesifikasi,lokasi,kondisi,jumlah_barang,sumber_dana,waktu_event) VALUES('hapus', old.nama_barang, old.spesifikasi,old.lokasi,old.kondisi,old.jumlah_barang,old.sumber_dana, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `triger_log_insert_barang_akmal_xiirplb` AFTER INSERT ON `barang` FOR EACH ROW BEGIN
	INSERT INTO barang_log (nama_event,nama_barang,spesifikasi,lokasi,kondisi,jumlah_barang,sumber_dana,waktu_event) VALUES('tambah', new.nama_barang, new.spesifikasi,new.lokasi,new.kondisi,new.jumlah_barang,new.sumber_dana, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `triger_log_update_barang_akmal_xiirplb` AFTER UPDATE ON `barang` FOR EACH ROW BEGIN
	INSERT INTO barang_log (nama_event,nama_barang,spesifikasi,lokasi,kondisi,jumlah_barang,sumber_dana,waktu_event) VALUES('edit', new.nama_barang, new.spesifikasi,new.lokasi,new.kondisi,new.jumlah_barang,new.sumber_dana, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `barang_belumpinjam`
-- (See below for the actual view)
--
CREATE TABLE `barang_belumpinjam` (
`id_pinjam` int(11)
,`peminjam` char(8)
,`nama_barang` varchar(225)
);

-- --------------------------------------------------------

--
-- Table structure for table `barang_keluar`
--

CREATE TABLE `barang_keluar` (
  `id_barang` char(8) NOT NULL,
  `tgl_keluar` date NOT NULL,
  `jml_keluar` int(11) NOT NULL,
  `supplier` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang_keluar`
--

INSERT INTO `barang_keluar` (`id_barang`, `tgl_keluar`, `jml_keluar`, `supplier`) VALUES
('BRG10001', '2020-11-03', 16, 'SPR001'),
('BRG20001', '2017-11-06', 3, 'SPR005');

-- --------------------------------------------------------

--
-- Table structure for table `barang_log`
--

CREATE TABLE `barang_log` (
  `id_log` int(11) NOT NULL,
  `nama_event` varchar(10) DEFAULT NULL,
  `nama_barang` varchar(255) DEFAULT NULL,
  `spesifikasi` text DEFAULT NULL,
  `kondisi` varchar(20) DEFAULT NULL,
  `lokasi` char(4) NOT NULL,
  `jumlah_barang` int(11) DEFAULT NULL,
  `sumber_dana` char(4) DEFAULT NULL,
  `waktu_event` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang_log`
--

INSERT INTO `barang_log` (`id_log`, `nama_event`, `nama_barang`, `spesifikasi`, `kondisi`, `lokasi`, `jumlah_barang`, `sumber_dana`, `waktu_event`) VALUES
(1, 'tambah', 'Proyektor Desk JET', '', 'Baik', 'R001', 10, 'S005', '2021-11-12 06:36:20'),
(2, 'edit', 'Proyektor Desk JET', '', 'Baik', 'R001', 12, 'S005', '2021-11-12 06:41:03'),
(3, 'hapus', 'Proyektor Desk JET', '', 'Baik', 'R001', 12, 'S005', '2021-11-12 06:49:44');

-- --------------------------------------------------------

--
-- Table structure for table `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id_barang` char(8) NOT NULL,
  `tgl_masuk` date NOT NULL,
  `jml_masuk` int(11) NOT NULL,
  `supplier` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang_masuk`
--

INSERT INTO `barang_masuk` (`id_barang`, `tgl_masuk`, `jml_masuk`, `supplier`) VALUES
('BRG10001', '2007-08-01', 36, 'SPR001'),
('BRG10002', '2007-08-01', 36, 'SPR002'),
('BRG10003', '2021-11-10', 36, 'SPR002'),
('BRG20001', '2013-07-09', 30, 'SPR004'),
('BRG20002', '2014-03-08', 23, 'SPR003'),
('BRG20003', '2020-11-10', 12, 'SPR004'),
('BRG20004', '2014-04-13', 16, 'SPR005'),
('BRG30001', '2018-04-06', 2, 'SPR005'),
('BRG30002', '2018-04-06', 4, 'SPR005');

-- --------------------------------------------------------

--
-- Stand-in structure for view `daftar_barangkeluar`
-- (See below for the actual view)
--
CREATE TABLE `daftar_barangkeluar` (
`id_barang` char(8)
,`tgl_keluar` date
,`nama_barang` varchar(225)
,`supplier` varchar(225)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `daftar_barangmasuk`
-- (See below for the actual view)
--
CREATE TABLE `daftar_barangmasuk` (
`id_barang` char(8)
,`tgl_masuk` date
,`nama_barang` varchar(225)
,`supplier` varchar(225)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `jumlah_barang_dipinjam_tiap_ruang`
-- (See below for the actual view)
--
CREATE TABLE `jumlah_barang_dipinjam_tiap_ruang` (
`id_lokasi` char(4)
,`nama_lokasi` varchar(225)
,`jumlah_barang_dilokasi` int(11)
,`id_barang` char(8)
,`jumlah_peminjaman` bigint(21)
,`total_barang_dipinjam` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `jumlah_barang_lokasi`
-- (See below for the actual view)
--
CREATE TABLE `jumlah_barang_lokasi` (
`lokasi` char(4)
,`total_barang` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `jumlah_ruang`
-- (See below for the actual view)
--
CREATE TABLE `jumlah_ruang` (
`jumlah_ruang` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `jumlah_ruang_tiap_penanggungjawab`
-- (See below for the actual view)
--
CREATE TABLE `jumlah_ruang_tiap_penanggungjawab` (
`penanggung_jawab` varchar(225)
,`jumlah_lokasi_penaggung_jawab` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `level_user`
--

CREATE TABLE `level_user` (
  `id_level` char(3) NOT NULL,
  `nama` varchar(225) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `level_user`
--

INSERT INTO `level_user` (`id_level`, `nama`, `keterangan`) VALUES
('U01', 'Administrator', ''),
('U02', 'Manajemen', ''),
('U03', 'Peminjam', '');

-- --------------------------------------------------------

--
-- Stand-in structure for view `listuser`
-- (See below for the actual view)
--
CREATE TABLE `listuser` (
`id_user` char(8)
,`nama` varchar(225)
,`username` varchar(50)
,`level` varchar(225)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `list_user`
-- (See below for the actual view)
--
CREATE TABLE `list_user` (
`foto_profil` varchar(225)
,`nama` varchar(225)
,`username` varchar(50)
,`level` varchar(225)
);

-- --------------------------------------------------------

--
-- Table structure for table `lokasi`
--

CREATE TABLE `lokasi` (
  `id_lokasi` char(4) NOT NULL,
  `nama_lokasi` varchar(225) NOT NULL,
  `penanggung_jawab` varchar(225) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lokasi`
--

INSERT INTO `lokasi` (`id_lokasi`, `nama_lokasi`, `penanggung_jawab`, `keterangan`) VALUES
('R001', 'Lab RPL 1', 'Satria Ade Putra', 'Lantai 3'),
('R002', 'Lab RPL 2', 'Satria Ade Putra', 'Lantai 3'),
('R003', 'Lab TKJ 1', 'Supriyadi', 'Lantai 2 Gedung D '),
('R004', 'Lab TKJ 2', 'Supriyadi', 'Lantai 2 Gedung D'),
('R005', 'Lab Multimedia', 'Bayu Setiawan', 'Gedung Multimedia');

-- --------------------------------------------------------

--
-- Stand-in structure for view `lokasi_barang`
-- (See below for the actual view)
--
CREATE TABLE `lokasi_barang` (
`id_barang` char(8)
,`nama_barang` varchar(225)
,`lokasi_barang` varchar(225)
);

-- --------------------------------------------------------

--
-- Table structure for table `pinjam_barang`
--

CREATE TABLE `pinjam_barang` (
  `id_pinjam` int(11) NOT NULL,
  `peminjam` char(8) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `barang_pinjam` char(8) NOT NULL,
  `jml_pinjam` int(11) NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kondisi` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pinjam_barang`
--

INSERT INTO `pinjam_barang` (`id_pinjam`, `peminjam`, `tgl_pinjam`, `barang_pinjam`, `jml_pinjam`, `tgl_kembali`, `kondisi`) VALUES
(1, 'USR20001', '2021-06-09', 'BRG20002', 1, '2021-06-23', 'Baik'),
(2, 'USR20002', '2021-06-09', 'BRG20002', 1, '2021-06-09', 'Baik'),
(3, 'USR20004', '2021-08-05', 'BRG20004', 3, '2021-08-21', 'Baik'),
(4, 'USR20004', '2021-08-05', 'BRG30002', 3, '2021-08-05', 'Baik'),
(9, 'USR20004', '2021-11-10', 'BRG10003', 3, '0000-00-00', 'Baik');

-- --------------------------------------------------------

--
-- Stand-in structure for view `rata_rata_barang_masuk`
-- (See below for the actual view)
--
CREATE TABLE `rata_rata_barang_masuk` (
`AVG(jml_masuk)` decimal(14,4)
);

-- --------------------------------------------------------

--
-- Table structure for table `stok`
--

CREATE TABLE `stok` (
  `id_barang` char(8) NOT NULL,
  `jml_masuk` int(11) NOT NULL,
  `jml_keluar` int(11) NOT NULL,
  `total_barang` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stok`
--

INSERT INTO `stok` (`id_barang`, `jml_masuk`, `jml_keluar`, `total_barang`) VALUES
('BRG10001', 36, 0, 36),
('BRG10002', 36, 16, 20),
('BRG10003', 36, 0, 33),
('BRG20001', 30, 3, 28),
('BRG20002', 23, 0, 23),
('BRG20003', 12, 0, 12),
('BRG20004', 16, 0, 16),
('BRG30001', 2, 0, 2),
('BRG30002', 4, 0, 4),
('BRG30003', 10, 0, 10);

-- --------------------------------------------------------

--
-- Stand-in structure for view `stok_terbanyak`
-- (See below for the actual view)
--
CREATE TABLE `stok_terbanyak` (
`id_barang` char(8)
,`MAX(total_barang)` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `sumber_dana`
--

CREATE TABLE `sumber_dana` (
  `id_sumber` char(4) NOT NULL,
  `nama_sumber` varchar(225) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sumber_dana`
--

INSERT INTO `sumber_dana` (`id_sumber`, `nama_sumber`, `keterangan`) VALUES
('S001', 'Komite 07/09', 'Bantuan Komite 2007/2009'),
('S002', 'Komite 13', 'bantuan Komite 2013'),
('S003', 'Sed t-vet', 'Bantuan Kerja sama Indonesia Jerman'),
('S004', 'BOPD 2020', 'Bantuan Provinsi Jawa Barat'),
('S005', 'BOSDA 2018', 'Bantuan Operasional Sekolah Daerah Jawa Barat 2018');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` varchar(8) NOT NULL,
  `nama_supplier` varchar(225) NOT NULL,
  `alamat_supplier` text NOT NULL,
  `telp_supplier` varchar(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `nama_supplier`, `alamat_supplier`, `telp_supplier`) VALUES
('SPR001', 'INFORMA-MALL METROPOLITAN BEKASI', 'Mall Metropolitan, Jl. KH. Noer Ali No.1, RT.008/RW.002, Pekayon Jaya, Kec. Bekasi Sel., Kota Bks, Jawa Barat 17148', '0812-9604-6051'),
('SPR002', 'Mitrakantor.com', 'Jl. I Gusti Ngurah Rai No.20, RT.1/RW.10, Klender, Kec. Duren Sawit, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta', '(021) 22862086'),
('SPR003', 'Bhinneka.com', 'Jl. Gn. Sahari No.73C, RT.9/RW.7, Gn. Sahari Sel., Kec. Kemayoran, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10610', '(021) 29292828'),
('SPR004', 'World Computer', 'Harco Mangga Dua Plaza, Jalan Arteri Jl. Mangga Dua Raya No.17, RW.11, Mangga Dua Sel., Kecamatan Sawah Besar, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10730', '(021) 6125266'),
('SPR005', 'Anekafoto Metro Atom', 'Metro Atom Plaza Jalan Samanhudi Blok AKS No. 19, RT.20/RW.3, Ps. Baru, Kecamatan Sawah Besar, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10710', '(021) 3455544');

-- --------------------------------------------------------

--
-- Stand-in structure for view `totalbarang`
-- (See below for the actual view)
--
CREATE TABLE `totalbarang` (
`id_barang` char(8)
,`nama_barang` varchar(225)
,`total_barang` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` char(8) NOT NULL,
  `foto_profil` varchar(225) NOT NULL,
  `nama` varchar(225) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `level` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `foto_profil`, `nama`, `username`, `password`, `level`) VALUES
('USR00001', 'nana.jpg', 'Nana Sukmana', 'admin', '$2y$10$WxmFoT73zm/EGMdv5mZsA.bgc/8Bv3e/qTK6dECqREyTXxmupdZsC', 'U01'),
('USR00002', 'default.png', 'Deden Deendi', 'toolman=RPL', '$2y$10$nPnRFg5GbhBEjKroLC0mx.62RdF1TB7eH/SOjWrzcbRmSaCl6oy.m', 'U02'),
('USR00003', 'default.png', 'Ilham Kamil', 'toolman=MM', '$2y$10$eJM6vzzerMKfMhV5cHz39eMFN8lbkoa8cXPGVWTrdOgX8wbZ.88ru', 'U02'),
('USR00004', 'default.png', 'Abdul Rahman', 'toolman=TKJ', '$2y$10$BiorRNRV1ZlE9JM0bxzMIeLxcCUSG4eB4ekGLvQ6VVdhqNStDYTqW', 'U02'),
('USR20001', 'default.png', 'Dzaki', 'dzaki', '$2y$10$yiV9/ZawmQTAsOasKMJSseXpIUeyJI81ThjNDSY2pa.VtMLXj7WVC', 'U03'),
('USR20002', 'default.png', 'Sulthan ', 'sulthan', '$2y$10$m0UEUZcx91Pk3.iszh0yZ.WJsDhlztViAe6Ms3i/7RMtKXg.4/zby', 'U03'),
('USR20003', 'default.png', 'Fahru', 'fahru', '$2y$10$VGZIKqVb32lCJwJeKrHyIeC.V2zPuSEi4U3njSpFAG0POnuZtnARu', 'U03'),
('USR20004', 'default.png', 'Akwan', 'akwan', '$2y$10$5OgmMcIfeklgFNhxeA0P0.aCAfLya5QxJGU80g/tdwJp/uFEYyfGy', 'U03');

-- --------------------------------------------------------

--
-- Structure for view `barang_belumpinjam`
--
DROP TABLE IF EXISTS `barang_belumpinjam`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `barang_belumpinjam`  AS SELECT `pinjam`.`id_pinjam` AS `id_pinjam`, `pinjam`.`peminjam` AS `peminjam`, `b`.`nama_barang` AS `nama_barang` FROM (`barang` `b` left join `pinjam_barang` `pinjam` on(`pinjam`.`barang_pinjam` = `b`.`id_barang`)) WHERE `pinjam`.`id_pinjam` is null ;

-- --------------------------------------------------------

--
-- Structure for view `daftar_barangkeluar`
--
DROP TABLE IF EXISTS `daftar_barangkeluar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `daftar_barangkeluar`  AS SELECT `keluar`.`id_barang` AS `id_barang`, `keluar`.`tgl_keluar` AS `tgl_keluar`, `b`.`nama_barang` AS `nama_barang`, `sup`.`nama_supplier` AS `supplier` FROM ((`barang_keluar` `keluar` left join `supplier` `sup` on(`keluar`.`supplier` = `sup`.`id_supplier`)) left join `barang` `b` on(`keluar`.`id_barang` = `b`.`id_barang`)) ;

-- --------------------------------------------------------

--
-- Structure for view `daftar_barangmasuk`
--
DROP TABLE IF EXISTS `daftar_barangmasuk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `daftar_barangmasuk`  AS SELECT `masuk`.`id_barang` AS `id_barang`, `masuk`.`tgl_masuk` AS `tgl_masuk`, `b`.`nama_barang` AS `nama_barang`, `sup`.`nama_supplier` AS `supplier` FROM ((`barang_masuk` `masuk` left join `supplier` `sup` on(`masuk`.`supplier` = `sup`.`id_supplier`)) left join `barang` `b` on(`masuk`.`id_barang` = `b`.`id_barang`)) ;

-- --------------------------------------------------------

--
-- Structure for view `jumlah_barang_dipinjam_tiap_ruang`
--
DROP TABLE IF EXISTS `jumlah_barang_dipinjam_tiap_ruang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jumlah_barang_dipinjam_tiap_ruang`  AS SELECT `l`.`id_lokasi` AS `id_lokasi`, `l`.`nama_lokasi` AS `nama_lokasi`, `b`.`jumlah_barang` AS `jumlah_barang_dilokasi`, `p`.`barang_pinjam` AS `id_barang`, count(`b`.`nama_barang`) AS `jumlah_peminjaman`, sum(`p`.`jml_pinjam`) AS `total_barang_dipinjam` FROM ((`pinjam_barang` `p` join `barang` `b` on(`b`.`id_barang` = `p`.`barang_pinjam`)) join `lokasi` `l` on(`b`.`lokasi` = `l`.`id_lokasi`)) GROUP BY `p`.`barang_pinjam` HAVING count(`b`.`nama_barang`) > 1 ;

-- --------------------------------------------------------

--
-- Structure for view `jumlah_barang_lokasi`
--
DROP TABLE IF EXISTS `jumlah_barang_lokasi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jumlah_barang_lokasi`  AS SELECT `barang`.`lokasi` AS `lokasi`, sum(`barang`.`jumlah_barang`) AS `total_barang` FROM `barang` GROUP BY `barang`.`lokasi` ;

-- --------------------------------------------------------

--
-- Structure for view `jumlah_ruang`
--
DROP TABLE IF EXISTS `jumlah_ruang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jumlah_ruang`  AS SELECT count(`lokasi`.`nama_lokasi`) AS `jumlah_ruang` FROM `lokasi` ;

-- --------------------------------------------------------

--
-- Structure for view `jumlah_ruang_tiap_penanggungjawab`
--
DROP TABLE IF EXISTS `jumlah_ruang_tiap_penanggungjawab`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jumlah_ruang_tiap_penanggungjawab`  AS SELECT `lokasi`.`penanggung_jawab` AS `penanggung_jawab`, count(`lokasi`.`penanggung_jawab`) AS `jumlah_lokasi_penaggung_jawab` FROM `lokasi` GROUP BY `lokasi`.`penanggung_jawab` ;

-- --------------------------------------------------------

--
-- Structure for view `listuser`
--
DROP TABLE IF EXISTS `listuser`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listuser`  AS SELECT `u`.`id_user` AS `id_user`, `u`.`nama` AS `nama`, `u`.`username` AS `username`, `l`.`nama` AS `level` FROM (`user` `u` join `level_user` `l` on(`u`.`level` = `l`.`id_level`)) ;

-- --------------------------------------------------------

--
-- Structure for view `list_user`
--
DROP TABLE IF EXISTS `list_user`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `list_user`  AS SELECT `user`.`foto_profil` AS `foto_profil`, `user`.`nama` AS `nama`, `user`.`username` AS `username`, `level_user`.`nama` AS `level` FROM (`user` join `level_user` on(`level_user`.`id_level` = `user`.`level`)) ;

-- --------------------------------------------------------

--
-- Structure for view `lokasi_barang`
--
DROP TABLE IF EXISTS `lokasi_barang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lokasi_barang`  AS SELECT `b`.`id_barang` AS `id_barang`, `b`.`nama_barang` AS `nama_barang`, `lok`.`nama_lokasi` AS `lokasi_barang` FROM (`lokasi` `lok` left join `barang` `b` on(`b`.`lokasi` = `lok`.`id_lokasi`)) ;

-- --------------------------------------------------------

--
-- Structure for view `rata_rata_barang_masuk`
--
DROP TABLE IF EXISTS `rata_rata_barang_masuk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rata_rata_barang_masuk`  AS SELECT avg(`barang_masuk`.`jml_masuk`) AS `AVG(jml_masuk)` FROM `barang_masuk` ;

-- --------------------------------------------------------

--
-- Structure for view `stok_terbanyak`
--
DROP TABLE IF EXISTS `stok_terbanyak`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `stok_terbanyak`  AS SELECT `stok`.`id_barang` AS `id_barang`, max(`stok`.`total_barang`) AS `MAX(total_barang)` FROM `stok` ;

-- --------------------------------------------------------

--
-- Structure for view `totalbarang`
--
DROP TABLE IF EXISTS `totalbarang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `totalbarang`  AS SELECT `s`.`id_barang` AS `id_barang`, `b`.`nama_barang` AS `nama_barang`, `s`.`total_barang` AS `total_barang` FROM (`stok` `s` join `barang` `b` on(`s`.`id_barang` = `b`.`id_barang`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `lokasi` (`lokasi`),
  ADD KEY `sumber_dana` (`sumber_dana`);

--
-- Indexes for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `supplier` (`supplier`);

--
-- Indexes for table `barang_log`
--
ALTER TABLE `barang_log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `supplier` (`supplier`);

--
-- Indexes for table `level_user`
--
ALTER TABLE `level_user`
  ADD PRIMARY KEY (`id_level`);

--
-- Indexes for table `lokasi`
--
ALTER TABLE `lokasi`
  ADD PRIMARY KEY (`id_lokasi`);

--
-- Indexes for table `pinjam_barang`
--
ALTER TABLE `pinjam_barang`
  ADD PRIMARY KEY (`id_pinjam`),
  ADD KEY `peminjam` (`peminjam`),
  ADD KEY `barang_pinjam` (`barang_pinjam`);

--
-- Indexes for table `stok`
--
ALTER TABLE `stok`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indexes for table `sumber_dana`
--
ALTER TABLE `sumber_dana`
  ADD PRIMARY KEY (`id_sumber`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_supplier`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `user_ibfk_1` (`level`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang_log`
--
ALTER TABLE `barang_log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pinjam_barang`
--
ALTER TABLE `pinjam_barang`
  MODIFY `id_pinjam` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`lokasi`) REFERENCES `lokasi` (`id_lokasi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_ibfk_2` FOREIGN KEY (`sumber_dana`) REFERENCES `sumber_dana` (`id_sumber`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD CONSTRAINT `barang_keluar_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_keluar_ibfk_2` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`id_supplier`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD CONSTRAINT `barang_masuk_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_masuk_ibfk_2` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`id_supplier`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pinjam_barang`
--
ALTER TABLE `pinjam_barang`
  ADD CONSTRAINT `pinjam_barang_ibfk_1` FOREIGN KEY (`peminjam`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pinjam_barang_ibfk_2` FOREIGN KEY (`barang_pinjam`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `stok`
--
ALTER TABLE `stok`
  ADD CONSTRAINT `stok_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`level`) REFERENCES `level_user` (`id_level`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
