#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <vendor> <cloud-account> [region]"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

vendor=$1
shift

if [ -x /opt/polynimbus/drivers/$vendor/list-instances.php ]; then
	/opt/polynimbus/drivers/$vendor/list-instances.php $@
else
	/opt/polynimbus/drivers/$vendor/list-instances.sh $@
fi
