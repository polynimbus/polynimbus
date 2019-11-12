#!/bin/bash

groups=$1

entries=`cat $groups |awk '{ print $1 ":" $3 }'`
for entry in $entries; do

	name="${entry%:*}"
	gid="${entry##*:}"

	az ad group member list --group $gid \
		|/opt/polynimbus/drivers/azure/internal/parse-users.php \
		|sed -e "s/^/$name /"
done
