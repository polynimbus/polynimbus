#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <cloud-account> <domain> <resource-group>"
	exit 1
elif [ ! -f /etc/polynimbus/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
domain=$2
group=$3
. /etc/polynimbus/azure/$account.sh

az network dns zone export --name $domain --resource-group $group --subscription $AZURE_SUBSCRIPTION
