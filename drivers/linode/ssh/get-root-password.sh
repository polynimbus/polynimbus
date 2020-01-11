#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/linode/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

. /etc/polynimbus/linode/$1.sh
echo $LINODE_DEFAULT_ROOT_PASSWORD
