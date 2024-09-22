<?php  
header('Content-Type: application/json');

// Include database connection
include "db.php";

// Get the raw POST data (JSON format)
$input = file_get_contents('php://input');
$data = json_decode($input, true); // Convert JSON to array

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($data['status'])) {
    $statusServer = isset($data['status']) ? mysqli_real_escape_string($connection, $data['status']) : 0;

    if ($statusServer !== null) {
        $query = "INSERT INTO status_server (status, update_at) VALUES ('$statusServer', CURRENT_TIMESTAMP)";

        if ($statusServer == 0) {
            // Multi-query for resetting tables
            $queryRestartServer = "
                TRUNCATE TABLE status_server;
                TRUNCATE TABLE devices_relay;
                INSERT INTO devices_relay (device_name, device_type, status, update_at) VALUES 
                    ('pump1', 'pump', '0', CURRENT_TIMESTAMP), 
                    ('fan1', 'fan', '0', CURRENT_TIMESTAMP);
                TRUNCATE TABLE smart_farm_data;
                TRUNCATE TABLE farm_operation;
                INSERT INTO farm_operation (system, updated_by) VALUES ('manual', 'admin');
            ";

            // Execute multi-query
            if (mysqli_multi_query($connection, $queryRestartServer)) {
                // Loop through the results of each query in the multi-query
                do {
                    if ($result = mysqli_store_result($connection)) {
                        mysqli_free_result($result);
                    }
                } while (mysqli_next_result($connection));

                $response = array(
                    'status' => 'success',
                    'message' => 'Berhasil matikan server dan reset DB'
                );
            } else {
                $response = array(
                    'status' => 'error',
                    'message' => 'Gagal reset DB: ' . mysqli_error($connection)
                );
            }
        }

        // Execute normal insert query
        if (mysqli_query($connection, $query)) {
            $response = array(
                'status' => 'success',
                'message' => 'Berhasil update status server'
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
