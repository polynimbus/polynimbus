<?php

function get_aws_sg_link($account, $region, $sg) {
	$file = "/var/cache/polynimbus/inventory/raw-aws-sg-$account-$region.json";
	if (!file_exists($file))
		return $sg;

	$enc1 = urlencode($account);
	$enc2 = urlencode($region);
	$enc3 = urlencode($sg);
	return "<a href=\"aws-security-group.php?account=$enc1&region=$enc2&group=$enc3\">$sg</a>";
}

function aws_load_acls($account, $region, $port) {
	$out = array();

	$file = "/var/cache/polynimbus/inventory/raw-aws-sg-$account-$region.json";
	$json = file_get_contents($file);
	$data = json_decode($json, true);

	foreach ($data["SecurityGroups"] as $group) {
		$rules = array();

		foreach ($group["IpPermissions"] as $perm) {
			if (!empty($perm["UserIdGroupPairs"]))
				continue;

			if (($perm["IpProtocol"] == "-1" && empty($perm["FromPort"]) && empty($perm["ToPort"])) ||
				($perm["IpProtocol"] != "icmp" && $perm["IpProtocol"] != "udp" && (int)$perm["FromPort"] <= $port && (int)$port <= $perm["ToPort"])) {
				foreach ($perm["IpRanges"] as $range)
					$rules[] = str_replace("/32", "", $range["CidrIp"]);
				foreach ($perm["Ipv6Ranges"] as $range)
					$rules[] = "v6/".$range["CidrIpv6"];
			} // else { print_r($perm); echo "port: $port"; }
		}

		$out[$group["GroupId"]] = $rules;
	}

	return $out;
}

function aws_map_acl_to_ranges($account, $region, $port, $acl_raw) {
	$out = array();
	$acls = explode(" ", $acl_raw);
	$sg = aws_load_acls($account, $region, $port);

	foreach ($acls as $acl) {
		$list = $sg[$acl];
		$tmp = get_aws_sg_link($account, $region, $acl);
		foreach ($list as $ip)
			$tmp .= "<br />$ip";
		$out[] = $tmp;
	}

	return implode("<br /><br />", $out);
}

function map_acl_to_ranges($vendor, $account, $region, $port, $acl_raw) {
	if ($vendor != "aws")
		return str_replace(" ", "<br />", $acl_raw);
	else
		return aws_map_acl_to_ranges($account, substr($region, 0, -1), $port, $acl_raw);
}
