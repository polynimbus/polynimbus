#!/usr/bin/php
<?php
require_once "/opt/polynimbus/common/include.php";

$roles = parse_stdin_json_data();

foreach ($roles as $role) {
	$id = $role["principalId"];
	$type = $role["principalType"];
	$roleName = $role["roleDefinitionName"];
	$roleId = basename($role["roleDefinitionId"]);
	$scope = basename($role["scope"]);
	echo "$id $type $roleName $roleId $scope\n";
}
