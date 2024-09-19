<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "smart_farm";

// Buat koneksi ke database
$connection = mysqli_connect($host, $username, $password, $database);

if (!$connection) {
    die("Connection failed: " . mysqli_connect_error());
}

// Query untuk mengambil data terbaru
$query = "SELECT * FROM smart_farm_data ORDER BY id DESC LIMIT 1";

$result = mysqli_query($connection, $query);

if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    
    // Buat array untuk dikirimkan sebagai JSON
    $data = array(
        "temperature" => $row['temperature'],
        "humidity" => $row['humidity'],
        "moisture" => $row['moisture'],
        "timestamp" => $row['datetime']
    );

    // Konversi array ke format JSON
    echo json_encode($data);
} else {
    echo json_encode(array("error" => "No data found."));
}

mysqli_close($connection);
?>
