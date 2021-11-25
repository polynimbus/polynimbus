#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-id> <new-instance-type>"
	exit 1
elif ! grep -q "\[$1\]" ~/.rack/config; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
instance=$2
type=$3

/opt/polynimbus/drivers/rackspace/support/rack servers instance resize \
	--id $instance \
	--flavor-id $type \
	--profile $account
