#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [...]"
	exit 1
elif ! grep -q "\[$1\]" ~/.aws/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
shift

aws --profile $account $@ --no-paginate
