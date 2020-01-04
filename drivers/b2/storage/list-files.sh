#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <bucket>"
	exit 1
elif [ ! -f /etc/polynimbus/b2/$1.db ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
bucket=$2
/opt/polynimbus/drivers/b2/client.sh $account ls --long --recursive $bucket |grep -v /.bzEmpty |/opt/polynimbus/drivers/b2/internal/parse-files.php
