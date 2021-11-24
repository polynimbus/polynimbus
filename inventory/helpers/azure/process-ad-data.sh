#!/bin/sh

account=$1
. /etc/polynimbus/azure/$account.sh

out=~/.polynimbus/inventory
SAVE=/opt/polynimbus/common/save.sh


az account set --subscription $AZURE_SUBSCRIPTION

az ad user list           |$SAVE 0 $out raw-azure-users-$account.json
az ad group list          |$SAVE 0 $out raw-azure-groups-$account.json
az role assignment list   |$SAVE 0 $out raw-azure-roles-$account.json
az account list-locations |$SAVE 0 $out raw-azure-locations-$account.json


cat $out/raw-azure-groups-$account.json \
	|/opt/polynimbus/drivers/azure/internal/parse-groups.php \
	|$SAVE 0 $out groups-azure-$account.list

cat $out/raw-azure-roles-$account.json \
	|/opt/polynimbus/drivers/azure/internal/parse-roles.php \
	|$SAVE 0 $out roles-azure-$account.list

/opt/polynimbus/inventory/helpers/azure/list-ad-users.sh \
	$out/raw-azure-users-$account.json \
	$out/roles-azure-$account.list \
	|$SAVE 0 $out users-azure-$account.list

/opt/polynimbus/inventory/helpers/azure/list-ad-groups.sh \
	$out/groups-azure-$account.list \
	|$SAVE 0 $out membership-azure-$account.list
