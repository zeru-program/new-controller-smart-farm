<?php
header('Content-Type: application/json'); // Mengatur header re>

// Cek metode permintaan
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Tangani permintaan GET
    $response = "localhost:3306";
    // Tambahkan logika tambahan sesuai kebutuhan Anda
} else {
    // Jika metode tidak didukung
    http_response_code(405); // Metode Tidak Diperbolehkan
    $response = "error";
}

echo json_encode($response);
?>
