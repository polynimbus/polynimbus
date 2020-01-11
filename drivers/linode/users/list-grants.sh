#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <username>"
	exit 1
elif [ ! -f /etc/polynimbus/linode/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
username=$2
/opt/polynimbus/drivers/linode/get.sh $account v4/account/users/$username/grants
