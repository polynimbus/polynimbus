#!/bin/bash

file=$1
out=~/.polynimbus/storage


buckets=`grep ^aws $file |grep " s3 " |awk '{ print $2 ":" $5 }'`
for entry in $buckets; do

	account="${entry%:*}"
	bucket="${entry##*:}"

	/opt/polynimbus/drivers/aws/storage/list-s3-objects.php $account $bucket \
		|/opt/polynimbus/common/save.sh 0 $out s3-$account-$bucket.list
done
