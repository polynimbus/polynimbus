<?php

function page_header($title) {
	echo "<!DOCTYPE html>
<html>
<head>
	<title>$title</title>
	<meta http-equiv=\"X-UA-Compatible\" content=\"chrome=1\">
	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />
	<link rel=\"shortcut icon\" href=\"assets/favicon.png\">
	<link rel=\"stylesheet\" href=\"assets/style.css\" type=\"text/css\" media=\"screen, all\" />
	<script type=\"text/javascript\" src=\"assets/jquery-1.9.1.min.js\"></script>
	<script type=\"text/javascript\" src=\"assets/jquery.tablesorter.min.js\"></script>
</head>
<body style=\"font-size:11px;font-family:verdana,helvetica,arial,sans-serif;\">
";
}

function table_start($id, $columns) {
	echo "<table id=\"$id\" class=\"tablesorter\">\n";
	echo "\t<thead>\n";
	echo "\t<tr>\n";
	foreach ($columns as $column)
		echo "\t\t<th>$column</th>\n";
	echo "\t</tr>\n";
	echo "\t</thead>\n";
	echo "\t<tbody>\n";
}

function table_row($values, $style = false) {
	echo "\t<tr>\n";
	foreach ($values as $value)
		if ($style)
			echo "\t\t<td style=\"$style\">$value</td>\n";
		else
			echo "\t\t<td>$value</td>\n";
	echo "\t</tr>\n";
}

function table_end($id) {
	echo "\t</tbody>\n";
	echo "</table>\n\n";
	echo "<script>\n";
	echo "jQuery(document).ready(function() {\n";
	echo "\tjQuery(\"#$id\").tablesorter();\n";
	echo "});\n";
	echo "</script>\n\n";
}

function page_end() {
	echo "\n</body>\n</html>\n";
}

function get_account_link($vendor, $account) {
	if ($vendor != "aws")
		return $account;

	$file = "/var/cache/polynimbus/inventory/users-aws-$account.list";
	if (!file_exists($file))
		return $account;

	$enc = urlencode($account);
	return "<a href=\"aws-account.php?account=$enc\">$account</a>";
}
