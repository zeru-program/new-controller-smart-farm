<?php  
header('Content-Type: text/plain'); // Mengatur header untuk format teks biasa

include "db.php";

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    $pump = isset($_GET['pump']) ? intval($_GET['pump']) : null;
    $fan = isset($_GET['fan']) ? intval($_GET['fan']) : null;

    if ($pump) {
        $sql = "SELECT device_name, pin, type FROM devices_manager";
        $result = $connection->query($sql);

        // Jika ada data yang ditemukan
        if ($result->num_rows > 0) {
            // Loop melalui data dan temukan device yang cocok
            while ($row = $result->fetch_assoc()) {
                if ($row['device_name'] === "pump" . $pump) {
                    echo $row['pin']; // Kirimkan nilai pin sebagai integer
                    exit; // Hentikan eksekusi setelah mengirimkan pin
                }
            }
            
            // Jika device tidak ditemukan, kirimkan pesan error
            echo "Device not found";
        } else {
            echo "No devices found";
        }
    } else if ($fan) {
        $sql = "SELECT device_name, pin, type FROM devices_manager";
        $result = $connection->query($sql);

        // Jika ada data yang ditemukan
        if ($result->num_rows > 0) {
            // Loop melalui data dan temukan device yang cocok
            while ($row = $result->fetch_assoc()) {
                if ($row['device_name'] === "fan" . $fan) {
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
