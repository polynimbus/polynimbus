#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [region]"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
region=$2
. ~/.polynimbus/accounts/azure/$account.sh

if [ "$region" = "" ]; then
	region=$AZURE_LOCATION
fi

file=~/.polynimbus/cache/azure/groups-$account-$region.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 hours' +%s` ]; then
	az group list --subscription $AZURE_SUBSCRIPTION --query "[?location=='$region']" >$file
fi

grep '"name"' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g |sort
