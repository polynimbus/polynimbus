#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account> [region]\n");

if ($argc > 2) {
	$_region = escapeshellarg($argv[2]);
	$data = aws_request($argv[1], "lambda list-functions --region $_region");
} else {
	$data = aws_request($argv[1], "lambda list-functions");
}

foreach ($data["Functions"] as $function) {
	$name = $function["FunctionName"];
	$runtime = $function["Runtime"];
	$modified = substr($function["LastModified"], 0, 10);
	echo "$name $runtime $modified -\n";
}
