#!/bin/sh

accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh |grep -vxFf /var/cache/polynimbus/aws/list-users.blacklist`
for account in $accounts; do
	region=`/opt/polynimbus/drivers/aws/get-configured-region.sh $account`
	echo "$account $region"
done
