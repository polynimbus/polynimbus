#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type] [--async]"
	exit 1
elif [ "`which gcloud 2>/dev/null`" = "" ]; then
	echo "error: gcloud command line client not found"
	exit 1
elif [ "$1" != "default" ]; then
	echo "error: gcloud command line client supports only one account, named \"default\""
	exit 1
fi

key=$2
type=$3

/opt/polynimbus/drivers/google/create-ssh-key.sh unused $key >/dev/null
host=`/opt/polynimbus/drivers/google/create-instance.sh $key $type |awk '{ print $1 }'`

if [ "$host" = "" ]; then
	exit 1
fi

if [ "$4" = "--async" ]; then
	exit 0
fi

echo $host
