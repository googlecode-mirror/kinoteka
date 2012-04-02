<?php
require_once "Mail.php";
include "inc/conn.php";

function genSalt() {
	$code = md5(uniqid(rand(), true));
	return substr($code, 0, 9);
}
function encPass($salt, $plain_pass) {
	CRYPT_MD5 == 1;
	return crypt($plain_pass, '$1$'.$salt.'$');
}
function genConfirmCode () {
	$code = md5(uniqid(rand(), true));
	$confirm_code = substr($code, 0, 50);
	return $confirm_code;
}
function sendConfirmURL($user_mail, $type, $code, $user_login, $user_pass) {
	$from = SITE_EMAIL;
	$to = $user_mail;
	if($type == 'newuser'){
		$subject = "[filmdb] Aktywacja konta";
		$body = "Witaj!\n\nAby aktywować konto kliknij: http://".DOMAIN_NAME."/confirm.php?scope=".$type."&code=".$code."\nlogin: ".$user_login."\npass: ".$user_pass."\n\n--\nTwoja baza filmów";
	}
	if($type == 'chpass') {
		$subject = "[filmdb] Zmiana hasła";
		$body = "Witaj!\n\nAby zmienić hasło kliknij: http://".DOMAIN_NAME."/confirm.php?scope=".$type."&code=".$code."\nlogin: ".$user_login."\npass: ".$user_pass."\n\n--\nTwoja baza filmów";
	}
	$headers = array(
		'From' => $from,
		'To' => $to,
		'Subject' => $subject
	);
	$smtp = Mail::factory('smtp', array('host' => SMTP_HOST));
	$mail = $smtp->send($to, $headers, $body);
}
?>