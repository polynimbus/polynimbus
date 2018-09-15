#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type]"
	exit 1
fi

account=$1
key=$2
type=$3

/opt/polynimbus/drivers/rackspace/create-ssh-key.sh $account $key >/dev/null
/opt/polynimbus/drivers/rackspace/create-instance.sh $account $key $type
