<?php

$file = "/var/cache/polynimbus/inventory/object-storage.list";
$date = date("Y-m-d H:i:s", filemtime($file));

require "include/page.php";
require "include/aws.php";
require "include/account.php";
require "include/storage.php";
page_header("Polynimbus - object storage buckets inventory");
echo "<strong>List of all object storage buckets as of $date</strong><br />\n";
table_start("buckets", array(
	"vendor",
	"account",
	"region",
	"name",
	"created",
	"contract",
));

$data = file_get_contents($file);
$lines = explode("\n", $data);

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line, 7);
	$vendor = $tmp[0];
	$account = $tmp[1];
	$category = $tmp[2];

	table_row(array(
		"$vendor-$category",
		get_account_link($vendor, $account),
		get_region_link($vendor, $account, $tmp[3]),
		get_storage_link($vendor, $category, $account, $tmp[6], $tmp[4]),
		$tmp[5],  // created
		$tmp[6],  // contract, storage account etc.
	), false);
}

table_end("buckets");
page_end();
