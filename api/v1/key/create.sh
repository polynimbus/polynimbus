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

/opt/polynimbus/drivers/$vendor/compute/create-ssh-key.sh $1 $2
