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

if [ -x /opt/polynimbus/drivers/$vendor/serverless/list-functions.php ]; then
	/opt/polynimbus/drivers/$vendor/serverless/list-functions.php $@
elif [ -x /opt/polynimbus/drivers/$vendor/serverless/list-functions.sh ]; then
	/opt/polynimbus/drivers/$vendor/serverless/list-functions.sh $@
fi
