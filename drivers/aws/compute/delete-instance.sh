#!/bin/bash

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-id>"
	exit 1
elif ! grep -q "\[$1\]" ~/.aws/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
elif ! [[ $2 =~ ^i-[0-9a-f]+$ ]]; then
	echo "error: parameter $2 not conforming instance id format"
	exit 1
fi

account=$1
instance=$2

aws --profile $account ec2 terminate-instances --instance-ids $instance
