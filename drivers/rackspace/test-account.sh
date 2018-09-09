#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/rackspace/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
result=`/opt/polynimbus/drivers/rackspace/support/rack servers flavor list --profile $account |grep onmetal`

if [ "$result" = "" ]; then
	echo "error: cloud account \"$1\" has invalid credentials"
fi