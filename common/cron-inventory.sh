#!/bin/sh

out=/var/cache/polynimbus/inventory

/opt/polynimbus/api/v1/all/list-instances.sh 2>/dev/null \
	|/opt/polynimbus/common/save.sh $out instances.list

/opt/polynimbus/api/v1/all/list-databases.sh 2>/dev/null \
	|/opt/polynimbus/common/save.sh $out databases.list

/opt/polynimbus/api/v1/all/list-zones.sh 2>/dev/null \
	|/opt/polynimbus/common/save.sh $out zones.list


# stderr is NOT redirected to /dev/null, so expect to receive a lot of errors like that:
#
# An error occurred (InvalidAMIID.NotFound) when calling the DescribeImages operation: The image id '[ami-039950f07c4a0d878]' does not exist
#
# you should get only one error per ami-id - but if you get different errors, go
# to /var/cache/polynimbus/aws/describe-images directory and remove empty files
# (you can do it manually or by running clean-empty-describe-images.sh script)
#
account=`/opt/polynimbus/api/v1/account/list.sh aws |head -n1`
AMIS1=`/opt/polynimbus/drivers/aws/list-ami-raw-data.sh --all |egrep -o 'ami-[0-9a-f]{8,17}' |uniq`
AMIS2=`grep ^aws $out/instances.list |awk '{ print $9 }' |sort |uniq`
for amiid in $AMIS1 $AMIS2; do
	/opt/polynimbus/drivers/aws/get-ami-image-name.sh $account $amiid --quiet
done
