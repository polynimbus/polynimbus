#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$accounts = parse_stdin_json_data();

foreach (@$accounts["result"] as $account)
	echo $account["id"]."\n";
