#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [--raw]"
	exit 1
elif [ ! -f /etc/polynimbus/godaddy/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
file=/var/cache/polynimbus/godaddy/domains-$account.cache
. /etc/polynimbus/godaddy/$account.sh

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-30 minutes' +%s` ]; then
	curl -sS -H "Authorization: sso-key $GODADDY_API_KEY:$GODADDY_API_SECRET" -H "Accept: application/json" https://api.godaddy.com/v1/domains >$file
fi

if [ "$2" = "--raw" ]; then
	cat $file |python -m json.tool
else
	cat $file |/opt/polynimbus/drivers/godaddy/internal/parse-zones.php
fi
