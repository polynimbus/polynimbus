#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [--raw]"
	exit 1
elif [ ! -f /etc/polynimbus/cloudflare/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
file=~/.polynimbus/cache/cloudflare/accounts-$account.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 hours' +%s` ]; then
	/opt/polynimbus/drivers/cloudflare/get.sh $account accounts >$file
fi

if [ "$2" = "--raw" ]; then
	cat $file |python -m json.tool
else
	cat $file |/opt/polynimbus/drivers/cloudflare/internal/parse-accounts.php
fi
