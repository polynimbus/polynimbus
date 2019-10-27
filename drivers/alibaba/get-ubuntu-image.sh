#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif ! grep -q "\[profile $1\]" /root/.aliyuncli/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

# As of 2018-08-25, Alibaba Cloud doesn't support Ubuntu 18.04 LTS yet.

account=$1
osname="ubuntu_16"

/opt/polynimbus/drivers/alibaba/get-os-image.sh $account $osname
