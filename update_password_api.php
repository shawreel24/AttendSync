<?php
header('Content-Type: application/json');
session_start();
require_once 'db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
    exit();
}

$role = isset($_SESSION['role']) ? $_SESSION['role'] : null;
$userId = null;
$table = '';
$idColumn = '';

if ($role === 'Student' && isset($_SESSION['student_id'])) {
    $userId = (int)$_SESSION['student_id'];
    $table = 'student';
    $idColumn = 'student_id';
} elseif ($role === 'Teacher' && isset($_SESSION['teacher_id'])) {
    $userId = (int)$_SESSION['teacher_id'];
    $table = 'teacher';
    $idColumn = 'teacher_id';
} else {
    echo json_encode(['success' => false, 'message' => 'Not authenticated']);
    exit();
}

$rawData = file_get_contents("php://input");
$data = json_decode($rawData, true);
$newPassword = $data['newPassword'] ?? '';

if (empty($newPassword)) {
    echo json_encode(['success' => false, 'message' => 'Password is required.']);
    exit();
}

try {
    $pdo->beginTransaction();

    $hashedPwd = password_hash($newPassword, PASSWORD_DEFAULT);

    // Fetch email to update users table
    $stmt = $pdo->prepare("SELECT email FROM {$table} WHERE {$idColumn} = :id");
    $stmt->execute([':id' => $userId]);
    $email = $stmt->fetchColumn();

    if (!$email) {
        $pdo->rollBack();
        echo json_encode(['success' => false, 'message' => 'Account record not found.']);
        exit();
    }

    // Update specific role table
    $updRole = $pdo->prepare("UPDATE {$table} SET password = :pwd WHERE {$idColumn} = :id");
    $updRole->execute([':pwd' => $hashedPwd, ':id' => $userId]);

    // Update global users table
    $updUser = $pdo->prepare("UPDATE users SET password = :pwd WHERE identifier = :email AND role = :role");
    $updUser->execute([':pwd' => $hashedPwd, ':email' => $email, ':role' => $role]);

    $pdo->commit();
    echo json_encode(['success' => true, 'message' => 'Password updated successfully.']);

} catch (PDOException $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    echo json_encode(['success' => false, 'message' => 'DB error: ' . $e->getMessage()]);
}
?>
