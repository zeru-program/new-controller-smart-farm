<?php  
header('Content-Type: application/json');

// Include database connection
include "db.php";

// Get the raw POST data (JSON format)
$input = file_get_contents('php://input');
$data = json_decode($input, true); // Convert JSON to array

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($data['pump']) && $data['pump'] === true) {
    // Get pump number and status
    $pumpNumber = isset($data['pumpNumber']) ? mysqli_real_escape_string($connection, $data['pumpNumber']) : null;
    $pumpStatus = isset($data['pumpStatus']) ? mysqli_real_escape_string($connection, $data['pumpStatus']) : 0;

    if ($pumpNumber !== null) {
        $deviceName = "pump" . $pumpNumber;
        $query = "INSERT INTO devices_relay (device_name, device_type, status, update_at) VALUES ('$deviceName', 'pump', '$pumpStatus', CURRENT_TIMESTAMP)";
        
        if (mysqli_query($connection, $query)) {
            $response = array(
                'status' => 'success',
                'message' => 'Pump data inserted successfully'
            );
        } else {
            $response = array(
                'status' => 'error',
                'message' => 'Failed to insert pump data: ' . mysqli_error($connection)
            );
        }
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'Pump number not specified'
        );
    }

} elseif ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($data['fan']) && $data['fan'] === true) {
    // Get fan number and status
    $fanNumber = isset($data['fanNumber']) ? mysqli_real_escape_string($connection, $data['fanNumber']) : null;
    $fanStatus = isset($data['fanStatus']) ? mysqli_real_escape_string($connection, $data['fanStatus']) : 0;

    if ($fanNumber !== null) {
        $deviceName = "fan" . $fanNumber;
        $query = "INSERT INTO devices_relay (device_name, device_type, status, update_at) VALUES ('$deviceName', 'fan', '$fanStatus', CURRENT_TIMESTAMP)";
        
        if (mysqli_query($connection, $query)) {
            $response = array(
                'status' => 'success',
                'message' => 'Fan data inserted successfully'
            );
        } else {
            $response = array(
                'status' => 'error',
                'message' => 'Failed to insert fan data: ' . mysqli_error($connection)
            );
        }
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'Fan number not specified'
        );
    }

} else {
    $response = array(
        'status' => 'error',
        'message' => 'Invalid request'
    );
}

mysqli_close($connection);
echo json_encode($response);
?>
