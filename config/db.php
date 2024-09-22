<?php

$host = "localhost";
$username = "root";
$password = "";
$database = "smart_farm";

$connection = mysqli_connect($host, $username, $password, $database);

if (!$connection) {
    die("Connection failed : " . mysqli_connect_error());
}  



if (isset($_GET['status'])) {
   echo("connect"); 
}

?>
