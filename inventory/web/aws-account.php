<?php

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp))
	$account = $tmp[1];
else
	die("Missing arguments...");

$highlight = array("AdministratorAccess", "AmazonEC2FullAccess", "EC2InstanceConnect", "AWSKeyManagementServicePowerUser", "Billing");

$path = "/var/cache/polynimbus/inventory";
$file = "$path/users-aws-$account.list";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$data = file_get_contents($file);
$lines = explode("\n", $data);

require "include/page.php";
page_header("Polynimbus - AWS account details");
echo "AWS account <strong>$account</strong> user list as of $date:<br />\n";
table_start("users", array("username", "created", "attached policies"));

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line);
	$username = $tmp[0];
	$created = $tmp[1];
	$permissions = array();

	$data2 = file_get_contents("$path/policies-aws-$account-user-$username.list");
	if (!empty($data2))
		$permissions[] = str_replace("\n", "<br />", $data2);

	$data2 = file_get_contents("$path/groups-aws-$account-$username.list");
	if (!empty($data2)) {
		$lines2 = explode("\n", $data2);
		foreach ($lines2 as $line2) {
			$tmp = explode(" ", $line2);
			$groupname = $tmp[0];

			$data3 = file_get_contents("$path/policies-aws-$account-group-$groupname.list");
			if (!empty($data3)) {
				$lines3 = explode("\n", $data3);
				array_unshift($lines3, "<b>[$groupname]</b>");
				$permissions[] = implode("<br />", $lines3);
			}
		}
	}

	$permissions_text = implode("<br />", $permissions);
	foreach ($highlight as $word)
		$permissions_text = preg_replace("#$word#", "<font color=\"red\">$word</font>", $permissions_text);
	table_row(array($username, $created, $permissions_text));
}

table_end("users");
page_end();
