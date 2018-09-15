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
region=$HETZNER_REGION

/opt/polynimbus/drivers/hetzner/support/hcloud server create \
	--name $name \
	--type $type \
	--datacenter $region \
	--image $image \
	--ssh-key $key \
	|grep IPv4 \
	|awk '{ print $2 }' \
	|/opt/polynimbus/drivers/hetzner/internal/parse-create.php $name $type $key $region $image

# example output:
# static.181.244.46.78.clients.your-server.de pending test2018 fsn1-dc8 cx11 test2018-06e6 ubuntu-18.04
