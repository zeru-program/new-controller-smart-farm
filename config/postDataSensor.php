<?php  
header('Content-Type: application/json');

include "db.php";

if(isset($_POST["temperatureDht1"]) && isset($_POST["humidityDht1"]) && isset($_POST["moisture"])) {
	$t = $_POST["temperatureDht1"];
	$h = $_POST["humidityDht1"];
	$m = $_POST["moisture"];

	$sql = "INSERT INTO smart_farm_data (temperature, humidity, moisture) VALUES (".$t.", ".$h.", ".$m.")"; 

	if (mysqli_query($connection, $sql)) { 
		echo "\nNew record created successfully"; 
	} else { 
		echo "Error: " . $sql . "<br>" . mysqli_error($conn); 
	}
}

?>