<?php

function highlight_critical_aws_policies($text) {
	$highlight = array (
		"AdministratorAccess",
		"AmazonEC2FullAccess",
		"EC2InstanceConnect",
		"AWSKeyManagementServicePowerUser",
		"Billing",
	);

	foreach ($highlight as $word)
		$text = preg_replace("#^$word<#", "<font color=\"red\">$word</font><", $text);
	return $text;
}

function first_column_as_list($file) {
	if (!file_exists($file))
		return array();
	$data = file_get_contents($file);
	if (empty($data))
		return array();

	$out = array();
	$lines = explode("\n", $data);
	foreach ($lines as $line) {
		$tmp = explode(" ", $line);
		$out[] = $tmp[0];
	}

	return $out;
}

function get_aws_inline_policy_link($text, $account, $type, $name) {
	$enc1 = urlencode($account);
	$enc2 = urlencode($name);
	return preg_replace("#:(.*)#", "<a href=\"aws-policy-document.php?account=$enc1&$type=$enc2&policy=\\1\">\\1</a>", $text);
}
