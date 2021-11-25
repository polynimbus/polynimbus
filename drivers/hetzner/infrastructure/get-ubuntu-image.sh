#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/hetzner/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
/opt/polynimbus/api/v1/image/list.sh hetzner $account |grep ubuntu- |tail -n1 |awk '{ print $3 }'
