#!/usr/bin/php
<?php

$fp = fopen("php://stdin", "r");

while ($line = fgets($fp)) {
	$cols = preg_split('/\s+/', $line);
	$ip = $cols[0];

	if (($rev = gethostbyaddr($ip)) !== false)
		$host = $rev;
	else
		$host = $ip;

	echo "$host $cols[1] - $cols[2] - $cols[3] -\n";
}

fclose($fp);
