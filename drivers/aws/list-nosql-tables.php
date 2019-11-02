#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account> [region]\n");

if ($argc > 2) {
	$_region = escapeshellarg($argv[2]);
	$data = aws_request($argv[1], "dynamodb list-tables --region $_region");
} else {
	$data = aws_request($argv[1], "dynamodb list-tables");
}

foreach ($data["TableNames"] as $table)
	echo "dynamodb $table\n";
