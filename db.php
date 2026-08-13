<?php
// db.php
// Database configuration
$host = getenv('MYSQLHOST') ?: 'localhost';
$db_name = getenv('MYSQLDATABASE') ?: 'attendsync';
$username = getenv('MYSQLUSER') ?: 'root';
$password = getenv('MYSQLPASSWORD') ?: '';
$port = getenv('MYSQLPORT') ?: '3306';

try {
    // Create a new PDO instance
    $pdo = new PDO("mysql:host=$host;port=$port;dbname=$db_name;charset=utf8", $username, $password);
    
    // Set PDO error mode to exception for better error handling
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    // Set default fetch mode to associative array
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
} catch(PDOException $e) {
    // Return a JSON error if connection fails
    header('Content-Type: application/json');
    echo json_encode([
        'success' => false,
        'message' => 'Database connection failed: ' . $e->getMessage()
    ]);
    exit();
}
?>
