#!/bin/sh

for PR in `ls /opt/polynimbus/drivers`; do
	echo "$PR:"
	ACCS=`/opt/polynimbus/api/v1/account/list.sh $PR`
	for acc in $ACCS; do
		echo "\t$acc"
	done
done
