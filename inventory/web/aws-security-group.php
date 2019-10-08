<?php

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) && preg_match('/^(sg-[a-fA-F0-9]+)$/', $_GET["group"], $tmp2)) {
	$account = $tmp1[1];
	$group = $tmp2[1];
	$enc = urlencode($account);
} else
	die("Missing arguments...");

$file = "/var/cache/polynimbus/inventory/acl-aws-$account.json";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$json = file_get_contents($file);
$data = json_decode($json, true);


require "include/page.php";
page_header("Polynimbus - AWS security group details");
echo "AWS account <a href=\"aws-account.php?account=$enc\"><strong>$account</strong></a>, security group <strong>$group</strong> as of $date:<br />\n";

foreach ($data["SecurityGroups"] as $sg) {
	if ($sg["GroupId"] == $group) {
		$descr = json_encode($sg, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES);
		$descr = preg_replace("/(sg-[a-fA-F0-9]+)/", "<a href=\"aws-security-group.php?account=$enc&group=\\1\">\\1</a>", $descr);
		echo "<pre>$descr</pre>\n";
	}
}

page_end();
