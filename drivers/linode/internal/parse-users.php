#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$users = parse_stdin_json_data();

foreach ($users["data"] as $user) {
	$username = $user["username"];
	$email = $user["email"];
	$tfa = (int)$user["tfa_enabled"];
	$restricted = (int)$user["restricted"];
	$keys = implode(";", $user["ssh_keys"]);
	echo "$username $email $tfa $restricted $keys\n";
}
