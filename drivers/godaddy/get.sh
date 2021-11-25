#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <endpoint>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/godaddy/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
endpoint=$2
. ~/.polynimbus/accounts/godaddy/$account.sh

curl -sS -H "Authorization: sso-key $GODADDY_API_KEY:$GODADDY_API_SECRET" -H "Accept: application/json" https://api.godaddy.com/v1/$endpoint
