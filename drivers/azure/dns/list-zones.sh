#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
file=/var/cache/polynimbus/azure/zones-$account.cache
. /etc/polynimbus/azure/$account.sh

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-30 minutes' +%s` ]; then
	az network dns zone list --subscription $AZURE_SUBSCRIPTION >$file
fi

cat $file |/opt/polynimbus/drivers/azure/internal/parse-zones.php
