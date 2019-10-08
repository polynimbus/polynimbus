#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 5)
	die("usage: $argv[0] <cloud-account> <user/group> <name> <policy-name>\n");

$_name = escapeshellarg($argv[3]);
$_policy = escapeshellarg($argv[4]);

if ($argv[2] == "user") {
	$data = aws_request($argv[1], "iam get-user-policy --user-name $_name --policy-name $_policy");
} else if ($argv[2] == "group") {
	$data = aws_request($argv[1], "iam get-group-policy --group-name $_name --policy-name $_policy");
} else {
	die("error: invalid mode, should either user or group\n");
}

echo json_encode($data, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES)."\n";
