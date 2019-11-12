<?php

$file = "/var/cache/polynimbus/inventory/trails.list";
$date = date("Y-m-d H:i:s", filemtime($file));

require "include/page.php";
require "include/aws.php";
require "include/account.php";
require "include/storage.php";
page_header("Polynimbus - trails inventory");
echo "<strong>List of all trails as of $date</strong><br />\n";
table_start("trails", array(
	"vendor",
	"account",
	"name",
	"region",
	"bucket",
	"multi",
));

$data = file_get_contents($file);
$lines = explode("\n", $data);

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line, 6);
	$vendor = $tmp[0];
	$account = $tmp[1];

	table_row(array(
		$vendor,
		get_account_link($vendor, $account),
		$tmp[2],  // trail name
		$tmp[3],  // region
		get_storage_link($vendor, "s3", $account, false, $tmp[4]),
		$tmp[5],  // multi-region flag (or not)
	), false);
}

table_end("trails");
page_end();
