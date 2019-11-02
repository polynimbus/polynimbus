<?php

$file = "/var/cache/polynimbus/inventory/object-storage.list";
$date = date("Y-m-d H:i:s", filemtime($file));

require "include/page.php";
require "include/aws.php";
page_header("Polynimbus - object storage buckets inventory");
echo "<strong>List of all object storage buckets as of $date</strong><br />\n";
table_start("buckets", array(
	"vendor",
	"account",
	"name",
	"created",
));

$data = file_get_contents($file);
$lines = explode("\n", $data);

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line, 5);
	$vendor = $tmp[0];
	$category = $tmp[2];
	$account = get_account_link($vendor, $tmp[1]);

	table_row(array(
		"$vendor-$category",
		$account,
		get_s3_bucket_link($vendor, $category, $tmp[1], $tmp[3]),
		$tmp[4],  // created
	), false);
}

table_end("buckets");
page_end();
