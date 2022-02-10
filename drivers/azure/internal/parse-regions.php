#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$regions = parse_stdin_json_data();
foreach ($regions as $region) {
	$name = $region["name"];
	echo "$name\n";
}
