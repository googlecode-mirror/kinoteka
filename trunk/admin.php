<?php
include "inc/conn.php";
include "inc/functions.php";
include('Smarty.class.php');
$site = new Smarty;

$q = $dbh->prepare("SELECT tytul FROM film");
$q->execute();
$total = $q->rowCount();

$site->assign('total_cnt', $total);
$site->assign('site_title', 'Baza filmów - Admin panel');
try {
	if(isset($_COOKIE['logged_as'])) {
		session_start();
		$site->assign('authuser', $_COOKIE['logged_as']);
		switch($_GET["action"]) {
			case 'logout':
				$_SESSION['login'] = "";
				$_SESSION['username'] = "";
				session_destroy();
				setcookie('logged_as', '', time() - 86400);
				header('Location: http://'.DOMAIN_NAME.'/');
			break;
			case 'newpass':
				$site->assign('action','newpass');
			break;
			case 'delete':
				$site->assign('action','delete');
				$sql = $dbh->query("SELECT tytul from film");
				foreach ($sql->fetchAll() as $r) {
					$tf[] = $r['tytul'];
				}
				$site->assign('films', $tf);
			break;
		}
		if(isset($_POST["oldpass"], $_POST['npass'], $_POST['confirmpass'])) {
			$confirm_code = genConfirmCode();
			$sql = $dbh->query("SELECT login,pass,email FROM users WHERE login='".$_COOKIE['logged_as']."'");
			$count = $sql->rowCount();
			if($count > 0) {
				foreach($sql->fetchAll() as $userdata) {
					$login = $userdata['login'];
					$md5pass = $userdata['pass'];
					$email = $userdata['email'];
				}
				$pw = explode('$', $md5pass);
				$salt = $pw[2];
				CRYPT_MD5 == 1;
				$oldpass = crypt($_POST['oldpass'], '$1$'.$salt.'$');
				if($oldpass == $md5pass) {
					if($_POST['npass'] == $_POST['confirmpass']) {
						$newpass = crypt($_POST['npass'], '$1$'.$salt.'$');
						setcookie('newpass', $newpass);
						$sql = $dbh->query("UPDATE users set confirm_pass='".$confirm_code."' WHERE login='".$login."'");
						sendConfirmURL($email, 'chpass', $confirm_code, $login, $_POST['npass']);
						$site->assign('err', 'msg_sent');
					}
					else {
						$site->assign('err','password_mismatch');
					}
				}
				else {
					$site->assign('err', 'oldpass_mismatch');
				}
			}
		}
		if(isset($_POST['todel'])) {
			foreach($_POST['tytul_filmu'] as $t) {
				$sql = $dbh->query("SELECT obrazek FROM film WHERE tytul='".$t."'");
				$obrazek = $sql->fetchColumn();
				unlink($obrazek);
				$sql = $dbh->query("DELETE FROM film WHERE tytul='".$t."'");
				$site->assign('err', 'deleteok');
				$site->assign('dtf', $_POST['tytul_filmu']);
			}
		}
		
	}
	else {
		$site->assign('authuser', 'unauth');
	}
}
catch (PDOException $e) {
	echo 'Connection failed: ', $e->getMessage();
}
$site->display('admin.tpl');
?>