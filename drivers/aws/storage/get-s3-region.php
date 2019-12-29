#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 3)
	die("usage: $argv[0] <cloud-account> <bucket>\n");

$_bucket = escapeshellarg($argv[2]);
$data = aws_request($argv[1], "s3api get-bucket-location --bucket $_bucket");

if (!empty($data["LocationConstraint"]))
	echo $data["LocationConstraint"]."\n";
else if (array_key_exists("LocationConstraint", $data))  // null value -> us-east-1
	echo "us-east-1\n";
else
	echo "-\n";
