-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 13, 2026 at 07:28 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `attendsync`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

CREATE TABLE `administrator` (
  `admin_id` int(11) NOT NULL,
  `institution_id` int(11) NOT NULL,
  `admin_name` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `administrator`
--

INSERT INTO `administrator` (`admin_id`, `institution_id`, `admin_name`, `email`, `password`, `phone`, `created_at`) VALUES
(1, 1, 'System Administrator', 'admin@hatim.local', '$2y$10$kgnCgXxMm0EmlZ6.U.po9uOmb2ixNcBZ8jZUvTbLs3Jgs66sWasYO', NULL, '2026-08-11 13:07:48');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendance_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `attendance_date` date NOT NULL,
  `status` enum('Present','Absent','Late','Excused') NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `marked_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`attendance_id`, `student_id`, `subject_id`, `teacher_id`, `attendance_date`, `status`, `remarks`, `marked_at`) VALUES
(11, 110, 54, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:22'),
(12, 111, 54, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:22'),
(13, 112, 54, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:22'),
(14, 113, 54, 7, '2026-08-13', 'Absent', NULL, '2026-08-13 05:09:22'),
(15, 114, 54, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:22'),
(16, 115, 54, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:22'),
(17, 116, 54, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:22'),
(18, 117, 54, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:22'),
(19, 118, 54, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:22'),
(20, 119, 54, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:22'),
(21, 110, 57, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:44'),
(22, 111, 57, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:44'),
(23, 112, 57, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:44'),
(24, 113, 57, 7, '2026-08-13', 'Absent', NULL, '2026-08-13 05:09:44'),
(25, 114, 57, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:44'),
(26, 115, 57, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:44'),
(27, 116, 57, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:44'),
(28, 117, 57, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:44'),
(29, 118, 57, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:44'),
(30, 119, 57, 7, '2026-08-13', 'Present', NULL, '2026-08-13 05:09:44'),
(31, 110, 56, 6, '2026-08-13', 'Present', NULL, '2026-08-13 05:12:27'),
(32, 111, 56, 6, '2026-08-13', 'Present', NULL, '2026-08-13 05:12:27'),
(33, 112, 56, 6, '2026-08-13', 'Present', NULL, '2026-08-13 05:12:27'),
(34, 113, 56, 6, '2026-08-13', 'Absent', NULL, '2026-08-13 05:12:27'),
(35, 114, 56, 6, '2026-08-13', 'Present', NULL, '2026-08-13 05:12:27'),
(36, 115, 56, 6, '2026-08-13', 'Present', NULL, '2026-08-13 05:12:27'),
(37, 116, 56, 6, '2026-08-13', 'Present', NULL, '2026-08-13 05:12:27'),
(38, 117, 56, 6, '2026-08-13', 'Present', NULL, '2026-08-13 05:12:27'),
(39, 118, 56, 6, '2026-08-13', 'Present', NULL, '2026-08-13 05:12:27'),
(40, 119, 56, 6, '2026-08-13', 'Present', NULL, '2026-08-13 05:12:27'),
(41, 71, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(42, 72, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(43, 73, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(44, 74, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(45, 75, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(46, 76, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(47, 77, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(48, 78, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(49, 79, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(50, 80, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(51, 81, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(52, 82, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(53, 83, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(54, 84, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48'),
(55, 85, 53, 11, '2026-08-13', 'Present', NULL, '2026-08-13 05:13:48');

-- --------------------------------------------------------

--
-- Table structure for table `attendance_alert`
--

CREATE TABLE `attendance_alert` (
  `alert_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `alert_type` enum('Low Attendance','Leave Status','General') NOT NULL DEFAULT 'Low Attendance',
  `message` varchar(255) NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `institution_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `institution_id`, `name`) VALUES
(1, 1, 'BA (English)'),
(2, 1, 'BA (History)'),
(3, 1, 'BA (Education)'),
(4, 1, 'BA (Philosophy)'),
(5, 1, 'BA (Psychology)'),
(6, 1, 'Bachelor of Social Work (BSW)'),
(7, 1, 'Bachelor of Computer Application (BCA)'),
(8, 1, 'Bachelor of Commerce (B.Com)');

-- --------------------------------------------------------

--
-- Table structure for table `institutions`
--

CREATE TABLE `institutions` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `institutions`
--

INSERT INTO `institutions` (`id`, `name`) VALUES
(1, 'HATIM');

-- --------------------------------------------------------

--
-- Table structure for table `parent`
--

CREATE TABLE `parent` (
  `parent_id` int(11) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `relation` varchar(40) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `parent_student`
--

CREATE TABLE `parent_student` (
  `parent_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `report_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `generated_by_teacher_id` int(11) DEFAULT NULL,
  `total_classes` int(11) NOT NULL DEFAULT 0,
  `attended_classes` int(11) NOT NULL DEFAULT 0,
  `attendance_percentage` decimal(5,2) NOT NULL DEFAULT 0.00,
  `generated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `semester`
--

CREATE TABLE `semester` (
  `semester_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `semester_number` tinyint(4) NOT NULL,
  `semester_name` varchar(80) NOT NULL,
  `academic_year` varchar(20) NOT NULL,
  `section_name` varchar(20) NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `semester`
--

INSERT INTO `semester` (`semester_id`, `department_id`, `teacher_id`, `semester_number`, `semester_name`, `academic_year`, `section_name`, `created_at`) VALUES
(1, 7, NULL, 1, 'BCA I Semester', '2026-2027', '', '2026-08-11 09:56:02'),
(2, 7, NULL, 3, 'BCA III Semester', '2026-2027', '', '2026-08-11 09:56:02'),
(3, 7, NULL, 5, 'BCA V Semester', '2026-2027', '', '2026-08-11 09:56:02'),
(4, 8, NULL, 1, 'B.Com I Semester', '2026-2027', '', '2026-08-11 14:32:31'),
(5, 8, NULL, 3, 'B.Com III Semester', '2026-2027', '', '2026-08-11 14:41:58'),
(6, 8, NULL, 5, 'B.Com V Semester', '2026-2027', '', '2026-08-11 14:41:58');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` int(11) NOT NULL,
  `institution_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `student_name` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `roll_no` varchar(40) NOT NULL,
  `admission_no` varchar(40) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `institution_id`, `department_id`, `semester_id`, `student_name`, `email`, `password`, `phone`, `roll_no`, `admission_no`, `created_at`) VALUES
(1, 1, 8, 4, 'Alicia D Lalrohlui', 'alicia.d.lalrohlui@hatim.local', 'change_me', NULL, '01', 'BCOM26001', '2026-08-11 14:32:31'),
(2, 1, 8, 4, 'C Lalbiaktluangi', 'c.lalbiaktluangi@hatim.local', 'change_me', NULL, '02', 'BCOM26002', '2026-08-11 14:32:31'),
(3, 1, 8, 4, 'C.Lalhriatchhungi', 'c.lalhriatchhungi@hatim.local', 'change_me', NULL, '03', 'BCOM26003', '2026-08-11 14:32:31'),
(4, 1, 8, 4, 'David R Vanlalruata', 'david.r.vanlalruata@hatim.local', 'change_me', NULL, '04', 'BCOM26004', '2026-08-11 14:32:31'),
(5, 1, 8, 4, 'Deborah Vanlalzawmpuii', 'deborah.vanlalzawmpuii@hatim.local', 'change_me', NULL, '05', 'BCOM26005', '2026-08-11 14:32:31'),
(6, 1, 8, 4, 'Dominic Malsawmkima', 'dominic.malsawmkima@hatim.local', 'change_me', NULL, '06', 'BCOM26006', '2026-08-11 14:32:31'),
(7, 1, 8, 4, 'Esther Lalchungnungi', 'esther.lalchungnungi@hatim.local', 'change_me', NULL, '07', 'BCOM26007', '2026-08-11 14:32:31'),
(8, 1, 8, 4, 'F Lalhmangaihzuali', 'f.lalhmangaihzuali@hatim.local', 'change_me', NULL, '08', 'BCOM26008', '2026-08-11 14:32:31'),
(9, 1, 8, 4, 'H.Lalruattluanga', 'h.lalruattluanga@hatim.local', 'change_me', NULL, '09', 'BCOM26009', '2026-08-11 14:32:31'),
(10, 1, 8, 4, 'Henny Laldinkimi', 'henny.laldinkimi@hatim.local', 'change_me', NULL, '10', 'BCOM26010', '2026-08-11 14:32:31'),
(11, 1, 8, 4, 'Jacob Lalmalsawma', 'jacob.lalmalsawma@hatim.local', 'change_me', NULL, '11', 'BCOM26011', '2026-08-11 14:32:31'),
(12, 1, 8, 4, 'John Carzon', 'john.carzon@hatim.local', 'change_me', NULL, '12', 'BCOM26012', '2026-08-11 14:32:31'),
(13, 1, 8, 4, 'Joseph PC Lalmalsawma', 'joseph.pc.lalmalsawma@hatim.local', 'change_me', NULL, '13', 'BCOM26013', '2026-08-11 14:32:31'),
(14, 1, 8, 4, 'K Zothansanga', 'k.zothansanga@hatim.local', 'change_me', NULL, '14', 'BCOM26014', '2026-08-11 14:32:31'),
(15, 1, 8, 4, 'Lalengmawii', 'lalengmawii@hatim.local', 'change_me', NULL, '15', 'BCOM26015', '2026-08-11 14:32:31'),
(16, 1, 8, 4, 'Lalhmingsangpuia', 'lalhmingsangpuia@hatim.local', 'change_me', NULL, '16', 'BCOM26016', '2026-08-11 14:32:31'),
(17, 1, 8, 4, 'Lallawmkima', 'lallawmkima@hatim.local', 'change_me', NULL, '17', 'BCOM26017', '2026-08-11 14:32:31'),
(18, 1, 8, 4, 'Lallawmkimi Pachuau', 'lallawmkimi.pachuau@hatim.local', 'change_me', NULL, '18', 'BCOM26018', '2026-08-11 14:32:31'),
(19, 1, 8, 4, 'Lalnundika', 'lalnundika@hatim.local', 'change_me', NULL, '19', 'BCOM26019', '2026-08-11 14:32:31'),
(20, 1, 8, 4, 'Lalnuntluanga Chawngthu', 'lalnuntluanga.chawngthu@hatim.local', 'change_me', NULL, '20', 'BCOM26020', '2026-08-11 14:32:31'),
(21, 1, 8, 4, 'Lalrinzuali', 'lalrinzuali@hatim.local', 'change_me', NULL, '21', 'BCOM26021', '2026-08-11 14:32:31'),
(22, 1, 8, 4, 'Lalruatfeli', 'lalruatfeli@hatim.local', 'change_me', NULL, '22', 'BCOM26022', '2026-08-11 14:32:31'),
(23, 1, 8, 4, 'Lalthantluangi', 'lalthantluangi@hatim.local', 'change_me', NULL, '23', 'BCOM26023', '2026-08-11 14:32:31'),
(24, 1, 8, 4, 'LH Lalnunsanga', 'lh.lalnunsanga@hatim.local', 'change_me', NULL, '24', 'BCOM26024', '2026-08-11 14:32:31'),
(25, 1, 8, 4, 'LH Nicky Malsawmkima', 'lh.nicky.malsawmkima@hatim.local', 'change_me', NULL, '25', 'BCOM26025', '2026-08-11 14:32:31'),
(26, 1, 8, 4, 'Lucy Lalrinthangi Ralte', 'lucy.lalrinthangi.ralte@hatim.local', 'change_me', NULL, '26', 'BCOM26026', '2026-08-11 14:32:31'),
(27, 1, 8, 4, 'Margareth Ramdintluangi Chinzah', 'margareth.ramdintluangi.chinzah@hatim.local', 'change_me', NULL, '27', 'BCOM26027', '2026-08-11 14:32:31'),
(28, 1, 8, 4, 'Nixon Lalpekhlua', 'nixon.lalpekhlua@hatim.local', 'change_me', NULL, '28', 'BCOM26028', '2026-08-11 14:32:31'),
(29, 1, 8, 4, 'Paul Lalrinawma', 'paul.lalrinawma@hatim.local', 'change_me', NULL, '29', 'BCOM26029', '2026-08-11 14:32:31'),
(30, 1, 8, 4, 'PC Lallawmzuali', 'pc.lallawmzuali@hatim.local', 'change_me', NULL, '30', 'BCOM26030', '2026-08-11 14:32:31'),
(31, 1, 8, 4, 'PC Malsawmtluangi', 'pc.malsawmtluangi@hatim.local', 'change_me', NULL, '31', 'BCOM26031', '2026-08-11 14:32:31'),
(32, 1, 8, 4, 'R Lalhruaizeli', 'r.lalhruaizeli@hatim.local', 'change_me', NULL, '32', 'BCOM26032', '2026-08-11 14:32:31'),
(33, 1, 8, 4, 'R Lalruatkimi', 'r.lalruatkimi@hatim.local', 'change_me', NULL, '33', 'BCOM26033', '2026-08-11 14:32:31'),
(34, 1, 8, 4, 'Rebecca Lalhunnghaki', 'rebecca.lalhunnghaki@hatim.local', 'change_me', NULL, '34', 'BCOM26034', '2026-08-11 14:32:31'),
(35, 1, 8, 4, 'Remruatfeli Fanai', 'remruatfeli.fanai@hatim.local', 'change_me', NULL, '35', 'BCOM26035', '2026-08-11 14:32:31'),
(36, 1, 8, 4, 'Rohluzuali', 'rohluzuali@hatim.local', 'change_me', NULL, '36', 'BCOM26036', '2026-08-11 14:32:31'),
(37, 1, 8, 4, 'Sarah Lalchhanchhuahi', 'sarah.lalchhanchhuahi@hatim.local', 'change_me', NULL, '37', 'BCOM26037', '2026-08-11 14:32:31'),
(38, 1, 8, 4, 'Sylvia Rosangzuali', 'sylvia.rosangzuali@hatim.local', 'change_me', NULL, '38', 'BCOM26038', '2026-08-11 14:32:31'),
(39, 1, 8, 4, 'T Lalmuanawmi', 't.lalmuanawmi@hatim.local', 'change_me', NULL, '39', 'BCOM26039', '2026-08-11 14:32:31'),
(40, 1, 8, 4, 'Vanlaldika Pachuau', 'vanlaldika.pachuau@hatim.local', 'change_me', NULL, '40', 'BCOM26040', '2026-08-11 14:32:31'),
(41, 1, 8, 4, 'Zorinsangi Jongte', 'zorinsangi.jongte@hatim.local', 'change_me', NULL, '41', 'BCOM26041', '2026-08-11 14:32:31'),
(42, 1, 8, 5, 'Ab Lalawmpuia', 'ab.lalawmpuia@hatim.local', 'change_me', NULL, '01', '2523BCOM001', '2026-08-11 14:50:45'),
(43, 1, 8, 5, 'Alex Lalrohlupuia', 'alex.lalrohlupuia@hatim.local', 'change_me', NULL, '02', '2523BCOM002', '2026-08-11 14:50:45'),
(44, 1, 8, 5, 'C. Lalnunpuii', 'c.lalnunpuii@hatim.local', 'change_me', NULL, '03', '2523BCOM003', '2026-08-11 14:50:45'),
(45, 1, 8, 5, 'C. Vanlalpeka', 'c.vanlalpeka@hatim.local', 'change_me', NULL, '04', '2523BCOM004', '2026-08-11 14:50:45'),
(46, 1, 8, 5, 'Cathy Runremsangi', 'cathy.runremsangi@hatim.local', 'change_me', NULL, '05', '2523BCOM005', '2026-08-11 14:50:45'),
(47, 1, 8, 5, 'Frankie Lalrindika', 'frankie.lalrindika@hatim.local', 'change_me', NULL, '06', '2523BCOM007', '2026-08-11 14:50:45'),
(48, 1, 8, 5, 'Gason Malsawmzuala', 'gason.malsawmzuala@hatim.local', 'change_me', NULL, '07', '2523BCOM008', '2026-08-11 14:50:45'),
(49, 1, 8, 5, 'Hannah Hp. Lalrindiki', 'hannah.hp.lalrindiki@hatim.local', 'change_me', NULL, '08', '2523BCOM010', '2026-08-11 14:50:45'),
(50, 1, 8, 5, 'Heidi Vanlalruati', 'heidi.vanlalruati@hatim.local', 'change_me', NULL, '09', '2523BCOM011', '2026-08-11 14:50:45'),
(51, 1, 8, 5, 'K. Ramdinmawia', 'k.ramdinmawia@hatim.local', 'change_me', NULL, '10', '2523BCOM013', '2026-08-11 14:50:45'),
(52, 1, 8, 5, 'Lalawmpuia Chongthu', 'lalawmpuia.chongthu@hatim.local', 'change_me', NULL, '11', '2523BCOM014', '2026-08-11 14:50:45'),
(53, 1, 8, 5, 'Lalrinpuii Kawlni', 'lalrinpuii.kawlni@hatim.local', 'change_me', NULL, '12', '2523BCOM015', '2026-08-11 14:50:45'),
(54, 1, 8, 5, 'Melody Zothansangi', 'melody.zothansangi@hatim.local', 'change_me', NULL, '13', '2523BCOM017', '2026-08-11 14:50:45'),
(55, 1, 8, 5, 'Nugrdingliana Sailo', 'nugrdingliana.sailo@hatim.local', 'change_me', NULL, '14', '2523BCOM018', '2026-08-11 14:50:45'),
(56, 1, 8, 5, 'Omega Laltlanthanga', 'omega.laltlanthanga@hatim.local', 'change_me', NULL, '15', '2523BCOM019', '2026-08-11 14:50:45'),
(57, 1, 8, 5, 'Rc. Lalduhawmi', 'rc.lalduhawmi@hatim.local', 'change_me', NULL, '16', '2523BCOM020', '2026-08-11 14:50:45'),
(58, 1, 8, 5, 'Rf Vanlalsiama', 'rf.vanlalsiama@hatim.local', 'change_me', NULL, '17', '2523BCOM021', '2026-08-11 14:50:45'),
(59, 1, 8, 5, 'Rochanmawia Pachuau', 'rochanmawia.pachuau@hatim.local', 'change_me', NULL, '18', '2523BCOM022', '2026-08-11 14:50:45'),
(60, 1, 8, 5, 'Rosangpuia Pautu', 'rosangpuia.pautu@hatim.local', 'change_me', NULL, '19', '2523BCOM023', '2026-08-11 14:50:45'),
(61, 1, 8, 5, 'S. Thyuheizi', 's.thyuheizi@hatim.local', 'change_me', NULL, '20', '2523BCOM024', '2026-08-11 14:50:45'),
(62, 1, 8, 5, 'Sarah Malsawmdawngzuali', 'sarah.malsawmdawngzuali@hatim.local', 'change_me', NULL, '21', '2523BCOM025', '2026-08-11 14:50:45'),
(63, 1, 8, 5, 'Sophia Lalruatkimi', 'sophia.lalruatkimi@hatim.local', 'change_me', NULL, '22', '2523BCOM026', '2026-08-11 14:50:45'),
(64, 1, 8, 5, 'Stephen K. Lalrindika', 'stephen.k.lalrindika@hatim.local', 'change_me', NULL, '23', '2523BCOM027', '2026-08-11 14:50:45'),
(65, 1, 8, 5, 'T. Vanlalzuia', 't.vanlalzuia@hatim.local', 'change_me', NULL, '24', '2523BCOM028', '2026-08-11 14:50:45'),
(66, 1, 8, 5, 'Vanlalhruaitluanga', 'vanlalhruaitluanga@hatim.local', 'change_me', NULL, '25', '2523BCOM029', '2026-08-11 14:50:45'),
(67, 1, 8, 5, 'Vanlalmalsawmdawngzuala', 'vanlalmalsawmdawngzuala@hatim.local', 'change_me', NULL, '26', '2523BCOM030', '2026-08-11 14:50:45'),
(68, 1, 8, 5, 'Vanlalrengpuii Chinzah', 'vanlalrengpuii.chinzah@hatim.local', 'change_me', NULL, '27', '2523BCOM031', '2026-08-11 14:50:45'),
(69, 1, 8, 5, 'Vanlalruati', 'vanlalruati@hatim.local', 'change_me', NULL, '28', '2523BCOM032', '2026-08-11 14:50:45'),
(70, 1, 8, 5, 'Catherine Lalramdinthari', 'catherine.lalramdinthari@hatim.local', 'change_me', NULL, '29', '2523BCOM035', '2026-08-11 14:50:45'),
(71, 1, 8, 6, 'A Lalhlimpuia', 'a.lalhlimpuia@hatim.local', 'change_me', NULL, '01', '2423BCOM001', '2026-08-11 14:50:45'),
(72, 1, 8, 6, 'C Lalhmangaihsanga', 'c.lalhmangaihsanga@hatim.local', 'change_me', NULL, '02', '2423BCOM002', '2026-08-11 14:50:45'),
(73, 1, 8, 6, 'Cassie Rohluzuali', 'cassie.rohluzuali@hatim.local', 'change_me', NULL, '03', '2423BCOM003', '2026-08-11 14:50:45'),
(74, 1, 8, 6, 'Christina H Malsawmsangi', 'christina.h.malsawmsangi@hatim.local', 'change_me', NULL, '04', '2423BCOM004', '2026-08-11 14:50:45'),
(75, 1, 8, 6, 'Christina Lalrinfeli', 'christina.lalrinfeli@hatim.local', 'change_me', NULL, '05', '2423BCOM005', '2026-08-11 14:50:45'),
(76, 1, 8, 6, 'Lalduhzuali', 'lalduhzuali@hatim.local', 'change_me', NULL, '06', '2423BCOM006', '2026-08-11 14:50:45'),
(77, 1, 8, 6, 'Lalhruaitluanga', 'lalhruaitluanga@hatim.local', 'change_me', NULL, '07', '2423BCOM007', '2026-08-11 14:50:45'),
(78, 1, 8, 6, 'Lalhruaitluanga', 'lalhruaitluanga.08@hatim.local', 'change_me', NULL, '08', '2423BCOM008', '2026-08-11 14:50:45'),
(79, 1, 8, 6, 'Lalhruaizela Khiangte', 'lalhruaizela.khiangte@hatim.local', 'change_me', NULL, '09', '2423BCOM009', '2026-08-11 14:50:45'),
(80, 1, 8, 6, 'Lallawmsangpuia Ralte', 'lallawmsangpuia.ralte@hatim.local', 'change_me', NULL, '10', '2423BCOM010', '2026-08-11 14:50:45'),
(81, 1, 8, 6, 'Malsawmtluanga', 'malsawmtluanga@hatim.local', 'change_me', NULL, '11', '2423BCOM011', '2026-08-11 14:50:45'),
(82, 1, 8, 6, 'Malsawmtluangi', 'malsawmtluangi@hatim.local', 'change_me', NULL, '12', '2423BCOM012', '2026-08-11 14:50:45'),
(83, 1, 8, 6, 'N Lalpekhlua', 'n.lalpekhlua@hatim.local', 'change_me', NULL, '13', '2423BCOM013', '2026-08-11 14:50:45'),
(84, 1, 8, 6, 'R Lalzemawii', 'r.lalzemawii@hatim.local', 'change_me', NULL, '14', '2423BCOM014', '2026-08-11 14:50:45'),
(85, 1, 8, 6, 'Ruthi C Lalpekhlui', 'ruthi.c.lalpekhlui@hatim.local', 'change_me', NULL, '15', '2423BCOM015', '2026-08-11 14:50:45'),
(86, 1, 7, 1, 'Abraham Malsawmdawngzuala', 'abraham.malsawmdawngzuala@student.hatim.edu', 'change_me', NULL, 'BCA26-01', NULL, '2026-08-11 04:30:00'),
(87, 1, 7, 1, 'Alex Debbarma', 'alex.debbarma@student.hatim.edu', 'change_me', NULL, 'BCA26-02', NULL, '2026-08-11 04:30:00'),
(88, 1, 7, 1, 'C Ramchansanga', 'c.ramchansanga@student.hatim.edu', 'change_me', NULL, 'BCA26-03', NULL, '2026-08-11 04:30:00'),
(89, 1, 7, 1, 'Cobby Lalmuanpuia', 'cobby.lalmuanpuia@student.hatim.edu', 'change_me', NULL, 'BCA26-04', NULL, '2026-08-11 04:30:00'),
(90, 1, 7, 1, 'Eric Vanlalduata', 'eric.vanlalduata@student.hatim.edu', 'change_me', NULL, 'BCA26-05', NULL, '2026-08-11 04:30:00'),
(91, 1, 7, 1, 'Hmingsangbera', 'hmingsangbera@student.hatim.edu', 'change_me', NULL, 'BCA26-06', NULL, '2026-08-11 04:30:00'),
(92, 1, 7, 1, 'Johny Zothanpuia', 'johny.zothanpuia@student.hatim.edu', 'change_me', NULL, 'BCA26-07', NULL, '2026-08-11 04:30:00'),
(93, 1, 7, 1, 'Malsawmtluanga Renthlei', 'malsawmtluanga.renthlei@student.hatim.edu', 'change_me', NULL, 'BCA26-08', NULL, '2026-08-11 04:30:00'),
(94, 1, 7, 1, 'T Vanlaltlankima', 't.vanlaltlankima@student.hatim.edu', 'change_me', NULL, 'BCA26-09', NULL, '2026-08-11 04:30:00'),
(95, 1, 7, 1, 'Vanlalhlimpuia', 'vanlalhlimpuia@student.hatim.edu', 'change_me', NULL, 'BCA26-10', NULL, '2026-08-11 04:30:00'),
(96, 1, 7, 2, 'Benjamin Lalremruata', 'benjamin.lalremruata@student.hatim.edu', 'change_me', NULL, 'BCA25-01', NULL, '2026-08-11 04:30:00'),
(97, 1, 7, 2, 'Benjamin Lalremruatpuia', 'benjamin.lalremruatpuia@student.hatim.edu', 'change_me', NULL, 'BCA25-02', NULL, '2026-08-11 04:30:00'),
(98, 1, 7, 2, 'Jacob Remruatpuia', 'jacob.remruatpuia@student.hatim.edu', 'change_me', NULL, 'BCA25-03', NULL, '2026-08-11 04:30:00'),
(99, 1, 7, 2, 'John Lalthlamuana', 'john.lalthlamuana@student.hatim.edu', 'change_me', NULL, 'BCA25-04', NULL, '2026-08-11 04:30:00'),
(100, 1, 7, 2, 'Kyle Lalrinzuala', 'kyle.lalrinzuala@student.hatim.edu', 'change_me', NULL, 'BCA25-05', NULL, '2026-08-11 04:30:00'),
(101, 1, 7, 2, 'PC Lalruatkima', 'pc.lalruatkima@student.hatim.edu', 'change_me', NULL, 'BCA25-06', NULL, '2026-08-11 04:30:00'),
(102, 1, 7, 2, 'PC Vanlalpeka', 'pc.vanlalpeka@student.hatim.edu', 'change_me', NULL, 'BCA25-07', NULL, '2026-08-11 04:30:00'),
(103, 1, 7, 2, 'PC Vanlalruata', 'pc.vanlalruata@student.hatim.edu', 'change_me', NULL, 'BCA25-08', NULL, '2026-08-11 04:30:00'),
(104, 1, 7, 2, 'R Laldingliana', 'r.laldingliana@student.hatim.edu', 'change_me', NULL, 'BCA25-09', NULL, '2026-08-11 04:30:00'),
(105, 1, 7, 2, 'Renedy Lalruatdika', 'renedy.lalruatdika@student.hatim.edu', 'change_me', NULL, 'BCA25-10', NULL, '2026-08-11 04:30:00'),
(106, 1, 7, 2, 'Sumon Chakma', 'sumon.chakma@student.hatim.edu', 'change_me', NULL, 'BCA25-11', NULL, '2026-08-11 04:30:00'),
(107, 1, 7, 2, 'Zohmingthanga Renthlei', 'zohmingthanga.renthlei@student.hatim.edu', 'change_me', NULL, 'BCA25-12', NULL, '2026-08-11 04:30:00'),
(108, 1, 7, 2, 'Saidingliana Sailo', 'saidingliana.sailo@student.hatim.edu', 'change_me', NULL, 'BCA25-13', NULL, '2026-08-11 04:30:00'),
(109, 1, 7, 2, 'Israel B Shyuhlo', 'israel.b.shyuhlo@student.hatim.edu', 'change_me', NULL, 'BCA25-14', NULL, '2026-08-11 04:30:00'),
(110, 1, 7, 3, 'Benjamin Lalruatsanga', 'benjamin.lalruatsanga@student.hatim.edu', 'change_me', NULL, 'BCA24-01', NULL, '2026-08-11 04:30:00'),
(111, 1, 7, 3, 'Bronson Lalpekhlua', 'bronson.lalpekhlua@student.hatim.edu', 'change_me', NULL, 'BCA24-02', NULL, '2026-08-11 04:30:00'),
(112, 1, 7, 3, 'C. Lallawmkimi', 'c.lallawmkimi@student.hatim.edu', 'change_me', NULL, 'BCA24-03', NULL, '2026-08-11 04:30:00'),
(113, 1, 7, 3, 'Eric Venhima', 'eric.venhima@student.hatim.edu', 'change_me', NULL, 'BCA24-04', NULL, '2026-08-11 04:30:00'),
(114, 1, 7, 3, 'Freddy Marandi', 'freddy.marandi@student.hatim.edu', 'change_me', NULL, 'BCA24-05', NULL, '2026-08-11 04:30:00'),
(115, 1, 7, 3, 'Isak Roluahpuia', 'isak.roluahpuia@student.hatim.edu', '$2y$10$E/hxMxkjLvq6B7f7OnriMOYx/Uv40mcu2ukOikXyO86.EtY0/BAsW', NULL, 'BCA24-06', NULL, '2026-08-11 04:30:00'),
(116, 1, 7, 3, 'Jonas MS Dawngzuala', 'jonas.ms.dawngzuala@student.hatim.edu', 'change_me', NULL, 'BCA24-07', NULL, '2026-08-11 04:30:00'),
(117, 1, 7, 3, 'Malsawmtluanga Ralte', 'malsawmtluanga.ralte@student.hatim.edu', 'change_me', NULL, 'BCA24-08', NULL, '2026-08-11 04:30:00'),
(118, 1, 7, 3, 'Solomon Vanlalfinga Lai', 'solomon.vanlalfinga.lai@student.hatim.edu', 'change_me', NULL, 'BCA24-09', NULL, '2026-08-11 04:30:00'),
(119, 1, 7, 3, 'Zabez Vanlalbela', 'zabez.vanlalbela@student.hatim.edu', 'change_me', NULL, 'BCA24-10', NULL, '2026-08-11 04:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `department_id`, `semester`, `name`) VALUES
(3, 7, 2, 'Data Structures'),
(4, 7, 2, 'Digital Logic'),
(7, 7, 4, 'Software Engineering'),
(8, 7, 4, 'Computer Networks'),
(11, 7, 6, 'Cloud Computing'),
(12, 7, 6, 'Mobile App Development'),
(15, 7, 2, 'Data Structures'),
(16, 7, 2, 'Digital Logic'),
(19, 7, 4, 'Software Engineering'),
(20, 7, 4, 'Computer Networks'),
(23, 7, 6, 'Cloud Computing'),
(24, 7, 6, 'Mobile App Development'),
(43, 8, 1, 'Mj 1 Financial Accounting'),
(44, 8, 1, 'Mj 2 Business Organisation & Management'),
(45, 8, 1, 'MDC Financial Literacy'),
(46, 8, 1, 'VAC'),
(47, 8, 3, 'Mj 1 Business Economics'),
(48, 8, 3, 'Mj 2 Financial Markets & Institutions'),
(49, 8, 3, 'MDC Financial Literacy'),
(50, 8, 3, 'VAC'),
(51, 8, 5, 'Mj 1 Business Laws'),
(52, 8, 5, 'Mj 2 Income tax'),
(53, 8, 5, 'Mj 3 Principles of Marketing'),
(54, 7, 5, 'S.E-I'),
(55, 7, 5, 'Comp. Graphics'),
(56, 7, 5, 'GUI'),
(57, 7, 5, 'E-Com & E-Gov'),
(58, 7, 5, 'Mini Project'),
(59, 7, 5, 'VB.NET'),
(60, 7, 3, 'OS'),
(61, 7, 3, 'DS using C'),
(62, 7, 3, 'DBMS'),
(63, 7, 3, 'COA'),
(64, 7, 3, 'Oracle Lab'),
(65, 7, 3, 'DS Pract.'),
(66, 7, 1, 'C Programming'),
(67, 7, 1, 'Maths'),
(68, 7, 1, 'Comp Arch'),
(69, 7, 1, 'MDE (OA)'),
(70, 7, 1, 'AEC (CS)'),
(71, 7, 1, 'VAC (UHV)');

-- --------------------------------------------------------

--
-- Table structure for table `subject_teacher`
--

CREATE TABLE `subject_teacher` (
  `id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subject_teacher`
--

INSERT INTO `subject_teacher` (`id`, `subject_id`, `teacher_id`, `created_at`) VALUES
(21, 43, 9, '2026-08-11 14:41:58'),
(22, 44, 10, '2026-08-11 14:41:58'),
(23, 45, 11, '2026-08-11 14:41:58'),
(24, 46, 12, '2026-08-11 14:41:58'),
(25, 47, 10, '2026-08-11 14:41:58'),
(26, 48, 9, '2026-08-11 14:41:58'),
(27, 49, 11, '2026-08-11 14:41:58'),
(28, 50, 13, '2026-08-11 14:41:58'),
(29, 51, 12, '2026-08-11 14:41:58'),
(30, 52, 13, '2026-08-11 14:41:58'),
(31, 53, 11, '2026-08-11 14:41:58');

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `teacher_id` int(11) NOT NULL,
  `institution_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `teacher_name` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `employee_no` varchar(40) DEFAULT NULL,
  `is_hod` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`teacher_id`, `institution_id`, `department_id`, `teacher_name`, `email`, `password`, `phone`, `employee_no`, `is_hod`, `created_at`) VALUES
(1, 1, 7, 'Sir Biaka', 'sir.biaka@hatim.local', 'change_me', NULL, 'BCA-T001', 0, '2026-08-11 09:56:02'),
(2, 1, 7, 'Sir Muanpuia', 'sir.muanpuia@hatim.local', 'change_me', NULL, 'BCA-T002', 0, '2026-08-11 09:56:02'),
(3, 1, 7, 'Sir Mama', 'sir.mama@hatim.local', 'change_me', NULL, 'BCA-T003', 1, '2026-08-11 09:56:02'),
(4, 1, 7, 'Sir Rfa', 'sir.rfa@hatim.local', 'change_me', NULL, 'BCA-T004', 0, '2026-08-11 09:56:02'),
(5, 1, 1, 'Miss Hannah', 'miss.hannah@hatim.local', 'change_me', NULL, 'BCA-T005', 0, '2026-08-11 09:56:02'),
(6, 1, 7, 'Sir Puitea', 'sir.puitea@hatim.local', 'change_me', NULL, 'BCA-T006', 0, '2026-08-11 09:56:02'),
(7, 1, 7, 'Sir Joseph', 'sir.joseph@hatim.local', 'change_me', NULL, 'BCA-T007', 0, '2026-08-11 09:56:02'),
(9, 1, 8, 'Sir Vena', 'sir.vena@hatim.local', 'change_me', NULL, 'BCOM-T001', 0, '2026-08-11 14:41:58'),
(10, 1, 8, 'Miss Kimliani', 'miss.kimliani@hatim.local', 'change_me', NULL, 'BCOM-T002', 1, '2026-08-11 14:41:58'),
(11, 1, 8, 'Miss Rsi', 'miss.rsi@hatim.local', 'change_me', NULL, 'BCOM-T003', 0, '2026-08-11 14:41:58'),
(12, 1, 8, 'Sir Peka', 'sir.peka@hatim.local', 'change_me', NULL, 'BCOM-T004', 0, '2026-08-11 14:41:58'),
(13, 1, 8, 'Miss Mawiteii', 'miss.mawiteii@hatim.local', 'change_me', NULL, 'BCOM-T005', 0, '2026-08-11 14:41:58');

-- --------------------------------------------------------

--
-- Table structure for table `timetable_entries`
--

CREATE TABLE `timetable_entries` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `day_name` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
  `period_no` tinyint(4) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `title` varchar(120) NOT NULL,
  `entry_type` enum('Class','Practical','Break','Mentoring','Activity') NOT NULL DEFAULT 'Class',
  `academic_year` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `timetable_entries`
--

INSERT INTO `timetable_entries` (`id`, `department_id`, `semester`, `day_name`, `period_no`, `start_time`, `end_time`, `subject_id`, `teacher_id`, `title`, `entry_type`, `academic_year`, `created_at`) VALUES
(1, 7, 1, 'Tuesday', 1, '10:00:00', '11:00:00', 67, 1, 'Maths', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(2, 7, 1, 'Wednesday', 2, '11:00:00', '12:00:00', 67, 1, 'Maths', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(3, 7, 1, 'Thursday', 4, '13:00:00', '13:50:00', 67, 1, 'Maths', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(4, 7, 1, 'Friday', 2, '11:00:00', '12:00:00', 67, 1, 'Maths', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(5, 7, 3, 'Monday', 4, '13:00:00', '13:50:00', NULL, 1, 'DS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(6, 7, 3, 'Tuesday', 4, '13:00:00', '13:50:00', NULL, 1, 'DS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(7, 7, 3, 'Wednesday', 4, '13:00:00', '13:50:00', NULL, 1, 'DS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(8, 7, 3, 'Thursday', 5, '13:50:00', '14:40:00', NULL, 1, 'DS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(9, 7, 3, 'Monday', 5, '13:50:00', '14:40:00', NULL, 1, 'DS (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(10, 7, 3, 'Wednesday', 5, '13:50:00', '14:40:00', NULL, 1, 'DS (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(11, 7, 3, 'Friday', 1, '10:00:00', '11:00:00', NULL, 1, 'DS (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(12, 7, 1, 'Monday', 2, '11:00:00', '12:00:00', NULL, 2, 'Comp. Arch.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(13, 7, 1, 'Tuesday', 4, '13:00:00', '13:50:00', NULL, 2, 'Comp. Arch.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(14, 7, 1, 'Wednesday', 4, '13:00:00', '13:50:00', NULL, 2, 'Comp. Arch.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(15, 7, 1, 'Thursday', 2, '11:00:00', '12:00:00', NULL, 2, 'Comp. Arch.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(16, 7, 5, 'Monday', 4, '13:00:00', '13:50:00', NULL, 2, 'CG', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(17, 7, 5, 'Tuesday', 1, '10:00:00', '11:00:00', NULL, 2, 'CG', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(18, 7, 5, 'Wednesday', 1, '10:00:00', '11:00:00', NULL, 2, 'CG', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(19, 7, 5, 'Friday', 1, '10:00:00', '11:00:00', NULL, 2, 'CG', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(20, 7, 1, 'Monday', 1, '10:00:00', '11:00:00', NULL, 3, 'C Prog.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(21, 7, 1, 'Tuesday', 2, '11:00:00', '12:00:00', NULL, 3, 'C Prog.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(22, 7, 1, 'Wednesday', 1, '10:00:00', '11:00:00', NULL, 3, 'C Prog.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(23, 7, 1, 'Wednesday', 5, '13:50:00', '14:40:00', NULL, 3, 'C (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(24, 7, 1, 'Thursday', 5, '13:50:00', '14:40:00', NULL, 3, 'C Prog.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(25, 7, 1, 'Friday', 4, '13:00:00', '13:50:00', NULL, 3, 'C Prog.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(26, 7, 1, 'Friday', 5, '13:50:00', '14:40:00', NULL, 3, 'C (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(27, 7, 5, 'Monday', 6, '14:40:00', '15:30:00', 58, 3, 'Mini Project', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(28, 7, 5, 'Tuesday', 5, '13:50:00', '14:40:00', 58, 3, 'Mini Project', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(29, 7, 5, 'Tuesday', 6, '14:40:00', '15:30:00', 58, 3, 'Mini Project', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(30, 7, 5, 'Wednesday', 6, '14:40:00', '15:30:00', 58, 3, 'Mini Project', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(31, 7, 5, 'Thursday', 2, '11:00:00', '12:00:00', 58, 3, 'Mini Project', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(32, 7, 1, 'Monday', 4, '13:00:00', '13:50:00', NULL, 4, 'Office Automation', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(33, 7, 1, 'Monday', 5, '13:50:00', '14:40:00', NULL, 4, 'Office Automation', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(34, 7, 1, 'Tuesday', 5, '13:50:00', '14:40:00', NULL, 4, 'Office Automation', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(35, 7, 1, 'Friday', 6, '14:40:00', '15:30:00', NULL, 4, 'Office Automation', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(36, 7, 3, 'Monday', 1, '10:00:00', '11:00:00', 62, 4, 'DBMS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(37, 7, 3, 'Wednesday', 1, '10:00:00', '11:00:00', 62, 4, 'DBMS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(38, 7, 3, 'Thursday', 2, '11:00:00', '12:00:00', 62, 4, 'DBMS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(39, 7, 3, 'Friday', 4, '13:00:00', '13:50:00', 62, 4, 'DBMS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(40, 7, 3, 'Tuesday', 2, '11:00:00', '12:00:00', NULL, 4, 'Oracle (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(41, 7, 3, 'Wednesday', 2, '11:00:00', '12:00:00', NULL, 4, 'Oracle (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(42, 7, 3, 'Friday', 5, '13:50:00', '14:40:00', NULL, 4, 'Oracle (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(43, 7, 1, 'Monday', 6, '14:45:00', '15:30:00', NULL, 5, 'AEC', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(44, 7, 1, 'Tuesday', 6, '14:45:00', '15:30:00', NULL, 5, 'AEC', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(45, 7, 1, 'Thursday', 1, '09:30:00', '10:15:00', NULL, 5, 'AEC', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(46, 7, 3, 'Monday', 2, '11:00:00', '12:00:00', 60, 6, 'OS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(47, 7, 3, 'Tuesday', 5, '13:50:00', '14:40:00', 60, 6, 'OS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(48, 7, 3, 'Tuesday', 6, '14:40:00', '15:30:00', 60, 6, 'OS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(49, 7, 3, 'Thursday', 1, '10:00:00', '11:00:00', 60, 6, 'OS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(50, 7, 3, 'Friday', 2, '11:00:00', '12:00:00', 60, 6, 'OS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(51, 7, 5, 'Monday', 1, '10:00:00', '11:00:00', 56, 6, 'GUI', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(52, 7, 5, 'Wednesday', 2, '11:00:00', '12:00:00', 56, 6, 'GUI', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(53, 7, 5, 'Thursday', 4, '13:00:00', '13:50:00', 56, 6, 'GUI', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(54, 7, 5, 'Friday', 5, '13:50:00', '14:40:00', 56, 6, 'GUI', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(55, 7, 5, 'Tuesday', 2, '11:00:00', '12:00:00', NULL, 6, 'VB.NET (Pract)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(56, 7, 5, 'Wednesday', 4, '13:00:00', '13:50:00', NULL, 6, 'VB.NET (Pract)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(57, 7, 5, 'Friday', 6, '14:40:00', '15:30:00', NULL, 6, 'VB.NET (Pract)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(58, 7, 3, 'Monday', 6, '14:40:00', '15:30:00', 63, 7, 'COA', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(59, 7, 3, 'Tuesday', 1, '10:00:00', '11:00:00', 63, 7, 'COA', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(60, 7, 3, 'Wednesday', 6, '14:40:00', '15:30:00', 63, 7, 'COA', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(61, 7, 3, 'Thursday', 4, '13:00:00', '13:50:00', 63, 7, 'COA', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(62, 7, 3, 'Friday', 6, '14:40:00', '15:30:00', 63, 7, 'COA', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(63, 7, 5, 'Monday', 5, '13:50:00', '14:40:00', 54, 7, 'S.E-I', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(64, 7, 5, 'Tuesday', 4, '13:00:00', '13:50:00', 54, 7, 'S.E-I', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(65, 7, 5, 'Wednesday', 5, '13:50:00', '14:40:00', 54, 7, 'S.E-I', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(66, 7, 5, 'Thursday', 1, '10:00:00', '11:00:00', 54, 7, 'S.E-I', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(67, 7, 5, 'Friday', 4, '13:00:00', '13:50:00', 54, 7, 'S.E-I', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(68, 7, 5, 'Monday', 2, '11:00:00', '12:00:00', 57, 7, 'E-Com & E-Gov', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(69, 7, 5, 'Thursday', 5, '13:50:00', '14:40:00', 57, 7, 'E-Com & E-Gov', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(70, 7, 5, 'Friday', 2, '11:00:00', '12:00:00', 57, 7, 'E-Com & E-Gov', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(71, 7, 1, 'Wednesday', 6, '14:45:00', '15:30:00', NULL, NULL, 'VAC', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(72, 7, 1, 'Friday', 1, '09:30:00', '10:15:00', NULL, NULL, 'VAC', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(128, 7, 1, 'Monday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(129, 7, 3, 'Monday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(130, 7, 5, 'Monday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(131, 7, 1, 'Tuesday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(132, 7, 3, 'Tuesday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(133, 7, 5, 'Tuesday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(134, 7, 1, 'Wednesday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(135, 7, 3, 'Wednesday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(136, 7, 5, 'Wednesday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(137, 7, 1, 'Thursday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(138, 7, 3, 'Thursday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(139, 7, 5, 'Thursday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(140, 7, 1, 'Friday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(141, 7, 3, 'Friday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(142, 7, 5, 'Friday', 3, '12:00:00', '13:00:00', NULL, NULL, 'Lunch Break', 'Break', '2026-2027', '2026-08-11 09:56:02'),
(143, 7, 1, 'Thursday', 6, '14:40:00', '15:30:00', NULL, NULL, 'Mentoring Session', 'Mentoring', '2026-2027', '2026-08-11 09:56:02'),
(144, 7, 3, 'Thursday', 6, '14:40:00', '15:30:00', NULL, NULL, 'Mentoring Session', 'Mentoring', '2026-2027', '2026-08-11 09:56:02'),
(145, 7, 5, 'Thursday', 6, '14:40:00', '15:30:00', NULL, NULL, 'Mentoring Session', 'Mentoring', '2026-2027', '2026-08-11 09:56:02'),
(146, 7, 1, 'Monday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(147, 7, 3, 'Monday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(148, 7, 5, 'Monday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(149, 7, 1, 'Tuesday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(150, 7, 3, 'Tuesday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(151, 7, 5, 'Tuesday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(152, 7, 1, 'Wednesday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(153, 7, 3, 'Wednesday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(154, 7, 5, 'Wednesday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(155, 7, 1, 'Thursday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(156, 7, 3, 'Thursday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(157, 7, 5, 'Thursday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(158, 7, 1, 'Friday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(159, 7, 3, 'Friday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(160, 7, 5, 'Friday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02'),
(161, 8, 1, 'Monday', 3, '11:00:00', '11:45:00', 43, 9, 'Mj 1 Financial Accounting', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(162, 8, 1, 'Tuesday', 3, '11:00:00', '11:45:00', 43, 9, 'Mj 1 Financial Accounting', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(163, 8, 1, 'Wednesday', 2, '10:15:00', '11:00:00', 43, 9, 'Mj 1 Financial Accounting', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(164, 8, 1, 'Thursday', 3, '11:00:00', '11:45:00', 43, 9, 'Mj 1 Financial Accounting', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(165, 8, 1, 'Friday', 3, '11:00:00', '11:45:00', 43, 9, 'Mj 1 Financial Accounting', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(166, 8, 1, 'Monday', 2, '10:15:00', '11:00:00', 44, 10, 'Mj 2 Business Organisation & Management', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(167, 8, 1, 'Tuesday', 4, '11:45:00', '12:30:00', 44, 10, 'Mj 2 Business Organisation & Management', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(168, 8, 1, 'Wednesday', 4, '11:45:00', '12:30:00', 44, 10, 'Mj 2 Business Organisation & Management', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(169, 8, 1, 'Thursday', 6, '13:15:00', '14:00:00', 44, 10, 'Mj 2 Business Organisation & Management', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(170, 8, 1, 'Friday', 7, '14:00:00', '14:45:00', 44, 10, 'Mj 2 Business Organisation & Management', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(171, 8, 1, 'Monday', 1, '09:30:00', '10:15:00', 45, 11, 'MDC Financial Literacy', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(172, 8, 1, 'Tuesday', 1, '09:30:00', '10:15:00', 45, 11, 'MDC Financial Literacy', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(173, 8, 1, 'Thursday', 8, '14:45:00', '15:30:00', 45, 11, 'MDC Financial Literacy', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(174, 8, 1, 'Wednesday', 7, '14:00:00', '14:45:00', 46, 12, 'VAC', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(175, 8, 1, 'Friday', 1, '09:30:00', '10:15:00', 46, 12, 'VAC', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(176, 8, 3, 'Monday', 3, '11:00:00', '11:45:00', 47, 10, 'Mj 1 Business Economics', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(177, 8, 3, 'Tuesday', 3, '11:00:00', '11:45:00', 47, 10, 'Mj 1 Business Economics', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(178, 8, 3, 'Wednesday', 2, '10:15:00', '11:00:00', 47, 10, 'Mj 1 Business Economics', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(179, 8, 3, 'Thursday', 3, '11:00:00', '11:45:00', 47, 10, 'Mj 1 Business Economics', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(180, 8, 3, 'Friday', 3, '11:00:00', '11:45:00', 47, 10, 'Mj 1 Business Economics', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(181, 8, 3, 'Monday', 7, '14:00:00', '14:45:00', 48, 9, 'Mj 2 Financial Markets & Institutions', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(182, 8, 3, 'Tuesday', 2, '10:15:00', '11:00:00', 48, 9, 'Mj 2 Financial Markets & Institutions', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(183, 8, 3, 'Wednesday', 3, '11:00:00', '11:45:00', 48, 9, 'Mj 2 Financial Markets & Institutions', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(184, 8, 3, 'Thursday', 5, '12:30:00', '13:15:00', 48, 9, 'Mj 2 Financial Markets & Institutions', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(185, 8, 3, 'Friday', 6, '13:15:00', '14:00:00', 48, 9, 'Mj 2 Financial Markets & Institutions', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(186, 8, 3, 'Monday', 1, '09:30:00', '10:15:00', 49, 11, 'MDC Financial Literacy', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(187, 8, 3, 'Tuesday', 1, '09:30:00', '10:15:00', 49, 11, 'MDC Financial Literacy', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(188, 8, 3, 'Thursday', 8, '14:45:00', '15:30:00', 49, 11, 'MDC Financial Literacy', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(189, 8, 3, 'Thursday', 1, '09:30:00', '10:15:00', 50, 13, 'VAC', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(190, 8, 3, 'Friday', 1, '09:30:00', '10:15:00', 50, 13, 'VAC', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(191, 8, 5, 'Monday', 3, '11:00:00', '11:45:00', 51, 12, 'Mj 1 Business Laws', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(192, 8, 5, 'Tuesday', 3, '11:00:00', '11:45:00', 51, 12, 'Mj 1 Business Laws', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(193, 8, 5, 'Wednesday', 2, '10:15:00', '11:00:00', 51, 12, 'Mj 1 Business Laws', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(194, 8, 5, 'Thursday', 3, '11:00:00', '11:45:00', 51, 12, 'Mj 1 Business Laws', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(195, 8, 5, 'Friday', 3, '11:00:00', '11:45:00', 51, 12, 'Mj 1 Business Laws', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(196, 8, 5, 'Monday', 5, '12:30:00', '13:15:00', 52, 13, 'Mj 2 Income tax', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(197, 8, 5, 'Tuesday', 5, '12:30:00', '13:15:00', 52, 13, 'Mj 2 Income tax', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(198, 8, 5, 'Wednesday', 4, '11:45:00', '12:30:00', 52, 13, 'Mj 2 Income tax', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(199, 8, 5, 'Thursday', 5, '12:30:00', '13:15:00', 52, 13, 'Mj 2 Income tax', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(200, 8, 5, 'Friday', 5, '12:30:00', '13:15:00', 52, 13, 'Mj 2 Income tax', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(201, 8, 5, 'Monday', 4, '11:45:00', '12:30:00', 53, 11, 'Mj 3 Principles of Marketing', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(202, 8, 5, 'Tuesday', 7, '14:00:00', '14:45:00', 53, 11, 'Mj 3 Principles of Marketing', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(203, 8, 5, 'Wednesday', 5, '12:30:00', '13:15:00', 53, 11, 'Mj 3 Principles of Marketing', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(204, 8, 5, 'Thursday', 4, '11:45:00', '12:30:00', 53, 11, 'Mj 3 Principles of Marketing', 'Class', '2026-2027', '2026-08-11 15:13:59'),
(205, 8, 5, 'Friday', 2, '10:15:00', '11:00:00', 53, 11, 'Mj 3 Principles of Marketing', 'Class', '2026-2027', '2026-08-11 15:13:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `identifier` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Teacher','Student','Admin') NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `institution_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `identifier`, `password`, `role`, `full_name`, `institution_id`, `department_id`, `semester`, `subject_id`, `created_at`) VALUES
(1, 'teacher@school.edu', '.qjoloYeP67TzwXOGyj63aAx4zqr5AkevnQ.Iol4I0wZGWe', 'Teacher', 'Dr. Anita Rao', 1, 7, NULL, NULL, '2026-08-11 08:33:08'),
(4, 'admin@hatim.local', '$2y$10$kgnCgXxMm0EmlZ6.U.po9uOmb2ixNcBZ8jZUvTbLs3Jgs66sWasYO', 'Admin', 'System Administrator', 1, NULL, NULL, NULL, '2026-08-11 13:07:48'),
(7, 'alicia.d.lalrohlui@hatim.local', 'change_me', 'Student', 'Alicia D Lalrohlui', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(8, 'c.lalbiaktluangi@hatim.local', 'change_me', 'Student', 'C Lalbiaktluangi', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(9, 'c.lalhriatchhungi@hatim.local', 'change_me', 'Student', 'C.Lalhriatchhungi', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(10, 'david.r.vanlalruata@hatim.local', 'change_me', 'Student', 'David R Vanlalruata', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(11, 'deborah.vanlalzawmpuii@hatim.local', 'change_me', 'Student', 'Deborah Vanlalzawmpuii', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(12, 'dominic.malsawmkima@hatim.local', 'change_me', 'Student', 'Dominic Malsawmkima', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(13, 'esther.lalchungnungi@hatim.local', 'change_me', 'Student', 'Esther Lalchungnungi', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(14, 'f.lalhmangaihzuali@hatim.local', 'change_me', 'Student', 'F Lalhmangaihzuali', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(15, 'h.lalruattluanga@hatim.local', 'change_me', 'Student', 'H.Lalruattluanga', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(16, 'henny.laldinkimi@hatim.local', 'change_me', 'Student', 'Henny Laldinkimi', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(17, 'jacob.lalmalsawma@hatim.local', 'change_me', 'Student', 'Jacob Lalmalsawma', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(18, 'john.carzon@hatim.local', 'change_me', 'Student', 'John Carzon', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(19, 'joseph.pc.lalmalsawma@hatim.local', 'change_me', 'Student', 'Joseph PC Lalmalsawma', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(20, 'k.zothansanga@hatim.local', 'change_me', 'Student', 'K Zothansanga', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(21, 'lalengmawii@hatim.local', 'change_me', 'Student', 'Lalengmawii', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(22, 'lalhmingsangpuia@hatim.local', 'change_me', 'Student', 'Lalhmingsangpuia', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(23, 'lallawmkima@hatim.local', 'change_me', 'Student', 'Lallawmkima', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(24, 'lallawmkimi.pachuau@hatim.local', 'change_me', 'Student', 'Lallawmkimi Pachuau', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(25, 'lalnundika@hatim.local', 'change_me', 'Student', 'Lalnundika', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(26, 'lalnuntluanga.chawngthu@hatim.local', 'change_me', 'Student', 'Lalnuntluanga Chawngthu', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(27, 'lalrinzuali@hatim.local', 'change_me', 'Student', 'Lalrinzuali', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(28, 'lalruatfeli@hatim.local', 'change_me', 'Student', 'Lalruatfeli', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(29, 'lalthantluangi@hatim.local', 'change_me', 'Student', 'Lalthantluangi', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(30, 'lh.lalnunsanga@hatim.local', 'change_me', 'Student', 'LH Lalnunsanga', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(31, 'lh.nicky.malsawmkima@hatim.local', 'change_me', 'Student', 'LH Nicky Malsawmkima', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(32, 'lucy.lalrinthangi.ralte@hatim.local', 'change_me', 'Student', 'Lucy Lalrinthangi Ralte', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(33, 'margareth.ramdintluangi.chinzah@hatim.local', 'change_me', 'Student', 'Margareth Ramdintluangi Chinzah', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(34, 'nixon.lalpekhlua@hatim.local', 'change_me', 'Student', 'Nixon Lalpekhlua', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(35, 'paul.lalrinawma@hatim.local', 'change_me', 'Student', 'Paul Lalrinawma', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(36, 'pc.lallawmzuali@hatim.local', 'change_me', 'Student', 'PC Lallawmzuali', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(37, 'pc.malsawmtluangi@hatim.local', 'change_me', 'Student', 'PC Malsawmtluangi', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(38, 'r.lalhruaizeli@hatim.local', 'change_me', 'Student', 'R Lalhruaizeli', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(39, 'r.lalruatkimi@hatim.local', 'change_me', 'Student', 'R Lalruatkimi', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(40, 'rebecca.lalhunnghaki@hatim.local', 'change_me', 'Student', 'Rebecca Lalhunnghaki', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(41, 'remruatfeli.fanai@hatim.local', 'change_me', 'Student', 'Remruatfeli Fanai', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(42, 'rohluzuali@hatim.local', 'change_me', 'Student', 'Rohluzuali', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(43, 'sarah.lalchhanchhuahi@hatim.local', 'change_me', 'Student', 'Sarah Lalchhanchhuahi', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(44, 'sylvia.rosangzuali@hatim.local', 'change_me', 'Student', 'Sylvia Rosangzuali', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(45, 't.lalmuanawmi@hatim.local', 'change_me', 'Student', 'T Lalmuanawmi', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(46, 'vanlaldika.pachuau@hatim.local', 'change_me', 'Student', 'Vanlaldika Pachuau', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(47, 'zorinsangi.jongte@hatim.local', 'change_me', 'Student', 'Zorinsangi Jongte', 1, 8, 4, NULL, '2026-08-11 14:32:31'),
(48, 'sir.vena@hatim.local', 'change_me', 'Teacher', 'Sir Vena', 1, 8, NULL, NULL, '2026-08-11 14:41:58'),
(49, 'miss.kimliani@hatim.local', 'change_me', 'Teacher', 'Miss Kimliani', 1, 8, NULL, NULL, '2026-08-11 14:41:58'),
(50, 'miss.rsi@hatim.local', 'change_me', 'Teacher', 'Miss Rsi', 1, 8, NULL, NULL, '2026-08-11 14:41:58'),
(51, 'sir.peka@hatim.local', 'change_me', 'Teacher', 'Sir Peka', 1, 8, NULL, NULL, '2026-08-11 14:41:58'),
(52, 'miss.mawiteii@hatim.local', 'change_me', 'Teacher', 'Miss Mawiteii', 1, 8, NULL, NULL, '2026-08-11 14:41:58'),
(53, 'ab.lalawmpuia@hatim.local', 'change_me', 'Student', 'Ab Lalawmpuia', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(54, 'alex.lalrohlupuia@hatim.local', 'change_me', 'Student', 'Alex Lalrohlupuia', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(55, 'c.lalnunpuii@hatim.local', 'change_me', 'Student', 'C. Lalnunpuii', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(56, 'c.vanlalpeka@hatim.local', 'change_me', 'Student', 'C. Vanlalpeka', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(57, 'cathy.runremsangi@hatim.local', 'change_me', 'Student', 'Cathy Runremsangi', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(58, 'frankie.lalrindika@hatim.local', 'change_me', 'Student', 'Frankie Lalrindika', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(59, 'gason.malsawmzuala@hatim.local', 'change_me', 'Student', 'Gason Malsawmzuala', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(60, 'hannah.hp.lalrindiki@hatim.local', 'change_me', 'Student', 'Hannah Hp. Lalrindiki', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(61, 'heidi.vanlalruati@hatim.local', 'change_me', 'Student', 'Heidi Vanlalruati', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(62, 'k.ramdinmawia@hatim.local', 'change_me', 'Student', 'K. Ramdinmawia', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(63, 'lalawmpuia.chongthu@hatim.local', 'change_me', 'Student', 'Lalawmpuia Chongthu', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(64, 'lalrinpuii.kawlni@hatim.local', 'change_me', 'Student', 'Lalrinpuii Kawlni', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(65, 'melody.zothansangi@hatim.local', 'change_me', 'Student', 'Melody Zothansangi', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(66, 'nugrdingliana.sailo@hatim.local', 'change_me', 'Student', 'Nugrdingliana Sailo', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(67, 'omega.laltlanthanga@hatim.local', 'change_me', 'Student', 'Omega Laltlanthanga', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(68, 'rc.lalduhawmi@hatim.local', 'change_me', 'Student', 'Rc. Lalduhawmi', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(69, 'rf.vanlalsiama@hatim.local', 'change_me', 'Student', 'Rf Vanlalsiama', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(70, 'rochanmawia.pachuau@hatim.local', 'change_me', 'Student', 'Rochanmawia Pachuau', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(71, 'rosangpuia.pautu@hatim.local', 'change_me', 'Student', 'Rosangpuia Pautu', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(72, 's.thyuheizi@hatim.local', 'change_me', 'Student', 'S. Thyuheizi', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(73, 'sarah.malsawmdawngzuali@hatim.local', 'change_me', 'Student', 'Sarah Malsawmdawngzuali', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(74, 'sophia.lalruatkimi@hatim.local', 'change_me', 'Student', 'Sophia Lalruatkimi', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(75, 'stephen.k.lalrindika@hatim.local', 'change_me', 'Student', 'Stephen K. Lalrindika', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(76, 't.vanlalzuia@hatim.local', 'change_me', 'Student', 'T. Vanlalzuia', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(77, 'vanlalhruaitluanga@hatim.local', 'change_me', 'Student', 'Vanlalhruaitluanga', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(78, 'vanlalmalsawmdawngzuala@hatim.local', 'change_me', 'Student', 'Vanlalmalsawmdawngzuala', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(79, 'vanlalrengpuii.chinzah@hatim.local', 'change_me', 'Student', 'Vanlalrengpuii Chinzah', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(80, 'vanlalruati@hatim.local', 'change_me', 'Student', 'Vanlalruati', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(81, 'catherine.lalramdinthari@hatim.local', 'change_me', 'Student', 'Catherine Lalramdinthari', 1, 8, 5, NULL, '2026-08-11 14:50:45'),
(82, 'a.lalhlimpuia@hatim.local', 'change_me', 'Student', 'A Lalhlimpuia', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(83, 'c.lalhmangaihsanga@hatim.local', 'change_me', 'Student', 'C Lalhmangaihsanga', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(84, 'cassie.rohluzuali@hatim.local', 'change_me', 'Student', 'Cassie Rohluzuali', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(85, 'christina.h.malsawmsangi@hatim.local', 'change_me', 'Student', 'Christina H Malsawmsangi', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(86, 'christina.lalrinfeli@hatim.local', 'change_me', 'Student', 'Christina Lalrinfeli', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(87, 'lalduhzuali@hatim.local', 'change_me', 'Student', 'Lalduhzuali', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(88, 'lalhruaitluanga@hatim.local', 'change_me', 'Student', 'Lalhruaitluanga', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(89, 'lalhruaitluanga.08@hatim.local', 'change_me', 'Student', 'Lalhruaitluanga', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(90, 'lalhruaizela.khiangte@hatim.local', 'change_me', 'Student', 'Lalhruaizela Khiangte', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(91, 'lallawmsangpuia.ralte@hatim.local', 'change_me', 'Student', 'Lallawmsangpuia Ralte', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(92, 'malsawmtluanga@hatim.local', 'change_me', 'Student', 'Malsawmtluanga', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(93, 'malsawmtluangi@hatim.local', 'change_me', 'Student', 'Malsawmtluangi', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(94, 'n.lalpekhlua@hatim.local', 'change_me', 'Student', 'N Lalpekhlua', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(95, 'r.lalzemawii@hatim.local', 'change_me', 'Student', 'R Lalzemawii', 1, 8, 6, NULL, '2026-08-11 14:50:45'),
(96, 'ruthi.c.lalpekhlui@hatim.local', 'change_me', 'Student', 'Ruthi C Lalpekhlui', 1, 8, 6, NULL, '2026-08-11 14:50:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_administrator_institution` (`institution_id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendance_id`),
  ADD UNIQUE KEY `uq_attendance_once_per_subject_date` (`student_id`,`subject_id`,`attendance_date`),
  ADD KEY `fk_attendance_subject` (`subject_id`),
  ADD KEY `fk_attendance_teacher` (`teacher_id`),
  ADD KEY `idx_attendance_date` (`attendance_date`),
  ADD KEY `idx_attendance_student_subject` (`student_id`,`subject_id`);

--
-- Indexes for table `attendance_alert`
--
ALTER TABLE `attendance_alert`
  ADD PRIMARY KEY (`alert_id`),
  ADD KEY `fk_alert_student` (`student_id`),
  ADD KEY `fk_alert_subject` (`subject_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `institution_id` (`institution_id`);

--
-- Indexes for table `institutions`
--
ALTER TABLE `institutions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `parent`
--
ALTER TABLE `parent`
  ADD PRIMARY KEY (`parent_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `parent_student`
--
ALTER TABLE `parent_student`
  ADD PRIMARY KEY (`parent_id`,`student_id`),
  ADD KEY `fk_parent_student_student` (`student_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `fk_report_student` (`student_id`),
  ADD KEY `fk_report_semester` (`semester_id`),
  ADD KEY `fk_report_teacher` (`generated_by_teacher_id`);

--
-- Indexes for table `semester`
--
ALTER TABLE `semester`
  ADD PRIMARY KEY (`semester_id`),
  ADD UNIQUE KEY `uq_semester_per_department` (`department_id`,`semester_number`,`academic_year`,`section_name`),
  ADD KEY `fk_semester_teacher` (`teacher_id`),
  ADD KEY `idx_semester_department` (`department_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `uq_student_roll_per_semester` (`semester_id`,`roll_no`),
  ADD UNIQUE KEY `uq_student_admission_per_institution` (`institution_id`,`admission_no`),
  ADD KEY `fk_student_department` (`department_id`),
  ADD KEY `idx_student_semester` (`semester_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `subject_teacher`
--
ALTER TABLE `subject_teacher`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_subject_teacher` (`subject_id`,`teacher_id`),
  ADD KEY `idx_subject_teacher_teacher` (`teacher_id`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`teacher_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `uq_teacher_employee_per_institution` (`institution_id`,`employee_no`),
  ADD KEY `fk_teacher_department` (`department_id`);

--
-- Indexes for table `timetable_entries`
--
ALTER TABLE `timetable_entries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_timetable_slot` (`department_id`,`semester`,`day_name`,`period_no`,`academic_year`),
  ADD KEY `idx_timetable_subject` (`subject_id`),
  ADD KEY `idx_timetable_teacher` (`teacher_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identifier` (`identifier`),
  ADD KEY `institution_id` (`institution_id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administrator`
--
ALTER TABLE `administrator`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `attendance_alert`
--
ALTER TABLE `attendance_alert`
  MODIFY `alert_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `institutions`
--
ALTER TABLE `institutions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `parent`
--
ALTER TABLE `parent`
  MODIFY `parent_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `semester`
--
ALTER TABLE `semester`
  MODIFY `semester_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `subject_teacher`
--
ALTER TABLE `subject_teacher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `timetable_entries`
--
ALTER TABLE `timetable_entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `administrator`
--
ALTER TABLE `administrator`
  ADD CONSTRAINT `fk_administrator_institution` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `fk_attendance_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_attendance_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_attendance_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`) ON UPDATE CASCADE;

--
-- Constraints for table `attendance_alert`
--
ALTER TABLE `attendance_alert`
  ADD CONSTRAINT `fk_alert_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_alert_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `fk_departments_institution` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `parent_student`
--
ALTER TABLE `parent_student`
  ADD CONSTRAINT `fk_parent_student_parent` FOREIGN KEY (`parent_id`) REFERENCES `parent` (`parent_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_parent_student_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `fk_report_semester` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`semester_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_report_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_report_teacher` FOREIGN KEY (`generated_by_teacher_id`) REFERENCES `teacher` (`teacher_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `semester`
--
ALTER TABLE `semester`
  ADD CONSTRAINT `fk_semester_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_semester_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `fk_student_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_student_institution` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_student_semester` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`semester_id`) ON UPDATE CASCADE;

--
-- Constraints for table `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `fk_subjects_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subject_teacher`
--
ALTER TABLE `subject_teacher`
  ADD CONSTRAINT `fk_subject_teacher_subjects` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_subject_teacher_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teacher`
--
ALTER TABLE `teacher`
  ADD CONSTRAINT `fk_teacher_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_teacher_institution` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `timetable_entries`
--
ALTER TABLE `timetable_entries`
  ADD CONSTRAINT `fk_timetable_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_timetable_subjects` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_timetable_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_users_institution` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_users_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
