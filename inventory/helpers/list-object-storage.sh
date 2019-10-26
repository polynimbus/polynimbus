#!/bin/sh

# TODO: support for other vendors (even with empty implementations in drivers)

accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh |grep -vxFf /var/cache/polynimbus/aws/list-storage.blacklist`
for account in $accounts; do
	/opt/polynimbus/drivers/aws/list-s3-buckets.php $account |sed -e "s/^/aws $account s3 /"
done
