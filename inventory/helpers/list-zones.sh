#!/bin/sh

# TODO: support for other vendors

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf /var/cache/polynimbus/aws/list-zones.blacklist`
for account in $accounts; do
	/opt/polynimbus/api/v1/zone/list.sh aws $account |sed -e "s/^/aws $account /"
done

for vendor in `/opt/polynimbus/api/v1/all/list-vendors.sh dns |grep -v aws`; do
	accounts=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $accounts; do
		/opt/polynimbus/api/v1/zone/list.sh $vendor $account |sed -e "s/^/$vendor $account /"
	done
done
