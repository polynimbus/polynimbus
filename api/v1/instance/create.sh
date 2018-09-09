#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <vendor> <cloud-account> <ssh-key-name> [instance-type] [--async]"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

/opt/polynimbus/drivers/$1/create-simple.sh $2 $3 $4 $5
