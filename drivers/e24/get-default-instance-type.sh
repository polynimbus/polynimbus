#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/e24/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

. /etc/polynimbus/e24/$1.sh
echo $E24_DEFAULT_INSTANCE_TYPE
