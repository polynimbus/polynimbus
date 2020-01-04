#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/b2/$1.db ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
result=`/opt/polynimbus/drivers/b2/client.sh $account get-account-info |grep accountAuthToken`

if [ "$result" = "" ]; then
	echo "error: Backblaze B2 account \"$account\" has invalid credentials"
fi
