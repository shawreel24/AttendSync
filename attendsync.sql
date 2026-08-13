-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 11, 2026 at 02:04 PM
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
(3, 7, NULL, 5, 'BCA V Semester', '2026-2027', '', '2026-08-11 09:56:02');

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
(1, 7, 1, 'Programming in C'),
(2, 7, 1, 'Computer Fundamentals'),
(3, 7, 2, 'Data Structures'),
(4, 7, 2, 'Digital Logic'),
(5, 7, 3, 'Object Oriented Programming'),
(6, 7, 3, 'Database Management Systems'),
(7, 7, 4, 'Software Engineering'),
(8, 7, 4, 'Computer Networks'),
(9, 7, 5, 'Web Technologies'),
(10, 7, 5, 'Operating Systems'),
(11, 7, 6, 'Cloud Computing'),
(12, 7, 6, 'Mobile App Development'),
(13, 7, 1, 'Programming in C'),
(14, 7, 1, 'Computer Fundamentals'),
(15, 7, 2, 'Data Structures'),
(16, 7, 2, 'Digital Logic'),
(17, 7, 3, 'Object Oriented Programming'),
(18, 7, 3, 'Database Management Systems'),
(19, 7, 4, 'Software Engineering'),
(20, 7, 4, 'Computer Networks'),
(21, 7, 5, 'Web Technologies'),
(22, 7, 5, 'Operating Systems'),
(23, 7, 6, 'Cloud Computing'),
(24, 7, 6, 'Mobile App Development'),
(25, 7, 1, 'Maths'),
(26, 7, 1, 'Comp Arch'),
(27, 7, 1, 'C Prog.'),
(28, 7, 1, 'MDE (OA)'),
(29, 7, 1, 'AEC (CS)'),
(30, 7, 1, 'VAC (UHV)'),
(31, 7, 3, 'OS'),
(32, 7, 3, 'DS using C'),
(33, 7, 3, 'DBMS'),
(34, 7, 3, 'COA'),
(35, 7, 3, 'Oracle Lab'),
(36, 7, 3, 'DS Pract.'),
(37, 7, 5, 'S.E-I'),
(38, 7, 5, 'Comp. Graphics'),
(39, 7, 5, 'GUI'),
(40, 7, 5, 'E-Com & E-Gov'),
(41, 7, 5, 'Mini Project'),
(42, 7, 5, 'VB.NET');

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
(1, 25, 1, '2026-08-11 09:56:02'),
(2, 32, 1, '2026-08-11 09:56:02'),
(3, 36, 1, '2026-08-11 09:56:02'),
(4, 26, 2, '2026-08-11 09:56:02'),
(5, 38, 2, '2026-08-11 09:56:02'),
(7, 27, 3, '2026-08-11 09:56:02'),
(8, 41, 3, '2026-08-11 09:56:02'),
(10, 28, 4, '2026-08-11 09:56:02'),
(11, 33, 4, '2026-08-11 09:56:02'),
(12, 35, 4, '2026-08-11 09:56:02'),
(13, 29, 5, '2026-08-11 09:56:02'),
(14, 31, 6, '2026-08-11 09:56:02'),
(15, 39, 6, '2026-08-11 09:56:02'),
(16, 42, 6, '2026-08-11 09:56:02'),
(17, 34, 7, '2026-08-11 09:56:02'),
(18, 37, 7, '2026-08-11 09:56:02'),
(19, 40, 7, '2026-08-11 09:56:02'),
(20, 30, 8, '2026-08-11 09:56:02');

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
(3, 1, 7, 'Sir Mama', 'sir.mama@hatim.local', 'change_me', NULL, 'BCA-T003', 0, '2026-08-11 09:56:02'),
(4, 1, 7, 'Sir Rfa', 'sir.rfa@hatim.local', 'change_me', NULL, 'BCA-T004', 0, '2026-08-11 09:56:02'),
(5, 1, 7, 'Miss Hannah', 'miss.hannah@hatim.local', 'change_me', NULL, 'BCA-T005', 0, '2026-08-11 09:56:02'),
(6, 1, 7, 'Sir Puitea', 'sir.puitea@hatim.local', 'change_me', NULL, 'BCA-T006', 0, '2026-08-11 09:56:02'),
(7, 1, 7, 'Sir Joseph', 'sir.joseph@hatim.local', 'change_me', NULL, 'BCA-T007', 0, '2026-08-11 09:56:02'),
(8, 1, 7, 'Hist.Dept', 'history.department@hatim.local', 'change_me', NULL, 'BCA-T008', 0, '2026-08-11 09:56:02');

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
(1, 7, 1, 'Tuesday', 1, '10:00:00', '11:00:00', 25, 1, 'Maths', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(2, 7, 1, 'Wednesday', 2, '11:00:00', '12:00:00', 25, 1, 'Maths', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(3, 7, 1, 'Thursday', 4, '13:00:00', '13:50:00', 25, 1, 'Maths', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(4, 7, 1, 'Friday', 2, '11:00:00', '12:00:00', 25, 1, 'Maths', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(5, 7, 3, 'Monday', 4, '13:00:00', '13:50:00', 32, 1, 'DS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(6, 7, 3, 'Tuesday', 4, '13:00:00', '13:50:00', 32, 1, 'DS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(7, 7, 3, 'Wednesday', 4, '13:00:00', '13:50:00', 32, 1, 'DS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(8, 7, 3, 'Thursday', 5, '13:50:00', '14:40:00', 32, 1, 'DS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(9, 7, 3, 'Monday', 5, '13:50:00', '14:40:00', 36, 1, 'DS (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(10, 7, 3, 'Wednesday', 5, '13:50:00', '14:40:00', 36, 1, 'DS (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(11, 7, 3, 'Friday', 1, '10:00:00', '11:00:00', 36, 1, 'DS (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(12, 7, 1, 'Monday', 2, '11:00:00', '12:00:00', 26, 2, 'Comp. Arch.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(13, 7, 1, 'Tuesday', 4, '13:00:00', '13:50:00', 26, 2, 'Comp. Arch.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(14, 7, 1, 'Wednesday', 4, '13:00:00', '13:50:00', 26, 2, 'Comp. Arch.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(15, 7, 1, 'Thursday', 2, '11:00:00', '12:00:00', 26, 2, 'Comp. Arch.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(16, 7, 5, 'Monday', 4, '13:00:00', '13:50:00', 38, 2, 'CG', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(17, 7, 5, 'Tuesday', 1, '10:00:00', '11:00:00', 38, 2, 'CG', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(18, 7, 5, 'Wednesday', 1, '10:00:00', '11:00:00', 38, 2, 'CG', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(19, 7, 5, 'Friday', 1, '10:00:00', '11:00:00', 38, 2, 'CG', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(20, 7, 1, 'Monday', 1, '10:00:00', '11:00:00', 27, 3, 'C Prog.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(21, 7, 1, 'Tuesday', 2, '11:00:00', '12:00:00', 27, 3, 'C Prog.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(22, 7, 1, 'Wednesday', 1, '10:00:00', '11:00:00', 27, 3, 'C Prog.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(23, 7, 1, 'Wednesday', 5, '13:50:00', '14:40:00', 27, 3, 'C (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(24, 7, 1, 'Thursday', 5, '13:50:00', '14:40:00', 27, 3, 'C Prog.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(25, 7, 1, 'Friday', 4, '13:00:00', '13:50:00', 27, 3, 'C Prog.', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(26, 7, 1, 'Friday', 5, '13:50:00', '14:40:00', 27, 3, 'C (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(27, 7, 5, 'Monday', 6, '14:40:00', '15:30:00', 41, 3, 'Mini Project', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(28, 7, 5, 'Tuesday', 5, '13:50:00', '14:40:00', 41, 3, 'Mini Project', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(29, 7, 5, 'Tuesday', 6, '14:40:00', '15:30:00', 41, 3, 'Mini Project', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(30, 7, 5, 'Wednesday', 6, '14:40:00', '15:30:00', 41, 3, 'Mini Project', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(31, 7, 5, 'Thursday', 2, '11:00:00', '12:00:00', 41, 3, 'Mini Project', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(32, 7, 1, 'Monday', 4, '13:00:00', '13:50:00', 28, 4, 'Office Automation', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(33, 7, 1, 'Monday', 5, '13:50:00', '14:40:00', 28, 4, 'Office Automation', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(34, 7, 1, 'Tuesday', 5, '13:50:00', '14:40:00', 28, 4, 'Office Automation', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(35, 7, 1, 'Friday', 6, '14:40:00', '15:30:00', 28, 4, 'Office Automation', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(36, 7, 3, 'Monday', 1, '10:00:00', '11:00:00', 33, 4, 'DBMS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(37, 7, 3, 'Wednesday', 1, '10:00:00', '11:00:00', 33, 4, 'DBMS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(38, 7, 3, 'Thursday', 2, '11:00:00', '12:00:00', 33, 4, 'DBMS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(39, 7, 3, 'Friday', 4, '13:00:00', '13:50:00', 33, 4, 'DBMS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(40, 7, 3, 'Tuesday', 2, '11:00:00', '12:00:00', 35, 4, 'Oracle (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(41, 7, 3, 'Wednesday', 2, '11:00:00', '12:00:00', 35, 4, 'Oracle (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(42, 7, 3, 'Friday', 5, '13:50:00', '14:40:00', 35, 4, 'Oracle (Practical)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(43, 7, 1, 'Monday', 6, '14:45:00', '15:30:00', 29, 5, 'AEC', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(44, 7, 1, 'Tuesday', 6, '14:45:00', '15:30:00', 29, 5, 'AEC', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(45, 7, 1, 'Thursday', 1, '09:30:00', '10:15:00', 29, 5, 'AEC', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(46, 7, 3, 'Monday', 2, '11:00:00', '12:00:00', 31, 6, 'OS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(47, 7, 3, 'Tuesday', 5, '13:50:00', '14:40:00', 31, 6, 'OS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(48, 7, 3, 'Tuesday', 6, '14:40:00', '15:30:00', 31, 6, 'OS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(49, 7, 3, 'Thursday', 1, '10:00:00', '11:00:00', 31, 6, 'OS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(50, 7, 3, 'Friday', 2, '11:00:00', '12:00:00', 31, 6, 'OS', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(51, 7, 5, 'Monday', 1, '10:00:00', '11:00:00', 39, 6, 'GUI', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(52, 7, 5, 'Wednesday', 2, '11:00:00', '12:00:00', 39, 6, 'GUI', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(53, 7, 5, 'Thursday', 4, '13:00:00', '13:50:00', 39, 6, 'GUI', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(54, 7, 5, 'Friday', 5, '13:50:00', '14:40:00', 39, 6, 'GUI', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(55, 7, 5, 'Tuesday', 2, '11:00:00', '12:00:00', 42, 6, 'VB.NET (Pract)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(56, 7, 5, 'Wednesday', 4, '13:00:00', '13:50:00', 42, 6, 'VB.NET (Pract)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(57, 7, 5, 'Friday', 6, '14:40:00', '15:30:00', 42, 6, 'VB.NET (Pract)', 'Practical', '2026-2027', '2026-08-11 09:56:02'),
(58, 7, 3, 'Monday', 6, '14:40:00', '15:30:00', 34, 7, 'COA', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(59, 7, 3, 'Tuesday', 1, '10:00:00', '11:00:00', 34, 7, 'COA', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(60, 7, 3, 'Wednesday', 6, '14:40:00', '15:30:00', 34, 7, 'COA', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(61, 7, 3, 'Thursday', 4, '13:00:00', '13:50:00', 34, 7, 'COA', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(62, 7, 3, 'Friday', 6, '14:40:00', '15:30:00', 34, 7, 'COA', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(63, 7, 5, 'Monday', 5, '13:50:00', '14:40:00', 37, 7, 'S.E-I', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(64, 7, 5, 'Tuesday', 4, '13:00:00', '13:50:00', 37, 7, 'S.E-I', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(65, 7, 5, 'Wednesday', 5, '13:50:00', '14:40:00', 37, 7, 'S.E-I', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(66, 7, 5, 'Thursday', 1, '10:00:00', '11:00:00', 37, 7, 'S.E-I', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(67, 7, 5, 'Friday', 4, '13:00:00', '13:50:00', 37, 7, 'S.E-I', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(68, 7, 5, 'Monday', 2, '11:00:00', '12:00:00', 40, 7, 'E-Com & E-Gov', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(69, 7, 5, 'Thursday', 5, '13:50:00', '14:40:00', 40, 7, 'E-Com & E-Gov', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(70, 7, 5, 'Friday', 2, '11:00:00', '12:00:00', 40, 7, 'E-Com & E-Gov', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(71, 7, 1, 'Wednesday', 6, '14:45:00', '15:30:00', 30, 8, 'VAC', 'Class', '2026-2027', '2026-08-11 09:56:02'),
(72, 7, 1, 'Friday', 1, '09:30:00', '10:15:00', 30, 8, 'VAC', 'Class', '2026-2027', '2026-08-11 09:56:02'),
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
(160, 7, 5, 'Friday', 7, '15:30:00', '16:00:00', NULL, NULL, 'Club Meetings / Extra Curricular', 'Activity', '2026-2027', '2026-08-11 09:56:02');

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
(2, 'valapclawmkima81@gmail.com', '$2y$10$FKOlsUjkJ.i56BFH6IxmdO8Tt.JvBXeePAFS50cdjszcXSnvcOKhm', 'Teacher', 'Sir Mike', 1, 7, NULL, 1, '2026-08-11 08:33:50'),
(3, 'valapclawmkima@gmail81com', '$2y$10$TEpkcix2uVTAmy1iSm4uOeGeKP8EaSL5G7eOgdc8/9KO7wba61NKm', 'Student', 'Isak Roluahpuia', 1, 7, 5, 9, '2026-08-11 09:20:01');

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
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `semester_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `subject_teacher`
--
ALTER TABLE `subject_teacher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `timetable_entries`
--
ALTER TABLE `timetable_entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
