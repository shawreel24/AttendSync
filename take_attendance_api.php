<?php
header('Content-Type: application/json');
session_start();
require_once 'db.php';

$teacherId = isset($_SESSION['teacher_id']) ? (int)$_SESSION['teacher_id'] : null;

if (!$teacherId) {
    echo json_encode(['success' => false, 'message' => 'Not authenticated']);
    exit();
}

$subjectId = isset($_GET['subject_id']) ? (int)$_GET['subject_id'] : 0;
$date = isset($_GET['date']) ? $_GET['date'] : date('Y-m-d');

if (!$subjectId) {
    echo json_encode(['success' => false, 'message' => 'Subject ID is required']);
    exit();
}

try {
    // Get subject details
    $subStmt = $pdo->prepare("SELECT department_id, semester, name FROM subjects WHERE id = :sid");
    $subStmt->execute([':sid' => $subjectId]);
    $subject = $subStmt->fetch();

    if (!$subject) {
        echo json_encode(['success' => false, 'message' => 'Subject not found']);
        exit();
    }
    
    $currentYear = '2026-2027'; // Hardcoded for simplicity as in teacher_api.php
    
    $semStmt = $pdo->prepare("
        SELECT semester_id 
        FROM semester 
        WHERE department_id = :did 
          AND semester_number = :sem 
          AND academic_year = :year
    ");
    $semStmt->execute([
        ':did' => $subject['department_id'], 
        ':sem' => $subject['semester'], 
        ':year' => $currentYear
    ]);
    $semRow = $semStmt->fetch();
    
    if (!$semRow) {
        echo json_encode(['success' => false, 'message' => 'Semester not found', 'students' => []]);
        exit();
    }
    
    $semesterId = $semRow['semester_id'];
    
    // Fetch students
    $stuStmt = $pdo->prepare("
        SELECT student_id, student_name, roll_no, email 
        FROM student 
        WHERE semester_id = :semid
        ORDER BY roll_no ASC
    ");
    $stuStmt->execute([':semid' => $semesterId]);
    $students = $stuStmt->fetchAll();
    
    // Fetch existing attendance for this subject, teacher and date
    $attStmt = $pdo->prepare("
        SELECT student_id, status 
        FROM attendance 
        WHERE subject_id = :sid AND teacher_id = :tid AND attendance_date = :date
    ");
    $attStmt->execute([
        ':sid' => $subjectId,
        ':tid' => $teacherId,
        ':date' => $date
    ]);
    
    $attendanceData = [];
    foreach ($attStmt->fetchAll() as $row) {
        $attendanceData[$row['student_id']] = $row['status'];
    }
    
    // Combine
    $resultStudents = [];
    foreach ($students as $stu) {
        $status = isset($attendanceData[$stu['student_id']]) ? $attendanceData[$stu['student_id']] : 'Unmarked';
        $resultStudents[] = [
            'student_id' => $stu['student_id'],
            'student_name' => $stu['student_name'],
            'roll_no' => $stu['roll_no'],
            'email' => $stu['email'],
            'status' => $status
        ];
    }
    
    echo json_encode([
        'success' => true,
        'subject_name' => $subject['name'],
        'date' => $date,
        'students' => $resultStudents
    ]);
    
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'DB error: ' . $e->getMessage()]);
}
?>
