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

// Query untuk mengambil data terbaru berdasarkan ID atau timestamp
$query = "SELECT * FROM smart_farm_data ORDER BY id DESC LIMIT 1"; // Bisa juga pakai ORDER BY timestamp DESC

$result = mysqli_query($connection, $query);
if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    $temperature = $row['temperature'];
    $humidity = $row['humidity'];
    $timestamp = $row['datetime'];
    
    // Tampilkan hasil di halaman web
    echo "<h1>Data Terbaru dari Sensor DHT</h1>";
    echo "Temperature: " . $temperature . " °C<br>";
    echo "Humidity: " . $humidity . " %<br>";
    echo "Timestamp: " . $timestamp . "<br>";
} else {
    echo "No data found.";
}

mysqli_close($connection);
?>
