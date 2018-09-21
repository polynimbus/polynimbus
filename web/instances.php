<?php

$file = "/var/cache/polynimbus/inventory/instances.list";
$date = date("Y-m-d H:i:s", filemtime($file));


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


require "include.php";
page_header("Polynimbus - cloud instances inventory");
echo "<strong>List of all cloud instances as of $date</strong><br />\n";
table_start("instances", array(
	"vendor",
	"account",
	"hostname",
	"state",
	"ssh-key",
	"location",
	"instance-type",
	"instance-id",
	"image-name",
	"optional",
));

$data = file_get_contents($file);
$lines = explode("\n", $data);

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$style = false;
	$tmp = explode(" ", $line, 10);
	$vendor = $tmp[0];
	$account = $tmp[1];
	$state = $tmp[3];
	$image = get_image_name($vendor, $tmp[8]);

	if ($state != "running")
		$style = "background-color: #f4cccc;";

	if ($vendor == "aws") {
		$enc = urlencode($account);
		$account = "<a href=\"aws-account.php?account=$enc\">$account</a>";
	}

	table_row(array(
		$vendor,
		$account,
		$tmp[2],
		$state,
		$tmp[4],
		$tmp[5],
		$tmp[6],
		$tmp[7],
		$image,
		$tmp[9],
	), $style);
}

table_end("instances");
page_end();