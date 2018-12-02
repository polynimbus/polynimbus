<?php
// TODO: supply vendor name as another parameter and support all vendors

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) && preg_match('/^([a-z0-9.-]+)$/', $_GET["domain"], $tmp2)) {
	$account = $tmp1[1];
	$domain = $tmp2[1];
	$enc = urlencode($account);
} else
	die("Missing arguments...");

$file = "/var/cache/polynimbus/inventory/zone-aws-$account-$domain.zone";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$data = file_get_contents($file);
$lines = explode("\n", $data);

require "include/page.php";
page_header("Polynimbus - domain $domain records");
echo "AWS account <a href=\"aws-account.php?account=$enc\"><strong>$account</strong></a>, domain <strong>$domain</strong> records as of $date:<br />\n";
table_start("domain", array(
	"name",
	"ttl",
	"type",
	"value",
));

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = preg_split('/\s+/', $line, 4);
	$name = $tmp[0];

	if (is_numeric($tmp[1])) {
		$ttl = $tmp[1];
		$type = $tmp[2];
		$value = $tmp[3];
	} else {
		$ttl = 300;
		$type = $tmp[1];
		$value = isset($tmp[3]) ? $tmp[2]." ".$tmp[3] : $tmp[2];
	}

	table_row(array(
		$name,
		$ttl,
		$type,
		$value,
	), false);
}

table_end("domain");
page_end();
