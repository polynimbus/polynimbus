#!/bin/sh

if [ "$1" = "" ]; then exit 0; fi
instance=$1

path=/var/cache/polynimbus/oracle/ip
mkdir -p $path

file=$path/$instance.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-1 hour' +%s` ]; then
	oci compute instance list-vnics --instance-id $instance >$file
fi

grep '"public-ip":' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g
