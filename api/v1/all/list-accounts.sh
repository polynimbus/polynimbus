#!/bin/sh

for vendor in `/opt/polynimbus/api/v1/all/list-vendors.sh`; do
	echo "$vendor:"
	accounts=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $accounts; do
		echo "\t$account"
	done
done
