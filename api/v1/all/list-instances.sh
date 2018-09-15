#!/bin/sh

for vendor in `ls /opt/polynimbus/drivers`; do
	ACCS=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $ACCS; do
		echo "# $vendor $account"
		/opt/polynimbus/api/v1/instance/list.sh $vendor $account
	done
done
