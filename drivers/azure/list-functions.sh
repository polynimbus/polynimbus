#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [--raw]"
	exit 1
elif [ ! -f /etc/polynimbus/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
file=/var/cache/polynimbus/azure/functions-$account.cache
. /etc/polynimbus/azure/$account.sh

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-30 minutes' +%s` ]; then
	az functionapp list --subscription $AZURE_SUBSCRIPTION >$file
fi

if [ "$2" = "--raw" ]; then
	cat $file
else
	cat $file |/opt/polynimbus/drivers/azure/internal/parse-functions.php
fi
