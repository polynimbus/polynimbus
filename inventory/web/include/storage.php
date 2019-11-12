<?php

function get_azure_storage_link($vendor, $category, $account, $param, $share)
{
	$file = "/var/cache/polynimbus/storage/$category-$account-$param-$share.list";
	if (!file_exists($file) || filesize($file) < 1)
		return $share;

	$enc1 = urlencode($account);
	$enc2 = urlencode($param);
	$enc3 = urlencode($share);
	return "<a href=\"files.php?vendor=$vendor&category=$category&account=$enc1&param1=$enc2&param2=$enc3\">$share</a>";
}

function get_storage_link($vendor, $category, $account, $param, $share)
{
	if ($vendor == "aws" && $category == "s3")
	{
		$file = "/var/cache/polynimbus/storage/$category-$account-$share.list";
		if (!file_exists($file) || filesize($file) < 1)
			return $share;

		$enc1 = urlencode($account);
		$enc2 = urlencode($share);
		return "<a href=\"files.php?vendor=$vendor&category=$category&account=$enc1&param2=$enc2\">$share</a>";
	}

	if ($vendor == "azure" && $category == "files")
		return get_azure_storage_link($vendor, "azfile", $account, $param, $share);

	if ($vendor == "azure" && $category == "blobs")
		return get_azure_storage_link($vendor, "azblob", $account, $param, $share);

	return $share;
}
