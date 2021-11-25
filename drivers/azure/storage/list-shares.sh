#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <cloud-account> <storage-account> <share|container> [--raw]"
	exit 1
elif [ "$3" != "share" ] && [ "$3" != "container" ]; then
	echo "error: storage type should be either \"share\" or \"container\""
	exit 1
elif [ ! -f /etc/polynimbus/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
storage=$2
type=$3
mode=$4
file=~/.polynimbus/cache/azure/$type-$account-$storage.cache
. /etc/polynimbus/azure/$account.sh

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 hours' +%s` ]; then
	az storage $type list --account-name $storage --subscription $AZURE_SUBSCRIPTION >$file 2>/dev/null
fi

if [ "$mode" = "--raw" ]; then
	cat $file
else
	cat $file |/opt/polynimbus/drivers/azure/internal/parse-shares.php
fi
