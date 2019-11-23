<?php

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) && preg_match('/^([a-z0-9]{5,25})$/', $_GET["region"], $tmp2)) {
	$account = $tmp1[1];
	$region = $tmp2[1];
	$enc = urlencode($account);
} else
	die("Missing arguments...");

$file = "/var/cache/polynimbus/inventory/usage-azure-$account.list";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$data = file_get_contents($file);
$lines = explode("\n", $data);

require "include/azure.php";
require "include/page.php";
page_header("Polynimbus - Azure usage statistics");
echo "Azure account <strong>$account</strong> region <strong>$region</strong> usage statistics as of $date:<br />\n";
table_start("usage", array(
	"name",
	"value",
	"limit",
	"unit",
));

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line);
	if ($tmp[0] == $region) {
		$name = str_replace("_", " ", $tmp[1]);
		$value = $tmp[2];
		$limit = $tmp[3];
		$unit = $tmp[4];

		$style = ($value > 0 ? "background-color: #fcf3cf;" : false);
		table_row(array($name, $value, $limit, $unit), $style);
	}
}

table_end("usage");
page_end();
