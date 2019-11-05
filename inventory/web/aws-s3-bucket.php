<?php

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) && preg_match('/^([a-zA-Z0-9.-]+)$/', $_GET["bucket"], $tmp2)) {
	$account = $tmp1[1];
	$bucket = $tmp2[1];
	$enc = urlencode($account);
} else
	die("Missing arguments...");

$file = "/var/cache/polynimbus/inventory/s3-$account-$bucket.list";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$data = file_get_contents($file);
$lines = explode("\n", $data);

require "include/page.php";
page_header("Polynimbus - S3 bucket $bucket contents");
echo "AWS account <a href=\"aws-account.php?account=$enc\"><strong>$account</strong></a>, S3 bucket <strong>$bucket</strong> contents as of $date:<br />\n";
table_start("bucket", array(
	"fullname",
	"size",
	"tier",
	"modified",
));

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	preg_match('/\"(.+)\" ([0-9]+) (.+) ([0-9-]+)/', $line, $tmp);
	table_row(array(
		$tmp[1],  // name
		$tmp[2],  // size
		$tmp[3],  // class
		$tmp[4],  // modified
	), false);
}

table_end("bucket");
page_end();
