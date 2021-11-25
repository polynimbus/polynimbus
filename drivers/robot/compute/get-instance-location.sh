#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-name>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/robot/$1.ini ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

/opt/polynimbus/drivers/robot/compute/describe-instance.sh $1 $2 |grep "data center:" |awk '{ print $3 }'
