#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <group-name> [region]"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
group=$2
region=$3
. ~/.polynimbus/accounts/azure/$account.sh

if [ "$region" = "" ]; then
	region=$AZURE_LOCATION
fi

list=`/opt/polynimbus/drivers/azure/list-resource-groups.sh $account $region |grep -Fx $group`

if [ "$list" = "" ]; then
	az group create --subscription $AZURE_SUBSCRIPTION --location $region --name $group
	rm -f ~/.polynimbus/cache/azure/groups-$account-$region.cache
fi
