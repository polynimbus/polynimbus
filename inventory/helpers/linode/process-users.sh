#!/bin/bash

account=$1
out=~/.polynimbus/inventory


/opt/polynimbus/drivers/linode/users/list-users.sh $account \
	|/opt/polynimbus/common/save.sh 10 $out users-linode-$account.list


map=`cat $out/users-linode-$account.list |awk '{ print $1 ":" $4 }'`
for entry in $map; do

	username="${entry%:*}"
	restricted="${entry##*:}"

	if [ "$restricted" = 1 ]; then
		/opt/polynimbus/drivers/linode/users/list-grants.sh $account $username \
			|python -m json.tool \
			|/opt/polynimbus/common/save.sh 10 $out raw-linode-grants-$account-$username.json
	fi
done
