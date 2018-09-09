#!/bin/sh
. /etc/polynimbus/azure/default.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <region>"
	exit 1
fi

region=$1
file=/root/.azure/groups.$region.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 hours' +%s` ]; then
	az group list --query "[?location=='$region']" >$file
fi

if [ "$2" = "--full" ]; then
	cat $file
else
	grep '"name"' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g |sort
fi
