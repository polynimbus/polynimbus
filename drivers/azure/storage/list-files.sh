#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <cloud-account> <storage-account> <share-name> [path]"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
storage=$2
share=$3
path=$4
. ~/.polynimbus/accounts/azure/$account.sh

if [ "$path" != "" ]; then
	az storage file list --share-name $share --account-name $storage --subscription $AZURE_SUBSCRIPTION --path "$path" 2>/dev/null \
		|/opt/polynimbus/drivers/azure/internal/parse-files.php "$path"
else
	az storage file list --share-name $share --account-name $storage --subscription $AZURE_SUBSCRIPTION 2>/dev/null \
		|/opt/polynimbus/drivers/azure/internal/parse-files.php
fi
