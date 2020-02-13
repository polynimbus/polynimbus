#!/bin/sh

# TODO: support for other vendors, see list-databases.sh script

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf /var/cache/polynimbus/aws/list-nosql.blacklist`
for account in $accounts; do
	regions=`/opt/polynimbus/drivers/aws/infrastructure/list-all-regions.sh $account`
	for region in $regions; do
		/opt/polynimbus/drivers/aws/database/list-nosql-tables.php $account $region |sed -e "s/^/aws $account $region /"
	done
done
