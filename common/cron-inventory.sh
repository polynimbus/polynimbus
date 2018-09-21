#!/bin/sh

/opt/polynimbus/api/v1/all/list-instances.sh 2>/dev/null \
	|/opt/polynimbus/common/save.sh /var/cache/polynimbus/inventory instances.list


AWS=`/opt/polynimbus/api/v1/account/list.sh aws`
for account in $AWS; do
	/opt/polynimbus/drivers/aws/list-users.php $account \
		|/opt/polynimbus/common/save.sh /var/cache/polynimbus/inventory users-aws-$account.list
done
