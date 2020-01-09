#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$buckets = parse_stdin_json_data();

foreach ($buckets["data"] as $bucket) {
	$cluster = $bucket["cluster"];
	$label = $bucket["label"];
	$created = substr($bucket["created"], 0, 10);
	echo "$cluster $label $created\n";
}
