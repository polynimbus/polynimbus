<?php

require "include/page.php";
require "include/aws.php";
require "include/raw.php";
$allowed = aws_global_raw_types();

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) && isset($allowed[$_GET["type"]])) {
	$account = $tmp1[1];
	$type = $_GET["type"];
	$enc = urlencode($account);
} else
	die("Missing arguments...");


$file = "/var/cache/polynimbus/inventory/$type-$account.json";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$json = file_get_contents($file);

page_header("Polynimbus - AWS $type details");
echo "AWS account <a href=\"aws-account.php?account=$enc\"><strong>$account</strong></a>, <strong>$type</strong> configuration as of $date:<br />\n";
echo "<pre>$json</pre>\n";
page_end();
