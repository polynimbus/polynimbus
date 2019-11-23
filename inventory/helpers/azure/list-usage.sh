#!/bin/sh

account=$1

regions=`/opt/polynimbus/api/v1/region/list-available.sh azure $account |egrep -v "(australiacentral2|francesouth|germany|norway|southafricawest|switzerland|uaecentral)"`
for region in $regions; do
	/opt/polynimbus/drivers/azure/list-usage.sh $account $region |sed -e "s/^/$region /"
done
