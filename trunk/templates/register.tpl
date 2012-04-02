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
					<li class="current_page_item"><a href="index.php">Homepage</a></li>
				</ul>
			</div>
		</div>
		<!-- end #header -->
		<div id="page">
			<div id="content">
				<div class="post">
					<h2 class="title">Nowe konto</h2>
					<div style="clear: both;">&nbsp;</div>
					<div class="entry">
						{if $result eq 'success'}
							<div id="insert">
							<form enctype="multipart/form-data" action="register.php" method="post">
								<table>
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
										<td><input type="submit" id="insert-submit" value="Dodaj"/></td><td></td>
									</tr>
								</table>							
							</form>		
						</div>							
							<p>Konto założone poprawnie. Aby je aktywować odbierz maila i kliknij link aktywacyjny</p>
						{elseif $result eq 'fail'}
							<div id="insert">
							<form enctype="multipart/form-data" action="register.php" method="post">
								<table>
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
										<td><input type="submit" id="insert-submit" value="Dodaj"/></td><td></td>
									</tr>
								</table>							
							</form>		
						</div>
							<p>Założenie konta nie powiodło się</p>
			
						{else}
							<div id="insert">
							<form enctype="multipart/form-data" action="register.php" method="post">
								<table>
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
										<td><input type="submit" id="insert-submit" value="Dodaj"/></td><td></td>
									</tr>
								</table>							
							</form>	
						</div>							
						{/if}
					</div>
				</div>
			</div>
			<!-- end #content -->
			<div style="clear: both;">&nbsp;</div>
		</div>
		<!-- end #page -->
		<div id="footer">
			<p>Liczba filmów dodanych do bazy: {$total_cnt}</p>
		</div>
	</div>
</div>
<!-- end #footer -->
</body>
</html>