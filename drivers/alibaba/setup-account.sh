#!/bin/sh
. /opt/polynimbus/common/functions

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif grep -q "\[profile $1\]" /root/.aliyuncli/credentials; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

account=$1
aliyuncli configure --profile $account

if ! grep -q "\[profile $account\]" /root/.aliyuncli/credentials; then
	echo "error: cloud account \"$account\" left unconfigured"
	exit 1
fi
