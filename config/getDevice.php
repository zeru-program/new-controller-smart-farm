<?php  
header('Content-Type: text/plain'); // Mengatur header untuk format teks biasa

include "db.php";

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    $soil = isset($_GET['soil']) ? intval($_GET['soil']) : null;

    if ($soil) {
        $sql = "SELECT device_name, pin, type FROM devices_manager";
        $result = $connection->query($sql);

        // Jika ada data yang ditemukan
        if ($result->num_rows > 0) {
            // Loop melalui data dan temukan device yang cocok
            while ($row = $result->fetch_assoc()) {
                if ($row['device_name'] === "soil" . $soil) {
                    echo $row['pin']; // Kirimkan nilai pin sebagai integer
                    exit; // Hentikan eksekusi setelah mengirimkan pin
                }
            }
            
            // Jika device tidak ditemukan, kirimkan pesan error
            echo "Device not found";
        } else {
            echo "No devices found";
        }
    } else {
        echo "Invalid dht parameter";
    }
}
?>
