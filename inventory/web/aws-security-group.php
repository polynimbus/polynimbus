<?php

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) && preg_match('/^([a-z]{2}-[a-z]{4,9}-[0-9]{1})$/', $_GET["region"], $tmp2) && preg_match('/^(sg-[a-fA-F0-9]+)$/', $_GET["group"], $tmp3)) {
	$account = $tmp1[1];
	$region = $tmp2[1];
	$group = $tmp3[1];
	$enc1 = urlencode($account);
	$enc2 = urlencode($region);
} else
	die("Missing arguments...");

$file = "/var/cache/polynimbus/inventory/raw-aws-sg-$account-$region.json";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$json = file_get_contents($file);
$data = json_decode($json, true);


require "include/page.php";
require "include/raw.php";
page_header("Polynimbus - AWS security group details");
echo "AWS account <a href=\"aws-account.php?account=$enc1\"><strong>$account</strong></a>, security group <strong>$group</strong> in region <strong>$region</strong> as of $date:<br />\n";

foreach ($data["SecurityGroups"] as $sg) {
	if ($sg["GroupId"] == $group) {
		$descr = json_encode($sg, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES);
		$descr = aws_apply_raw_links($account, $region, $descr);
		echo "<pre>$descr</pre>\n";
	}
}

page_end();
