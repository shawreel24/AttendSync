<?php
// login.php
header('Content-Type: application/json');
session_start();
require_once 'db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
    exit();
}

$rawData = file_get_contents("php://input");
$data = json_decode($rawData, true);

$identifier = trim($data['email'] ?? '');
$password   = $data['password'] ?? '';
$role       = $data['role'] ?? 'Teacher';

if (empty($identifier) || empty($password) || empty($role)) {
    echo json_encode(['success' => false, 'message' => 'Please provide all required fields.']);
    exit();
}

try {
    // -----------------------------------------------------------------------
    // 1. Look up in the unified `users` table first
    // -----------------------------------------------------------------------
    $stmt = $pdo->prepare("
        SELECT id, identifier, password, role, full_name, institution_id, department_id, semester
        FROM users
        WHERE identifier = :identifier AND role = :role
        LIMIT 1
    ");
    $stmt->execute([':identifier' => $identifier, ':role' => $role]);
    $user = $stmt->fetch();

    $authenticated = false;
    $teacherId     = null;
    $studentId     = null;
    $extraData     = [];

    if ($user) {
        // Try bcrypt verify first, then plain-text fallback (for seeded 'change_me' accounts)
        if (password_verify($password, $user['password']) || $password === $user['password']) {
            $authenticated = true;

            // Fetch extra teacher data if role is Teacher
            if ($role === 'Teacher') {
                $tStmt = $pdo->prepare("
                    SELECT t.teacher_id, t.teacher_name, t.email, t.employee_no, t.is_hod,
                           d.name AS department_name
                    FROM teacher t
                    JOIN departments d ON d.id = t.department_id
                    WHERE t.email = :email
                    LIMIT 1
                ");
                $tStmt->execute([':email' => $identifier]);
                $tRow = $tStmt->fetch();
                if ($tRow) {
                    $teacherId = $tRow['teacher_id'];
                    $extraData = [
                        'teacher_id'      => $tRow['teacher_id'],
                        'employee_no'     => $tRow['employee_no'],
                        'is_hod'          => $tRow['is_hod'],
                        'department_name' => $tRow['department_name'],
                        'department_id'   => $user['department_id']
                    ];
                }
            }

            // Fetch student data if role is Student
            if ($role === 'Student') {
                $sStmt = $pdo->prepare("
                    SELECT s.student_id, s.roll_no, s.admission_no, s.semester_id,
                           sem.semester_name, d.name AS department_name
                    FROM student s
                    JOIN semester sem ON sem.semester_id = s.semester_id
                    JOIN departments d ON d.id = s.department_id
                    WHERE s.email = :email
                    LIMIT 1
                ");
                $sStmt->execute([':email' => $identifier]);
                $sRow = $sStmt->fetch();
                if ($sRow) {
                    $studentId = $sRow['student_id'];
                    $extraData = [
                        'student_id'      => $sRow['student_id'],
                        'roll_no'         => $sRow['roll_no'],
                        'admission_no'    => $sRow['admission_no'],
                        'semester_id'     => $sRow['semester_id'],
                        'semester_name'   => $sRow['semester_name'],
                        'department_name' => $sRow['department_name'],
                        'department_id'   => $user['department_id']
                    ];
                }
            }
        }
    } else {
        // -----------------------------------------------------------------------
        // 2. Fallback: check role-specific tables directly
        // -----------------------------------------------------------------------
        if ($role === 'Teacher') {
            $tStmt = $pdo->prepare("
                SELECT t.teacher_id, t.teacher_name, t.email, t.password, t.employee_no,
                       t.is_hod, t.institution_id, t.department_id,
                       d.name AS department_name
                FROM teacher t
                JOIN departments d ON d.id = t.department_id
                WHERE t.email = :email
                LIMIT 1
            ");
            $tStmt->execute([':email' => $identifier]);
            $tRow = $tStmt->fetch();

            if ($tRow && (password_verify($password, $tRow['password']) || $password === $tRow['password'])) {
                $authenticated = true;
                $teacherId     = $tRow['teacher_id'];
                $user = [
                    'id'            => 0,
                    'identifier'    => $tRow['email'],
                    'role'          => 'Teacher',
                    'full_name'     => $tRow['teacher_name'],
                    'institution_id'=> $tRow['institution_id'],
                    'department_id' => $tRow['department_id'],
                    'semester'      => null
                ];
                $extraData = [
                    'teacher_id'      => $tRow['teacher_id'],
                    'employee_no'     => $tRow['employee_no'],
                    'is_hod'          => $tRow['is_hod'],
                    'department_name' => $tRow['department_name'],
                    'department_id'   => $tRow['department_id']
                ];
            }
        }

        // Admin fallback: check administrator table
        if ($role === 'Admin') {
            $aStmt = $pdo->prepare("
                SELECT a.admin_id, a.admin_name, a.email, a.password, a.institution_id
                FROM administrator a
                WHERE a.email = :email
                LIMIT 1
            ");
            $aStmt->execute([':email' => $identifier]);
            $aRow = $aStmt->fetch();

            if ($aRow && (password_verify($password, $aRow['password']) || $password === $aRow['password'])) {
                $authenticated = true;
                $user = [
                    'id'            => 0,
                    'identifier'    => $aRow['email'],
                    'role'          => 'Admin',
                    'full_name'     => $aRow['admin_name'],
                    'institution_id'=> $aRow['institution_id'],
                    'department_id' => null,
                    'semester'      => null
                ];
                $extraData = ['admin_id' => $aRow['admin_id']];
            }
        }

        // Student fallback: check student table
        if ($role === 'Student') {
            $sStmt = $pdo->prepare("
                SELECT s.student_id, s.student_name, s.email, s.password, s.roll_no, s.admission_no, s.semester_id, s.department_id, s.institution_id,
                       sem.semester_name, d.name AS department_name
                FROM student s
                JOIN semester sem ON sem.semester_id = s.semester_id
                JOIN departments d ON d.id = s.department_id
                WHERE s.email = :email
                LIMIT 1
            ");
            $sStmt->execute([':email' => $identifier]);
            $sRow = $sStmt->fetch();

            if ($sRow && (password_verify($password, $sRow['password']) || $password === $sRow['password'])) {
                $authenticated = true;
                $studentId     = $sRow['student_id'];
                $user = [
                    'id'            => 0,
                    'identifier'    => $sRow['email'],
                    'role'          => 'Student',
                    'full_name'     => $sRow['student_name'],
                    'institution_id'=> $sRow['institution_id'],
                    'department_id' => $sRow['department_id'],
                    'semester'      => $sRow['semester_id']
                ];
                $extraData = [
                    'student_id'      => $sRow['student_id'],
                    'roll_no'         => $sRow['roll_no'],
                    'admission_no'    => $sRow['admission_no'],
                    'semester_id'     => $sRow['semester_id'],
                    'semester_name'   => $sRow['semester_name'],
                    'department_name' => $sRow['department_name'],
                    'department_id'   => $sRow['department_id']
                ];
            }
        }
    }

    if ($authenticated && $user) {
        // Store in session
        $_SESSION['user_id']       = $user['id'] ?? 0;
        $_SESSION['role']          = $role;
        $_SESSION['full_name']     = $user['full_name'];
        $_SESSION['identifier']    = $user['identifier'];
        $_SESSION['department_id'] = $user['department_id'];
        if ($teacherId) $_SESSION['teacher_id'] = $teacherId;
        if ($studentId) $_SESSION['student_id'] = $studentId;
        if ($role === 'Admin' && !empty($extraData['admin_id'])) {
            $_SESSION['admin_id'] = $extraData['admin_id'];
        }

        echo json_encode([
            'success' => true,
            'message' => 'Login successful',
            'user'    => array_merge([
                'id'          => $user['id'] ?? 0,
                'identifier'  => $user['identifier'],
                'role'        => $user['role'],
                'full_name'   => $user['full_name'],
                'department_id' => $user['department_id']
            ], $extraData)
        ]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Invalid credentials or user not found.']);
    }

} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
}
?>
