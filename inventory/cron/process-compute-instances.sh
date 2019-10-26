#!/bin/sh

out=/var/cache/polynimbus/inventory

/opt/polynimbus/api/v1/all/list-instances.sh 2>/dev/null \
	|/opt/polynimbus/common/save.sh 14 $out instances.list


# stderr is NOT redirected to /dev/null, so expect to receive a lot of errors like that:
#
# An error occurred (InvalidAMIID.NotFound) when calling the DescribeImages operation: The image id '[ami-039950f07c4a0d878]' does not exist
#
# you should get only one error per ami-id - but if you get different errors, go
# to /var/cache/polynimbus/aws/describe-images directory and remove empty files
# (you can do it manually or by running clean-empty-describe-images.sh script)
#
# TODO: use proper region instead of default from aws-cli configuration
#
account=`/opt/polynimbus/drivers/aws/list-accounts.sh |head -n1`
AMIS1=`/opt/polynimbus/drivers/aws/list-ami-raw-data.sh --all |egrep -o 'ami-[0-9a-f]{8,17}' |uniq`
AMIS2=`grep ^aws $out/instances.list |awk '{ print $9 }' |sort |uniq`
for amiid in $AMIS1 $AMIS2; do
	/opt/polynimbus/drivers/aws/get-ami-image-name.sh $account $amiid --quiet
done


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
