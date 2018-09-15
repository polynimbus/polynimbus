#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <vendor> <cloud-account> <instance-name>"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

if [ -x /opt/polynimbus/drivers/$1/delete-instance.php ]; then
	/opt/polynimbus/drivers/$1/delete-instance.php $2 $3
else
	/opt/polynimbus/drivers/$1/delete-instance.sh $2 $3
fi
