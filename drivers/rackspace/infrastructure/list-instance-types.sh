#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [--full]"
	exit 1
elif ! grep -q "\[$1\]" ~/.rack/config; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1

if [ "$2" != "--full" ]; then
	/opt/polynimbus/drivers/rackspace/support/rack servers flavor list --profile $account |grep -v ^ID |cut -f1
else
	/opt/polynimbus/drivers/rackspace/support/rack servers flavor list --profile $account
fi
