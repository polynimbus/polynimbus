#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [region]"
	exit 1
fi

account=$1
region=$2
osver="18.04"

/opt/polynimbus/drivers/azure/list-images.sh $account $region |grep -v DAILY |grep $osver |tail -n1
