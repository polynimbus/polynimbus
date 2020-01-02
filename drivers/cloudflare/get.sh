#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <endpoint>"
	exit 1
elif [ ! -f /etc/polynimbus/cloudflare/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
endpoint=$2
. /etc/polynimbus/cloudflare/$account.sh

curl -sS -H "X-Auth-Email: $CLOUDFLARE_EMAIL" -H "X-Auth-Key: $CLOUDFLARE_KEY" -H "Accept: application/json" "https://api.cloudflare.com/client/v4/$endpoint"
