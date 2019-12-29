#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account> [user]\n");

if ($argc > 2) {
	$_user = escapeshellarg($argv[2]);
	$data = aws_request($argv[1], "iam list-groups-for-user --user-name $_user");
} else {
	$data = aws_request($argv[1], "iam list-groups");
}

foreach ($data["Groups"] as $group) {
	$groupname = $group["GroupName"];
	$created = substr($group["CreateDate"], 0, 10);
	echo "$groupname $created\n";
}
