#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/azure/internal/include.php";

$records = parse_stdin_json_data();
$domain = $argv[1];

foreach ($records as $record) {
	$ttl = $record["ttl"];
	$type = $record["type"];
	$name = $record["name"];
	$value = $record["data"];

	if ($name == "@")
		$name = $domain;
	else
		$name .= ".".$domain;

	if ($value == "@")
		$value = $domain;
	else if ($value != "Parked" && strpos($value, ".") === false)
		$value .= ".".$domain;

	if ($ttl == 300)
		echo sprintf("%-69s %-10s%s\n", $name, $type, $value);
	else
		echo sprintf("%-62s %6s %-10s%s\n", $name, $ttl, $type, $value);
}
