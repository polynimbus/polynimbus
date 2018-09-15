#!/usr/bin/php
<?php

$name = $argv[1];
$type = $argv[2];
$key = $argv[3];
$region = $argv[4];
$image = $argv[5];

$fp = fopen("php://stdin", "r");

while ($line = fgets($fp)) {
	$ip = trim($line);

	if (empty($ip))
		continue;

	if (($rev = gethostbyaddr($ip)) !== false)
		$host = $rev;
	else
		$host = $ip;

	echo "$host pending $key $region $type $name $image\n";
}

fclose($fp);
