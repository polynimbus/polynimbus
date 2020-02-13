#!/bin/sh

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf /var/cache/polynimbus/aws/list-cognito.blacklist`
for account in $accounts; do
	regions=`/opt/polynimbus/drivers/aws/infrastructure/list-all-regions.sh $account |egrep -v "(us-west-1|eu-north-1|eu-west-3|sa-east-1)"`
	for region in $regions; do
		/opt/polynimbus/drivers/aws/database/list-cognito-pools.php $account $region |sed -e "s/^/aws $account $region /"
	done
done
