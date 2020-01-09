#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [region]"
	exit 1
fi

account=$1
region=$2

/opt/polynimbus/api/v1/image/list.sh azure $account $region |grep -i ubuntu |tail -n1
