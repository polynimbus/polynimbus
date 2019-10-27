#!/bin/sh

out=/var/cache/polynimbus/inventory

/opt/polynimbus/inventory/helpers/list-functions.sh \
	|/opt/polynimbus/common/save.sh 0 $out functions.list


accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh |grep -vxFf /var/cache/polynimbus/aws/list-serverless.blacklist`
for account in $accounts; do

	/opt/polynimbus/drivers/aws/list-functions.php $account --raw \
		|/opt/polynimbus/common/save.sh 20 $out functions-aws-$account.json

	/opt/polynimbus/drivers/aws/list-network.sh $account cloudfront list-distributions \
		|/opt/polynimbus/common/save.sh 0 $out cloudfront-$account.json
done
