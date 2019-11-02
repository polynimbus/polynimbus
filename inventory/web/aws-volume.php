<?php

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) && preg_match('/^([a-z]{2}-[a-z]{4,9}-[0-9]{1})$/', $_GET["region"], $tmp2) && preg_match('/^(vol-[a-fA-F0-9]+)$/', $_GET["volume"], $tmp3)) {
	$account = $tmp1[1];
	$region = $tmp2[1];
	$volume = $tmp3[1];
	$enc1 = urlencode($account);
	$enc2 = urlencode($region);
} else
	die("Missing arguments...");

$file = "/var/cache/polynimbus/inventory/raw-aws-volumes-$account-$region.json";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$json = file_get_contents($file);
$data = json_decode($json, true);

require "include/page.php";
page_header("Polynimbus - AWS EC2 volume details");
echo "AWS account <a href=\"aws-account.php?account=$enc1\"><strong>$account</strong></a>, EC2 volume <strong>$volume</strong> in region <strong>$region</strong> as of $date:<br />\n";

foreach ($data["Volumes"] as $entry) {
	if ($entry["VolumeId"] == $volume) {
		$descr = json_encode($entry, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES);
		echo "<pre>$descr</pre>\n";
	}
}

page_end();
