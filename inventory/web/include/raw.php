<?php

function aws_region_list() {
	return array (
		"eu-central-1",
		"eu-north-1",
		"eu-west-1",
		"eu-west-2",
		"eu-west-3",
		"us-east-1",
		"us-east-2",
		"us-west-1",
		"us-west-2",
		"ap-south-1",
		"ap-southeast-1",
		"ap-southeast-2",
		"ap-northeast-1",
		"ap-northeast-2",
		"sa-east-1",
		"ca-central-1",
	);
}

function aws_regional_raw_types() {
	return array (
		"addrs"     => 30,
		"beanstalk" => 30,
		"certs"     => 40,
		"elb"       => 40,
		"elbv2"     => 30,
		"functions" => 40,
		"gws"       => 300,
		"ifaces"    => 40,
		"instances" => 30,
		"nat"       => 30,
		"route"     => 950,
		"sg"        => 40,
		"subnets"   => 1400,
		"volumes"   => 30,
		"vpcs"      => 650,
	);
}

function global_raw_types() {
	return array(
		"aws" => array (
			"cloudfront" => 140,
		),
		"azure" => array (
			"kubernetes" => 10,
		),
	);
}

function link_global_raw_content($vendor, $account, $type) {
	$enc = urlencode($account);
	$file = "/var/cache/polynimbus/inventory/raw-$vendor-$type-$account.json";
	$allowed = global_raw_types();

	if (isset($allowed[$vendor][$type]) && file_exists($file) && filesize($file) > $allowed[$vendor][$type])
		return " - <a href=\"raw.php?vendor=$vendor&account=$enc&type=$type\">$type</a>";
	else
		return "";
}

function aws_apply_raw_links($account, $region, $text) {
	$enc1 = urlencode($account);
	$enc2 = urlencode($region);
	$text = preg_replace("/(sg-[a-fA-F0-9]+)/", "<a href=\"aws-security-group.php?account=$enc1&region=$enc2&group=\\1\">\\1</a>", $text);
	$text = preg_replace("/(vol-[a-fA-F0-9]+)/", "<a href=\"aws-volume.php?account=$enc1&region=$enc2&volume=\\1\">\\1</a>", $text);
	$text = preg_replace("/[^a-zA-Z](i-[a-fA-F0-9]+)/", "<a href=\"aws-instance.php?account=$enc1&region=$enc2&id=\\1\">\\1</a>", $text);
	$text = preg_replace("/(vpc-[^i][a-fA-F0-9]+)/", "<a href=\"aws-raw.php?account=$enc1&region=$enc2&type=vpcs\">\\1</a>", $text);
	$text = preg_replace("/(eni-[^t][a-fA-F0-9]+)/", "<a href=\"aws-raw.php?account=$enc1&region=$enc2&type=ifaces\">\\1</a>", $text);
	$text = preg_replace("/(subnet-[^i][a-fA-F0-9]+)/", "<a href=\"aws-raw.php?account=$enc1&region=$enc2&type=subnets\">\\1</a>", $text);
	return $text;
}
