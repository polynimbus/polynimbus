#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [--full]"
	exit 1
elif ! grep -q "\[$1\]" /root/.rack/config; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1

if [ "$2" != "--full" ]; then
	/opt/polynimbus/drivers/rackspace/support/rack servers instance list --profile $account --output csv |grep -v "No result" |grep -v ^ID |cut -d, -f4
else
	/opt/polynimbus/drivers/rackspace/support/rack servers instance list --profile $account |sed s/ACTIVE/running/g
fi

# ID        Name            Status  Public IPv4     Private IPv4    Image   Flavor
# GUID      my_server       ACTIVE  101.130.19.31   10.208.128.233  GUID    io1-30
