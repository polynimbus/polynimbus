#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 3)
	die("usage: $argv[0] <cloud-account> <pool-id> [region]\n");

$_pool = escapeshellarg($argv[2]);

if ($argc > 3) {
	$_region = escapeshellarg($argv[3]);
	$data = aws_request($argv[1], "cognito-idp list-users --user-pool-id $_pool --no-paginate --region $_region");
} else {
	$data = aws_request($argv[1], "cognito-idp list-users --user-pool-id $_pool --no-paginate");
}

foreach ($data["Users"] as $user) {
	$name = $user["Username"];
	$status = $user["UserStatus"];
	$created = $user["UserCreateDate"];
	$modified = $user["UserLastModifiedDate"];
	$attrs = "$name $status $created $modified";

	foreach ($user["Attributes"] as $attribute) {
		if ($attribute["Name"] != "sub") {
			$n = $attribute["Name"];
			$v = $attribute["Value"];
			$attrs .= " $n=$v";
		}
	}

	echo "$attrs\n";
}
