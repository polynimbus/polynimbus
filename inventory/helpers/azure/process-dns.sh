#!/bin/bash

account=$1
out=~/.polynimbus/inventory

map=`cat $out/zones.list |grep "^azure $account " |awk '{ print $3 ":" $6 }'`
for entry in $map; do

	domain="${entry%:*}"
	group="${entry##*:}"

	/opt/polynimbus/api/v1/zone/list-records.sh azure $account $domain $group \
		|/opt/polynimbus/common/save.sh 120 $out raw-azure-zone-$account-$domain.export
done
