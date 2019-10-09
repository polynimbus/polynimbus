<?php

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) && preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["policy"], $tmp2)) {
	$account = $tmp1[1];
	$policy = $tmp2[1];
	$enc = urlencode($account);
} else
	die("Missing arguments...");

if (preg_match('/^([a-zA-Z0-9.@_-]+)$/', $_GET["user"], $tmp)) {
	$type = "user";
	$name = $tmp[1];
} else if (preg_match('/^([a-zA-Z0-9.@_-]+)$/', $_GET["group"], $tmp)) {
	$type = "group";
	$name = $tmp[1];
} else
	die("Missing arguments...");

$file = "/var/cache/polynimbus/inventory/policy-aws-$account-$type-$name-$policy.json";

if (!file_exists($file))
	die("Invalid policy...");

$date = date("Y-m-d H:i:s", filemtime($file));
$json = file_get_contents($file);

require "include/page.php";
page_header("Polynimbus - AWS inline policy details");
echo "AWS account <a href=\"aws-account.php?account=$enc\"><strong>$account</strong></a>, inline security policy <strong>$policy</strong> as of $date:<br />\n";
echo "<pre>$json</pre>\n";
page_end();
