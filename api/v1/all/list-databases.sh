#!/bin/sh

for vendor in `ls /opt/polynimbus/drivers`; do
	ACCS=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $ACCS; do
		/opt/polynimbus/api/v1/database/list.sh $vendor $account |sed -e "s/^/$vendor $account /"
	done
done
