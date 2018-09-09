#!/usr/bin/php
<?php

function decode_instance($instance)
{
	$states = array(
		"VM running" => "running",
	);

	if (empty($instance["powerState"]))
		$state = "pending";
	else
		$state = str_replace(array_keys($states), array_values($states), $instance["powerState"]);

	$zone = $instance["location"];
	$type = $instance["hardwareProfile"]["vmSize"];
	$name = $instance["name"];
	$fqdn = $instance["fqdns"];
	$ip = $instance["publicIps"];
	$id = basename($instance["id"]);
	$sku = $instance["storageProfile"]["imageReference"]["sku"];

	$tmp = explode("-", $name);
	$key = $tmp[0];

	if (!empty($fqdn))
		$host = $fqdn;
	else if (!empty($ip))
		$host = $ip;
	else
		$host = "-";

	echo "$host $state $key $zone $type $id $sku\n";
}


$json = "";
$fp = fopen("php://stdin", "r");

while ($line = fgets($fp))
	$json .= $line;

fclose($fp);
$data = json_decode($json, true);

if (is_null($data))
	die("error: $json\n");

foreach ($data as $instance)
	decode_instance($instance);
