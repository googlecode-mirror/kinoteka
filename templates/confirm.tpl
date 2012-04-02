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
							<p>Aktywacja konta zakończyła się powodzeniem</p>
						{elseif $result eq 'passok'}
							<p>Hasło zostało zmienione</p>
						{elseif $result eq 'passnok'}
							<p>Zmiana hasła nie powiodła się</p>
						{elseif $result eq 'nocookie'}
							<p>Nieoczekiwany problem ze zmianą hasła</p>
						{else}
							<p>Aktywacja konta nie powiodła się</p>
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