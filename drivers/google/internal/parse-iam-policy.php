#!/usr/bin/php
<?php

$json = "";
$fp = fopen("php://stdin", "r");

while ($line = fgets($fp))
	$json .= $line;

fclose($fp);
$data = json_decode($json, true);

if (is_null($data))
	die();

foreach ($data["bindings"] as $binding) {
	$members = $binding["members"];
	$role = substr($binding["role"], 6);
	foreach ($members as $member) {
		$tmp = explode(":", $member, 2);
		$type = $tmp[0];
		$address = $tmp[1];
		echo "$role $type $address\n";
	}
}
