#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 3)
	die("usage: $argv[0] <cloud-account> <zone-id> [--raw]\n");

$_zone = escapeshellarg($argv[2]);
$data = aws_request($argv[1], "route53 list-resource-record-sets --hosted-zone-id $_zone");

if ($argc > 3 && $argv[3] == "--raw") {
	echo json_encode($data, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES)."\n";
	die();
}

foreach ($data["ResourceRecordSets"] as $set) {
	$ttl = $set["TTL"];
	$type = $set["Type"];
	$name = substr($set["Name"], 0, -1);
	$name = str_replace("\\052", "*", $name);

	if (isset($set["AliasTarget"]))
		echo sprintf("%-69s %-10s%s\n", $name, "CNAME", $set["AliasTarget"]["DNSName"]);

	else if (isset($set["ResourceRecords"]))
		foreach ($set["ResourceRecords"] as $record)
			if ($ttl == 300)
				echo sprintf("%-69s %-10s%s\n", $name, $type, $record["Value"]);
			else
				echo sprintf("%-62s %6s %-10s%s\n", $name, $ttl, $type, $record["Value"]);
}
