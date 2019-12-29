#!/bin/sh

account=$1

contracts=`/opt/polynimbus/drivers/azure/storage/list-storage-accounts.sh $account all |tr ' ' ':'`
for contract in $contracts; do

	region=`echo "$contract" |cut -d: -f1`
	storage=`echo "$contract" |cut -d: -f2`
	created=`echo "$contract" |cut -d: -f3`

	shares=`/opt/polynimbus/drivers/azure/storage/list-shares.sh $account $storage share |cut -d' ' -f1`
	for share in $shares; do
		echo "files $region $share $created $storage"
	done

	blobs=`/opt/polynimbus/drivers/azure/storage/list-shares.sh $account $storage container |cut -d' ' -f1`
	for blob in $blobs; do
		echo "blobs $region $blob $created $storage"
	done
done
