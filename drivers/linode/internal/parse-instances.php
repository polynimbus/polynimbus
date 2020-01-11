#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

function decode_instance($instance)
{
	$states = array(
		"provisioning" => "pending",
		"booting" => "pending",
		"rebooting" => "pending",
		"migrating" => "pending",
		"rebuilding" => "pending",
		"cloning" => "pending",
		"restoring" => "pending",
		"offline" => "terminated",
		"deleting" => "terminated",
		"shutting_down" => "terminated",
	);

	$state = str_replace(array_keys($states), array_values($states), $instance["status"]);
	$id = $instance["id"];
	$type = $instance["type"];
	$image = $instance["image"];
	$group = @$instance["group"];
	$location = $instance["region"];
	$date = substr($instance["created"], 0, 10);
	$tags = empty($instance["tags"]) ? "-" : str_replace(" ", "_", implode(";", $instance["tags"]));

	if (!isset($instance["ipv4"][0]))
		$host = "-";
	else if (($rev = gethostbyaddr($instance["ipv4"][0])) !== false)
		$host = $rev;
	else
		$host = $instance["ipv4"][0];

	$tmp = explode("-", $instance["label"]);
	$key = $tmp[0];

	echo "$host $state $key $location $type $id $image $date $tags $group\n";
}


$instances = parse_stdin_json_data();

if (isset($instances["data"]))
	foreach ($instances["data"] as $instance)
		decode_instance($instance);
else
	decode_instance($instances);
