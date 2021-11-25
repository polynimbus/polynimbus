#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/cloudflare/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
result=`/opt/polynimbus/drivers/cloudflare/get.sh $account zones |grep activated_on`

if [ "$result" = "" ]; then
	echo "error: Cloudflare account \"$account\" has invalid credentials"
fi
