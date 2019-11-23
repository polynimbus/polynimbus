#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/azure/internal/include.php";

$zones = parse_stdin_json_data();

foreach ($zones as $zone) {
	$id = basename($zone["id"]);
	$name = $zone["name"];
	$group = $zone["resourceGroup"];
	$records = $zone["numberOfRecordSets"];
	echo "$name $id $records $group\n";
}
