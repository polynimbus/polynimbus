#!/usr/bin/php
<?php

function decode_instance($instance)
{
	$states = array(
		"RUNNING" => "running",
	);

	if (empty($instance["status"]))
		$state = "pending";
	else
		$state = str_replace(array_keys($states), array_values($states), $instance["status"]);

	$zone = basename($instance["zone"]);
	$type = basename($instance["machineType"]);
	$name = $instance["name"];
	$system = basename($instance["disks"][0]["licenses"][0]);
	$id = basename($instance["selfLink"]);
	$ip = @$instance["networkInterfaces"][0]["accessConfigs"][0]["natIP"];

	$tmp = explode("-", $name);
	$key = $tmp[0];

	if (empty($ip))
		$host = "-";
	else if (($rev = gethostbyaddr($ip)) !== false)
		$host = $rev;
	else
		$host = $ip;

# example output:
# 187.68.205.35.bc.googleusercontent.com running test2018 europe-west1-c f1-micro test2018-109f ubuntu-1804-lts

	echo "$host $state $key $zone $type $id $system\n";
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
