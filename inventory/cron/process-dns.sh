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

		/opt/polynimbus/api/v1/zone/list-records.sh aws $account $zoneid \
			|/opt/polynimbus/common/save.sh 14 $out zone-aws-$account-$domain.zone
	done
done


accounts=`/opt/polynimbus/api/v1/account/list.sh azure`
for account in $accounts; do

	map=`cat $out/zones.list |grep "^azure $account " |awk '{ print $3 ":" $6 }'`
	for entry in $map; do

		domain="${entry%:*}"
		group="${entry##*:}"

		/opt/polynimbus/api/v1/zone/list-records.sh azure $account $domain $group \
			|/opt/polynimbus/common/save.sh 120 $out raw-azure-zone-$account-$domain.export
	done
done


map=`cat $out/zones.list |grep ^godaddy |awk '{ print $2 ":" $4 }'`
for entry in $map; do

	account="${entry%:*}"
	domain="${entry##*:}"

	/opt/polynimbus/api/v1/zone/list-records.sh godaddy $account $domain \
		|/opt/polynimbus/common/save.sh 10 $out zone-godaddy-$account-$domain.zone

	/opt/polynimbus/drivers/godaddy/dns/get-details.sh $account $domain \
		|/opt/polynimbus/common/save.sh 10 $out raw-godaddy-domain-$account-$domain.json
done

accounts=`/opt/polynimbus/api/v1/account/list.sh godaddy`
for account in $accounts; do
	/opt/polynimbus/api/v1/zone/list.sh godaddy $account --raw \
		|/opt/polynimbus/common/save.sh 10 $out raw-godaddy-alldomains-$account.json
done
