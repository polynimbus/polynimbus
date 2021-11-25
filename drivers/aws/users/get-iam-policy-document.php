#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 5)
	die("usage: $argv[0] <cloud-account> <user/group/managed> <name> <policy-name> [cache-file]\n");

$_name = escapeshellarg($argv[3]);
$_policy = escapeshellarg($argv[4]);

if ($argv[2] == "user") {
	$data = aws_request($argv[1], "iam get-user-policy --user-name $_name --policy-name $_policy");
	echo json_encode($data, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES)."\n";

} else if ($argv[2] == "group") {

	$data = aws_request($argv[1], "iam get-group-policy --group-name $_name --policy-name $_policy");
	echo json_encode($data, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES)."\n";

} else if ($argv[2] == "managed") {

	$account = $argv[1];
	$policyname = $argv[4];
	$cache = $argv[5];
	$arn = false;

	if (empty($cache) || !file_exists($cache))
		die("error: managed policies cache not populated for account $account\n");

	$json = file_get_contents($cache);
	$data = json_decode($json, true);

	foreach ($data["Policies"] as $managed) {
		if ($managed["PolicyName"] == $policyname) {
			$_arn = escapeshellarg($managed["Arn"]);
			$version = $managed["DefaultVersionId"];
			$data = aws_request($account, "iam get-policy-version --policy-arn $_arn --version-id $version");
			echo json_encode($data, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES)."\n";
			break;
		}
	}

} else {
	die("error: invalid mode, should be either user, group or managed\n");
}
