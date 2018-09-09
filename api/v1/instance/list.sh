#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <vendor> <cloud-account>"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

if [ -x /opt/polynimbus/drivers/$1/list-instances.php ]; then
	/opt/polynimbus/drivers/$1/list-instances.php $2
else
	/opt/polynimbus/drivers/$1/list-instances.sh $2
fi
