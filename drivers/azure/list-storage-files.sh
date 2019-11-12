#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> <storage-account> <share-name> [path]"
	exit 1
elif [ ! -f /etc/polynimbus/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
storage=$2
share=$3
path=$4
. /etc/polynimbus/azure/$account.sh

if [ "$path" != "" ]; then
	az storage file list --share-name $share --account-name $storage --subscription $AZURE_SUBSCRIPTION --path "$path" \
		|/opt/polynimbus/drivers/azure/internal/parse-files.php "$path"
else
	az storage file list --share-name $share --account-name $storage --subscription $AZURE_SUBSCRIPTION \
		|/opt/polynimbus/drivers/azure/internal/parse-files.php
fi
