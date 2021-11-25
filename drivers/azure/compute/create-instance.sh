#!/bin/sh

if [ "$4" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> <instance-type> <image-name> [region]"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
key=$2
type=$3
image=$4
region=$5
. ~/.polynimbus/accounts/azure/$account.sh

if [ "$region" = "" ]; then
	region=$AZURE_LOCATION
fi

privkey=`/opt/polynimbus/drivers/azure/ssh/get-key-path.sh $key`
pubkey=$privkey.pub
random=`date +%s |md5sum |head -c 4`
alias=$key-$random

if [ "$privkey" = "-" ] || [ ! -f $pubkey ]; then
	echo "error: ssh key for \"$key\" not found"
	exit 0
fi

group=`/opt/polynimbus/drivers/azure/get-resource-group-name.sh $region`
/opt/polynimbus/drivers/azure/create-resource-group.sh $account $group $region >/dev/null

az vm create \
	--subscription $AZURE_SUBSCRIPTION \
	--name $alias \
	--size $type \
	--resource-group $group \
	--admin-username ubuntu \
	--public-ip-address-dns-name $alias \
	--location $region \
	--image $image \
	--ssh-key-value $pubkey \
	--output json \
	|/opt/polynimbus/drivers/azure/internal/parse-create.php $type $image

dt=`date +%Y-%m-%d`
echo "$alias $dt $key" >>~/.polynimbus/cache/azure/created.list

# example output:
# test1-7761.eastus.cloudapp.azure.com running test1 eastus Standard_A2 test1-7761 Canonical:UbuntuServer:18.04-LTS:latest 2018-06-17 test-key=test-value;test-key2=test-value2
