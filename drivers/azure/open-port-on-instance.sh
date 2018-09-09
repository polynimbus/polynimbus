#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <region> <instance-name> <port>"
	exit 1
fi

region=$1
name=$2
port=$3
group=`/opt/polynimbus/drivers/azure/get-group-name.sh $region`

az vm open-port --resource-group $group --name $name --port $port --output json
