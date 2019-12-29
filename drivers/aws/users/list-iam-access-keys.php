#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 3)
	die("usage: $argv[0] <cloud-account> <user>\n");

$_user = escapeshellarg($argv[2]);
$data = aws_request($argv[1], "iam list-access-keys --user-name $_user");

foreach ($data["AccessKeyMetadata"] as $key) {
	$created = substr($key["CreateDate"], 0, 10);
	$keyid = $key["AccessKeyId"];

	$_keyid = escapeshellarg($keyid);
	$data2 = aws_request($argv[1], "iam get-access-key-last-used --access-key-id $_keyid");

	if ($data2["AccessKeyLastUsed"]["ServiceName"] != "N/A") {
		$lastused = substr($data2["AccessKeyLastUsed"]["LastUsedDate"], 0, 10);
		$service = $data2["AccessKeyLastUsed"]["ServiceName"];
	} else {
		$lastused = "-";
		$service = "-";
	}

	if ($data2["AccessKeyLastUsed"]["Region"] != "N/A") {
		$region = $data2["AccessKeyLastUsed"]["Region"];
	} else {
		$region = "-";
	}

	echo "$keyid $created $lastused $service $region\n";
}
