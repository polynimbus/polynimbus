#!/usr/bin/php
<?php

$json = "";
$fp = fopen("php://stdin", "r");

while ($line = fgets($fp))
	$json .= $line;

fclose($fp);
$subscription = json_decode($json, true);

if (is_null($subscription))
	die("error: $json\n");


$id = $subscription["id"];
$state = $subscription["state"];

if ($state == "Enabled")
	echo "$id\n";
