#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 3)
	die("usage: $argv[0] <cloud-account> <region>\n");

$_region = escapeshellarg($argv[2]);
$data = aws_request($argv[1], "kms list-keys --no-paginate --region $_region");

foreach ($data["Keys"] as $key) {
	$arn = $key["KeyArn"];
	echo "kms $arn\n";
}
