#!/bin/sh
. /opt/polynimbus/common/functions

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f /etc/polynimbus/b2/$1.db ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

mkdir -p /etc/polynimbus/b2
B2_ACCOUNT_INFO=/etc/polynimbus/b2/$1.db b2 authorize-account
