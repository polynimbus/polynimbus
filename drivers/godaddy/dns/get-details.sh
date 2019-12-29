#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <domain>"
	exit 1
elif [ ! -f /etc/polynimbus/godaddy/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
domain=$2
file=/var/cache/polynimbus/godaddy/details-$account-$domain.cache
. /etc/polynimbus/godaddy/$account.sh

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 minutes' +%s` ]; then
	curl -sS -H "Authorization: sso-key $GODADDY_API_KEY:$GODADDY_API_SECRET" -H "Accept: application/json" https://api.godaddy.com/v1/domains/$domain >$file
fi

cat $file |python -m json.tool
