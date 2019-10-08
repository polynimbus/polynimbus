<?php

function get_image_name($vendor, $image) {
	if ($vendor != "aws")
		return $image;

	$file = "/var/cache/polynimbus/aws/describe-images/$image.json";
	if (!file_exists($file))
		return $image;

	$json = file_get_contents($file);
	$data = json_decode($json, true);

	if (is_null($data) || !isset($data["Images"][0]["Name"]))
		return $image;
	else
		return basename($data["Images"][0]["Name"]);
}


$file = "/var/cache/polynimbus/inventory/instances.list";
$date = date("Y-m-d H:i:s", filemtime($file));

require "include/page.php";
require "include/acl.php";
page_header("Polynimbus - cloud instances inventory");
echo "<strong>List of all cloud instances as of $date</strong><br />\n";
table_start("instances", array(
	"vendor",
	"account",
	"hostname",
	"state",
	"created",
	"label",
	"ssh-key",
	"location",
	"instance-type",
	"instance-id",
	"image-name",
	"net",
	"ssh-acl",
));

$data = file_get_contents($file);
$lines = explode("\n", $data);

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line, 13);
	$vendor = $tmp[0];
	$account = get_account_link($vendor, $tmp[1]);
	$state = $tmp[3];
	$image = get_image_name($vendor, $tmp[8]);

	$style = ($state != "running" ? "background-color: #f4cccc;" : false);

	table_row(array(
		$vendor,
		$account,
		$tmp[2],
		$state,
		$tmp[9],
		str_replace(";", "<br />", $tmp[10]),
		$tmp[4],
		$tmp[5],
		$tmp[6],
		$tmp[7],
		$image,
		$tmp[11],
		map_acl_to_ranges($vendor, $tmp[1], 22, $tmp[12]),
	), $style);
}

table_end("instances");
page_end();
