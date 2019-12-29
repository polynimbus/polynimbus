#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <vendor> <cloud-account>"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

vendor=$1
shift

if [ -x /opt/polynimbus/drivers/$vendor/dns/list-zones.php ]; then
	/opt/polynimbus/drivers/$vendor/dns/list-zones.php $@
else
	/opt/polynimbus/drivers/$vendor/dns/list-zones.sh $@
fi
