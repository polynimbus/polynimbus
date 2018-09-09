<?php

function alibaba_request($profile, $request)
{
	$_profile = escapeshellarg($profile);
	$json = shell_exec("aliyuncli ecs $request --profile $_profile");
	$data = json_decode($json, true);

	if (is_null($data))
		die("error: $json\n");

	return $data;
}
