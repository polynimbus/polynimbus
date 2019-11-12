#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/azure/internal/include.php";

$shares = parse_stdin_json_data();
foreach ($shares as $share) {
	$name = $share["name"];
	$modified = substr($share["properties"]["lastModified"], 0, 10);
	echo "$name $modified\n";
}
