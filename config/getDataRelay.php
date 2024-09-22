<?php
header('Content-Type: application/json');

// Include database connection
include "db.php";

// Query to get all device statuses
$query = "SELECT device_name, device_type, status FROM devices_relay";
$result = mysqli_query($connection, $query);

$devices = array();

if (mysqli_num_rows($result) > 0) {
    // Fetch all device data and store in an array
    while ($row = mysqli_fetch_assoc($result)) {
        $devices[] = array(
            'device_name' => $row['device_name'],
            'device_type' => $row['device_type'],
            'status' => $row['status']
        );
    }

    // Return devices data in JSON format
    echo json_encode(array('status' => 'success', 'devices' => $devices));

} else {
    // If no devices are found
    echo json_encode(array('status' => 'error', 'message' => 'No devices found'));
}

mysqli_close($connection);
?>
