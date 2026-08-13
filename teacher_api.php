<?php
// teacher_api.php
// Returns JSON data for the teacher dashboard. Accepts optional ?date=YYYY-MM-DD
header('Content-Type: application/json');
session_start();
require_once 'db.php';

// ── Resolve teacher_id ────────────────────────────────────────────────────
$teacherId = null;
if (isset($_SESSION['teacher_id'])) {
    $teacherId = (int)$_SESSION['teacher_id'];
} elseif (isset($_GET['teacher_id'])) {
    $teacherId = (int)$_GET['teacher_id'];
}

if (!$teacherId) {
    echo json_encode(['success' => false, 'message' => 'Not authenticated. Please login.']);
    exit();
}

// ── Resolve date (default = today, max = today, no future limit enforced) ─
$requestedDate = null;
if (!empty($_GET['date'])) {
    $parsed = DateTime::createFromFormat('Y-m-d', $_GET['date']);
    if ($parsed && $parsed->format('Y-m-d') === $_GET['date']) {
        $requestedDate = $parsed->format('Y-m-d');
    }
}
if (!$requestedDate) {
    $requestedDate = date('Y-m-d');
}

$dateObj    = new DateTime($requestedDate);
$dayOfWeek  = $dateObj->format('l');          // e.g. "Monday"
$todayReal  = date('Y-m-d');
$isToday    = ($requestedDate === $todayReal);
$isPast     = ($requestedDate < $todayReal);
$currentYear = '2026-2027';                    // academic year

