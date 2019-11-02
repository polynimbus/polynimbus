#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account> [region]\n");

if ($argc > 2) {
	$_region = escapeshellarg($argv[2]);
	$data = aws_request($argv[1], "cognito-idp list-user-pools --max-results 60 --region $_region");
} else {
	$data = aws_request($argv[1], "cognito-idp list-user-pools --max-results 60");
}

foreach ($data["UserPools"] as $pool) {
	$name = $pool["Name"];
	$id = $pool["Id"];
	$created = $pool["CreationDate"];
	$modified = $pool["LastModifiedDate"];
	echo "$name $id $created $modified\n";
}
