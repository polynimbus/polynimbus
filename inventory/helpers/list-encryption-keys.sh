#!/bin/sh

# TODO: support for other vendors (even with empty implementations in drivers)

accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh`
for account in $accounts; do
	regions=`/opt/polynimbus/api/v1/region/list-available.sh aws $account`
	for region in $regions; do
		/opt/polynimbus/drivers/aws/list-encryption-keys.php $account $region |sed -e "s/^/aws $account /"
	done
done
