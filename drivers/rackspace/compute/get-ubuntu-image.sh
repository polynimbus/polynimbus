#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif ! grep -q "\[$1\]" /root/.rack/config; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
osver="18.04"

/opt/polynimbus/drivers/rackspace/compute/list-images.sh $account |grep Ubuntu |grep PVHVM |grep $osver |head -n1
