#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$result = parse_stdin_json_data();
$pages = 1;

if (isset($result["result_info"]["total_pages"]))
	$pages = $result["result_info"]["total_pages"];

echo "$pages\n";
