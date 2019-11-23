#!/bin/bash

out=/var/cache/polynimbus/inventory

/opt/polynimbus/inventory/helpers/list-zones.sh \
	|/opt/polynimbus/common/save.sh 0 $out zones.list


accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf /var/cache/polynimbus/aws/list-zones.blacklist`
for account in $accounts; do

	map=`cat $out/zones.list |grep "^aws $account " |awk '{ print $3 ":" $4 }'`
	for entry in $map; do

		domain="${entry%:*}"
		zoneid="${entry##*:}"

		/opt/polynimbus/drivers/aws/list-records.php $account $zoneid \
			|/opt/polynimbus/common/save.sh 14 $out zone-aws-$account-$domain.zone
	done
done


accounts=`/opt/polynimbus/api/v1/account/list.sh azure`
for account in $accounts; do

	map=`cat $out/zones.list |grep "^azure $account " |awk '{ print $3 ":" $6 }'`
	for entry in $map; do

		domain="${entry%:*}"
		group="${entry##*:}"

		/opt/polynimbus/drivers/azure/list-records.sh $account $domain $group \
			|/opt/polynimbus/common/save.sh 120 $out raw-azure-zone-$account-$domain.export
	done
done
