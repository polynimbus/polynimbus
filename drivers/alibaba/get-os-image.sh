#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <os-name>"
	exit 1
elif [ ! -f /etc/polynimbus/alibaba/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
osname=$2

/opt/polynimbus/drivers/alibaba/list-images.sh $account |grep $osname |tail -n1
