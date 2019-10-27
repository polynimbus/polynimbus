#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif ! grep -q "\[$1\]" /root/.aws/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
region=`/opt/polynimbus/drivers/aws/get-configured-region.sh $account`

/opt/polynimbus/drivers/aws/list-ami-raw-data.sh |grep $region |egrep -o 'ami-[0-9a-f]{8,17}' |uniq