try {
    // ── 1. Teacher basic info ─────────────────────────────────────────────
    $tStmt = $pdo->prepare("
        SELECT t.teacher_id, t.teacher_name, t.email, t.employee_no, t.is_hod,
               t.department_id, d.name AS department_name,
               i.name AS institution_name
        FROM teacher t
        JOIN departments d ON d.id = t.department_id
        JOIN institutions i ON i.id = t.institution_id
        WHERE t.teacher_id = :tid
    ");
    $tStmt->execute([':tid' => $teacherId]);
    $teacher = $tStmt->fetch();

    if (!$teacher) {
        echo json_encode(['success' => false, 'message' => 'Teacher not found.']);
        exit();
    }

    // ── 2. Timetable entries for the requested day ────────────────────────
    $ttStmt = $pdo->prepare("
        SELECT te.id, te.day_name, te.period_no, te.start_time, te.end_time,
               te.title, te.entry_type, te.semester,
               s.name  AS subject_name, s.id AS subject_id,
               sem.semester_name,
               d.name  AS dept_name
        FROM timetable_entries te
        LEFT JOIN subjects  s   ON s.id   = te.subject_id
        LEFT JOIN semester  sem ON sem.department_id   = te.department_id
                                AND sem.semester_number = te.semester
                                AND sem.academic_year   = te.academic_year
        LEFT JOIN departments d ON d.id = te.department_id
        WHERE te.teacher_id    = :tid
          AND te.day_name      = :day
          AND te.academic_year = :year
        ORDER BY te.period_no ASC
    ");
    $ttStmt->execute([':tid' => $teacherId, ':day' => $dayOfWeek, ':year' => $currentYear]);
    $dayClasses = $ttStmt->fetchAll();

    // ── 3. Which subjects already have attendance marked for this date ─────
    $attStmt = $pdo->prepare("
        SELECT te.subject_id,
               COUNT(DISTINCT a.attendance_id) AS marked_count
        FROM timetable_entries te
        LEFT JOIN attendance a ON a.subject_id      = te.subject_id
                               AND a.teacher_id      = te.teacher_id
                               AND a.attendance_date = :qdate
        WHERE te.teacher_id = :tid
          AND te.day_name   = :day
          AND te.entry_type != 'Break'
        GROUP BY te.subject_id
    ");
    $attStmt->execute([':tid' => $teacherId, ':day' => $dayOfWeek, ':qdate' => $requestedDate]);
    $markedSubjectIds = [];
    foreach ($attStmt->fetchAll() as $row) {
        if ($row['marked_count'] > 0) $markedSubjectIds[] = $row['subject_id'];
    }

    // ── 4. Student counts per semester ────────────────────────────────────
    $semCountStmt = $pdo->prepare("
        SELECT sem.semester_number,
               COUNT(DISTINCT st.student_id) AS student_count
        FROM timetable_entries te
        JOIN semester sem ON sem.department_id    = te.department_id
                         AND sem.semester_number  = te.semester
                         AND sem.academic_year    = te.academic_year
        LEFT JOIN student st ON st.semester_id = sem.semester_id
        WHERE te.teacher_id    = :tid
          AND te.academic_year = :year
        GROUP BY sem.semester_number
    ");
    $semCountStmt->execute([':tid' => $teacherId, ':year' => $currentYear]);
    $semCounts = [];
    foreach ($semCountStmt->fetchAll() as $row) {
        $semCounts[$row['semester_number']] = (int)$row['student_count'];
    }

    // ── 5. Overall avg attendance percentage for this teacher ─────────────
    $avgStmt = $pdo->prepare("
        SELECT AVG(a.status = 'Present') * 100 AS avg_pct
        FROM attendance a WHERE a.teacher_id = :tid
    ");
    $avgStmt->execute([':tid' => $teacherId]);
    $avgPct = round($avgStmt->fetch()['avg_pct'] ?? 0, 1);

    // ── 6. Attendance stats specifically for the requested date ───────────
    $dateAttStmt = $pdo->prepare("
        SELECT COUNT(*) AS total_marked,
               SUM(a.status = 'Present') AS present_count,
               SUM(a.status = 'Absent')  AS absent_count
        FROM attendance a
        WHERE a.teacher_id = :tid AND a.attendance_date = :qdate
    ");
    $dateAttStmt->execute([':tid' => $teacherId, ':qdate' => $requestedDate]);
    $dateAtt = $dateAttStmt->fetch();

    // ── Build formatted class list ────────────────────────────────────────
    $classIcons = [
        'Class'      => 'bx-chalkboard',
        'Practical'  => 'bx-code-alt',
        'Break'      => 'bx-coffee',
        'Mentoring'  => 'bx-user-voice',
        'Activity'   => 'bx-star',
    ];

    $formattedClasses = [];
    $completedCount   = 0;
    $pendingCount     = 0;

    foreach ($dayClasses as $cls) {
        $isCompleted    = in_array($cls['subject_id'], $markedSubjectIds);
        $startFormatted = date('h:i A', strtotime($cls['start_time']));
        $endFormatted   = date('h:i A', strtotime($cls['end_time']));
        $semNo          = $cls['semester'];
        $studCount      = $semCounts[$semNo] ?? 0;

        $formattedClasses[] = [
            'id'            => $cls['id'],
            'title'         => $cls['title'],
            'subject_name'  => $cls['subject_name'] ?? $cls['title'],
            'subject_id'    => $cls['subject_id'],
            'type'          => $cls['entry_type'],
            'icon'          => $classIcons[$cls['entry_type']] ?? 'bx-book',
            'start_time'    => $startFormatted,
            'end_time'      => $endFormatted,
            'time_range'    => "$startFormatted – $endFormatted",
            'semester'      => $semNo,
            'semester_name' => $cls['semester_name'] ?? "Sem $semNo",
            'department'    => $cls['dept_name'],
            'student_count' => $studCount,
            'is_completed'  => $isCompleted,
            'period_no'     => $cls['period_no'],
        ];

        if (!in_array($cls['entry_type'], ['Break', 'Mentoring', 'Activity'])) {
            if ($isCompleted) $completedCount++;
            else $pendingCount++;
        }
    }

    $teachableClasses  = array_filter($formattedClasses, fn($c) => !in_array($c['type'], ['Break','Mentoring','Activity']));
    $totalClassesCount = count($teachableClasses);

    echo json_encode([
        'success'    => true,
        'teacher'    => [
            'teacher_id'      => $teacher['teacher_id'],
            'name'            => $teacher['teacher_name'],
            'email'           => $teacher['email'],
            'employee_no'     => $teacher['employee_no'],
            'is_hod'          => (bool)$teacher['is_hod'],
            'department_id'   => $teacher['department_id'],
            'department_name' => $teacher['department_name'],
            'institution'     => $teacher['institution_name'],
        ],
        // Date info
        'requested_date' => $requestedDate,
        'day_of_week'    => $dayOfWeek,
        'today_date'     => date('D, d M Y', strtotime($requestedDate)),
        'is_today'       => $isToday,
        'is_past'        => $isPast,
        // Summary
        'summary' => [
            'total_classes'  => $totalClassesCount,
            'completed'      => $completedCount,
            'pending'        => $pendingCount,
            'avg_attendance' => $avgPct > 0 ? $avgPct . '%' : 'N/A',
            'date_present'   => (int)($dateAtt['present_count'] ?? 0),
            'date_absent'    => (int)($dateAtt['absent_count']  ?? 0),
            'date_marked'    => (int)($dateAtt['total_marked']  ?? 0),
        ],
        'classes' => $formattedClasses,
    ]);

} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'DB error: ' . $e->getMessage()]);
}
?>
