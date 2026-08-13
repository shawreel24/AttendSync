<?php
header('Content-Type: application/json');
session_start();
require_once 'db.php';

$studentId = isset($_SESSION['student_id']) ? (int)$_SESSION['student_id'] : null;
$role = isset($_SESSION['role']) ? $_SESSION['role'] : null;

if (!$studentId || $role !== 'Student') {
    echo json_encode(['success' => false, 'message' => 'Not authenticated as a student']);
    exit();
}

try {
    $stmt = $pdo->prepare("
        SELECT s.student_name, s.email, s.roll_no, s.admission_no, sem.semester_name, d.name AS department_name
        FROM student s
        JOIN semester sem ON sem.semester_id = s.semester_id
        JOIN departments d ON d.id = s.department_id
        WHERE s.student_id = :sid
    ");
    $stmt->execute([':sid' => $studentId]);
    $student = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$student) {
        echo json_encode(['success' => false, 'message' => 'Student not found']);
        exit();
    }

    echo json_encode([
        'success' => true,
        'student' => $student
    ]);

} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'DB error: ' . $e->getMessage()]);
}
?>
