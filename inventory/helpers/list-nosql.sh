#!/bin/sh

# TODO: support for other vendors, see list-databases.sh script

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf ~/.polynimbus/settings/aws/list-nosql.blacklist`
for account in $accounts; do
	regions=`/opt/polynimbus/api/v1/region/list-available.sh aws $account`
	for region in $regions; do
		/opt/polynimbus/drivers/aws/database/list-nosql-tables.php $account $region |sed -e "s/^/aws $account $region /"
	done
done
