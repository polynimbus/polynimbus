#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/rackspace/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
/opt/polynimbus/drivers/rackspace/support/rack servers image list \
	--profile $account \
	--output csv \
	|cut -d, -f2 |grep -v ^Name |grep -v Windows |sort
