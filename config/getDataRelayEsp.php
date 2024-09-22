<?php
header('Content-Type: text/plain');

// Include database connection
include "db.php";

// Check if 'pump' or 'fan' is requested
if (isset($_GET['pump'])) {
    $pumpNumber = intval($_GET['pump']); // Sanitize input
    $query = "SELECT status FROM devices_relay WHERE device_name = 'pump$pumpNumber' ORDER BY update_at DESC LIMIT 1"; // Get status based on device_name
} elseif (isset($_GET['fan'])) {
    $fanNumber = intval($_GET['fan']); // Sanitize input
    $query = "SELECT status FROM devices_relay WHERE device_name = 'fan$fanNumber' ORDER BY update_at DESC LIMIT 1"; // Get status based on device_name
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request']);
    exit;
}

$result = mysqli_query($connection, $query);

if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    echo $row["status"];
} else {
  echo "undefined pin";
}

mysqli_close($connection);
?>
