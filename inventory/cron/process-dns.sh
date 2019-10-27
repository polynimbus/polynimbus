#!/bin/bash

out=/var/cache/polynimbus/inventory

/opt/polynimbus/inventory/helpers/list-zones.sh \
	|/opt/polynimbus/common/save.sh 0 $out zones.list


accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh |grep -vxFf /var/cache/polynimbus/aws/list-zones.blacklist`
for account in $accounts; do

	map=`/opt/polynimbus/drivers/aws/list-zones.php $account --map`
	for entry in $map; do

		domain="${entry%:*}"
		zoneid="${entry##*:}"

		/opt/polynimbus/drivers/aws/list-records.php $account $zoneid \
			|/opt/polynimbus/common/save.sh 14 $out zone-aws-$account-$domain.zone
	done
done
