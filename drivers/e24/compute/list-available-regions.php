#!/usr/bin/php
<?php

require_once "/opt/polynimbus/drivers/e24/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account> [--full]\n");

$account = $argv[1];

$e24 = e24client($account);
$response = $e24->describe_regions();

foreach ($response->body->regionInfo->item as $item) {
	$region = (string)$item->regionName;
	$endpoint = (string)$item->regionEndpoint;

	if ($argc > 2 && $argv[2] == "--full")
		echo "$region\t$endpoint\n";
	else
		echo "$region\n";
}
