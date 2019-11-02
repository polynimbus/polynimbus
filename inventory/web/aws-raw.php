<?php

require "include/page.php";
require "include/raw.php";
$allowed = aws_regional_raw_types();

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) && preg_match('/^([a-z]{2}-[a-z]{4,9}-[0-9]{1})$/', $_GET["region"], $tmp2) && isset($allowed[$_GET["type"]])) {
	$account = $tmp1[1];
	$region = $tmp2[1];
	$type = $_GET["type"];
	$enc1 = urlencode($account);
	$enc2 = urlencode($region);
} else
	die("Missing arguments...");

$file = "/var/cache/polynimbus/inventory/raw-aws-$type-$account-$region.json";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$json = file_get_contents($file);
$json = aws_apply_raw_links($account, $region, $json);

page_header("Polynimbus - AWS raw $type dump");
echo "AWS account <a href=\"aws-account.php?account=$enc1\"><strong>$account</strong></a>, raw <strong>$type</strong> dump in region <strong>$region</strong> as of $date:<br />\n";
echo "<pre>$json</pre>\n";
page_end();
