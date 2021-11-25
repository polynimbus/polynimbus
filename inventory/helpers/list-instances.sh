#!/bin/sh

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf ~/.polynimbus/settings/aws/list-compute.blacklist`
for account in $accounts; do
	regions=`/opt/polynimbus/api/v1/region/list-available.sh aws $account`
	for region in $regions; do
		/opt/polynimbus/api/v1/instance/list.sh aws $account $region |sed -e "s/^/aws $account /"
	done
done


for vendor in `/opt/polynimbus/api/v1/all/list-vendors.sh compute |egrep -v "(aws|azure)"`; do
	accounts=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $accounts; do
		/opt/polynimbus/api/v1/instance/list.sh $vendor $account |sed -e "s/^/$vendor $account /"
	done
done


accounts=`/opt/polynimbus/api/v1/account/list.sh azure`
for account in $accounts; do
	/opt/polynimbus/api/v1/instance/list.sh azure $account all |sed -e "s/^/azure $account /"
done
