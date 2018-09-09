#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <vendor>"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

vendor=$1
shift

/opt/polynimbus/drivers/$vendor/list-accounts.sh $@
