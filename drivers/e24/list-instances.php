#!/usr/bin/php
<?php

require_once "/opt/polynimbus/drivers/e24/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account>\n");

$account = $argv[1];

$e24 = e24client($account);
$response = $e24->describe_instances();

foreach ($response->body->reservationSet->item as $item) {
	$instance = $item->instancesSet->item;

	$id    = (string)$instance->instanceId;
	$type  = (string)$instance->instanceType;
	$host  = (string)$instance->dnsName;
	$image = (string)$instance->imageId;
	$state = (string)$instance->instanceState->name;

	$sshkey = "-ssh";
	$region = "-region";
	$cache  = "/var/cache/e24/$account-$id.dump";

	if (file_exists($cache)) {
		$json = file_get_contents($cache);
		$data = json_decode($json, true);

		if (isset($data["ssh"]) && isset($data["region"])) {
			$sshkey = $data["ssh"];
			$region = $data["region"];
		}
	}

	echo "$host $state $sshkey $region $type $id $image\n";
}
