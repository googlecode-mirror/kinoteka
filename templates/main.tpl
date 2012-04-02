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
					{if $smarty.session.login eq 1 || isset($smarty.cookies.logged_as)}
						<li><a href="index.php?c=add">Nowy Film</a></li>
						<li><a href="admin.php" target="_blank">Panel</a></li>
					{else}
						<li><a href="register.php">Zarejestruj się</a></li>
					{/if}
				</ul>
			</div>
		</div>
		<!-- end #header -->
		<div id="page">
			<div id="content">
			{if $det eq 'display'}
				<div class="post">
				<h2 class="title">{$tytul_filmu}</h2>
				<div style="clear: both;">&nbsp;</div>
				<div class="entry">
					<p>
						<img src="{$img_link}" align="left" width=90 height=118 hspace=5/>
						<b>Reżyser:</b> {$rezyser}</br>
						<b>Rok:</b> {$rok}</br>
						<b>Gatunek:</b> {$gatunek}<br>
						<b>Dodał:</b> {$by}<br>
							</p>
						<p>	
						{$streszczenie}
						</p>
				</div>
			{elseif $action eq 'denyadd'}
				<div class="post">
					<h2 class="title">Nowy film</h2>
					<div style="clear: both;">&nbsp;</div>
					<div class="entry">
						<div id="insert">
							<p>Aby dodać nowy film musisz się zalogować"</p>
						</div>
					</div>
			{elseif $action eq 'add'}
				<div class="post">
					<h2 class="title">Nowy film</h2>
					<div style="clear: both;">&nbsp;</div>
					<div class="entry">
						<div id="insert">
							<form enctype="multipart/form-data" action="index.php" method="post">
								<table>
									<tr>
										<td>Tytuł</td>
										<td>
											<input type="text" id="insert-text" name="tytul" />
										</td>
									</tr>
									<tr>
										<td>Rok</td><td><input type="text" id="insert-text" name="rok" /></td>
									</tr>
									<tr>
										<td>Gatunek</td><td><input type="text" id="insert-text" name="gatunek" /></td>
									</tr>
									<tr>
										<td>Reżyser</td><td><input type="text" id="insert-text" name="rezyser" /></td>
									</tr>
									<tr>
										<td>Streszczenie</td><td><textarea id="insert-textarea" name="streszczenie"></textarea></td>
									</tr>
									<tr>
										<td>Okładka</td><td><input type="file" name="obrazek" /></td>
									</tr>
									<tr>
										<td><input type="submit" id="insert-submit" value="Dodaj"/></td><td></td>
									</tr>
							</table>
							</form>
						</div>
				</div>
			{elseif $flist eq 'titles'}
				<div class="post">
					<h2 class="title">Tytuły filmów</h2>
					<div style="clear: both;">&nbsp;</div>
					<div class="entry">
						{foreach from=$tytuly item=tf}
							<a href="index.php?t={$tf}">{$tf}</a></br>
						{/foreach}
					</div>
			{elseif $y_list eq 'years'}
				<div class="post">
					<h2 class="title">Tytuły filmów</h2>
					<div style="clear: both;">&nbsp;</div>
					<div class="entry">
						{foreach from=$tytuly item=tf}
							<a href="index.php?t={$tf}">{$tf}</a></br>
						{/foreach}
					</div>
			{else}
				<div class="post">
					{foreach from=$rows item=r}
						<h2 class="title">{$tytul_filmu[$r]}</h2>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
					<p>
						<img src="{$img_link[$r]}" align="left" width=90 height=118 hspace=5/>
						<b>Reżyser:</b> {$rezyser[$r]}</br>
						<b>Rok:</b> {$rok[$r]}</br>
						<b>Gatunek:</b> {$gatunek[$r]}<br>
						<b>Dodał:</b> {$by[$r]}<br>
							</p>
						<p>
						{$streszczenie[$r]}
						</p>
						</div>
						<div style="clear: both;">&nbsp;</div>
					{/foreach}
			{/if}
				</div>
			</div>
			<!-- end #content -->
			<div id="sidebar">
				<ul>
					<li>
					<h2>Logowanie</h2>
					<ul>
					{if $smarty.session.login eq 1}
						<li>Jesteś zalogowany jako <b>{$smarty.session.username}</li>
						<li><a href="index.php?s=logout">Wyloguj się</a></li>
					{else}
						<li>
						<table>
							<form name="logging" action="index.php" method="post">
								<tr>
									<td>Login: </td><td><input type="text" id="insert-text" name="user" /></td>
								</tr>
								<tr>
									<td>Hasło: </td><td><input type="password" id="insert-text" name="pass" /></td>
								</tr>
								<tr>
									<td></td><td><input type="submit" id="insert-submit" value="Zaloguj"/></td><td>
								</tr>
							</form>
						</table>
						</li>
						{if $pass_incorrect eq 'err_pass'}
							<li>Błędne hasło</li>
						{elseif $user_noexist eq 'nouser'}
							<li>Błędny login</li>
						{elseif $inactive eq 'user_inactive'}
							<li>Konto nieaktywne</li>
						{/if}
					{/if}
					</ul>
					</li>
					<li>
						<h2>Gatunki</h2>
						<ul>
							{foreach name=outer item=gat from=$gatunki}
								{foreach key=k item=it from=$gat}
									<li><a href="index.php?g={$k}">{$k}</a> ({$it})</li>
								{/foreach}
							{/foreach}
							<li><a href="index.php?g=all">Wszystkie</a> ({$total_cnt})</li>'
						</ul>
					</li>
					<li>
						<h2>Rok</h2>
						<ul>
							{foreach name=outer item=index from=$year}
								{foreach key=y item=ile from=$index}
									<li><a href="index.php?y={$y}">{$y}</a> ({$ile})</li>
								{/foreach}
							{/foreach}
						</ul>
					</li>
				</ul>
			</div>
			<!-- end #sidebar -->
			<div style="clear: both;">&nbsp;</div>
		</div>
		<!-- end #page -->
		<div id="footer">
			{if $user_login eq 'success'}
				<p>Liczba filmów dodanych do bazy: {$total_cnt} || Logged as: {$smarty.session.username}</p>
			{else}
				<p>Liczba filmów dodanych do bazy: {$total_cnt} || Logged as: guest</p>
			{/if}
		</div>
	</div>
</div>
<!-- end #footer -->
</body>
</html>