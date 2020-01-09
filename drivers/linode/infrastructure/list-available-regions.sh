#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/linode/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
/opt/polynimbus/drivers/linode/get.sh $account v4/regions |python -m json.tool |grep '"id"' |awk '{ print $2 }' |tr -d '"' |tr -d ',' |sort
