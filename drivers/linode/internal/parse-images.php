#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/azure/internal/include.php";

$images = parse_stdin_json_data();

foreach ($images["data"] as $image) {

	// TODO: also filter out images past $image["eol"]
	if ($image["created_by"] != "linode" || $image["is_public"] != true || $image["deprecated"] === true)
		continue;

	$id = $image["id"];
	$size = $image["size"];
	$label = $image["label"];
	$vendor = $image["vendor"];
	$created = substr($image["created"], 0, 10);

	if (strpos($label, "Kubernetes") !== false)
		continue;

	echo sprintf("%-10s %-26s %10s %4d \"%s\"\n", $vendor, $id, $created, $size, $label);
}


/*
        {
            "created": "2014-04-17T19:42:07",
            "created_by": "linode",
            "deprecated": true,
            "description": null,
            "eol": "2019-10-23T04:00:00",
            "expiry": null,
            "id": "linode/ubuntu14.04lts",
            "is_public": true,
            "label": "Ubuntu 14.04 LTS",
            "size": 1500,
            "type": "manual",
            "vendor": "Ubuntu"
        },
*/
