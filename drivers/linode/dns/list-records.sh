#!/bin/bash

if [ "$3" = "" ]; then
	echo "usage: $0 <cloud-account> <zone-id> <domain>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/linode/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
elif ! [[ $2 =~ ^[0-9]+$ ]]; then
	echo "error: parameter $2 not conforming zone id format"
	exit 1
fi

account=$1
zoneid=$2
domain=$3
/opt/polynimbus/drivers/linode/get.sh $account v4/domains/$zoneid/records |/opt/polynimbus/drivers/linode/internal/parse-records.php $domain
