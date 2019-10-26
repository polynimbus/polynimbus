<?php

function highlight_critical_aws_policies($text) {
	$highlight = array (
		"AdministratorAccess",
		"AmazonEC2FullAccess",
		"EC2InstanceConnect",
		"AWSKeyManagementServicePowerUser",
		"IAMFullAccess",
		"Billing",
	);

	foreach ($highlight as $word)
		$text = preg_replace("#>$word<#", "><font color=\"red\">$word</font><", $text);
	return $text;
}

function get_aws_groups_for_user($file, $username) {
	if (!file_exists($file))
		return array();
	$data = file_get_contents($file);
	if (empty($data))
		return array();

	$out = array();
	$lines = explode("\n", $data);
	foreach ($lines as $line) {
		$tmp = explode(" ", $line);
		if ($tmp[0] == $username)
			$out[] = $tmp[1];
	}

	return $out;
}

function get_aws_policy_link($text, $account, $type, $name) {
	$enc1 = urlencode($account);
	$enc2 = urlencode($name);
	$out = array();
	$lines = explode("\n", $text);
	foreach ($lines as $line) {
		$tmp = explode(" ", $line);
		if ($tmp[0] == $type && $tmp[1] == $name) {
			if (substr($tmp[2], 0, 1) == ":") {
				$sub = substr($tmp[2], 1);
				$out[] = "<a href=\"aws-policy-document.php?account=$enc1&$type=$enc2&policy=$sub\">$sub</a>*";
			} else {
				$out[] = "<a href=\"aws-policy-document.php?account=$enc1&policy=$tmp[2]\">$tmp[2]</a>";
			}
		}
	}
	return implode("\n", $out);
}
