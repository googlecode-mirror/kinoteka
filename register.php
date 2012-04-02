<?php
session_start();

require_once "Mail.php";
include "inc/conn.php";
include "inc/functions.php";
include('Smarty.class.php');

$q = $dbh->prepare("SELECT tytul FROM film");
$q->execute();
$total = $q->rowCount();

$site = new Smarty;

$site->assign('site_title', 'Baza filmów');
$site->assign('total_cnt', $total);

try {
	if (isset($_POST["login"], $_POST["pass"], $_POST["repass"], $_POST["email"])) {
		if($_POST["pass"] == $_POST["repass"]) {
			$md5_pass = encPass(genSalt(), $_POST["pass"]);
			$confirm_code = genConfirmCode();
			$query = $dbh->prepare("INSERT INTO users(login,pass,email,aktywny,confirm) VALUES(?,?,?,?,?)");
			$query->execute(array($_POST["login"], $md5_pass, $_POST["email"], 0, $confirm_code));
			sendConfirmURL($_POST["email"], 'newuser', $confirm_code, $_POST["login"], $_POST["pass"]);
			$site->assign('result','success');
		}
		else {
			$site->assign('result','fail');
		}
	}
}
catch (PDOException $e) {
	echo 'Connection failed: ', $e->getMessage();
}
$site->display('register.tpl');
?>