#!/bin/bash

account=$1
out=/var/cache/polynimbus/inventory

map=`cat $out/zones.list |grep "^aws $account " |awk '{ print $3 ":" $4 }'`
for entry in $map; do

	domain="${entry%:*}"
	zoneid="${entry##*:}"

	/opt/polynimbus/api/v1/zone/list-records.sh aws $account $zoneid \
		|/opt/polynimbus/common/save.sh 14 $out zone-aws-$account-$domain.zone
done
