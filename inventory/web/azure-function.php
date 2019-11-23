<?php

$files = array (
	"config" => "configuration",
	"settings" => "variables",
	"cors" => "CORS settings",
	"profiles" => "publishing profiles",
	"credentials" => "publishing credentials",
	"source" => "deployment source",
);

if (preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["account"], $tmp1) && preg_match('/^([a-zA-Z0-9._-]+)$/', $_GET["function"], $tmp2)) {
	$account = $tmp1[1];
	$function = $tmp2[1];
	$enc = urlencode($account);
} else
	die("Missing arguments...");

$path = "/var/cache/polynimbus/inventory";
$file = "$path/raw-azure-functions-$account-$function-details.json";

if (!file_exists($file))
	die("Invalid account...");

$date = date("Y-m-d H:i:s", filemtime($file));
$json = file_get_contents($file);

require "include/page.php";
page_header("Polynimbus - Azure Function $function configuration");
echo "Azure account <a href=\"azure-account.php?account=$enc\"><strong>$account</strong></a>, serverless function <strong>$function</strong> as of $date:<br />\n";
echo "<pre>$json</pre>\n";

foreach ($files as $key => $description) {
	$file = "$path/raw-azure-functions-$account-$function-$key.json";
	if (file_exists($file)) {
		$json = file_get_contents($file);
		echo "<br /><br />function <strong>$function</strong> $description:<br /><br /><br />\n";
		echo "<pre>$json</pre>\n";
	}
}

page_end();
