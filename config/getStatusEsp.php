<?php
header('Content-Type: application/json');

// Include database connection
include "db.php";

// Query to get all device statuses
$query = "SELECT * FROM status_esp ORDER BY id DESC LIMIT 1";
$result = mysqli_query($connection, $query);


if (mysqli_num_rows($result) > 0) {
    // Fetch all device data and store in an array
    while ($row = mysqli_fetch_assoc($result)) {
        $data = array(
        'esp_client' => $row["esp_client"],
        'esp_server' => $row["esp_server"]
        );
        
        // Konversi array ke format JSON
        echo json_encode($data);
    }


} else {
    // If no devices are found
    echo json_encode(array('status' => 'error', 'message' => 'No devices found'));
}

mysqli_close($connection);
?>
