#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/linode/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
result=`/opt/polynimbus/drivers/linode/get.sh $account v4/linode/instances |grep '"errors"'`

if [ "$result" != "" ]; then
	echo "error: Linode account \"$account\" has invalid credentials"
fi
