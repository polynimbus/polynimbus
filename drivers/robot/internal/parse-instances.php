#!/usr/bin/php
<?php

function execute($script, $account, $param)
{
	$path = "/opt/polynimbus/drivers/robot";
	$_account = escapeshellarg($account);
	$_param = escapeshellarg($param);
	return trim(shell_exec("$path/$script $_account $_param"));
}


$account = $argv[1];

$lines = explode("\n", file_get_contents($argv[2]));
$created = array();

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line);
	$created[$tmp[0]] = $tmp[1];
}

$fp = fopen("php://stdin", "r");

while ($line = fgets($fp)) {
	$cols = preg_split('/\s+/', $line);
	$ip = $cols[0];
	$type = $cols[2];
	$id = $cols[4];
	$date = "-";
	$key = "-";
	$os = "-";

	if (($rev = gethostbyaddr($ip)) !== false && strpos($rev, ".") !== false)
		$host = $rev;
	else
		$host = $ip;

	$location = execute("get-instance-location.sh", $account, $id);
	$state = execute("get-instance-status.sh", $account, $id);
	$label = execute("get-instance-label.sh", $account, $id);

	if ($state == "ready")
		$state = "running";

	if ($label == "")
		$label = "-";

	if (isset($created[$id]))
		$date = $created[$id];

	echo "$host $state $key $location $type $id $os $date $label\n";
}

fclose($fp);
