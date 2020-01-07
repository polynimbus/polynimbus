#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/azure/internal/include.php";

$types = parse_stdin_json_data();

echo "ID                 CPU   MEM     DISK  PRICE NAME\n";

foreach ($types["data"] as $type) {
	$id = $type["id"];
	$label = $type["label"];
	$disk = $type["disk"];
	$memory = $type["memory"];
	$cpu = $type["vcpus"];
	$price = round($type["price"]["monthly"], 0);

	echo sprintf("%-18s %3d %6d %8d %5d \"%s\"\n", $id, $cpu, $memory, $disk, $price, $label);
}


/*
        {
            "class": "nanode",
            "disk": 25600,
            "gpus": 0,
            "id": "g6-nanode-1",
            "label": "Nanode 1GB",
            "memory": 1024,
            "network_out": 1000,
            "price": {
                "hourly": 0.0075,
                "monthly": 5.0
            },
            "successor": null,
            "transfer": 1000,
            "vcpus": 1
        },{
            "class": "gpu",
            "disk": 655360,
            "gpus": 1,
            "id": "g1-gpu-rtx6000-1",
            "label": "Dedicated 32GB + RTX6000 GPU x1",
            "memory": 32768,
            "network_out": 10000,
            "price": {
                "hourly": 1.5,
                "monthly": 1000.0
            },
            "successor": null,
            "transfer": 16000,
            "vcpus": 8
        },
*/
