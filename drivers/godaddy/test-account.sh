#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/godaddy/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
. /etc/polynimbus/godaddy/$account.sh

result=`curl -sS -H "Authorization: sso-key $GODADDY_API_KEY:$GODADDY_API_SECRET" -H "Accept: application/json" https://api.godaddy.com/v1/domains/agreements |grep MISSING_VALUE`

if [ "$result" = "" ]; then
	echo "error: GoDaddy account \"$1\" has invalid credentials"
fi
