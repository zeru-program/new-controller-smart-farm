<?php
include("db.php");

header('Content-Type: application/json');

// Query untuk mengambil data terbaru
$query = "SELECT * FROM smart_farm_data ORDER BY id DESC LIMIT 1";

$result = mysqli_query($connection, $query);

if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    
    // Buat array untuk dikirimkan sebagai JSON
    $data = array(
    "temperature" => $row['temperature'],
    "humidity" => $row['humidity'],
    "moisture1" => $row['moisture1'],
    "moisture2" => $row['moisture2'],
    "moisture3" => $row['moisture3'],
    "moisture4" => $row['moisture4'],
    "moisture5" => $row['moisture5'],
    "moisture6" => $row['moisture6'],
    "moisture7" => $row['moisture7'],
    "moisture8" => $row['moisture8'],
    "moisture9" => $row['moisture9'],
    "moisture10" => $row['moisture10'],
    "timestamp" => $row['datetime']
    );

    // Konversi array ke format JSON
    echo json_encode($data);
} else {
    //echo json_encode(array("error" => "No data found."));
}

mysqli_close($connection);
?>
