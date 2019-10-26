#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account> [--raw]\n");

$data = aws_request($argv[1], "lambda list-functions");

if (@$argv[2] == "--raw") {
	echo json_encode($data, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES)."\n";
	die();
}

foreach ($data["Functions"] as $function) {
	$name = $function["FunctionName"];
	$runtime = $function["Runtime"];
	$modified = substr($function["LastModified"], 0, 10);

	$descr = "$name $runtime $modified";
	echo "$descr\n";
}
