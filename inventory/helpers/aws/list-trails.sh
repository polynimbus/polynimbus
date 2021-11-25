#!/bin/sh

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf ~/.polynimbus/settings/aws/list-trails.blacklist`
for account in $accounts; do
	regions=`/opt/polynimbus/api/v1/region/list-available.sh aws $account`
	for region in $regions; do
		/opt/polynimbus/drivers/aws/storage/list-trails.php $account $region |sed -e "s/^/aws $account /"
	done
done
