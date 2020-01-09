#!/bin/sh

if [ "$1" = "" ]; then exit 0; fi
instance=$1
path=/var/cache/polynimbus/oracle

if [ "$2" != "--full" ]; then
	grep $instance $path/images.map |cut -d: -f2
else
	os=`grep $instance $path/images.map |cut -d: -f3`
	ver=`grep $instance $path/images.map |cut -d: -f2`
	echo "$os $ver"
fi
