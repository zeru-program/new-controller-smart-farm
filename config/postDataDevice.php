<?php  
//header('Content-Type: application/json');

// Include database connection
include "db.php";


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Validate inputs
    $deviceName = $_POST['device_name'];
    $devicePin = $_POST['device_pin'];
    $deviceType = $_POST['device_type'];
    $kondisi = $_POST['kondisi'];

    // Check for empty inputs
   if ($deviceName !== '' && $devicePin !== '' && $deviceType !== '' && $kondisi !== '') {
        // Prepare and execute query
        $query = "INSERT INTO devices_manager (device_name, pin, type, kondisi, update_at) 
                  VALUES ('$deviceName', '$devicePin', '$deviceType', '$kondisi', CURRENT_TIMESTAMP)";

        if (mysqli_query($connection, $query)) {
            $response = array(
                'status' => 'success',
                'message' => 'Sukses membuat device baru, akan redirect dalam 2detik..'
            );
            sleep(5);
         echo '<script type="text/javascript">'; echo 'window.location.href = "/dashboard/device-manager/";'; echo '</script>';
        } else {
            // Log the error
            $response = array(
                'status' => 'error',
                'message' => 'Failed to create device: ' . mysqli_error($connection)
            );
        }
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'All fields are required.'
                    );
    }
} else {
    $response = array(
        'status' => 'error',
        'message' => 'Invalid request method.'
    );
}

mysqli_close($connection);
echo json_encode($response);

?>
