#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account>\n");

$data = aws_request($argv[1], "s3api list-buckets");

foreach ($data["Buckets"] as $user) {
	$name = $user["Name"];
	$created = substr($user["CreationDate"], 0, 10);
	echo "$name $created\n";
}
