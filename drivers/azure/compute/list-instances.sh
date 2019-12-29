#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [region|all|raw] [--fqdn]"
	exit 1
elif [ ! -f /etc/polynimbus/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
region=$2
mode=$3
file=/var/cache/polynimbus/azure/instances-$account.cache
. /etc/polynimbus/azure/$account.sh

if [ "$region" = "" ]; then
	region=$AZURE_LOCATION
fi

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-2 minutes' +%s` ]; then
	az vm list --subscription $AZURE_SUBSCRIPTION --show-details >$file
fi

if [ "$region" = "raw" ]; then
	cat $file
	exit 0
elif [ "$region" = "all" ]; then
	input=`cat $file |/opt/polynimbus/drivers/azure/internal/parse-instances.php /var/cache/polynimbus/azure/created.list`
else
	input=`cat $file |/opt/polynimbus/drivers/azure/internal/parse-instances.php /var/cache/polynimbus/azure/created.list |grep $region`
fi

if [ "$mode" = "--fqdn" ]; then
	echo "$input" |awk '{ print $1 }'
elif [ "$input" != "" ]; then
	echo "$input"
fi

# example full output:
# test1-0143.eastus.cloudapp.azure.com running test1 eastus Standard_A2 test1-0143 Canonical:UbuntuServer:16.04.0-LTS:latest 2018-06-17 -
# test1-1e3b.eastus.cloudapp.azure.com running test1 eastus Standard_A1 test1-1e3b Canonical:UbuntuServer:16.04.0-LTS:latest 2018-06-17 -
# test1-7761.eastus.cloudapp.azure.com running test1 eastus Standard_A0 test1-7761 Canonical:UbuntuServer:16.04.0-LTS:latest 2018-06-17 -
