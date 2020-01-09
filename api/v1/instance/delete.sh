#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <vendor> <cloud-account> <instance-name> [region]"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

vendor=$1
shift

if [ -x /opt/polynimbus/drivers/$vendor/compute/delete-instance.php ]; then
	/opt/polynimbus/drivers/$vendor/compute/delete-instance.php $@
elif [ -x /opt/polynimbus/drivers/$vendor/compute/delete-instance.sh ]; then
	/opt/polynimbus/drivers/$vendor/compute/delete-instance.sh $@
else
	echo "error: cloud vendor \"$vendor\" does not support deleting compute instances"
	exit 1
fi
