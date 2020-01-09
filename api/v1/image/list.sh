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

if [ -x /opt/polynimbus/drivers/$vendor/infrastructure/list-images.php ]; then
	/opt/polynimbus/drivers/$vendor/infrastructure/list-images.php $@
elif [ -x /opt/polynimbus/drivers/$vendor/infrastructure/list-images.sh ]; then
	/opt/polynimbus/drivers/$vendor/infrastructure/list-images.sh $@
fi
