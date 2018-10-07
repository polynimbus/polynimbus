#!/bin/sh

/opt/polynimbus/drivers/azure/test-account.sh
/opt/polynimbus/drivers/google/test-account.sh

for vendor in `ls /opt/polynimbus/drivers |egrep -v "(azure|google)"`; do
	ACCS=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $ACCS; do
		/opt/polynimbus/api/v1/account/test.sh $vendor $account
	done
done
