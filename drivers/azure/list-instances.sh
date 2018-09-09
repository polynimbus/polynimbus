#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <region>"
	exit 1
fi

region=$1
file=/root/.azure/instances.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-2 minutes' +%s` ]; then
	az vm list --show-details >$file 2>&1
fi

input=`cat $file |/opt/polynimbus/drivers/azure/internal/parse-instances.php |grep $region`

if [ "$2" = "--fqdn" ]; then
	echo "$input" |awk '{ print $1 }'
elif [ "$2" = "--name" ]; then
	echo "$input" |awk '{ print $1 }' |cut -d. -f1
else
	echo "$input"
fi

# example full output:
# test1-0143.eastus.cloudapp.azure.com running test1 eastus Standard_A2 test1-0143 16.04.0-LTS
# test1-1e3b.eastus.cloudapp.azure.com running test1 eastus Standard_A1 test1-1e3b 16.04.0-LTS
# test1-7761.eastus.cloudapp.azure.com running test1 eastus Standard_A0 test1-7761 16.04.0-LTS
