#!/bin/bash

out=/var/cache/polynimbus/inventory

/opt/polynimbus/inventory/helpers/aws/list-cognito-pools.sh \
	|/opt/polynimbus/common/save.sh 0 $out cognito-pools.list


pools=`cat $out/cognito-pools.list |awk '{ print $2 ":" $5 }'`
for entry in $pools; do

	account="${entry%:*}"
	poolid="${entry##*:}"
	region="${poolid%_*}"

	/opt/polynimbus/drivers/aws/database/list-cognito-users.php $account $poolid $region \
		|/opt/polynimbus/common/save.sh 0 $out cognito-$poolid.list
done
