<?php
// https://support.e24cloud.com/API_e24cloud

require_once "sdk-1.6.2/sdk.class.php";

function read_variable($account, $var)
{
	$home = getenv("HOME");
	$_account = escapeshellarg($account);
	return trim(shell_exec(". $home/.polynimbus/accounts/e24/$_account.sh; echo \$$var"));
}

function e24client($account)
{
	$key = read_variable($account, "E24_API_KEY");
	$secret = read_variable($account, "E24_API_SECRET");
	$region = read_variable($account, "E24_REGION");

	$e24 = new AmazonEC2(array(
		"key" => $key,
		"secret" => $secret,
	));

	$host = "https://$region.api.e24cloud.com";
	$e24->set_hostname($host);

	return $e24;
}
