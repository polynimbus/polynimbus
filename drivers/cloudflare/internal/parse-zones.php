#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$zones = parse_stdin_json_data();

foreach (@$zones["result"] as $zone) {
	if ($zone["status"] != "active")
		continue;

	$id = $zone["id"];
	$name = $zone["name"];
	$records = -1;
	echo "$name $id $records -\n";
}
