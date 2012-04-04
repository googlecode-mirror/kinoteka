<?php
include('Smarty.class.php');

function genSalt() {
	$code = md5(uniqid(rand(), true));
	return substr($code, 0, 9);
}
function encPass($salt, $plain_pass) {
	CRYPT_MD5 == 1;
	return crypt($plain_pass, '$1$'.$salt.'$');
}

$site = new Smarty;

$site->assign('site_title', 'Baza filmów :: Instalacja');
if(!file_exists("inc/config.php")) {
	if(isset($_POST['installform'])) {
		$cfg = array(
			'dbname' => $_POST['dbname'],
			'dbhost' => $_POST['dbhost'],
			'dbuser' => $_POST['dbuser'],
			'dbpass' => $_POST['dbpass'],
			'mailhost' => $_POST['mailhost'],
			'sitemail' => $_POST['sitemail'],
			'domain' => $_SERVER['SERVER_NAME']
		);
		try {
			$dbh = new PDO('mysql:dbname='.$_POST['dbname'].';host='.$_POST['dbhost'], $_POST['dbuser'], $_POST['dbpass']);
			$sql = $dbh->query("
			CREATE TABLE `film` (
			  `id` int(11) NOT NULL AUTO_INCREMENT,
			  `tytul` varchar(100) DEFAULT NULL,
			  `rok` int(4) DEFAULT NULL,
			  `rezyser` varchar(100) DEFAULT NULL,
			  `gatunek` varchar(50) NOT NULL,
			  `streszczenie` varchar(10000) DEFAULT NULL,
			  `obrazek` varchar(50) DEFAULT NULL,
			  `added_by` varchar(40) DEFAULT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=MyISAM AUTO_INCREMENT=194 DEFAULT CHARSET=latin1
			");
			$sql = $dbh->query("CREATE TABLE `users` (
			  `id` int(11) NOT NULL AUTO_INCREMENT,
			  `login` varchar(20) NOT NULL,
			  `pass` varchar(200) NOT NULL,
			  `email` varchar(60) NOT NULL,
			  `aktywny` int(1) NOT NULL,
			  `confirm` varchar(50) NOT NULL,
			  `confirm_pass` varchar(50) NOT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=latin1
			");
			if($_POST["pass"] == $_POST["repass"]) {
				$md5_pass = encPass(genSalt(), $_POST["pass"]);
				$query = $dbh->prepare("INSERT INTO users(login,pass,email,aktywny) VALUES(?,?,?,?)");
				$query->execute(array($_POST["login"], $md5_pass, $_POST["email"], 1));
				$site->assign('result','success');
				$site->assign('config', $cfg);
			}
			else {
				$site->assign('result','fail');
			}
		}
		catch (PDOException $e) {
			echo 'Connection failed: ', $e->getMessage();
		}
	}
}
else {
	$site->assign('result', 'cfg_exists');
}
$site->display('install.tpl');
?>