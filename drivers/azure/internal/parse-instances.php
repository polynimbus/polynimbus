#!/usr/bin/php
<?php

function replace_unicode($text) {
	$unicode = array(
		"\u017c" => "ż",
		"\u00f3" => "ó",
		"\u0142" => "ł",
		"\u0107" => "ć",
		"\u0119" => "ę",
		"\u015b" => "ś",
		"\u0105" => "ą",
		"\u017a" => "ź",
		"\u0144" => "ń",
		"\u017b" => "Ż",
		"\u00d3" => "Ó",
		"\u0141" => "Ł",
		"\u0106" => "Ć",
		"\u0118" => "Ę",
		"\u015a" => "Ś",
		"\u0104" => "Ą",
		"\u0179" => "Ź",
		"\u0143" => "Ń",
		" " => "_",
	);
	return str_replace(array_keys($unicode), array_values($unicode), $text);
}

function decode_instance($instance, $created)
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
	$offer = $instance["storageProfile"]["imageReference"]["offer"];
	$publisher = $instance["storageProfile"]["imageReference"]["publisher"];
	$version = $instance["storageProfile"]["imageReference"]["version"];
	$image = "$publisher:$offer:$sku:$version";

	$tmp = explode("-", $name);
	$key = $tmp[0];

	if (!empty($fqdn))
		$host = $fqdn;
	else if (!empty($ip))
		$host = $ip;
	else
		$host = "-";

	if (isset($created[$name]))
		$date = $created[$name];
	else
		$date = "-";

	$labels = array();
	foreach ($instance["tags"] as $lk => $lv)
		$labels[] = "$lk=$lv";
	$tags = empty($labels) ? "-" : replace_unicode(implode(";", $labels));

	echo "$host $state $key $zone $type $id $image $date $tags\n";
}


$json = "";
$fp = fopen("php://stdin", "r");

while ($line = fgets($fp))
	$json .= $line;

fclose($fp);
$data = json_decode($json, true);

if (is_null($data))
	die("error: $json\n");


$lines = explode("\n", file_get_contents($argv[1]));
$created = array();

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line);
	$created[$tmp[0]] = $tmp[1];
}

foreach ($data as $instance)
	decode_instance($instance, $created);
