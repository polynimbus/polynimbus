#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account> [region]\n");

if ($argc > 2) {
	$_region = escapeshellarg($argv[2]);
	$data = aws_request($argv[1], "ec2 describe-instances --region $_region");
} else {
	$data = aws_request($argv[1], "ec2 describe-instances");
}

if (empty($data["Reservations"]))
	die();

foreach ($data["Reservations"] as $reservation) {
	aws_decode_reservation($reservation);
}
