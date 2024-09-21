<?php

$host = "localhost:3306";
$username = "root";
$password = "";
$database = "smart_farm";

$connection = mysqli_connect($host, $username, $password, $database);

if (!$connection) {
    die("Connection failed : " . mysqli_connect_error());
}  

 //echo("Success connect to database " . $database);


if (isset($_GET['remove_farm_data']) && $_GET['remove_farm_data'] == 'true') {
    
    // Query untuk menghapus semua baris di tabel smart_farm_data menggunakan TRUNCATE
    $query = "TRUNCATE TABLE smart_farm_data";
    
    if (mysqli_query($connection, $query)) {
        echo json_encode(array("status" => "success", "message" => "All records truncated successfully."));
    } else {
        echo json_encode(array("status" => "error", "message" => "Error truncating records: " . mysqli_error($connection)));
    }
}

?>
