#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 3)
	die("usage: $argv[0] <cloud-account> <region>\n");

$region = $argv[2];
$_region = escapeshellarg($region);
$data = aws_request($argv[1], "kms list-keys --no-paginate --region $_region");

foreach ($data["Keys"] as $key) {
	$arn = $key["KeyArn"];
	echo "kms $region $arn\n";
}
