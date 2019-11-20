<?php

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp))
	$account = $tmp[1];
else
	die("Missing arguments...");

$path = "/var/cache/polynimbus/inventory";
$file = "$path/users-azure-$account.list";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$data = file_get_contents($file);
$lines = explode("\n", $data);

require "include/azure.php";
require "include/page.php";
page_header("Polynimbus - Azure account details");
echo "Azure account <strong>$account</strong> user list as of $date:<br />\n";
table_start("users", array(
	"username",
	"created",
	"token valid from",
	"type",
	"assigned role",
	"groups",
));

$memberships = load_azure_group_memberships($account);

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line);
	$mail = $tmp[0];
	$created = $tmp[1];
	$lastused = $tmp[2];
	$type = $tmp[3];
	$role = $tmp[4];
	$enabled = $tmp[5];

	if ($enabled != "enabled")
		$style = "background-color: #f4cccc;";
	else if ($type == "Member")
		$style = "background-color: #fcf3cf;";
	else
		$style = false;

	$groups_text = implode("<br />", $memberships[$mail]);
	table_row(array($mail, $created, $lastused, $type, $role, $groups_text), $style);
}

table_end("users");
page_end();
