#!/bin/bash

file=$1
out=~/.polynimbus/storage


buckets=`grep ^backblaze $file |grep " b2 " |awk '{ print $2 ":" $5 }'`
for entry in $buckets; do

	account="${entry%:*}"
	bucket="${entry##*:}"

	/opt/polynimbus/drivers/b2/storage/list-files.sh $account $bucket \
		|/opt/polynimbus/common/save.sh 0 $out b2-$account-$bucket.list
done
