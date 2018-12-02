<?php

function get_records_link($vendor, $account, $domain) {
	if ($vendor != "aws")
		return $domain;

	$file = "/var/cache/polynimbus/inventory/zone-aws-$account-$domain.zone";
	if (!file_exists($file))
		return $domain;

	$enc1 = urlencode($account);
	$enc2 = urlencode($domain);
	return "<a href=\"aws-domain.php?account=$enc1&domain=$enc2\">$domain</a>";
}


$file = "/var/cache/polynimbus/inventory/zones.list";
$date = date("Y-m-d H:i:s", filemtime($file));

require "include/page.php";
page_header("Polynimbus - cloud hosted zones inventory");
echo "<strong>List of all cloud hosted zones as of $date</strong><br />\n";
table_start("zones", array(
	"vendor",
	"account",
	"domain",
	"zone-id",
	"records",
));


$data = file_get_contents($file);
$lines = explode("\n", $data);

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line, 5);
	$vendor = $tmp[0];
	$account = get_account_link($vendor, $tmp[1]);

	table_row(array(
		$vendor,
		$account,
		get_records_link($vendor, $tmp[1], $tmp[2]),
		$tmp[3],  // zone-id
		$tmp[4],  // records count
	), false);
}

table_end("zones");
page_end();
