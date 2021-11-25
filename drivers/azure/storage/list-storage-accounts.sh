#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [region|all|raw]"
	exit 1
elif [ ! -f /etc/polynimbus/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
region=$2
file=~/.polynimbus/cache/azure/storage-$account.cache
. /etc/polynimbus/azure/$account.sh

if [ "$region" = "" ]; then
	region=$AZURE_LOCATION
fi

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 hours' +%s` ]; then
	az storage account list --subscription $AZURE_SUBSCRIPTION >$file
fi

if [ "$region" = "raw" ]; then
	cat $file
elif [ "$region" = "all" ]; then
	cat $file |/opt/polynimbus/drivers/azure/internal/parse-storage.php
else
	cat $file |/opt/polynimbus/drivers/azure/internal/parse-storage.php |grep $region
fi
