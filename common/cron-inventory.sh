#!/bin/sh

out=/var/cache/polynimbus/inventory


/opt/polynimbus/api/v1/all/list-instances.sh 2>/dev/null \
	|/opt/polynimbus/common/save.sh $out instances.list


AWS=`/opt/polynimbus/api/v1/account/list.sh aws`
for account in $AWS; do
	/opt/polynimbus/drivers/aws/list-users.php $account 2>/dev/null \
		|/opt/polynimbus/common/save.sh $out users-aws-$account.list
done


# stderr is NOT redirected to /dev/null, so expect to receive a lot of errors like that:
#
# An error occurred (InvalidAMIID.NotFound) when calling the DescribeImages operation: The image id '[ami-039950f07c4a0d878]' does not exist
#
# you should get only one error per ami-id - but if you get different errors, go
# to /var/cache/polynimbus/aws/describe-images directory and remove empty files
# (you can do it manually or by running clean-empty-describe-images.sh script)
#
account=`/opt/polynimbus/api/v1/account/list.sh aws |head -n1`
AMIS=`/opt/polynimbus/drivers/aws/list-ami-raw-data.sh --all |egrep -o 'ami-[0-9a-f]{8,17}' |uniq`
for amiid in $AMIS; do
	/opt/polynimbus/drivers/aws/get-ami-image-name.sh $account $amiid --quiet
done
