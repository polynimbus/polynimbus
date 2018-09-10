#!/bin/sh

/opt/polynimbus/drivers/azure/test-account.sh

for vendor in `ls /opt/polynimbus/drivers |grep -v azure`; do
	ACCS=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $ACCS; do
		/opt/polynimbus/drivers/$vendor/test-account.sh $account
	done
done
