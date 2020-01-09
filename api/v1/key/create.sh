#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <vendor> <cloud-account> <ssh-key-name>"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

vendor=$1
shift

if [ -x /opt/polynimbus/drivers/$vendor/ssh/create-key.sh ]; then
	/opt/polynimbus/drivers/$vendor/ssh/create-key.sh $@
else
	echo "error: cloud vendor \"$vendor\" does not support creating ssh keys"
	exit 1
fi
