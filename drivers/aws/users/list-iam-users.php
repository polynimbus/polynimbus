#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account>\n");

$data = aws_request($argv[1], "iam list-users");

foreach ($data["Users"] as $user) {
	$username = $user["UserName"];
	$created = substr($user["CreateDate"], 0, 10);
	$lastused = isset($user["PasswordLastUsed"]) ? substr($user["PasswordLastUsed"], 0, 10) : "-";
	echo "$username $created $lastused\n";
}
