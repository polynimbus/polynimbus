#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif ! grep -q "\[profile $1\]" ~/.aliyuncli/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

# TODO: parse output and print single-line instance descriptions, just like for other cloud vendors

account=$1
aliyuncli ecs DescribeInstances --profile $account
