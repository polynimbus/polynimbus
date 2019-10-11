<?php

$path = "/var/cache/polynimbus/inventory";
$file = "$path/projects-google.list";
$date = date("Y-m-d H:i:s", filemtime($file));

require "include/page.php";
page_header("Polynimbus - list of available projects and users in Google Cloud Platform");
echo "List of available projects and users in Google Cloud Platform as of $date<br />\n";
table_start("google", array(
	"project",
	"type",
	"role",
	"email",
));


$data = file_get_contents($file);
$lines = explode("\n", $data);

foreach ($lines as $line) {
	$project = trim($line);
	if (empty($project))
		continue;

	$file2 = "$path/users-google-$project.list";
	$data2 = file_get_contents($file2);
	$lines2 = explode("\n", $data2);

	foreach ($lines2 as $line2) {
		$line2 = trim($line2);
		if (empty($line2))
			continue;

		$tmp = explode(" ", $line2);
		$role = $tmp[0];
		$type = $tmp[1];
		$email = $tmp[2];

		table_row(array($project, $type, $role, $email), false);
	}
}

table_end("google");
page_end();



