#!/bin/sh

if [ "$5" = "" ]; then
	echo "usage: $0 <vendor> <cloud-account> <ssh-key-name> <instance-type> <image-name> [region]"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

vendor=$1
account=$2
key=$3
type=$4
image=$5
region=$6

if [ -x /opt/polynimbus/drivers/$vendor/compute/create-instance.sh ]; then
	/opt/polynimbus/drivers/$vendor/compute/create-instance.sh $account $key $type $image $region
else
	echo "error: cloud vendor \"$vendor\" does not support creating compute instances"
	exit 1
fi
