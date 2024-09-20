<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Farm Data</title>
    <script>
        function getData() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "../config/getDataSensor.php", true);
            xhr.onload = function () {
                if (xhr.status === 200) {
                    var data = JSON.parse(xhr.responseText);
                    
                    if (!data.error) {
                        // Update konten halaman dengan data baru
                        document.getElementById("temperature").innerHTML = data.temperature + " °C";
                        document.getElementById("humidity").innerHTML = data.humidity + " %";
                        document.getElementById("moisture1").innerHTML = data.moisture1 + " %";
                        document.getElementById("timestamp").innerHTML = data.timestamp;
                    } else {
                        document.getElementById("temperature").innerHTML = "No data";
                        document.getElementById("humidity").innerHTML = "No data";
                        document.getElementById("moisture1").innerHTML = "No data";
                        document.getElementById("timestamp").innerHTML = "No data";
                    }
                }
            };
            xhr.send();
        }
        
        function removeFarmData() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "../config/db.php?remove_farm_data=true", true);
            xhr.onload = function () {
                if (xhr.status === 200) {
                    var data = JSON.parse(xhr.responseText);
                    
                    if (!data.error) {
                        alert("data berhasil dihapus")
                    } else {
                        alert("data gagal dihapus")
                    }
                }
            };
            xhr.send();
        }

        // Panggil fungsi getData() setiap 5 detik
        setInterval(getData, 5000);

        // Panggil saat pertama kali halaman dimuat
        window.onload = getData;
    </script>
</head>
<body>
    <h1>Data Terbaru dari Sensor DHT</h1>
    <p>Temperature: <span id="temperature">Loading...</span></p>
    <p>Humidity: <span id="humidity">Loading...</span></p>
    <p>Moisture: <span id="moisture1">Loading...</span></p>
    <p>Timestamp: <span id="timestamp">Loading...</span></p>
    <button onclick="removeFarmData()">hapus semua data</button>
</body>
</html>
