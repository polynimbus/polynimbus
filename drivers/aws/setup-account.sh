#!/bin/sh
. /opt/polynimbus/common/functions

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif grep -q "\[$1\]" /root/.aws/credentials; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

account=$1
aws configure --profile $account

if ! grep -q "\[$account\]" /root/.aws/credentials; then
	echo "error: cloud account \"$account\" left unconfigured"
	exit 1
fi
