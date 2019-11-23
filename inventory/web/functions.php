<?php

function get_function_link($vendor, $account, $region, $function)
{
	if ($vendor == "aws")
	{
		$file = "/var/cache/polynimbus/inventory/raw-aws-functions-$account-$region.json";
		if (!file_exists($file) || filesize($file) < 30)
			return $function;

		$enc1 = urlencode($account);
		$enc2 = urlencode($region);
		$enc3 = urlencode($function);
		return "<a href=\"aws-function.php?account=$enc1&region=$enc2&function=$enc3\">$function</a>";
	}

	if ($vendor == "azure")
	{
		$file = "/var/cache/polynimbus/inventory/raw-azure-functions-$account-$function-details.json";
		if (!file_exists($file) || filesize($file) < 30)
			return $function;

		$enc1 = urlencode($account);
		$enc3 = urlencode($function);
		return "<a href=\"azure-function.php?account=$enc1&function=$enc3\">$function</a>";
	}

	return $function;
}


$file = "/var/cache/polynimbus/inventory/functions.list";
$date = date("Y-m-d H:i:s", filemtime($file));

require "include/page.php";
require "include/account.php";
page_header("Polynimbus - serverless functions inventory");
echo "<strong>List of all serverless functions as of $date</strong><br />\n";
table_start("functions", array(
	"vendor",
	"account",
	"location",
	"name",
	"runtime",
	"modified",
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
	$region = $tmp[2];

	table_row(array(
		$vendor,
		get_account_link($vendor, $account),
		get_region_link($vendor, $account, $region),
		get_function_link($vendor, $account, $region, $tmp[3]),
		$tmp[4],  // runtime
		$tmp[5],  // modified
	), false);
}

table_end("functions");
page_end();
