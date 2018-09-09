#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type]"
	exit 1
elif [ ! -f /etc/polynimbus/e24/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
. /etc/polynimbus/e24/$account.sh

if [ "$3" != "" ]; then
	type=$3
else
	type=$E24_DEFAULT_INSTANCE_TYPE
fi

ami_id=`/opt/polynimbus/drivers/e24/get-ubuntu-image.sh $account`

/opt/polynimbus/drivers/e24/internal/create-instance.php $account $2 $type $ami_id
