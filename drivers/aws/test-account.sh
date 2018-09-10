#!/bin/sh

# Valid account -> no messages (unless --arn).
# So this script can be used straight from cron.

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [--arn]"
	exit 1
fi

account=$1
result=`aws --profile $account iam get-user 2>&1 |egrep -o 'arn:aws:iam::[0-9]+:[a-zA-Z0-9/._-]+'`

if [ "$result" = "" ]; then
	echo "error: AWS account \"$1\" has invalid credentials"
elif [ "$2" = "--arn" ]; then
	echo "$result"
fi
