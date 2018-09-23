#!/usr/bin/php
<?php

require_once "/opt/polynimbus/drivers/e24/internal/include.php";

if ($argc < 5)
	die("usage: $argv[0] <cloud-account> <ssh-key-name> <instance-type> <ami-id>\n");

$account = $argv[1];
$name = $argv[2];
$type = $argv[3];
$ami_id = $argv[4];


$e24 = e24client($account);
$response = $e24->run_instances($ami_id, 1, 1, array(
	"KeyName" => $name,
	"InstanceType" => $type,
));


if (empty($response->body->instancesSet))
	die("error: cannot create instance\n");

$id    = (string)$response->body->instancesSet->item->instanceId;
$image = (string)$response->body->instancesSet->item->imageId;
$state = (string)$response->body->instancesSet->item->instanceState->name;
$ip    = (string)$response->body->instancesSet->item->networkInterfaceSet->item->privateIpAddressesSet->item->association->publicIp;

if (empty($ip))
	$host = "-";
else if (($rev = gethostbyaddr($ip)) !== false)
	$host = $rev;
else if (strpos($ip, "178.216.") === false)
	$host = $ip;
else
	$host = "ip-" . str_replace(".", "-", $ip) . ".e24cloud.com";

$region = read_variable($account, "E24_REGION");
$date = date("Y-m-d");

echo "$host $state $name $region $type $id $image $date -\n";


$cache = "/var/cache/polynimbus/e24/$account-$id.dump";
$data = array(
	"ssh" => $name,
	"region" => $region,
	"response" => $response->body->instancesSet,
);

$json = json_encode($data, JSON_PRETTY_PRINT);
file_put_contents($cache, $json);
