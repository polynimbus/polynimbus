#!/bin/sh

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf /var/cache/polynimbus/aws/list-users.blacklist`
for account in $accounts; do
	region=`/opt/polynimbus/drivers/aws/get-configured-region.sh $account`
	echo "$account $region"
done
