#!/bin/sh

out=/var/cache/polynimbus/inventory

/opt/polynimbus/inventory/helpers/list-instances.sh \
	|/opt/polynimbus/common/save.sh 14 $out instances.list

/opt/polynimbus/inventory/helpers/aws/resolve-ami-images.sh


accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh |grep -vxFf /var/cache/polynimbus/aws/list-sg.blacklist`
for account in $accounts; do

	regions=`/opt/polynimbus/inventory/helpers/aws/list-active-regions.sh $account`
	for region in $regions; do
		/opt/polynimbus/drivers/aws/list-security-groups.php $account $region --raw \
			|/opt/polynimbus/common/save.sh 14 $out acl-aws-$account-$region.json
	done

	/opt/polynimbus/drivers/aws/list-network.sh $account elb describe-load-balancers \
		|/opt/polynimbus/common/save.sh 0 $out elb-$account.json

	/opt/polynimbus/drivers/aws/list-network.sh $account elbv2 describe-load-balancers \
		|/opt/polynimbus/common/save.sh 0 $out elbv2-$account.json
done
