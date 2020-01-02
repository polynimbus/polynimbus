#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/azure/internal/include.php";

$records = parse_stdin_json_data();

foreach (@$records["result"] as $record) {
	$ttl = $record["ttl"];
	$type = $record["type"];
	$name = $record["name"];
	$value = $record["content"];

	if ($ttl == 300 || $ttl == 1)
		echo sprintf("%-69s %-10s%s\n", $name, $type, $value);
	else
		echo sprintf("%-62s %6s %-10s%s\n", $name, $ttl, $type, $value);
}
