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

/opt/polynimbus/api/v1/key/create.sh $vendor $account $key >/dev/null

instance=`/opt/polynimbus/api/v1/instance/create.sh $vendor $account $key $type`

host=`echo $instance |cut -d' ' -f1`
state=`echo $instance |cut -d' ' -f2`
name=`echo $instance |cut -d' ' -f6`

if [ "$state" = "running" ] && [ "$host" != "-" ]; then
	echo $instance
else
	/opt/polynimbus/api/v1/instance/wait.sh $vendor $account $name
fi
