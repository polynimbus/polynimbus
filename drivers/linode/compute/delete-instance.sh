#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-id>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/linode/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
instance=$2
. ~/.polynimbus/accounts/linode/$account.sh

curl -sS -X DELETE \
	-H "Authorization: Bearer $LINODE_API_TOKEN" \
	https://api.linode.com/v4/linode/instances/$instance |python2 -m json.tool
