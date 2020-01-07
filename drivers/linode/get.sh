#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <endpoint>"
	exit 1
elif [ ! -f /etc/polynimbus/linode/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
endpoint=$2
. /etc/polynimbus/linode/$account.sh

curl -sS -H "Authorization: Bearer $LINODE_API_TOKEN" -H "Accept: application/json" "https://api.linode.com/$endpoint"
