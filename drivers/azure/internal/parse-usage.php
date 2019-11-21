#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/azure/internal/include.php";

$entries = parse_stdin_json_data();
foreach ($entries as $entry) {
	$name = str_replace(" ", "_", $entry["localName"]);
	$value = $entry["currentValue"];
	$limit = $entry["limit"];
	$type = $entry["name"]["value"];
	echo "$name $value $limit $type\n";
}
