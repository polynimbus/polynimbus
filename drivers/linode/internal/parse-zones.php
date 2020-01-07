#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/azure/internal/include.php";

$zones = parse_stdin_json_data();

foreach ($zones["data"] as $zone) {
	$name = $zone["domain"];
	$id = $zone["id"];
	$records = -1;
	echo "$name $id $records -\n";
}


/*
        {
            "axfr_ips": [],
            "description": "",
            "domain": "fake.com",
            "expire_sec": 0,
            "group": "",
            "id": 1321097,
            "master_ips": [],
            "refresh_sec": 0,
            "retry_sec": 0,
            "soa_email": "linode-dns@tomaszklim.pl",
            "status": "active",
            "tags": [],
            "ttl_sec": 0,
            "type": "master"
        }
*/
