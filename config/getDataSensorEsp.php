<?php
include("db.php");

header('Content-Type: text/plain');

// Cek apakah parameter 'moisture' ada dalam request
if (isset($_GET['moisture'])) {
    $moistureIndex = intval($_GET['moisture']);

    // Validasi bahwa nilai moisture adalah antara 1 hingga 10
    if ($moistureIndex >= 1 && $moistureIndex <= 10) {
        // Buat nama kolom berdasarkan index moisture
        $column = "moisture" . $moistureIndex;

        // Query untuk mengambil data terbaru dari kolom yang sesuai
        $query = "SELECT $column FROM smart_farm_data ORDER BY id DESC LIMIT 1";
        
        $result = mysqli_query($connection, $query);

        if ($result && mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
            $data = array(
                "moisture" => $row[$column]
            );
            
            // Mengembalikan data dalam format JSON
            echo $data["moisture"];
        } else {
            // Jika tidak ada data yang ditemukan
            echo json_encode(array("error" => "No data found."));
        }
    } else {
        // Jika nilai moisture tidak valid
        echo json_encode(array("error" => "Invalid moisture parameter. Please use a value between 1 and 10."));
    }
} 
if (isset($_GET['temperature'])) {
    // Validasi bahwa nilai moisture adalah antara 1 hingga 10
    $query = "SELECT temperature FROM smart_farm_data ORDER BY id DESC LIMIT 1";
    $result = mysqli_query($connection, $query);
    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
       
        // Mengembalikan data dalam format JSON
        echo $row["temperature"];
    } else {
        // Jika tidak ada data yang ditemukan
        echo json_encode(array("error" => "No data found."));
    }
} 
if (isset($_GET['humidity'])) {
    // Validasi bahwa nilai moisture adalah antara 1 hingga 10
    $query = "SELECT humidity FROM smart_farm_data ORDER BY id DESC LIMIT 1";
    $result = mysqli_query($connection, $query);
    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
       
        // Mengembalikan data dalam format JSON
        echo $row["humidity"];
    } else {
        // Jika tidak ada data yang ditemukan
        echo json_encode(array("error" => "No data found."));
    }
} 

mysqli_close($connection);
?>
