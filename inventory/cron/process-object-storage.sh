#!/bin/bash

out=/var/cache/polynimbus/inventory

/opt/polynimbus/inventory/helpers/list-object-storage.sh \
	|/opt/polynimbus/common/save.sh 0 $out object-storage.list


buckets=`cat $out/object-storage.list |grep ^aws |grep " s3 " |awk '{ print $2 ":" $4 }'`
for entry in $buckets; do

	account="${entry%:*}"
	bucket="${entry##*:}"

	/opt/polynimbus/drivers/aws/list-s3-objects.php $account $bucket \
		|/opt/polynimbus/common/save.sh 0 $out s3-$account-$bucket.list
done
