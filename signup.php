<?php
// signup.php  – handles multi-subject selection for Teachers and Students
header('Content-Type: application/json');
session_start();
require_once 'db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
    exit();
}

$rawData = file_get_contents("php://input");
$data    = json_decode($rawData, true);

// ── Extract fields ────────────────────────────────────────────────────────
$fullName    = trim($data['fullName']  ?? '');
$identifier  = trim($data['email']    ?? '');
$password    = $data['password']      ?? '';
$role        = $data['role']          ?? 'Teacher';

$institutionId = (int)($data['institutionId'] ?? 1);
$departmentId  = (int)($data['departmentId']  ?? 0);
$semester      = $data['semester']    ?? null;

// Multi-subject array: [ { name, id, sem }, … ]
$subjects    = $data['subjects']      ?? [];

// Student-specific
$rollNo      = trim($data['rollNo']    ?? '');
$studentAdmNo = trim($data['studentId'] ?? ''); // admission_no

// ── Basic validation ──────────────────────────────────────────────────────
if (empty($fullName) || empty($identifier) || empty($password) || empty($role) || !$departmentId) {
    echo json_encode(['success' => false, 'message' => 'Please provide all required fields.']);
    exit();
}
if (empty($subjects)) {
    echo json_encode(['success' => false, 'message' => 'Please select at least one subject.']);
    exit();
}
if ($role === 'Student') {
    if (empty($semester)) {
        echo json_encode(['success' => false, 'message' => 'Semester is required for students.']);
        exit();
    }
    if (empty($rollNo)) {
        echo json_encode(['success' => false, 'message' => 'Roll No (Class Roll No) is required for students.']);
        exit();
    }
    if (empty($studentAdmNo)) {
        echo json_encode(['success' => false, 'message' => 'Student ID (Admission No.) is required for students.']);
        exit();
    }
}

