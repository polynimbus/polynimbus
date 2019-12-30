#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/e24/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
osver="18.04"

/opt/polynimbus/drivers/e24/compute/list-images.php $account |grep Ubuntu |grep $osver |tail -n1 |awk '{ print $1 }'
