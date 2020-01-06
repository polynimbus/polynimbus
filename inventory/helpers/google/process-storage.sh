#!/bin/bash

file=$1
out=/var/cache/polynimbus/storage


buckets=`grep ^google $file |grep " gs " |awk '{ print $2 ":" $5 }'`
for entry in $buckets; do

	account="${entry%:*}"
	bucket="${entry##*:}"

	/opt/polynimbus/drivers/google/storage/list-gs-files.sh $account $bucket \
		|/opt/polynimbus/common/save.sh 0 $out gs-$account-$bucket.list
done