try {
    // ── Check if user already exists ──────────────────────────────────────────
    $chk = $pdo->prepare("SELECT id FROM users WHERE identifier = :id AND role = :role LIMIT 1");
    $chk->execute([':id' => $identifier, ':role' => $role]);
    $existingUser = $chk->fetch();
    $isUpdate = $existingUser !== false;

    // ── Hash password ─────────────────────────────────────────────────────
    $hashedPwd = password_hash($password, PASSWORD_DEFAULT);

    // ── Resolve primary subject_id (first selected subject) for users table
    $primarySubjectId = null;
    if (!empty($subjects[0]['id'])) {
        $primarySubjectId = (int)$subjects[0]['id'];
    } elseif (!empty($subjects[0]['name'])) {
        $subQ = $pdo->prepare("SELECT id FROM subjects WHERE name = :n AND department_id = :d LIMIT 1");
        $subQ->execute([':n' => $subjects[0]['name'], ':d' => $departmentId]);
        $subRow = $subQ->fetch();
        if ($subRow) $primarySubjectId = $subRow['id'];
    }

    // ── Begin transaction ─────────────────────────────────────────────────
    $pdo->beginTransaction();

    // ── UPSERT `users` ───────────────────────────────────────────────
    if ($isUpdate) {
        $updUser = $pdo->prepare("
            UPDATE users
            SET password = :password, role = :role, full_name = :fullName, institution_id = :instId,
                department_id = :deptId, semester = :semester, subject_id = :subjectId
            WHERE identifier = :identifier AND role = :role
        ");
        $updUser->execute([
            ':identifier' => $identifier,
            ':password'   => $hashedPwd,
            ':role'       => $role,
            ':fullName'   => $fullName,
            ':instId'     => $institutionId,
            ':deptId'     => $departmentId,
            ':semester'   => $semester ?: null,
            ':subjectId'  => $primarySubjectId
        ]);
    } else {
        $insUser = $pdo->prepare("
            INSERT INTO users
                (identifier, password, role, full_name, institution_id, department_id, semester, subject_id)
            VALUES
                (:identifier, :password, :role, :fullName, :instId, :deptId, :semester, :subjectId)
        ");
        $insUser->execute([
            ':identifier' => $identifier,
            ':password'   => $hashedPwd,
            ':role'       => $role,
            ':fullName'   => $fullName,
            ':instId'     => $institutionId,
            ':deptId'     => $departmentId,
            ':semester'   => $semester ?: null,
            ':subjectId'  => $primarySubjectId
        ]);
    }

    // ── Teacher: UPSERT `teacher` table and `subject_teacher` ────────
    if ($role === 'Teacher') {
        $tChk = $pdo->prepare("SELECT teacher_id FROM teacher WHERE email = :e LIMIT 1");
        $tChk->execute([':e' => $identifier]);
        $existingTeacher = $tChk->fetch();

        if ($existingTeacher) {
            $teacherId = (int)$existingTeacher['teacher_id'];
            $updTeacher = $pdo->prepare("
                UPDATE teacher
                SET password = :pwd, teacher_name = :name, department_id = :deptId, institution_id = :instId
                WHERE teacher_id = :tid
            ");
            $updTeacher->execute([
                ':pwd'    => $hashedPwd,
                ':name'   => $fullName,
                ':deptId' => $departmentId,
                ':instId' => $institutionId,
                ':tid'    => $teacherId
            ]);
            
            // Clear existing subjects for update
            $pdo->prepare("DELETE FROM subject_teacher WHERE teacher_id = :tid")->execute([':tid' => $teacherId]);
        } else {
            $insTeacher = $pdo->prepare("
                INSERT INTO teacher
                    (institution_id, department_id, teacher_name, email, password)
                VALUES
                    (:instId, :deptId, :name, :email, :pwd)
            ");
            $insTeacher->execute([
                ':instId' => $institutionId,
                ':deptId' => $departmentId,
                ':name'   => $fullName,
                ':email'  => $identifier,
                ':pwd'    => $hashedPwd
            ]);
            $teacherId = (int)$pdo->lastInsertId();
        }

        // Insert subject_teacher rows
        $insSubTeach = $pdo->prepare("
            INSERT IGNORE INTO subject_teacher (subject_id, teacher_id)
            VALUES (:subId, :teachId)
        ");
        foreach ($subjects as $sub) {
            $subId = resolveSubjectId($pdo, $sub, $departmentId);
            if ($subId) {
                $insSubTeach->execute([':subId' => $subId, ':teachId' => $teacherId]);
            }
        }
    }

    // ── Student: UPSERT `student` table ──────────────────────────────
    if ($role === 'Student') {
        $semQ = $pdo->prepare("
            SELECT semester_id FROM semester
            WHERE department_id = :deptId AND semester_number = :semNum
            LIMIT 1
        ");
        $semQ->execute([':deptId' => $departmentId, ':semNum' => (int)$semester]);
        $semRow = $semQ->fetch();

        if (!$semRow) {
            $pdo->rollBack();
            echo json_encode([
                'success' => false,
                'message' => "Semester $semester is not set up for the selected department. Please contact admin."
            ]);
            exit();
        }
        $semesterId = (int)$semRow['semester_id'];

        $rollChk = $pdo->prepare("
            SELECT student_id FROM student WHERE semester_id = :semId AND roll_no = :rn AND email != :email LIMIT 1
        ");
        $rollChk->execute([':semId' => $semesterId, ':rn' => $rollNo, ':email' => $identifier]);
        if ($rollChk->fetch()) {
            $pdo->rollBack();
            echo json_encode([
                'success' => false,
                'message' => "Roll No '$rollNo' is already taken in this semester. Please use your correct class roll number."
            ]);
            exit();
        }

        $admChk = $pdo->prepare("
            SELECT student_id FROM student WHERE institution_id = :instId AND admission_no = :an AND email != :email LIMIT 1
        ");
        $admChk->execute([':instId' => $institutionId, ':an' => $studentAdmNo, ':email' => $identifier]);
        if ($admChk->fetch()) {
            $pdo->rollBack();
            echo json_encode([
                'success' => false,
                'message' => "Student ID '$studentAdmNo' is already registered. Please check your Admission No."
            ]);
            exit();
        }

        $sChk = $pdo->prepare("SELECT student_id FROM student WHERE email = :email LIMIT 1");
        $sChk->execute([':email' => $identifier]);
        $existingStudent = $sChk->fetch();

        if ($existingStudent) {
            $updStud = $pdo->prepare("
                UPDATE student
                SET password = :pwd, student_name = :name, department_id = :deptId, semester_id = :semId,
                    roll_no = :rollNo, admission_no = :admNo, institution_id = :instId
                WHERE email = :email
            ");
            $updStud->execute([
                ':pwd'    => $hashedPwd,
                ':name'   => $fullName,
                ':deptId' => $departmentId,
                ':semId'  => $semesterId,
                ':rollNo' => $rollNo,
                ':admNo'  => $studentAdmNo,
                ':instId' => $institutionId,
                ':email'  => $identifier
            ]);
        } else {
            $insStud = $pdo->prepare("
                INSERT INTO student
                    (institution_id, department_id, semester_id, student_name, email, password, roll_no, admission_no)
                VALUES
                    (:instId, :deptId, :semId, :name, :email, :pwd, :rollNo, :admNo)
            ");
            $insStud->execute([
                ':instId'  => $institutionId,
                ':deptId'  => $departmentId,
                ':semId'   => $semesterId,
                ':name'    => $fullName,
                ':email'   => $identifier,
                ':pwd'     => $hashedPwd,
                ':rollNo'  => $rollNo,
                ':admNo'   => $studentAdmNo
            ]);
        }
    }

    $pdo->commit();

    echo json_encode([
        'success'  => true,
        'message'  => $isUpdate ? 'Account updated successfully.' : 'Account created successfully.',
        'subjects' => count($subjects)
    ]);


} catch (PDOException $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();

    $errMsg = 'Database error: ' . $e->getMessage();
    if ($e->getCode() == 23000) {
        if (strpos($e->getMessage(), 'roll_no') !== false) {
            $errMsg = "Roll No '$rollNo' is already taken in this semester.";
        } elseif (strpos($e->getMessage(), 'admission_no') !== false) {
            $errMsg = "Student ID '$studentAdmNo' is already registered.";
        } elseif (strpos($e->getMessage(), 'identifier') !== false || strpos($e->getMessage(), 'email') !== false) {
            $errMsg = 'An account with this email already exists.';
        } else {
            $errMsg = 'A duplicate entry error occurred. Please check your details.';
        }
    }
    echo json_encode(['success' => false, 'message' => $errMsg]);
}

// ── Helper: resolve a subject ID from { id, name } or just name ───────────
function resolveSubjectId(PDO $pdo, array $sub, int $deptId): ?int {
    if (!empty($sub['id']) && $sub['id'] > 0) {
        return (int)$sub['id'];
    }
    if (!empty($sub['name'])) {
        $q = $pdo->prepare("SELECT id FROM subjects WHERE name = :n AND department_id = :d LIMIT 1");
        $q->execute([':n' => $sub['name'], ':d' => $deptId]);
        $r = $q->fetch();
        return $r ? (int)$r['id'] : null;
    }
    return null;
}
?>
