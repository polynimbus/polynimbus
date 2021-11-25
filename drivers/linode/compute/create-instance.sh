#!/bin/sh

if [ "$4" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> <instance-type> <image-name> [region]"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/linode/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
key=$2
type=$3
image=$4
region=$5
. ~/.polynimbus/accounts/linode/$account.sh

if [ "$region" = "" ]; then
	region=$LINODE_DEFAULT_REGION
fi

privkey=`/opt/polynimbus/drivers/linode/ssh/get-key-path.sh $key`
pubkey=$privkey.pub
random=`date +%s |md5sum |head -c 4`
alias=$key-$random

if [ "$privkey" = "-" ] || [ ! -f $pubkey ]; then
	echo "error: ssh key for \"$key\" not found"
	exit 0
fi

public="`cat $pubkey`"
curl -sS -X POST \
	-H "Authorization: Bearer $LINODE_API_TOKEN" \
	-H "Content-Type: application/json" \
	-X POST -d "{
\"backups_enabled\": false,
\"image\": \"$image\",
\"authorized_keys\": [\"$public\"],
\"root_pass\": \"$LINODE_DEFAULT_ROOT_PASSWORD\",
\"label\": \"$alias\",
\"type\": \"$type\",
\"region\": \"$region\"
}" \
	https://api.linode.com/v4/linode/instances |/opt/polynimbus/drivers/linode/internal/parse-instances.php
