#!/bin/sh

out=/var/cache/polynimbus/inventory

/opt/polynimbus/inventory/helpers/aws/list-trails.sh \
	|/opt/polynimbus/common/save.sh 0 $out trails.list

/opt/polynimbus/inventory/helpers/list-encryption-keys.sh \
	|/opt/polynimbus/common/save.sh 0 $out encryption-keys.list


accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf /var/cache/polynimbus/aws/list-compute.blacklist`
for account in $accounts; do
	regions=`/opt/polynimbus/inventory/helpers/aws/list-active-regions.sh $account`
	for region in $regions; do
		/opt/polynimbus/inventory/helpers/aws/process-raw-data.sh $account $region
	done
done
