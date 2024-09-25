<?php  
header('Content-Type: application/json');

// Include database connection
include "db.php";

// Get the raw POST data (JSON format)
$input = file_get_contents('php://input');
$data = json_decode($input, true); // Convert JSON to array

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get pump number and status
    $userId = isset($data['user_id']) ? mysqli_real_escape_string($connection, $data['user_id']) : "";
    $username = isset($data['username']) ? mysqli_real_escape_string($connection, $data['username']) : "";
    $password = isset($data['password']) ? mysqli_real_escape_string($connection, $data['password']) : "";
    $passwordEncrypt = password_hash($password, PASSWORD_DEFAULT);;

    if ($userId !== null && $username !== null && $password !== null) {
        $query = "INSERT INTO account (user_id, role, username, password, created_at) VALUES ('$userId', 'user', '$username', '$passwordEncrypt', CURRENT_TIMESTAMP)";
        
        if (mysqli_query($connection, $query)) {
            $response = array(
                'status' => 'success',
                'message' => 'Account created successfully'
            );
        } else {
            $response = array(
                'status' => 'error',
                'message' => 'Failed to created account' . mysqli_error($connection)
            );
        }
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'post data is empty'
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
