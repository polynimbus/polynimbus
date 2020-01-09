#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$users = parse_stdin_json_data();

foreach ($users as $user) {
	$mail = $user["mail"];
	$created = substr($user["createdDateTime"], 0, 10);
	$last = substr($user["refreshTokensValidFromDateTime"], 0, 10);
	$id = $user["objectId"];
	$enabled = "-";

	if (empty($user["userState"]))
		$type = $user["userType"];
	else
		$type = $user["userType"]."-".$user["userState"];

	if (empty($user["mail"]))
		$mail = $user["otherMails"][0];

	if ($user["accountEnabled"])
		$enabled = "enabled";

	echo "$mail $created $last $type $id $enabled\n";
}
