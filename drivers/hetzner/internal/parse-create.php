#!/usr/bin/php
<?php

$fp = fopen("php://stdin", "r");

while ($line = fgets($fp)) {
	$ip = trim($line);

	if (empty($ip))
		continue;

	if (($rev = gethostbyaddr($ip)) !== false)
		$host = $rev;
	else
		$host = $ip;

	echo "$host\n";
}

fclose($fp);
