<?php

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp))
	$account = $tmp[1];
else
	die("Missing arguments...");

$path = "/var/cache/polynimbus/inventory";
$file = "$path/users-aws-$account.list";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$data = file_get_contents($file);
$lines = explode("\n", $data);

$policies = file_get_contents("$path/policies-aws-$account.list");
$policies = preg_replace("#(.*) IAMUserChangePassword#", "", $policies);

require "include/aws.php";
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

	$data2 = get_aws_policy_link($policies, $account, "user", $username);
	if (!empty($data2))
		$permissions[] = str_replace("\n", "<br />", $data2);

	$groups = get_aws_groups_for_user("$path/membership-aws-$account.list", $username);
	foreach ($groups as $groupname) {
		$data2 = get_aws_policy_link($policies, $account, "group", $groupname);
		$space = empty($permissions) ? "" : "<br />";
		$permissions[] = "$space<b>[$groupname]</b><br />".str_replace("\n", "<br />", $data2);
	}

	$permissions_text = implode("<br />", $permissions);
	$permissions_text = highlight_critical_aws_policies($permissions_text);
	table_row(array($username, $created, $permissions_text));
}

table_end("users");
page_end();
