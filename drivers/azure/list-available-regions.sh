#!/bin/sh

file=/root/.azure/locations.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d yesterday +%s` ]; then
	az account list-locations >$file
fi

grep '"name"' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g |sort
