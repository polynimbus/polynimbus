#!/usr/bin/php
<?php

$fp = fopen("php://stdin", "r");

while ($line = fgets($fp)) {
	$line = trim($line);
	if (empty($line))
		continue;

	$cols = preg_split('/\s+/', $line, 6);
	$class = $cols[1];
	$modified = $cols[2];
	$size = $cols[4];
	$name = $cols[5];
	echo "\"$name\" $size $class $modified\n";
}

fclose($fp);
