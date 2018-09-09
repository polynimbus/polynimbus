#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [--full]"
	exit 1
elif [ ! -f /etc/polynimbus/rackspace/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1

if [ "$2" != "--full" ]; then
	/opt/polynimbus/drivers/rackspace/support/rack servers instance list --profile $account --output csv |grep -v "No result" |grep -v ^ID |cut -d, -f4
else
	/opt/polynimbus/drivers/rackspace/support/rack servers instance list --profile $account
fi
