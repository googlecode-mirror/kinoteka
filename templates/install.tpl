<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--
Design by Free CSS Templates
http://www.freecsstemplates.org
Released for free under a Creative Commons Attribution 2.5 License

Name       : Simple World 
Description: A two-column, fixed-width design with dark color scheme.
Version    : 1.0
Released   : 20111225

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>{$site_title}</title>
<link href='http://fonts.googleapis.com/css?family=Ubuntu+Condensed' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Marvel' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Marvel|Delius+Unicase' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Arvo' rel='stylesheet' type='text/css'>
<link href="static/style.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
<div id="wrapper">
	<div id="wrapper2">
		<div id="header" class="container">
			<div id="logo">
				<h1><a href="#">Baza <span>Filmów</span></a></h1>
			</div>
			<div id="menu">
				<ul>
					<li class="current_page_item"><a href="#">Install</a></li>
				</ul>
			</div>
		</div>
		<!-- end #header -->
		<div id="page">
			<div id="content">
				<div class="post">
					<h2 class="title">Konfiguracja witryny</h2>
					<div style="clear: both;">&nbsp;</div>
					{if $result eq 'success'}
					<div class="entry">
						<p>Poniższą konfigurację należy zapisać w pliku: <b>inc/config.php</b></p>
						<p>&lt;?php<pre>
/*
Konfiguracja bazy filmów
*/
define('DB_HOST', '{$config.dbhost}');
define('DB_NAME', '{$config.dbname}');
define('DB_USER', '{$config.dbuser}');
define('DB_PASS', '{$config.dbpass}');

define('LAST_MOVIES', '5');
define('DOMAIN_NAME', '{$config.domain}');
define('SMTP_HOST', '{$config.mailhost}');
define('SITE_EMAIL', '{$config.sitemail}');
</pre>?&gt;</p>
					<p>Po zapisaniu konfiguracji możesz skasować plik install.php</p>
					</div>
					{elseif $result eq 'fail'}
					<div class="entry">
						<p>Instalacja się nie powiodła</p>
					</div>
					{elseif $result eq 'cfg_exists'}
					<div class="entry">
						<p>Witryna została już zainstalowana</p>
					</div>
					{else}
					<div class="entry">
						<div id="insert">
						<form enctype="multipart/form-data" action="install.php" method="post">
							<input type="hidden" name="installform" value="done" />
							<table>
								<caption><strong>Baza Danych</strong></caption>
								<tr>
									<td>Baza</td><td><input type="text" id="insert-text" name="dbname"/></td>
								</tr>									
								<tr>
									<td>Host</td><td><input type="text" id="insert-text" name="dbhost"/></td>
								</tr>
								<tr>
									<td>Login</td><td><input type="text" id="insert-text" name="dbuser"/></td>
								</tr>
								<tr>
									<td>Hasło</td><td><input type="password" id="insert-text" name="dbpass"/></td>
								</tr>
							</table>
							<table>
								<caption><strong>Mailing</strong></caption>
								<tr>
									<td>SMTP</td><td><input type="text" id="insert-text" name="mailhost"/></td>
								</tr>
								<tr>
									<td>e-mail</td><td><input type="text", id="insert-text" name="sitemail" /></td>
								</tr>
							</table>
							<table>
								<caption><strong>Konto administracyjne</strong></caption>
								<tr>
									<td>Login</td><td><input type="text" id="insert-text" name="login" /></td>
								</tr>
								<tr>
									<td>Hasło</td><td><input type="password" id="insert-text" name="pass" /></td>
								</tr>
								<tr>
									<td>Potwierdź</td><td><input type="password" id="insert-text" name="repass" /></td>
								</tr>
								<tr>
									<td>e-mail</td><td><input type="text" id="insert-text" name="email" /></td>
								</tr>
								<tr>
									<td><input type="submit" id="insert-submit" value="Instaluj"/></td><td></td>
								</tr>
							</table>							
						</form>	
						</div>							
					</div>
					{/if}
				</div>
			</div>
			<!-- end #content -->
			<div style="clear: both;">&nbsp;</div>
		</div>
		<!-- end #page -->
		<div id="footer">
			<p>Skrypt instalacyjny</p>
		</div>
	</div>
</div>
<!-- end #footer -->
</body>
</html>