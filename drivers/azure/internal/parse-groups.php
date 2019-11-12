#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/azure/internal/include.php";

$groups = parse_stdin_json_data();

foreach ($groups as $group) {
	$name = preg_replace("/[^a-zA-Z0-9]/", "_", $group["displayName"]);
	$mail = empty($group["mail"]) ? "-" : $group["mail"];
	$id = $group["objectId"];
	echo "$name $mail $id\n";
}
