<?php
session_start();

include "inc/conn.php";
include('Smarty.class.php');

$q = $dbh->prepare("SELECT tytul FROM film");
$q->execute();
$total = $q->rowCount();

$site = new Smarty;

$site->assign('site_title', 'Baza filmów');
$site->assign('total_cnt', $total);

try {
	$action = $_GET['scope'];
	switch($action) {
		case 'newuser':
			$q = $dbh->query("SELECT confirm FROM users WHERE confirm='".$_GET["code"]."'");
			$cnt = $q->rowCount();
			if($cnt > 0) {
				$q = $dbh->query("UPDATE users set aktywny = 1 WHERE confirm='".$_GET["code"]."'");
				$site->assign('result', 'success');
			}
			else {
				$site->assign('result','fail');
			}
		break;
		case 'chpass':
			$q = $dbh->query("SELECT confirm_pass FROM users WHERE confirm_pass='".$_GET['code']."'");
			$cnt = $q->rowCount();
			if($cnt > 0) {
				if(isset($_COOKIE['newpass'])) {
					$q = $dbh->query("UPDATE users SET pass='".$_COOKIE['newpass']."' WHERE confirm_pass='".$_GET['code']."'");
					$site->assign('result', 'passok');
				}
				else {
					$q->assign('result', 'nocookie');
				}
			}
			else {
				$site->assign('result', 'passnok');
			}
			setcookie('newpass', '', time() - 86400);
		break;
	}
}
catch (PDOException $e) {
	echo 'Connection failed: ', $e->getMessage();
}
$site->display('confirm.tpl');
?>