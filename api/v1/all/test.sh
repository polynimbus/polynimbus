#!/bin/sh

/opt/polynimbus/drivers/google/test-account.sh

for vendor in `/opt/polynimbus/api/v1/all/list-vendors.sh |grep -v google`; do
	accounts=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $accounts; do
		/opt/polynimbus/api/v1/account/test.sh $vendor $account
	done
done
