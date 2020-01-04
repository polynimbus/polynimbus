#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/b2/$1.db ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
/opt/polynimbus/drivers/b2/client.sh $account list-buckets |awk '{ print "- " $3 " - -" }'
