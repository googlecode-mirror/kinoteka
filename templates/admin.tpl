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
				<h1><a href="index.php">Baza <span>Filmów</span></a></h1>
			</div>
			<div id="menu">
				<ul>
					<li class="current_page_item"><a href="index.php" target="_blank">Homepage</a></li>
				</ul>
			</div>
		</div>
		<!-- end #header -->
		<div id="page">
			<div id="content">
				<div class="post">
					<h2 class="title">Panel Administracyjny</h2>
					<div style="clear: both;">&nbsp;</div>
					{if $authuser eq 'unauth'}
						<div class="entry">
							<p>Przejdź do strony głównej aby się zalogować</p>
						</div>
					{elseif $action eq 'newpass'}
						<div class="entry">
							<form action="admin.php" name="npw" method="POST">
							<table>
								<tr>
									<td>Stare hasło</td><td><input type="password" name="oldpass" /></td>
								</tr>
								<tr>
									<td>Nowe hasło</td><td><input type="password" name="npass" /></td>
								</tr>
								<tr>
									<td>Potwierdź hasło</td><td><input type="password" name="confirmpass" /></td>
								</tr>
								<tr>
									<td><input type="submit" value="Zmień"></td><td></td>
								</tr>
							</table>
							</form>
						</div>
					{elseif $action eq 'delete'}
						<div class="entry">
							<form action="admin.php" method="POST">
							<input type="hidden" name="todel" value="selected" />
							<table>
								{foreach from=$films item=tf}
								<tr>
									<td><input type="checkbox" name="tytul_filmu[]" value="{$tf}"></td><td>{$tf}</td>
								</tr>
								{/foreach}
								<tr>
									<td><input type="submit" value="Kasuj"></td><td></td>
								</tr>
							</table>
							</form>
						</div>
					{else}
						<div class="entry">
						</div>
					{/if}
					{if $err eq 'password_mismatch'}
						<p>Nowe hasło się nie zgadza</p>
					{elseif $err eq 'oldpass_mismatch'}
						<p>Stare hasło się nie zgadza</p>
					{elseif $err eq 'msg_sent'}
						<p>Aby potwierdzić zmianę hasła kliknij link w mailu</p>
					{elseif $err eq 'deleteok'}
						<p><strong>Skasowane filmy</strong></p>
						<ul>
							{foreach from=$dtf item=t}
								<li>{$t}</li>
							{/foreach}
						</ul>
					{/if}
				</div>
			</div>
			<!-- end #content -->
			<div id="sidebar">
				<ul>
					<li>
					<h2>Konto</h2>
						<ul>
							{if $authuser eq 'unauth'}
								<li>Brak uprawnień</li>
							{else}
								<li>Jesteś zalogowany jako <b>{$authuser}</li>
								<li><a href="admin.php?action=newpass">Zmień hasło</a></li>
								<li><a href="admin.php?action=delete">Kasuj film</a></li>
								<li><a href="admin.php?action=logout">Wyloguj się</a></li>
							{/if}
						</ul>
					</li>
				</ul>
			</div>
			<!-- end #sidebar -->
			<div style="clear: both;">&nbsp;</div>
		</div>
		<!-- end #page -->
		<div id="footer">
			<p>Liczba filmów dodanych do bazy: {$total_cnt} || Logged as: {$authuser}</p>
		</div>
	</div>
</div>
<!-- end #footer -->
</body>
</html>