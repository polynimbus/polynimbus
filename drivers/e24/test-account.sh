#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
fi

account=$1
result=`/opt/polynimbus/api/v1/region/list-available.sh e24 $account |grep poznan`

if [ "$result" = "" ]; then
	echo "error: e24cloud.com account \"$1\" has invalid credentials"
fi
