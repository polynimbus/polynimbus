#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account>\n");

$data = aws_request($argv[1], "route53 list-hosted-zones");

if (empty($data["HostedZones"]))
	die();

foreach ($data["HostedZones"] as $zone) {
	$id = basename($zone["Id"]);
	$name = substr($zone["Name"], 0, -1);
	$records = $zone["ResourceRecordSetCount"];
	echo "$name $id $records\n";
}
