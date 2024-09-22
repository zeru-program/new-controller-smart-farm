<?php
include("db.php");

header('Content-Type: application/json');

// Query untuk mengambil data terbaru
$query = "SELECT * FROM alert WHERE status = 'active'";

$result = mysqli_query($connection, $query);

if ($result && mysqli_num_rows($result) > 0) {
    $alerts = mysqli_fetch_all($result, MYSQLI_ASSOC);

    // Output the result as JSON
    echo json_encode($alerts);
} else {
    echo json_encode(array("error" => "No data found."));
}

mysqli_close($connection);
?>
