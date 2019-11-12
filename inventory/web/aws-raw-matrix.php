<?php

require "include/page.php";
require "include/acl.php";
require "include/aws.php";
require "include/raw.php";
require "include/account.php";
page_header("Polynimbus - AWS raw data matrix");
echo "<strong>List of all AWS raw data dumps</strong><br />\n";

$regions = aws_region_list();
$dumps = aws_regional_raw_types();

$path = "/var/cache/polynimbus/inventory";
$file = "$path/projects-aws.list";
$data = file_get_contents($file);
$lines = explode("\n", $data);

$verses = array();
$used = array();

foreach ($lines as $line) {
	$line = trim($line);
	if (empty($line))
		continue;

	$tmp = explode(" ", $line, 17);
	$account = $tmp[0];
	$accountLink = get_account_link("aws", $account);
	$columns = array("account" => $accountLink);

	foreach ($regions as $region) {
		$links = array();
		foreach ($dumps as $dumpName => $minSize) {

			$dumpFile = "$path/raw-aws-$dumpName-$account-$region.json";
			if (file_exists($dumpFile) && filesize($dumpFile) > $minSize) {
				$enc1 = urlencode($account);
				$enc2 = urlencode($region);
				$links[] = "<a href=\"aws-raw.php?account=$enc1&region=$enc2&type=$dumpName\">$dumpName</a>";
				$used[$region] = true;
			}
		}

		$html = implode(", \n", $links);
		$columns[$region] = $html;
	}
	$verses[] = $columns;
}


$headers = array("account");
foreach ($regions as $region)
	if (isset($used[$region]))
		$headers[] = $region;
table_start("raw", $headers);

foreach ($verses as $verse) {
	$columns = array($verse["account"]);
	foreach ($regions as $region)
		if (isset($used[$region]))
			$columns[] = $verse[$region];
	table_row($columns, false);
}

table_end("raw");
page_end();
