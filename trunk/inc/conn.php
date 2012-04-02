<?php
include "config.php";

$dsn = 'mysql:host='.DB_HOST.';dbname='.DB_NAME;

try {
	$dbh = new PDO($dsn, DB_USER, DB_PASS);
}
catch (PDOException $e) {
	echo 'Connection failed: ', $e->getMessage();
}
?>