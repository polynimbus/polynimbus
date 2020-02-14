#!/bin/sh

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf /var/cache/polynimbus/aws/list-serverless.blacklist`
for account in $accounts; do
	regions=`/opt/polynimbus/api/v1/region/list-available.sh aws $account`
	for region in $regions; do
		/opt/polynimbus/api/v1/function/list.sh aws $account $region |sort |sed -e "s/^/aws $account $region /"
	done
done

for vendor in `/opt/polynimbus/api/v1/all/list-vendors.sh serverless |grep -v aws`; do
	accounts=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $accounts; do
		/opt/polynimbus/api/v1/function/list.sh $vendor $account |sort |sed -e "s/^/$vendor $account /"
	done
done
