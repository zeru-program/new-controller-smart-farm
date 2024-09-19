<?php  
header('Content-Type: application/json');

// Include database connection
include "db.php";

if(isset($_POST["temperature"]) && isset($_POST["humidity"])) {
    $temperature = $_POST["temperature"];
    $humidity = $_POST["humidity"];
    
    $moisture_values = [];

    // Loop untuk menangani hingga 10 sensor soil moisture
    for ($i = 1; $i <= 10; $i++) {
        if (isset($_POST["moisture".$i])) {
            $moisture_values[] = $_POST["moisture".$i];
        }
    }

    // Buat query untuk memasukkan data ke dalam database
    $sql = "INSERT INTO smart_farm_data (temperature, humidity";

    // Tambahkan kolom moisture berdasarkan jumlah sensor
    for ($i = 1; $i <= count($moisture_values); $i++) {
        $sql .= ", moisture" . $i;
    }
    
    // Tutup bagian kolom query
    $sql .= ") VALUES (" . $temperature . ", " . $humidity;

    // Tambahkan nilai moisture ke query
    foreach ($moisture_values as $value) {
        $sql .= ", " . $value;
    }

    // Tutup query
    $sql .= ")";

    // Eksekusi query
    if (mysqli_query($connection, $sql)) {
        echo json_encode(["message" => "New record created successfully"]);
    } else {
        echo json_encode(["message" => "Error: " . $sql . " - " . mysqli_error($connection)]);
    }
} else {
    echo json_encode(["message" => "Temperature and humidity not set"]);
}

mysqli_close($connection);
?>
