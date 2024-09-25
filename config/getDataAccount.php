<?php  
header('Content-Type: application/json');

// Include database connection
include "db.php";

// Get the raw POST data (JSON format)
$input = file_get_contents('php://input');
$data = json_decode($input, true); // Convert JSON to array

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get pump number and status
     $username = isset($data['username']) ? mysqli_real_escape_string($connection, $data['username']) : "";
     $password = isset($data['password']) ? mysqli_real_escape_string($connection, $data['password']) : "";
 
    if ($username !== null && $password !== null) {
        $query = "SELECT * FROM account WHERE username = '$username'";
        $result = mysqli_query($connection, $query);

        if ($result && mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
    
            // Verify password (assuming passwords are hashed)
            if (password_verify($password, $row['password'])) {
                // Successful login
                $response = array(
                    'status' => 'success',
                    'message' => 'success login',
                    'user_id' => $row["user_id"],
                    'role' => $row["role"]
                );
                // You can start a session or redirect the user here
            } else {
                // Incorrect password
                $response = array(
                    'status' => 'error',
                    'message' => 'password incorrect'
                );
            }
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
