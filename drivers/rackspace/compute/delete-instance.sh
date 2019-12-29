#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-id>"
	exit 1
elif ! grep -q "\[$1\]" /root/.rack/config; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
instance=$2

/opt/polynimbus/drivers/rackspace/support/rack servers instance delete \
	--id $instance \
	--profile $account
