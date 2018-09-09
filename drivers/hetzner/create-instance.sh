#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type]"
	exit 1
elif [ ! -f /etc/polynimbus/hetzner/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
key=$2
random=`date +%s |md5sum |head -c 4`
name=$key-$random

. /etc/polynimbus/hetzner/$account.sh

if [ "$3" != "" ]; then
	type=$3
else
	type=$HETZNER_DEFAULT_INSTANCE_TYPE
fi

image=`/opt/polynimbus/drivers/hetzner/get-ubuntu-image.sh $account`

/opt/polynimbus/drivers/hetzner/support/hcloud server create \
	--name $name \
	--type $type \
	--datacenter $HETZNER_REGION \
	--image $image \
	--ssh-key $key \
	|grep IPv4 \
	|awk '{ print $2 }' \
	|/opt/polynimbus/drivers/hetzner/internal/parse-create.php
