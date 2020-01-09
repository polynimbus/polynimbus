#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$records = parse_stdin_json_data();
$domain = $argv[1];

foreach ($records["data"] as $record) {
	$ttl = $record["ttl_sec"];
	$name = $record["name"];
	$type = $record["type"];
	$value = $record["target"];

	if ($name == "")
		$name = $domain;
	else
		$name .= ".".$domain;

	if ($ttl == 300 || $ttl == 0)
		echo sprintf("%-69s %-10s%s\n", $name, $type, $value);
	else
		echo sprintf("%-62s %6s %-10s%s\n", $name, $ttl, $type, $value);
}


/*
        {
            "id": 14568528,
            "name": "",
            "port": 0,
            "priority": 10,
            "protocol": null,
            "service": null,
            "tag": null,
            "target": "aspmx.l.google.com",
            "ttl_sec": 0,
            "type": "MX",
            "weight": 0
        },
        {
            "id": 14568536,
            "name": "",
            "port": 0,
            "priority": 0,
            "protocol": null,
            "service": null,
            "tag": null,
            "target": "195.201.233.183",
            "ttl_sec": 0,
            "type": "A",
            "weight": 0
        },
        {
            "id": 14568538,
            "name": "web",
            "port": 0,
            "priority": 0,
            "protocol": null,
            "service": null,
            "tag": null,
            "target": "www.fake.com",
            "ttl_sec": 0,
            "type": "CNAME",
            "weight": 0
        },
*/
