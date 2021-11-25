#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/hetzner/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
. ~/.polynimbus/accounts/hetzner/$account.sh

if [ "$2" = "--full" ]; then
	/opt/polynimbus/drivers/hetzner/support/hcloud datacenter list
else
	/opt/polynimbus/drivers/hetzner/support/hcloud datacenter list |awk '{ print $2 }' |grep -v ^NAME
fi
