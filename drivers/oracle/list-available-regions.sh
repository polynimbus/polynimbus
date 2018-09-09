#!/bin/sh

file=/root/.oci/regions.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-8 hours' +%s` ]; then
	oci iam region list >$file
fi

grep '"name":' $file |awk '{ print $2 }' |sed s/\"//g |sort
