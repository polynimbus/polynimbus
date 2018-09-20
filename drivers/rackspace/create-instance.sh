#!/bin/sh

if [ "$4" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> <instance-type> <image-name>"
	exit 1
elif [ ! -f /etc/polynimbus/rackspace/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
key=$2
type=$3
image="$4"
random=`date +%s |md5sum |head -c 4`

. /etc/polynimbus/rackspace/$account.sh

/opt/polynimbus/drivers/rackspace/support/rack servers instance create \
	--name $key-$random \
	--flavor-id $type \
	--keypair $key \
	--image-name "$image" \
	--profile $account \
	|grep -v ^ID |awk '{ print $2 " - - - - - -" }'
