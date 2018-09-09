#!/bin/sh

if [ "$1" = "" ]; then exit 0; fi
instance=$1

if [ "$2" != "--full" ]; then
	grep $instance /root/.oci/images.map |cut -d: -f2
else
	os=`grep $instance /root/.oci/images.map |cut -d: -f3`
	ver=`grep $instance /root/.oci/images.map |cut -d: -f2`
	echo "$os $ver"
fi
