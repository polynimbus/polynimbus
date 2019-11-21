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

function get_instance_link($vendor, $account, $region, $id) {
	if ($vendor != "aws")
		return $id;

	$region = substr($region, 0, -1);
	$file = "/var/cache/polynimbus/inventory/raw-aws-instances-$account-$region.json";
	if (!file_exists($file) || filesize($file) < 30)
		return $id;

	$enc1 = urlencode($account);
	$enc2 = urlencode($region);
	$enc3 = urlencode($id);
	return "<a href=\"aws-instance.php?account=$enc1&region=$enc2&id=$enc3\">$id</a>";
}


$file = "/var/cache/polynimbus/inventory/instances.list";
$date = date("Y-m-d H:i:s", filemtime($file));

require "include/page.php";
require "include/acl.php";
require "include/account.php";
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
	$account = $tmp[1];
	$state = $tmp[3];
	$style = ($state != "running" ? "background-color: #f4cccc;" : false);

	table_row(array(
		$vendor,
		get_account_link($vendor, $account),
		$tmp[2],
		$state,
		$tmp[9],
		str_replace(";", "<br />", $tmp[10]),
		$tmp[4],
		get_region_link($vendor, $account, $tmp[5]),
		$tmp[6],
		get_instance_link($vendor, $account, $tmp[5], $tmp[7]),
		get_image_name($vendor, $tmp[8]),
		$tmp[11],
		map_acl_to_ranges($vendor, $account, $tmp[5], 22, $tmp[12]),
	), $style);
}

table_end("instances");
page_end();
