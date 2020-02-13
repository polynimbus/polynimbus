#!/bin/sh

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf /var/cache/polynimbus/aws/list-trails.blacklist`
for account in $accounts; do
	regions=`/opt/polynimbus/drivers/aws/infrastructure/list-all-regions.sh $account`
	for region in $regions; do
		/opt/polynimbus/drivers/aws/storage/list-trails.php $account $region |sed -e "s/^/aws $account /"
	done
done
