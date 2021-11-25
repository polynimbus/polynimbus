#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [region] [--raw]"
	exit 1
elif [ ! -f /etc/polynimbus/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
region=$2
. /etc/polynimbus/azure/$account.sh

if [ "$region" = "" ]; then
	region=$AZURE_LOCATION
fi

file=~/.polynimbus/cache/azure/sizes-$account-$region.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d yesterday +%s` ]; then
	az vm list-sizes --subscription $AZURE_SUBSCRIPTION --location $region >$file
fi

if [ "$3" = "--raw" ]; then
	cat $file
else
	grep '"name"' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g |sort
fi
