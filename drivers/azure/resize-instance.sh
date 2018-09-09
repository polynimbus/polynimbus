#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <region> <instance-name> <new-instance-type>"
	exit 1
fi

region=$1
name=$2
type=$3
group=`/opt/polynimbus/drivers/azure/get-group-name.sh $region`

az vm resize --resource-group $group --name $name --size $type --output json
