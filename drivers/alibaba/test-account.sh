#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif ! grep -q "\[profile $1\]" /root/.aliyuncli/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
result=`aliyuncli ecs DescribeRegions --profile $account |grep southeast`

if [ "$result" = "" ]; then
	echo "error: Alibaba Cloud account \"$1\" has invalid credentials"
fi
