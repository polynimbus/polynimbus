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

/*
	if ($vendor == "azure")
	{
	}
*/

	return $account;
}
