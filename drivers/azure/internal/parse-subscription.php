#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/azure/internal/include.php";

$subscription = parse_stdin_json_data();

$id = $subscription["id"];
$state = $subscription["state"];

if ($state == "Enabled")
	echo "$id\n";
