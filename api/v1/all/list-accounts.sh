#!/bin/sh

for vendor in `ls /opt/polynimbus/drivers`; do
	echo "$vendor:"
	accounts=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $accounts; do
		echo "\t$account"
	done
done
