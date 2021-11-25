#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [...]"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/b2/$1.db ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
shift
B2_ACCOUNT_INFO=~/.polynimbus/accounts/b2/$account.db b2 $@
