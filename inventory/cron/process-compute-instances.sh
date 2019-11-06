#!/bin/sh

out=/var/cache/polynimbus/inventory

/opt/polynimbus/inventory/helpers/list-instances.sh \
	|/opt/polynimbus/common/save.sh 14 $out instances.list


# execute right after list-instances.sh to leverage 2 minutes cache
accounts=`/opt/polynimbus/api/v1/account/list.sh azure`
for account in $accounts; do
	/opt/polynimbus/api/v1/instance/list.sh azure $account raw \
		|/opt/polynimbus/common/save.sh 0 $out raw-azure-instances-$account.json
done


/opt/polynimbus/inventory/helpers/aws/resolve-ami-images.sh
