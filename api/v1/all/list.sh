#!/bin/sh

for vendor in `ls /opt/polynimbus/drivers`; do
	echo "$vendor:"
	ACCS=`/opt/polynimbus/api/v1/account/list.sh $vendor`
	for account in $ACCS; do
		echo "\t$account"
	done
done
