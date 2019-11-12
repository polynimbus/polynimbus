<?php

function parse_stdin_json_data()
{
	$json = "";
	$fp = fopen("php://stdin", "r");

	while ($line = fgets($fp))
		$json .= $line;

	fclose($fp);
	$data = json_decode($json, true);

	if (is_null($data))
		die("error: $json\n");

	return $data;
}
