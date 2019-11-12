#!/usr/bin/php
<?php

function request($account, $storage, $share, $path = "")
{
	$cmd = "/opt/polynimbus/drivers/azure/list-storage-files.sh $account $storage $share $path";
	$result = shell_exec($cmd);

	if (!empty($result)) {
		$lines = explode("\n", $result);
		foreach ($lines as $line) {
			$line = trim($line);
			if (empty($line))
				continue;

			$tmp = explode(" ", $line, 4);
			$name = $tmp[3];
			$last = substr($name, -1);
			if ($last == "/") {
				request($account, $storage, $share, escapeshellarg($name));
			} else {
				echo "\"$name\" $tmp[2] $tmp[1] $tmp[0]\n";
			}
		}
	}
}


if ($argc < 4)
	die("usage: $argv[0] <cloud-account> <storage-account> <share-name>\n");

$_account = escapeshellarg($argv[1]);
$_storage = escapeshellarg($argv[2]);
$_share   = escapeshellarg($argv[3]);
request($_account, $_storage, $_share);
