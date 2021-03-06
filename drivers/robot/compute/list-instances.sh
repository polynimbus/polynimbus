#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/robot/$1.ini ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
hetznerctl list -c /etc/polynimbus/robot/$account.ini \
	|grep -v ^None \
	|tr '[:upper:]' '[:lower:]' \
	|sed -e s/[\(\),]//g \
	|/opt/polynimbus/drivers/robot/internal/parse-instances.php $account /var/cache/polynimbus/robot/created.list
