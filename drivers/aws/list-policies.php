#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 4)
	die("usage: $argv[0] <cloud-account> <user/group> <name>\n");

$_name = escapeshellarg($argv[3]);

if ($argv[2] == "user")
{
	$data = aws_request($argv[1], "iam list-attached-user-policies --user-name $_name");
	foreach ($data["AttachedPolicies"] as $policy)
		echo $policy["PolicyName"]."\n";

	$data = aws_request($argv[1], "iam list-user-policies --user-name $_name");
	foreach ($data["PolicyNames"] as $policyname)
		echo ":$policyname\n";
}
else if ($argv[2] == "group")
{
	$data = aws_request($argv[1], "iam list-attached-group-policies --group-name $_name");
	foreach ($data["AttachedPolicies"] as $policy)
		echo $policy["PolicyName"]."\n";

	$data = aws_request($argv[1], "iam list-group-policies --group-name $_name");
	foreach ($data["PolicyNames"] as $policyname)
		echo ":$policyname\n";
}
else
{
	die("error: invalid mode, should either user or group\n");
}
