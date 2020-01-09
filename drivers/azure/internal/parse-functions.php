#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$functions = parse_stdin_json_data();

function reverse_location_name($location) {
	$file = "/var/cache/polynimbus/azure/locations.cache";
	if (file_exists($file)) {
		$json = file_get_contents($file);
		$data = json_decode($json, true);
		if (!empty($data))
			foreach ($data as $entry)
				if ($entry["displayName"] == $location)
					return $entry["name"];
	}

	return str_replace(" ", "", strtolower($location));
}

foreach ($functions as $function) {
	$region = reverse_location_name($function["location"]);
	$name = $function["name"];
	$runtime = $function["kind"];
	$modified = substr($function["lastModifiedTimeUtc"], 0, 10);
	$group = $function["resourceGroup"];
	echo "$region $name $runtime $modified $group\n";
}
