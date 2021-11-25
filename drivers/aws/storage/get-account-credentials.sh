#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <type>"
	exit 1
elif ! grep -q "\[$1\]" ~/.aws/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
type=$2

if [ "$type" = "secret" ]; then
	token="aws_secret_access_key"
else
	token="aws_access_key_id"
fi

egrep "^(\[|a)" ~/.aws/credentials |sed s/\ //g |grep -F -A3 "[$account]" |grep $token |cut -d= -f2
