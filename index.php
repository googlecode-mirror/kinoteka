<?php
if(!file_exists("inc/config.php")) {
	header("Location: http://".$_SERVER['SERVER_NAME']."/install.php");
}
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
	$r = 0;
/**********************************************************************************
	Wyświetlanie ostatnio dodanych filmów do bazy. Liczba jest określona za pomocą
	stałej LAST_MOVIES zdefiniowanej w pliku config.php
***********************************************************************************/
	foreach($dbh->query('SELECT * FROM film ORDER BY id DESC LIMIT '.LAST_MOVIES) as $nowefilmy) {
		$tyt_t[] = $nowefilmy['tytul'];
		$img_t[] = $nowefilmy['obrazek'];
		$rez_t[] = $nowefilmy['rezyser'];
		$rok_t[] = $nowefilmy['rok'];
		$gat_t[] = $nowefilmy['gatunek'];
		$by_t[] = $nowefilmy['added_by'];
		$str_t[] = $nowefilmy['streszczenie'];
		$row_cnt[] = $r++;
	}
	$site->assign('tytul_filmu', $tyt_t);
	$site->assign('img_link', $img_t);
	$site->assign('rezyser', $rez_t);
	$site->assign('gatunek', $gat_t);
	$site->assign('by', $by_t);
	$site->assign('rok', $rok_t);
	$site->assign('streszczenie', $str_t);
	$site->assign('rows', $row_cnt);
	
/****************************************************************************
	Generowanie menu z gatunkami filmów wraz z liczbą filmów w danym gatunku
*****************************************************************************/	
	foreach($dbh->query("SELECT gatunek, count( tytul ) AS ilosc FROM film GROUP BY gatunek") as $row) {
		$gat_tab[] = array($row['gatunek'] => $row['ilosc']);
	}
	$site->assign('gatunki', $gat_tab);
/*********************************************************************************
	Generowanie menu z rokiem produkcji filmów wraz z liczbą filmów w danym roku
**********************************************************************************/
	foreach($dbh->query("SELECT rok, count( tytul ) AS ilosc FROM film GROUP BY rok ORDER BY rok DESC") as $row) {
		$year[] = array($row['rok'] => $row['ilosc']);
	}
	$site->assign('year', $year);
	$ch = array_keys($_GET);
	switch($ch[0]) {
		case "g":
/******************************************************
	Generowanie listy filmów na podstawie gatunku
*******************************************************/
			$site->assign('flist', 'titles');
			$kategoria = $_GET["g"];
			if($kategoria == 'all') {
				$sql = $dbh->prepare("SELECT tytul FROM film");
				$sql->execute();
			}
			else {
				$sql = $dbh->prepare("SELECT tytul FROM film WHERE gatunek=?");
				$sql->execute(array($_GET["g"]));
			}
			$filmy_lista = $sql->fetchAll();
			foreach($filmy_lista as $row) {
			$ttab[] = $row['tytul'];
			}
			$site->assign('tytuly', $ttab);
			break;
		case "y":
/************************************************************
	Generowanie listy filmów na podstawie roku produkcji
*************************************************************/
		$site->assign('y_list', 'years');
			$sql = $dbh->prepare("SELECT tytul FROM film WHERE rok=?");
			$sql->execute(array($_GET["y"]));
			$filmy_lista = $sql->fetchAll();
			foreach($filmy_lista as $row) {
				$ttab[] = $row['tytul'];
			}
			$site->assign('tytuly', $ttab);
			break;
		case "t":
/***********************************************************************
	Wyświetlanie pełnego opisu filmy ze zdjęciem oraz streszczeniem
*************************************************************************/
			$site->assign('tytul_filmu', $_GET["t"]);
			$site->assign('det','display');
			$sql = $dbh->prepare("SELECT * FROM film WHERE tytul=?");
			$sql->execute(array($_GET["t"]));
			$h_det = $sql->fetchAll();
			$site->assign('img_link', $h_det[0]["obrazek"]);
			$site->assign('rezyser', $h_det[0]["rezyser"]);
			$site->assign('rok', $h_det[0]["rok"]);
			$site->assign('gatunek', $h_det[0]["gatunek"]);
			$site->assign('by', $h_det[0]["added_by"]);
			$site->assign('streszczenie', $h_det[0]["streszczenie"]);
			break;
		case "c":
/*****************************************************
	Wyświetlanie formularza dodawania nowego filmuu
******************************************************/
			if($_SESSION["login"] == 1 || isset($_COOKIE["logged_as"])) {
				$site->assign('action', 'add');
			}
			else {
				$site->assign('action', 'denyadd');
			}
			break;
		case "s":
			if($_GET["s"] == 'logout') {
				$_SESSION['login'] = "";
				$_SESSION['username'] = "";
				session_destroy();
				setcookie('logged_as', '', time() - 86400);
				header('Location: http://'.DOMAIN_NAME.'/');
			}
			break;
	}
	if (isset($_POST["tytul"], $_POST["rok"], $_POST["gatunek"], $_POST["rezyser"], $_POST['streszczenie'], $_FILES['obrazek']['name'])) {
		$updir = './files/';
		$upfile = $updir . basename($_FILES['obrazek']['name']);
		move_uploaded_file($_FILES['obrazek']['tmp_name'], $upfile);
		$query = $dbh->prepare("INSERT INTO film(tytul,rok,gatunek,rezyser,streszczenie,obrazek,added_by) VALUES(?,?,?,?,?,?,?)");
		$query->execute(array($_POST["tytul"], $_POST["rok"], $_POST["gatunek"], $_POST["rezyser"], $_POST['streszczenie'], 'files/'.$_FILES['obrazek']['name'], $_SESSION["username"]));
	}
	if(empty($_SESSION["login"])) {
		if(isset($_POST["user"], $_POST["pass"])) {
			$sql = $dbh->query("SELECT pass,aktywny FROM users WHERE login='".$_POST["user"]."'");
			$count = $sql->rowCount();
			if($count > 0) {
				foreach($sql->fetchAll() as $login_info) {
					$md5pass = $login_info['pass'];
					$isActiveUser = $login_info['aktywny'];
				}
				$hash_split = explode("$", $md5pass);
				$salt = $hash_split[2];
				CRYPT_MD5 == 1;
				$input_pass = crypt($_POST["pass"], '$1$'.$salt.'$');
				if($md5pass == $input_pass) {
					if($isActiveUser == 1) {
						$_SESSION['login'] = 1;
						setcookie("logged_as", $_POST["user"], time() + 1440);
						$_SESSION['username'] = $_POST["user"];
						$site->assign('user_login', 'success');
						$site->assign('login_as', $_SESSION["username"]);
					}
					else {
						$_SESSION['login'] = "";
						$site->assign('inactive', 'user_inactive');
					}
				}
				else {
					$_SESSION['login'] = "";
					$site->assign('pass_incorrect', 'err_pass');
				}
			}
			else {
				$_SESSION['login'] = "";
				$site->assign('user_noexist', 'nouser');
			}
		}
	}
	else {
		$site->assign('user_login', 'success');
	}
}
catch (PDOException $e) {
	echo 'Connection failed: ', $e->getMessage();
}
$site->display('main.tpl');
?>