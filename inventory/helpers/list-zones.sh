#!/bin/sh

for vendor in `ls /opt/polynimbus/drivers`; do
	accounts=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $accounts; do
		/opt/polynimbus/api/v1/zone/list.sh $vendor $account |sed -e "s/^/$vendor $account /"
	done
done
