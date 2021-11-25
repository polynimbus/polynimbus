#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif ! grep -q "\[$1\]" ~/.aws/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
file=~/.polynimbus/cache/aws/regions-$account.list

if [ ! -s $file ]; then
	aws --profile $account ec2 describe-regions |jq -r '.Regions[].RegionName' |sort >$file
fi

cat $file
