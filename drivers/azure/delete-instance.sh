#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <region> <instance-name>"
	exit 1
fi

region=$1
name=$2
group=`/opt/polynimbus/drivers/azure/get-group-name.sh $region`

az vm delete --resource-group $group --name $name --yes --output json
