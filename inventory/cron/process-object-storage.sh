#!/bin/bash

out=/var/cache/polynimbus/inventory
out2=/var/cache/polynimbus/storage

/opt/polynimbus/inventory/helpers/list-object-storage.sh \
	|/opt/polynimbus/common/save.sh 0 $out object-storage.list


buckets=`grep ^aws $out/object-storage.list |grep " s3 " |awk '{ print $2 ":" $5 }'`
for entry in $buckets; do

	account="${entry%:*}"
	bucket="${entry##*:}"

	/opt/polynimbus/drivers/aws/list-s3-objects.php $account $bucket \
		|/opt/polynimbus/common/save.sh 0 $out2 s3-$account-$bucket.list
done


accounts=`grep ^azure $out/object-storage.list |cut -d' ' -f2 |sort |uniq`
for account in $accounts; do
	shares=`grep "^azure $account files " $out/object-storage.list |awk '{ print $7 ":" $5 }'`
	for entry in $shares; do

		storage="${entry%:*}"
		share="${entry##*:}"

		/opt/polynimbus/drivers/azure/list-storage-files-recursive.php $account $storage $share \
			|/opt/polynimbus/common/save.sh 0 $out2 azfile-$account-$storage-$share.list
	done
	blobs=`grep "^azure $account blobs " $out/object-storage.list |awk '{ print $7 ":" $5 }'`
	for entry in $blobs; do

		storage="${entry%:*}"
		container="${entry##*:}"

		/opt/polynimbus/drivers/azure/list-storage-blobs.sh $account $storage $container \
			|/opt/polynimbus/common/save.sh 0 $out2 azblob-$account-$storage-$container.list
	done
done
