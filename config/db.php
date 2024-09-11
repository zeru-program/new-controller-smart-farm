<?php

$host = "localhost";
$username = "root";
$password = "";
$database = "smart_farm";

$connection = mysqli_connect($host, $username, $password, $database);

if (!$connection) {
    die("Connection failed : " . mysqli_connect_error());
}  

echo("Success connect to database " . $database);


if(isset($_POST["temperature"]) && isset($_POST["humidity"]) && isset($_POST["moisture"])) {

	$t = $_POST["temperature"];
	$h = $_POST["humidity"];
	$m = $_POST["moisture"];

	$sql = "INSERT INTO smart_farm_data (temperature, humidity, moisture) VALUES (".$t.", ".$h.", ".$m.")"; 

	if (mysqli_query($connection, $sql)) { 
		echo "\nNew record created successfully"; 
	} else { 
		echo "Error: " . $sql . "<br>" . mysqli_error($conn); 
	}
}


?>