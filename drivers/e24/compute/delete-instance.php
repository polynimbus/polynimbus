#!/usr/bin/php
<?php

require_once "/opt/polynimbus/drivers/e24/internal/include.php";

if ($argc < 3)
	die("usage: $argv[0] <cloud-account> <instance-id>\n");

$account = $argv[1];
$instance = $argv[2];

$e24 = e24client($account);
$response = $e24->terminateInstances(array("InstanceId" => $instance));

if ($response->status != 200)
	print_r($response->body);
