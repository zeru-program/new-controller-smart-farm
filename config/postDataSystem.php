<?php  
header('Content-Type: application/json');

// Include database connection
include "db.php";

// Get the raw POST data (JSON format)
$input = file_get_contents('php://input');
$data = json_decode($input, true); // Convert JSON to array

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($data['system'])) {
    $system = isset($data['system']) ? mysqli_real_escape_string($connection, $data['system']) : 'manual';

    if ($system !== null) {
        $query = "INSERT INTO farm_operation (system, updated_by) VALUES ('$system', 'admin')";

        // Execute normal insert query
        if (mysqli_query($connection, $query)) {
            $response = array(
                'status' => 'success',
                'message' => 'Berhasil update system farm'
            );
        } else {
            $response = array(
                'status' => 'error',
                'message' => 'Failed to insert status: ' . mysqli_error($connection)
            );
        }
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'Status server tidak valid'
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
