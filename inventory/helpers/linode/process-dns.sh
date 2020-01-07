#!/bin/bash

account=$1
out=/var/cache/polynimbus/inventory


map=`cat $out/zones.list |grep "^linode $account " |awk '{ print $3 ":" $4 }'`
for entry in $map; do

	domain="${entry%:*}"
	zoneid="${entry##*:}"

	/opt/polynimbus/api/v1/zone/list-records.sh linode $account $zoneid $domain \
		|/opt/polynimbus/common/save.sh 10 $out zone-linode-$account-$domain.zone
done
