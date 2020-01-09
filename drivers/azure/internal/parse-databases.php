#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

function azure_engine_type($raw) {
	switch ($raw) {
		case "Microsoft.Sql/servers": return "mssql";
		case "Microsoft.DBforMySQL/servers": return "mysql";
		case "Microsoft.DBforMariaDB/servers": return "mariadb";
		case "Microsoft.DBforPostgreSQL/servers": return "postgres";
		default: return "unknown";
	}
}

function azure_map_db_states($state) {
	return str_replace("Ready", "available", $state);
}

function azure_decode_db_state($db) {
	if (isset($db["state"]))
		$state = $db["state"];
	else if (isset($db["userVisibleState"]))
		$state = $db["userVisibleState"];
	else
		$state = "available";
	return azure_map_db_states($state);
}


$entries = parse_stdin_json_data();
foreach ($entries as $entry) {
	$dbhost = $entry["fullyQualifiedDomainName"];
	$dbport = "-";
	$dbname = $entry["name"];
	$dbuser = $entry["administratorLogin"];
	$zone = $entry["location"];
	$state = azure_decode_db_state($entry);
	$engine = azure_engine_type($entry["type"]);
	$version = $entry["version"];
	$id = basename($entry["id"]);
	$created = isset($entry["earliestRestoreDate"]) ? substr($entry["earliestRestoreDate"], 0, 10) : "-";
	$type = isset($entry["sku"]) ? $entry["sku"]["name"] : "-";
	$storage = isset($entry["sku"]) ? $entry["sku"]["tier"] : "-";
	$size = isset($entry["storageProfile"]) ? $entry["storageProfile"]["storageMb"]/1024 : "-";

	echo "$dbhost $dbport $dbname $dbuser $state $engine $version $storage $size $zone $type $id $created -\n";
}
