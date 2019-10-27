#!/bin/sh
. /opt/polynimbus/common/functions

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif grep -q "\[$1\]" /root/.rack/config; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

account=$1
/opt/polynimbus/drivers/rackspace/support/rack configure

if ! grep -q "\[$account\]" /root/.rack/config; then
	echo "error: cloud account \"$account\" left unconfigured"
	exit 1
fi
