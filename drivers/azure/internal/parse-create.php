#!/usr/bin/php
<?php

function decode_create($instance)
{
	$states = array(
		"VM running" => "running",
	);

	if (empty($instance["powerState"]))
		$state = "pending";
	else
		$state = str_replace(array_keys($states), array_values($states), $instance["powerState"]);

	$id = basename($instance["id"]);
	$ip = $instance["publicIpAddress"];
	$fqdn = $instance["fqdns"];
	$zone = $instance["location"];
	$type = "-";
	$sku = "-";
	$key = "-";

	if (!empty($fqdn)) {
		$host = $fqdn;
		$tmp = explode("-", $fqdn);
		$key = $tmp[0];
	} else if (!empty($ip))
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
$instance = json_decode($json, true);

if (is_null($instance))
	die("error: $json\n");

decode_create($instance);
