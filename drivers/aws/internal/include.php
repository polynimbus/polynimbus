<?php

function aws_client($profile)
{
	$_profile = escapeshellarg($profile);
	return "aws --profile $_profile";
}

function aws_request($profile, $request)
{
	$aws = aws_client($profile);
	$json = shell_exec("$aws $request");

	if (empty($json))
		return array();

	$data = json_decode($json, true);

	if (is_null($data))
		die("error: $json\n");

	return $data;
}

function aws_decode_reservation($reservation)
{
	$states = array(
		"shutting-down" => "terminated",
	);

	foreach ($reservation["Instances"] as $instance) {
		$state = str_replace(array_keys($states), array_values($states), $instance["State"]["Name"]);
		$zone = $instance["Placement"]["AvailabilityZone"];
		$type = $instance["InstanceType"];
		$id = $instance["InstanceId"];
		$imgid = $instance["ImageId"];
		$key = str_replace(" ", "_", $instance["KeyName"]);
		$host = empty($instance["PublicDnsName"]) ? "-" : $instance["PublicDnsName"];
		$vpcid = empty($instance["VpcId"]) ? "-" : $instance["VpcId"];
		$created = substr($instance["LaunchTime"], 0, 10);
		$tag = empty($instance["Tags"][0]["Value"]) ? "-" : str_replace(" ", "_", $instance["Tags"][0]["Value"]);

		$descr = "$host $state $key $zone $type $id $imgid $created $tag $vpcid";

		foreach ($instance["SecurityGroups"] as $sg)
			$descr .= " " . $sg["GroupId"];

		echo "$descr\n";
	}
}
