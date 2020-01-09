#!/bin/sh

# TODO: pass region/compartment as arguments to this script

region=`/opt/polynimbus/drivers/oracle/infrastructure/get-configured-region.sh`
compartment=`/opt/polynimbus/drivers/oracle/get-compartment-id.sh`

file=/var/cache/polynimbus/oracle/vcn-$region.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-8 hours' +%s` ]; then
	oci network vcn list --compartment-id $compartment >$file
fi

if [ "$1" = "--full" ]; then
	cat $file
else
	grep '"id":' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g
fi
