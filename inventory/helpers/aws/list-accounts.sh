#!/bin/sh

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf ~/.polynimbus/settings/aws/list-users.blacklist`
for account in $accounts; do
	region=`/opt/polynimbus/drivers/aws/infrastructure/get-configured-region.sh $account`
	echo "$account $region"
done
