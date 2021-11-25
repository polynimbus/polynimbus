#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/robot/$1.ini ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

result=`hetznerctl list -c ~/.polynimbus/accounts/robot/$1.ini 2>&1 |grep hetzner.RobotError`

if [ "$result" != "" ]; then
	echo "error: Hetzner Online account \"$1\" has invalid credentials"
fi
