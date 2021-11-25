#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/godaddy/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
result=`/opt/polynimbus/drivers/godaddy/get.sh $account domains/agreements |grep MISSING_VALUE`

if [ "$result" = "" ]; then
	echo "error: GoDaddy account \"$account\" has invalid credentials"
fi
