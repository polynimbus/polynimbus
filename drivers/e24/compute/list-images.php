#!/usr/bin/php
<?php

require_once "/opt/polynimbus/drivers/e24/internal/include.php";

if ($argc < 2)
	die("usage: $argv[0] <cloud-account>\n");

$account = $argv[1];

$e24 = e24client($account);
$response = $e24->describe_images();

$images = array();
foreach ($response->body->imagesSet->item as $item) {
	$id = (string)$item->imageId;
	$images[$id] = (string)$item->name;
}

asort($images);

foreach ($images as $id => $name)
	echo "$id\t$name\n";
