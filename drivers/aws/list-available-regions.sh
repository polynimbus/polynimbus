#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/aws/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
aws --profile $account ec2 describe-regions |grep RegionName |awk '{ print $2 }' |sed s/\"//g |sort
