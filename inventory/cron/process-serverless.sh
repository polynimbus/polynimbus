#!/bin/bash

out=/var/cache/polynimbus/inventory

/opt/polynimbus/inventory/helpers/list-functions.sh \
	|/opt/polynimbus/common/save.sh 0 $out functions.list


accounts=`/opt/polynimbus/api/v1/account/list.sh azure`
for account in $accounts; do
	/opt/polynimbus/inventory/helpers/azure/process-functions.sh $account
done


entries=`cat $out/functions.list |grep ^aws |awk '{ print $2 ":" $3 }' |sort |uniq`
for entry in $entries; do

	account="${entry%:*}"
	region="${entry##*:}"

	/opt/polynimbus/drivers/aws/get-raw.sh $account --region $region lambda list-functions \
		|/opt/polynimbus/common/save.sh 0 $out raw-aws-functions-$account-$region.json
done


accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf /var/cache/polynimbus/aws/list-serverless.blacklist`
for account in $accounts; do
	/opt/polynimbus/drivers/aws/get-raw.sh $account cloudfront list-distributions \
		|/opt/polynimbus/common/save.sh 0 $out cloudfront-$account.json
done
