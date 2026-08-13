<?php
require 'db.php';
$stmt = $pdo->query("SELECT * FROM timetable_entries");
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
