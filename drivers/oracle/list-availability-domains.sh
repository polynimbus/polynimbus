#!/bin/sh

region=`/opt/polynimbus/drivers/oracle/get-configured-region.sh`
compartment=`/opt/polynimbus/drivers/oracle/get-compartment-id.sh`

file=/var/cache/polynimbus/oracle/availability-domains-$region.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-8 hours' +%s` ]; then
	oci iam availability-domain list --compartment-id $compartment >$file
fi

grep '"name":' $file |awk '{ print $2 }' |sed s/\"//g |sort
