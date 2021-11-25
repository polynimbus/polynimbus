#!/bin/sh

# TODO: support for other vendors (even with empty implementations in drivers)

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf ~/.polynimbus/settings/aws/list-encryption.blacklist`
for account in $accounts; do
	regions=`/opt/polynimbus/api/v1/region/list-available.sh aws $account`
	for region in $regions; do
		/opt/polynimbus/drivers/aws/list-encryption-keys.php $account $region |sed -e "s/^/aws $account $region /"
	done
done
