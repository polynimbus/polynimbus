#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <cloud-account> <storage-account> <container-name>"
	exit 1
elif [ ! -f /etc/polynimbus/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
storage=$2
container=$3
. /etc/polynimbus/azure/$account.sh

az storage blob list --container-name $container --account-name $storage --subscription $AZURE_SUBSCRIPTION 2>/dev/null \
	|/opt/polynimbus/drivers/azure/internal/parse-files.php --plain
