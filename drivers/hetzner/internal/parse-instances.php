#!/usr/bin/php
<?php

function execute($script, $account, $param)
{
	$path = "/opt/polynimbus/drivers/hetzner";
	$_account = escapeshellarg($account);
	$_param = escapeshellarg($param);
	return trim(shell_exec("$path/$script $_account $_param"));
}


$account = $argv[1];

$fp = fopen("php://stdin", "r");

while ($line = fgets($fp)) {
	$cols = preg_split('/\s+/', $line);
	$ip = $cols[0];
	$state = $cols[1];
	$location = $cols[2];
	$id = $cols[3];
	$key = "-";

	if (($rev = gethostbyaddr($ip)) !== false)
		$host = $rev;
	else
		$host = $ip;

	if (preg_match('/^([a-zA-Z0-9._-]+)-[a-z0-9]{4}$/', $id, $tmp))
		$key = $tmp[1];

	$type = execute("get-instance-type.sh", $account, $id);
	$os = execute("get-instance-os.sh", $account, $id);

	echo "$host $state $key $location $type $id $os\n";
}

fclose($fp);
