<?php

$vendors = array (
	"aws" => "AWS S3 bucket",
	"azure" => "Azure Storage",
);

if (isset($vendors[@$_GET["vendor"]]) &&
	preg_match('/^([a-z0-9]+)$/', $_GET["category"], $tmp0) &&
	preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) &&
	(empty(@$_GET["param1"]) || preg_match('/^([a-zA-Z0-9.-]+)$/', $_GET["param1"], $tmp2)) &&
	preg_match('/^([a-zA-Z0-9.-]+)$/', $_GET["param2"], $tmp3)) {

	$vendor = $_GET["vendor"];
	$label = $vendors[$vendor];
	$category = $tmp0[1];
	$account = $tmp1[1];
	$param2 = $tmp3[1];
	$params = empty(@$_GET["param1"]) ? $param2 : $tmp2[1]."-".$param2;
	$enc = urlencode($account);
} else
	die("Missing arguments...");

$file = "/var/cache/polynimbus/storage/$category-$account-$params.list";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$data = file_get_contents($file);
$lines = explode("\n", $data);

require "include/page.php";
page_header("Polynimbus - $label $param2 contents");
echo "Account <a href=\"$vendor-account.php?account=$enc\"><strong>$account</strong></a>, $label <strong>$param2</strong> contents as of $date:<br />\n";
table_start("files", array(
	"fullname",
	"size",
	"class",
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

table_end("files");
page_end();
