#!/bin/sh

# TODO: support for other vendors (even with empty implementations in drivers)

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf /var/cache/polynimbus/aws/list-storage.blacklist`
for account in $accounts; do
	/opt/polynimbus/drivers/aws/storage/list-s3-buckets.php $account |sed -e "s/^/aws $account s3 /"
done

accounts=`/opt/polynimbus/api/v1/account/list.sh azure`
for account in $accounts; do
	/opt/polynimbus/inventory/helpers/azure/list-storage.sh $account |sed -e "s/^/azure $account /"
done
