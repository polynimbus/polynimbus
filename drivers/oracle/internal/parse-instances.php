#!/usr/bin/php
<?php

require_once "/opt/polynimbus/drivers/oracle/internal/include.php";

$json = "";
$fp = fopen("php://stdin", "r");

while ($line = fgets($fp))
	$json .= $line;

fclose($fp);

if (empty($json))
	die();

$data = json_decode($json, true);

if (is_null($data))
	die("error: $json\n");

foreach ($data["data"] as $instance)
	decode_instance($instance);
