#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$zones = parse_stdin_json_data();

foreach ($zones as $zone) {
	if ($zone["status"] != "ACTIVE")
		continue;

	$name = $zone["domain"];
	$records = -1;
	echo "$name $name $records -\n";
}
