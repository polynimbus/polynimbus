#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$files = parse_stdin_json_data();

foreach ($files as $file) {
	$name = $file["name"];

	if (isset($file["type"]) && $file["type"] == "dir") {
		$size = "-";
		$name .= "/";
	} else {
		$size = $file["properties"]["contentLength"];
	}

	if (isset($file["properties"]["blobTier"])) {
		$class = $file["properties"]["blobTier"];
	} else {
		$class = "-";
	}

	if (isset($file["properties"]["lastModified"])) {
		$modified = substr($file["properties"]["lastModified"], 0, 10);
	} else {
		$modified = "-";
	}

	// blobs view
	if (isset($argv[1]) && $argv[1] == "--plain") {
		echo "\"$name\" $size $class $modified\n";

	// shares view - for easier recursive processing
	} else {
		if (isset($argv[1]))
			$name = $argv[1].$name;
		echo "$modified $class $size $name\n";
	}
}
