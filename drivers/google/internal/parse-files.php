#!/usr/bin/php
<?php

$fp = fopen("php://stdin", "r");

while ($line = fgets($fp)) {
	$line = trim($line);
	if (empty($line))
		continue;

	$cols = preg_split('/\s+/', $line, 3);
	$size = $cols[0];
	$modified = substr($cols[1], 0, 10);
	$tmp = explode("/", $cols[2], 4);
	$name = $tmp[3];
	echo "\"$name\" $size - $modified\n";
}

fclose($fp);
