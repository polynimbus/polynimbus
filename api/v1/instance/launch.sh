#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <vendor> <cloud-account> <ssh-key-name> [instance-type] [image-name] [region]"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

vendor=$1
account=$2
key=$3
region=$6
path=/opt/polynimbus/api/v1

if [ "$4" != "" ]; then
	type=$4
else
	type=`$path/instance-type/get-default.sh $vendor $account`
fi

if [ "$5" != "" ]; then
	image=$5
else
	image=`$path/image/get-ubuntu.sh $vendor $account`
fi

$path/key/create.sh $vendor $account $key >/dev/null

instance=`$path/instance/create.sh $vendor $account $key $type $image $region`

host=`echo $instance |cut -d' ' -f1`
state=`echo $instance |cut -d' ' -f2`
name=`echo $instance |cut -d' ' -f6`

if [ "$state" = "running" ] && [ "$host" != "-" ]; then
	echo $instance
else
	$path/instance/wait.sh $vendor $account $name
fi
