<?php

function get_account_link($vendor, $account)
{
	if ($vendor == "aws")
	{
		$file = "/var/cache/polynimbus/inventory/users-aws-$account.list";
		if (!file_exists($file))
			return $account;

		$enc = urlencode($account);
		return "<a href=\"aws-account.php?account=$enc\">$account</a>";
	}

	if ($vendor == "azure")
	{
		$file = "/var/cache/polynimbus/inventory/users-azure-$account.list";
		if (!file_exists($file))
			return $account;

		$enc = urlencode($account);
		return "<a href=\"azure-account.php?account=$enc\">$account</a>";
	}

	return $account;
}


function get_region_link($vendor, $account, $region)
{
	if ($vendor == "azure")
	{
		$file = "/var/cache/polynimbus/inventory/usage-azure-$account.list";
		if (!file_exists($file))
			return $region;

		$enc = urlencode($account);
		return "<a href=\"azure-usage.php?account=$enc&region=$region\">$region</a>";
	}

	return $region;
}
