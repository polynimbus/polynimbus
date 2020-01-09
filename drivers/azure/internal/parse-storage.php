#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$storage = parse_stdin_json_data();
foreach ($storage as $account) {
	$name = $account["name"];
	$region = $account["location"];
	$created = substr($account["creationTime"], 0, 10);
	echo "$region $name $created\n";
}
