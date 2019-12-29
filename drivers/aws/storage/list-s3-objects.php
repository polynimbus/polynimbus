#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 3)
	die("usage: $argv[0] <cloud-account> <bucket>\n");

# TODO: implement pagination handling (currently only 1000 first entries are returned)
# https://docs.aws.amazon.com/cli/latest/reference/s3api/list-objects-v2.html

$_bucket = escapeshellarg($argv[2]);
$data = aws_request($argv[1], "s3api list-objects-v2 --no-paginate --bucket $_bucket");

foreach ($data["Contents"] as $object) {
	$name = $object["Key"];
	$size = $object["Size"];
	$class = $object["StorageClass"];
	$modified = substr($object["LastModified"], 0, 10);
	echo "\"$name\" $size $class $modified\n";
}
