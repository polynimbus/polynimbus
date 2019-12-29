#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account> [region]\n");

if ($argc > 2) {
	$_region = escapeshellarg($argv[2]);
	$data = aws_request($argv[1], "cloudtrail describe-trails --region $_region");
} else {
	$data = aws_request($argv[1], "cloudtrail describe-trails");
}

foreach ($data["trailList"] as $trail) {
	$name = $trail["Name"];
	$region = $trail["HomeRegion"];
	$target = $trail["S3BucketName"];
	$multi = $trail["IsMultiRegionTrail"] ? "multiregion" : "-";

	if ($argc < 3 || $argv[2] == $region)
		echo "$name $region $target $multi\n";
}
