#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <unused> <vcn-id> <availability-domain> [--full]"
	exit 1
fi

# TODO: pass region/compartment as arguments to this script

region=`/opt/polynimbus/drivers/oracle/infrastructure/get-configured-region.sh`
compartment=`/opt/polynimbus/drivers/oracle/get-compartment-id.sh`

vcn=$2
avdomain=$3

file=~/.polynimbus/cache/oracle/subnets-$region-$vcn-$avdomain.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-1 hour' +%s` ]; then
	oci network subnet list --compartment-id $compartment --vcn-id $vcn --display-name "Public Subnet $avdomain" >$file
fi

if [ "$4" = "--full" ]; then
	cat $file
else
	grep '"id":' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g
fi
