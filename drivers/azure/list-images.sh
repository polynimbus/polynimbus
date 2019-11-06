#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [region]"
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

file=/var/cache/polynimbus/azure/skus-$account-$region-$AZURE_PUBLISHER-$AZURE_OFFER.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d yesterday +%s` ]; then
	az vm image list-skus --subscription $AZURE_SUBSCRIPTION --publisher $AZURE_PUBLISHER --offer $AZURE_OFFER --location $region >$file
fi

grep '"name"' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g |sort |sed -e "s/^/$AZURE_PUBLISHER:$AZURE_OFFER:/" -e "s/$/:latest/"
