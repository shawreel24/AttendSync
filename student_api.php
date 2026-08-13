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
    // 1. Fetch student info
    $stmt = $pdo->prepare("
        SELECT s.student_name, s.semester_id, s.department_id, sem.semester_name, d.name AS department_name
        FROM student s
        JOIN semester sem ON sem.semester_id = s.semester_id
        JOIN departments d ON d.id = s.department_id
        WHERE s.student_id = :sid
    ");
    $stmt->execute([':sid' => $studentId]);
    $student = $stmt->fetch();
    
    if (!$student) {
        echo json_encode(['success' => false, 'message' => 'Student not found']);
        exit();
    }
    
    // We need to know the semester number to fetch subjects.
    $semStmt = $pdo->prepare("SELECT semester_number FROM semester WHERE semester_id = :semid");
    $semStmt->execute([':semid' => $student['semester_id']]);
    $semNumber = $semStmt->fetchColumn();

    // 2. Fetch subjects for this student's semester and department
    $subStmt = $pdo->prepare("
        SELECT id, name
        FROM subjects
        WHERE semester = :sem_num AND department_id = :dep_id
    ");
    $subStmt->execute([':sem_num' => $semNumber, ':dep_id' => $student['department_id']]);
    $subjects = $subStmt->fetchAll();

    // 3. Fetch attendance records for this student
    $attStmt = $pdo->prepare("
        SELECT subject_id, status, attendance_date
        FROM attendance
        WHERE student_id = :sid
    ");
    $attStmt->execute([':sid' => $studentId]);
    $attendanceRecords = $attStmt->fetchAll();

    // 4. Calculate stats
    $totalClassesHeld = count($attendanceRecords);
    $classesAttended = 0;
    $uniqueDays = [];
    
    $subjectStats = [];
    foreach ($subjects as $sub) {
        $subjectStats[$sub['id']] = [
            'subject_name' => $sub['name'],
            'subject_id' => $sub['id'],
            'held' => 0,
            'attended' => 0,
            'percentage' => 0,
            'status' => 'Safe'
        ];
    }
    
    foreach ($attendanceRecords as $att) {
        $sid = $att['subject_id'];
        if (!isset($subjectStats[$sid])) continue; // Edge case: attendance for a dropped/changed subject
        
        $subjectStats[$sid]['held']++;
        
        // Count 'Present' or 'Late' as attended
        if ($att['status'] === 'Present' || $att['status'] === 'Late') {
            $classesAttended++;
            $subjectStats[$sid]['attended']++;
            $uniqueDays[$att['attendance_date']] = true;
        }
    }
    
    $overallPercentage = $totalClassesHeld > 0 ? round(($classesAttended / $totalClassesHeld) * 100) : 0;
    
    $subjectBreakdown = [];
    foreach ($subjectStats as $stat) {
        if ($stat['held'] > 0) {
            $stat['percentage'] = round(($stat['attended'] / $stat['held']) * 100);
        } else {
            $stat['percentage'] = 100; // If no classes held yet, assume 100%
        }
        
        if ($stat['percentage'] >= 75) {
            $stat['status'] = 'Safe';
        } elseif ($stat['percentage'] >= 65) {
            $stat['status'] = 'Warning';
        } else {
            $stat['status'] = 'Critical';
        }
        
        $subjectBreakdown[] = $stat;
    }
    
    // Sort subjects by percentage (critical first)
    usort($subjectBreakdown, function($a, $b) {
        return $a['percentage'] <=> $b['percentage'];
    });
    
    $daysPresent = count($uniqueDays);

    echo json_encode([
        'success' => true,
        'user' => [
            'name' => $student['student_name'],
            'role_label' => $student['department_name'] . ' • ' . $student['semester_name']
        ],
        'summary' => [
            'overall_percentage' => $overallPercentage,
            'classes_attended' => $classesAttended,
            'total_held' => $totalClassesHeld,
            'days_present' => $daysPresent
        ],
        'subjects' => $subjectBreakdown
    ]);

} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'DB error: ' . $e->getMessage()]);
}
?>
