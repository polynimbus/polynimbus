#!/bin/bash

out=/var/cache/polynimbus/inventory

/opt/polynimbus/inventory/helpers/list-zones.sh \
	|/opt/polynimbus/common/save.sh 0 $out zones.list


accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf /var/cache/polynimbus/aws/list-zones.blacklist`
for account in $accounts; do
	/opt/polynimbus/inventory/helpers/aws/process-dns.sh $account
done

accounts=`/opt/polynimbus/api/v1/account/list.sh azure`
for account in $accounts; do
	/opt/polynimbus/inventory/helpers/azure/process-dns.sh $account
done

accounts=`/opt/polynimbus/api/v1/account/list.sh cloudflare`
for account in $accounts; do
	/opt/polynimbus/inventory/helpers/cloudflare/process-dns.sh $account
done

accounts=`/opt/polynimbus/api/v1/account/list.sh linode`
for account in $accounts; do
	/opt/polynimbus/inventory/helpers/linode/process-dns.sh $account
done


map=`cat $out/zones.list |grep ^godaddy |awk '{ print $2 ":" $4 }'`
for entry in $map; do

	account="${entry%:*}"
	domain="${entry##*:}"

	/opt/polynimbus/api/v1/zone/list-records.sh godaddy $account $domain \
		|/opt/polynimbus/common/save.sh 10 $out zone-godaddy-$account-$domain.zone

	/opt/polynimbus/drivers/godaddy/get.sh $account domains/$domain |python -m json.tool \
		|/opt/polynimbus/common/save.sh 10 $out raw-godaddy-domain-$account-$domain.json
done

accounts=`/opt/polynimbus/api/v1/account/list.sh godaddy`
for account in $accounts; do
	/opt/polynimbus/api/v1/zone/list.sh godaddy $account --raw \
		|/opt/polynimbus/common/save.sh 10 $out raw-godaddy-alldomains-$account.json
done
