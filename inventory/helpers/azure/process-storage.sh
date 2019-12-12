#!/bin/bash

file=$1
out=/var/cache/polynimbus/storage


accounts=`grep ^azure $file |cut -d' ' -f2 |sort |uniq`
for account in $accounts; do


	shares=`grep "^azure $account files " $file |awk '{ print $7 ":" $5 }'`
	for entry in $shares; do

		storage="${entry%:*}"
		share="${entry##*:}"

		/opt/polynimbus/drivers/azure/list-storage-files-recursive.php $account $storage $share \
			|/opt/polynimbus/common/save.sh 0 $out azfile-$account-$storage-$share.list
	done


	blobs=`grep "^azure $account blobs " $file |awk '{ print $7 ":" $5 }'`
	for entry in $blobs; do

		storage="${entry%:*}"
		container="${entry##*:}"

		/opt/polynimbus/drivers/azure/list-storage-blobs.sh $account $storage $container \
			|/opt/polynimbus/common/save.sh 0 $out azblob-$account-$storage-$container.list
	done


done
