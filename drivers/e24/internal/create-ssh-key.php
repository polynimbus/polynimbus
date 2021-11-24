#!/usr/bin/php
<?php

require_once "/opt/polynimbus/drivers/e24/internal/include.php";

if ($argc < 3)
	die("usage: $argv[0] <cloud-account> <ssh-key-fullname>\n");

$account = $argv[1];
$file = $argv[2];
$name = basename($argv[2]);

if (file_exists($file))
	die("warning: ssh key $name already exists\n");

$e24 = e24client($account);
$response = $e24->create_key_pair($name);

if (empty($response->body->keyMaterial))
	die("error: cannot create ssh key $name\n");

file_put_contents($file, (string)$response->body->keyMaterial);
chmod($file, 0600);
