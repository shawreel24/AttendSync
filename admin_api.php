<?php
// admin_api.php  – Data endpoint for the AttendSync admin dashboard
header('Content-Type: application/json');
session_start();
require_once 'db.php';

// ── Auth check ────────────────────────────────────────────────────────
$adminId = null;
if (isset($_SESSION['role']) && $_SESSION['role'] === 'Admin') {
    $adminId = $_SESSION['user_id'] ?? 1;
} elseif (isset($_GET['admin_id'])) {
    $adminId = (int)$_GET['admin_id']; // dev fallback
}
if (!$adminId) {
    echo json_encode(['success' => false, 'message' => 'Not authenticated as Admin.']);
    exit();
}

// ── Section requested ─────────────────────────────────────────────────
$section = $_GET['section'] ?? 'overview';

try {
    switch ($section) {

        case 'overview':
            $date = $_GET['date'] ?? null;
            $params = $date ? [':date' => $date] : [];
            $whereDate = $date ? "WHERE attendance_date = :date" : "";
            $whereDateA = $date ? "WHERE a.attendance_date = :date" : "";
            $andDateA = $date ? "AND a.attendance_date = :date" : "";

            // Counts
            $counts = $pdo->query("
                SELECT
                  (SELECT COUNT(*) FROM teacher)     AS total_teachers,
                  (SELECT COUNT(*) FROM student)     AS total_students,
                  (SELECT COUNT(*) FROM departments) AS total_depts,
                  (SELECT COUNT(*) FROM subjects)    AS total_subjects,
                  (SELECT COUNT(*) FROM semester)    AS total_semesters,
                  (SELECT COUNT(*) FROM attendance $whereDate)  AS total_att_records
            ");
            $counts->execute($params);
            $counts = $counts->fetch();

            // Attendance overall %
            $attPctStmt = $pdo->prepare("
                SELECT ROUND(AVG(status = 'Present') * 100, 1) AS pct
                FROM attendance $whereDate
            ");
            $attPctStmt->execute($params);
            $attPct = $attPctStmt->fetch()['pct'] ?? 0;

            // Attendance per status
            $attStatusStmt = $pdo->prepare("
                SELECT status, COUNT(*) AS cnt FROM attendance $whereDate GROUP BY status
            ");
            $attStatusStmt->execute($params);
            $attStatus = $attStatusStmt->fetchAll();
            $statusMap = [];
            foreach ($attStatus as $r) $statusMap[$r['status']] = (int)$r['cnt'];

            // Students per semester
            $semStats = $pdo->query("
                SELECT sem.semester_name, sem.semester_number,
                       d.name AS dept, COUNT(s.student_id) AS cnt
                FROM semester sem
                JOIN departments d ON d.id = sem.department_id
                LEFT JOIN student s ON s.semester_id = sem.semester_id
                GROUP BY sem.semester_id
                ORDER BY sem.semester_number
            ")->fetchAll();

            // Recent 10 attendance entries
            $recentStmt = $pdo->prepare("
                SELECT a.attendance_date, a.status,
                       s.student_name, s.roll_no,
                       sub.name AS subject_name,
                       t.teacher_name
                FROM attendance a
                JOIN student s   ON s.student_id  = a.student_id
                JOIN subjects sub ON sub.id        = a.subject_id
                JOIN teacher t   ON t.teacher_id  = a.teacher_id
                $whereDateA
                ORDER BY a.marked_at DESC LIMIT 10
            ");
            $recentStmt->execute($params);
            $recent = $recentStmt->fetchAll();

            // Teacher workload (classes per teacher this week)
            $teacherLoad = $pdo->query("
                SELECT t.teacher_id, t.teacher_name, t.employee_no,
                       COUNT(DISTINCT te.id) AS class_count,
                       GROUP_CONCAT(DISTINCT d_all.id) AS dept_ids,
                       MAX(d_main.name) AS dept
                FROM teacher t
                LEFT JOIN timetable_entries te ON te.teacher_id = t.teacher_id AND te.entry_type = 'Class'
                LEFT JOIN subject_teacher st ON st.teacher_id = t.teacher_id
                LEFT JOIN subjects sub ON sub.id = st.subject_id
                LEFT JOIN departments d_all ON (d_all.id = t.department_id OR d_all.id = sub.department_id)
                LEFT JOIN departments d_main ON d_main.id = t.department_id
                GROUP BY t.teacher_id
                ORDER BY class_count DESC
            ")->fetchAll();

            // Department Attendance Percentages
            $deptAttStmt = $pdo->prepare("
                SELECT d.id AS dept_id, d.name AS dept_name,
                       IFNULL(ROUND(AVG(a.status = 'Present') * 100, 1), 0) AS att_pct
                FROM departments d
                LEFT JOIN student s ON s.department_id = d.id
                LEFT JOIN attendance a ON a.student_id = s.student_id $andDateA
                GROUP BY d.id
                ORDER BY att_pct DESC
            ");
            $deptAttStmt->execute($params);
            $deptAtt = $deptAttStmt->fetchAll();

            // All Departments
            $allDepts = $pdo->query("SELECT id, name FROM departments ORDER BY name")->fetchAll();

            // Attendance trend last 7 days
            $trend = $pdo->query("
                SELECT attendance_date,
                       COUNT(*) AS total,
                       SUM(status='Present') AS present
                FROM attendance
                WHERE attendance_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
                GROUP BY attendance_date
                ORDER BY attendance_date ASC
            ")->fetchAll();

            echo json_encode([
                'success' => true,
                'section' => 'overview',
                'counts'  => $counts,
                'att_pct' => (float)$attPct,
                'att_status'   => $statusMap,
                'sem_stats'    => $semStats,
                'recent_att'   => $recent,
                'teacher_load' => $teacherLoad,
                'trend'        => $trend,
                'dept_att'     => $deptAtt,
                'all_depts'    => $allDepts,
            ]);
            break;

        // ── TEACHERS ─────────────────────────────────────────────────
        case 'teachers':
            $teachers = $pdo->query("
                SELECT t.teacher_id, t.teacher_name, t.email, t.employee_no,
                       t.phone, t.is_hod, t.created_at,
                       d.name AS department,
                       COUNT(DISTINCT st.id) AS subject_count,
                       COUNT(DISTINCT a.attendance_id) AS att_records
                FROM teacher t
                JOIN departments d ON d.id = t.department_id
                LEFT JOIN subject_teacher st ON st.teacher_id = t.teacher_id
                LEFT JOIN attendance a ON a.teacher_id = t.teacher_id
                GROUP BY t.teacher_id
                ORDER BY t.teacher_name
            ")->fetchAll();
            echo json_encode(['success' => true, 'section' => 'teachers', 'teachers' => $teachers]);
            break;

        // ── STUDENTS ─────────────────────────────────────────────────
        case 'students':
            $students = $pdo->query("
                SELECT s.student_id, s.student_name, s.email, s.roll_no,
                       s.admission_no, s.phone, s.created_at,
                       d.name AS department,
                       sem.semester_name, sem.semester_number,
                       COUNT(a.attendance_id) AS total_classes,
                       SUM(a.status='Present')  AS present_count,
                       ROUND(
                           IFNULL(SUM(a.status='Present')/NULLIF(COUNT(a.attendance_id),0)*100, 0)
                       , 1) AS attendance_pct
                FROM student s
                JOIN departments d   ON d.id   = s.department_id
                JOIN semester sem    ON sem.semester_id = s.semester_id
                LEFT JOIN attendance a ON a.student_id = s.student_id
                GROUP BY s.student_id
                ORDER BY s.student_name
            ")->fetchAll();
            echo json_encode(['success' => true, 'section' => 'students', 'students' => $students]);
            break;

        // ── DEPARTMENTS ───────────────────────────────────────────────
        case 'departments':
            $depts = $pdo->query("
                SELECT d.id, d.name,
                       COUNT(DISTINCT t.teacher_id) AS teacher_count,
                       COUNT(DISTINCT s.student_id) AS student_count,
                       COUNT(DISTINCT sub.id)        AS subject_count,
                       COUNT(DISTINCT sem.semester_id) AS semester_count
                FROM departments d
                LEFT JOIN teacher  t   ON t.department_id   = d.id
                LEFT JOIN student  s   ON s.department_id   = d.id
                LEFT JOIN subjects sub ON sub.department_id = d.id
                LEFT JOIN semester sem ON sem.department_id = d.id
                GROUP BY d.id
                ORDER BY d.name
            ")->fetchAll();
            echo json_encode(['success' => true, 'section' => 'departments', 'departments' => $depts]);
            break;

        // ── ATTENDANCE ────────────────────────────────────────────────
        case 'attendance':
            $date   = $_GET['date'] ?? date('Y-m-d');
            $deptId = isset($_GET['dept']) ? (int)$_GET['dept'] : null;

            $sql = "
                SELECT a.attendance_date, a.status, a.remarks, a.marked_at,
                       s.student_name, s.roll_no, s.admission_no,
                       sub.name AS subject_name,
                       t.teacher_name,
                       d.name AS department,
                       sem.semester_name
                FROM attendance a
                JOIN student  s   ON s.student_id  = a.student_id
                JOIN subjects sub ON sub.id         = a.subject_id
                JOIN teacher  t   ON t.teacher_id  = a.teacher_id
                JOIN departments d ON d.id = s.department_id
                JOIN semester sem  ON sem.semester_id = s.semester_id
                WHERE a.attendance_date = :date
            ";
            $params = [':date' => $date];
            if ($deptId) { $sql .= " AND s.department_id = :deptId"; $params[':deptId'] = $deptId; }
            $sql .= " ORDER BY a.marked_at DESC LIMIT 200";
            $stmt = $pdo->prepare($sql);
            $stmt->execute($params);
            $records = $stmt->fetchAll();

            // Summary for that date
            $sum = $pdo->prepare("
                SELECT COUNT(*) AS total,
                       SUM(status='Present') AS present,
                       SUM(status='Absent')  AS absent,
                       SUM(status='Late')    AS late
                FROM attendance WHERE attendance_date = :date
            ");
            $sum->execute([':date' => $date]);
            $daySummary = $sum->fetch();

            echo json_encode([
                'success'     => true,
                'section'     => 'attendance',
                'date'        => $date,
                'records'     => $records,
                'day_summary' => $daySummary,
            ]);
            break;

        default:
            echo json_encode(['success' => false, 'message' => 'Unknown section.']);
    }

} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'DB error: ' . $e->getMessage()]);
}
?>
