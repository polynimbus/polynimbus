#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type]"
	exit 1
elif [ ! -f /etc/polynimbus/rackspace/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
key=$2
random=`date +%s |md5sum |head -c 4`

. /etc/polynimbus/rackspace/$account.sh

if [ "$3" != "" ]; then
	type=$3
else
	type=$RACKSPACE_DEFAULT_INSTANCE_TYPE
fi

image="`/opt/polynimbus/drivers/rackspace/get-ubuntu-image.sh $account`"

/opt/polynimbus/drivers/rackspace/support/rack servers instance create \
	--name $key-$random \
	--flavor-id $type \
	--keypair $key \
	--image-name "$image" \
	--profile $account \
	|grep -v ^ID |awk '{ print $2 " - - - - - -" }'
