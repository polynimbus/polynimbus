<?php

require "include/page.php";
require "include/raw.php";
$allowed = global_raw_types();

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) && isset($allowed[$_GET["vendor"]][$_GET["type"]])) {
	$account = $tmp1[1];
	$vendor = $_GET["vendor"];
	$type = $_GET["type"];
	$enc = urlencode($account);
} else
	die("Missing arguments...");


$file = "/var/cache/polynimbus/inventory/raw-$vendor-$type-$account.json";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$json = file_get_contents($file);

page_header("Polynimbus - $type raw dump");
echo "Account <a href=\"$vendor-account.php?account=$enc\"><strong>$account</strong></a>, <strong>$type</strong> configuration as of $date:<br />\n";
echo "<pre>$json</pre>\n";
page_end();
