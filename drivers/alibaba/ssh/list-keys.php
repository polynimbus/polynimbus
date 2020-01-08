#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/alibaba/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account>\n");

$data = alibaba_request($argv[1], "DescribeKeyPairs");

foreach ($data["KeyPairs"] as $pair)
	echo $pair[0]["KeyPairName"]."\n";
