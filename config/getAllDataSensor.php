<?php
header('Content-Type: application/json');

// Include database connection
include "db.php";

// Query to get all device statuses
$query = "SELECT * FROM devices_manager";
$result = mysqli_query($connection, $query);

$data = array(); // Array to store all device data

if (mysqli_num_rows($result) > 0) {
    // Fetch all device data and store in an array
    while ($row = mysqli_fetch_assoc($result)) {
        $data[] = array(
            'id' => $row["id"],
            'device_name' => $row["device_name"],
            'pin' => $row["pin"],
            'type' => $row["type"],
            'kondisi' => $row["kondisi"],
            'updated_at' => $row["update_at"]
        );
    }
    
    // Konversi seluruh array ke format JSON
    echo json_encode($data);
} else {
    // If no devices are found
    echo json_encode(array('status' => 'error', 'message' => 'No devices found'));
}

mysqli_close($connection);
?>
