#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-name>"
	exit 1
elif [ ! -f /etc/polynimbus/hetzner/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

/opt/polynimbus/drivers/hetzner/describe-instance.sh $1 $2 |grep Name: |grep ubuntu |awk '{ print $2 }'
