#!/bin/sh
. /etc/polynimbus/azure/default.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <region>"
	exit 1
fi

region=$1
file=/var/cache/polynimbus/azure/skus.$region.$AZURE_PUBLISHER.$AZURE_OFFER.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d yesterday +%s` ]; then
	az vm image list-skus --publisher $AZURE_PUBLISHER --offer $AZURE_OFFER --location $region >$file
fi

if [ "$2" = "--full" ]; then
	cat $file
else
	grep '"name"' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g |sort
fi
