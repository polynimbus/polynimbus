#!/usr/bin/php
<?php

$json = "";
$fp = fopen("php://stdin", "r");

while ($line = fgets($fp))
	$json .= $line;

fclose($fp);
$data = json_decode($json, true);

if (is_null($data))
	die("error: $json\n");


if ($argc > 1 && file_exists($argv[1]))
	$infile = file_get_contents($argv[1]);
else
	$infile = "";


foreach ($data["data"] as $image) {
	$id = $image["id"];
	$os = $image["operating-system"];
	$ver = $image["operating-system-version"];

	if (strpos($infile, $id) === false)
		file_put_contents($argv[1], "$id:$ver:$os\n", FILE_APPEND);
}
