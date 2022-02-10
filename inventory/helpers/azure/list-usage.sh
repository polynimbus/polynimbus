#!/bin/sh

account=$1

regions=`/opt/polynimbus/api/v1/region/list-available.sh azure $account |grep -xFf /opt/polynimbus/drivers/azure/config/regions-supporting-usage.conf`
for region in $regions; do
	/opt/polynimbus/drivers/azure/list-usage.sh $account $region |sed -e "s/^/$region /"
done
