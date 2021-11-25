#!/bin/sh

accounts=`/opt/polynimbus/api/v1/account/list.sh azure`
for account in $accounts; do
	. ~/.polynimbus/accounts/azure/$account.sh
	echo "$account $AZURE_SUBSCRIPTION"
done
