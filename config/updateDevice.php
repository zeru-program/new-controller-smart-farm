<?php
// Include koneksi database
include 'db.php';

// Mendapatkan data JSON dari request body
$data = json_decode(file_get_contents('php://input'), true);

if (isset($data['id']) && isset($data['device_name']) && isset($data['pin']) && isset($data['type']) && isset($data['kondisi'])) {
    $id = $data['id'];
    $deviceName = $data['device_name'];
    $pin = $data['pin'];
    $type = $data['type'];
    $kondisi = $data['kondisi'];

    // Query SQL UPDATE
    $query = "UPDATE devices_manager 
              SET device_name = '$deviceName', pin = '$pin', type = '$type', kondisi = '$kondisi', update_at = CURRENT_TIMESTAMP
              WHERE id = '$id'";

    // Eksekusi query
    if (mysqli_query($connection, $query)) {
        // Jika berhasil, kirimkan response JSON sukses
        echo json_encode(array('status' => 'success', 'message' => 'Device updated successfully'));
    } else {
        // Jika gagal, kirimkan response JSON error
        echo json_encode(array('status' => 'error', 'message' => 'Failed to update device: ' . mysqli_error($connection)));
    }
} else {
    // Kirim response JSON error jika data tidak lengkap
    echo json_encode(array('status' => 'error', 'message' => 'Invalid input data'));
}

// Tutup koneksi
mysqli_close($connection);
?>
