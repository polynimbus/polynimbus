#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-name> <new-instance-type> [region]"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
name=$2
type=$3
region=$4
. ~/.polynimbus/accounts/azure/$account.sh

if [ "$region" = "" ]; then
	region=$AZURE_LOCATION
fi

group=`/opt/polynimbus/drivers/azure/get-resource-group-name.sh $region`

az vm resize --subscription $AZURE_SUBSCRIPTION --resource-group $group --name $name --size $type --output json
