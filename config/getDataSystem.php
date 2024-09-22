<?php
header('Content-Type: application/json');

// Include database connection
include "db.php";

// Query to get all device statuses
$query = "SELECT system FROM farm_operation ORDER BY id DESC LIMIT 1";
$result = mysqli_query($connection, $query);


if (mysqli_num_rows($result) > 0) {
    // Fetch all device data and store in an array
    while ($row = mysqli_fetch_assoc($result)) {
        echo $row["system"];
    }


} else {
    // If no devices are found
    echo json_encode(array('status' => 'error', 'message' => 'No devices found'));
}

mysqli_close($connection);
?>
