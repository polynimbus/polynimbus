#!/usr/bin/php
<?php
require_once "/opt/polynimbus/drivers/aws/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account>\n");

$data = aws_request($argv[1], "rds describe-db-instances");

if (empty($data["DBInstances"]))
	die();

foreach ($data["DBInstances"] as $instance) {
	$id = $instance["DBInstanceIdentifier"];
	$dbuser = $instance["MasterUsername"];
	$dbname = isset($instance["DBName"]) ? $instance["DBName"] : "-";
	$dbhost = $instance["Endpoint"]["Address"];
	$dbport = $instance["Endpoint"]["Port"];
	$vpcid = $instance["DBSubnetGroup"]["VpcId"];
	$zone = $instance["AvailabilityZone"];
	$engine = $instance["Engine"];
	$version = $instance["EngineVersion"];
	$size = $instance["AllocatedStorage"];
	$storage = $instance["StorageType"];
	$state = $instance["DBInstanceStatus"];
	$type = substr($instance["DBInstanceClass"], 3);
	$created = substr($instance["InstanceCreateTime"], 0, 10);

	$descr = "$dbhost $dbport $dbname $dbuser $state $engine $version $storage $size $zone $type $id $created $vpcid";

	foreach ($instance["VpcSecurityGroups"] as $group)
		if ($group["Status"] == "active")
			$descr .= " " . $group["VpcSecurityGroupId"];

	echo "$descr\n";
}
