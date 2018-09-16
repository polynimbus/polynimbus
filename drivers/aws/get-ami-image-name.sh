#!/bin/bash

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ami-id>"
	exit 1
elif [ ! -f /etc/polynimbus/aws/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
elif ! [[ $2 =~ ^ami-[0-9a-f]+$ ]]; then
	echo "error: parameter $2 not conforming ami-id format"
	exit 1
fi

account=$1
amiid=$2

file=/var/cache/polynimbus/aws/describe-images/$amiid.json

if [ ! -s $file ]; then
	aws --profile $account ec2 describe-images --image-ids $amiid >$file
fi

if [ -s $file ]; then
	basename `grep '"Name":' $file |awk '{ print $2 }' |sed s/\"//g`
fi
