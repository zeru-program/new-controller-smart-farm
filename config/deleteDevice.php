<?php
// Include koneksi database
include 'db.php';

// Mendapatkan data JSON dari request body
$data = json_decode(file_get_contents('php://input'), true);

if (isset($data['id'])) {
    $id = $data['id'];
    
    // Query SQL UPDATE
    $query = "DELETE FROM devices_manager WHERE id = '$id'";

    // Eksekusi query
    if (mysqli_query($connection, $query)) {
        // Jika berhasil, kirimkan response JSON sukses
        echo json_encode(array('status' => 'success', 'message' => 'Device deleted successfully'));
    } else {
        // Jika gagal, kirimkan response JSON error
        echo json_encode(array('status' => 'error', 'message' => 'Failed to delete device: ' . mysqli_error($connection)));
    }
} else {
    // Kirim response JSON error jika data tidak lengkap
    echo json_encode(array('status' => 'error', 'message' => 'Invalid input data'));
}

// Tutup koneksi
mysqli_close($connection);
?>
