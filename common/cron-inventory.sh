#!/bin/sh

out=/var/cache/polynimbus/inventory


/opt/polynimbus/api/v1/all/list-instances.sh 2>/dev/null \
	|/opt/polynimbus/common/save.sh $out instances.list


AWS=`/opt/polynimbus/api/v1/account/list.sh aws`
for account in $AWS; do
	/opt/polynimbus/drivers/aws/list-users.php $account 2>/dev/null \
		|/opt/polynimbus/common/save.sh $out users-aws-$account.list
done
