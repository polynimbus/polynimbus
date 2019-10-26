#!/bin/sh

accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh |grep -vxFf /var/cache/polynimbus/aws/list-serverless.blacklist`
for account in $accounts; do
	/opt/polynimbus/api/v1/function/list.sh aws $account |sort |sed -e "s/^/aws $account /"
done

for vendor in `ls /opt/polynimbus/drivers |grep -v aws`; do
	accounts=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $accounts; do
		/opt/polynimbus/api/v1/function/list.sh $vendor $account |sort |sed -e "s/^/$vendor $account /"
	done
done
