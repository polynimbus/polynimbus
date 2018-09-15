#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <vendor> <cloud-account> <ssh-key-name> [instance-type]"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

vendor=$1
account=$2
key=$3
type=$4

/opt/polynimbus/drivers/$vendor/create-instance.sh $account $key $type
