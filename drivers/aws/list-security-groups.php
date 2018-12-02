#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account> [--raw]\n");

$data = aws_request($argv[1], "ec2 describe-security-groups");

if ($argc > 2 && $argv[2] == "--raw") {
	echo json_encode($data, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES)."\n";
	die();
}

foreach ($data["SecurityGroups"] as $group) {
	$name = $group["GroupName"];
	$vpcid = $group["VpcId"];
	$id = $group["GroupId"];

	$descr = "$vpcid $id $name";

	foreach ($group["IpPermissions"] as $perm) {
		$proto = (empty($perm["IpProtocol"]) ? "all" : $perm["IpProtocol"]);
		$port = (is_numeric($perm["FromPort"]) ? $perm["FromPort"] : "any");

		foreach ($perm["IpRanges"] as $range) {
			$cidr = str_replace("0.0.0.0/0", "any", $range["CidrIp"]);
			$cidr = str_replace("/32", "", $cidr);
			$descr .= " ip:$proto:$port:$cidr";
		}

		foreach ($perm["Ipv6Ranges"] as $range) {
			$cidr = str_replace("::/0", "any", $range["CidrIpv6"]);
			$cidr = str_replace(":", ".", $cidr);
			$descr .= " ip6:$proto:$port:$cidr";
		}
	}

	echo "$descr\n";
}
