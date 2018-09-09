#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 3)
	die("usage: $argv[0] <cloud-account> <ami-id> [...]\n");

$args = escapeshellarg($argv[2]);
for ($x = 3; $x < 64; $x++)
	if (!empty($argv[$x]))
		$args .= " ".escapeshellarg($argv[$x]);

$data = aws_request($argv[1], "ec2 describe-images --image-ids $args");

foreach ($data["Images"] as $image) {
	$id = $image["ImageId"];
	$full = $image["Name"];
	$name = basename($full);
	echo "$id $name\n";
}
