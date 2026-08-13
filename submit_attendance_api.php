<?php
header('Content-Type: application/json');
session_start();
require_once 'db.php';

$teacherId = isset($_SESSION['teacher_id']) ? (int)$_SESSION['teacher_id'] : null;

if (!$teacherId) {
    echo json_encode(['success' => false, 'message' => 'Not authenticated']);
    exit();
}

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['subject_id']) || !isset($data['date']) || !isset($data['attendance'])) {
    echo json_encode(['success' => false, 'message' => 'Invalid data provided']);
    exit();
}

$subjectId = (int)$data['subject_id'];
$date = $data['date'];
$attendanceList = $data['attendance'];

try {
    $pdo->beginTransaction();
    
    $stmt = $pdo->prepare("
        INSERT INTO attendance (student_id, subject_id, teacher_id, attendance_date, status) 
        VALUES (:stuid, :subid, :tid, :date, :status)
        ON DUPLICATE KEY UPDATE status = VALUES(status)
    ");
    
    foreach ($attendanceList as $att) {
        // Only save valid statuses
        if (!in_array($att['status'], ['Present', 'Absent', 'Late', 'Excused'])) {
            continue;
        }
        
        $stmt->execute([
            ':stuid' => $att['student_id'],
            ':subid' => $subjectId,
            ':tid' => $teacherId,
            ':date' => $date,
            ':status' => $att['status']
        ]);
    }
    
    $pdo->commit();
    echo json_encode(['success' => true, 'message' => 'Attendance saved successfully']);
} catch (PDOException $e) {
    $pdo->rollBack();
    echo json_encode(['success' => false, 'message' => 'DB error: ' . $e->getMessage()]);
}
?>
