<?php

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) && preg_match('/^([a-z]{2}-[a-z]{4,9}-[0-9]{1})$/', $_GET["region"], $tmp2) && preg_match('/^(i-[a-f0-9]+)$/', $_GET["id"], $tmp3)) {
	$account = $tmp1[1];
	$region = $tmp2[1];
	$id = $tmp3[1];
	$enc = urlencode($account);
} else
	die("Missing arguments...");

$file = "/var/cache/polynimbus/inventory/raw-aws-instances-$account-$region.json";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$json = file_get_contents($file);
$data = json_decode($json, true);

require "include/page.php";
require "include/raw.php";
page_header("Polynimbus - AWS EC2 instance $id configuration");
echo "AWS account <a href=\"aws-account.php?account=$enc\"><strong>$account</strong></a>, EC2 instance <strong>$id</strong> in region <strong>$region</strong> as of $date:<br />\n";

foreach ($data["Reservations"] as $reservation) {
	foreach ($reservation["Instances"] as $instance) {

		if ($instance["InstanceId"] == $id) {
			$descr = json_encode($instance, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES);
			$descr = aws_apply_raw_links($account, $region, $descr);
			echo "<pre>$descr</pre>\n";
		}
	}
}

page_end();
