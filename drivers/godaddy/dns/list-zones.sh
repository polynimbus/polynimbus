#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [--raw]"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/godaddy/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
file=~/.polynimbus/cache/godaddy/domains-$account.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-30 minutes' +%s` ]; then
	/opt/polynimbus/drivers/godaddy/get.sh $account domains >$file
fi

if [ "$2" = "--raw" ]; then
	cat $file |python2 -m json.tool
else
	cat $file |/opt/polynimbus/drivers/godaddy/internal/parse-zones.php
fi
