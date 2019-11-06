#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
. /etc/polynimbus/azure/$account.sh
echo $AZURE_LOCATION
