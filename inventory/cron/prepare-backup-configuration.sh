#!/bin/bash
# This script needs to be added to crontab manually. It prepares configuration
# files for Amazon S3 storage buckets, and Microsoft Azure Storage accounts, that
# are used by separate polynimbus-backup subproject, possibly on another server.

list=~/.polynimbus/inventory/storage.list


accounts=`grep ^aws $list |grep ' s3 ' |cut -d' ' -f2 |sort |uniq`
for account in $accounts; do

	access=`/opt/polynimbus/drivers/aws/storage/get-account-credentials.sh $account access`
	secret=`/opt/polynimbus/drivers/aws/storage/get-account-credentials.sh $account secret`

	if [ ${access:0:4} != "ASIA" ]; then
		buckets=`grep "^aws $account s3 " $list |cut -d' ' -f5`
		for bucket in $buckets; do

			file="/var/cache/polynimbus/aws/s3cmd/$account-$bucket.ini"
			if [ ! -f $file ]; then

				region=`/opt/polynimbus/drivers/aws/storage/get-s3-region.php $account $bucket`
				echo "configuring new S3 bucket: $account/$bucket (region $region, access key $access)"
				echo "[default]
access_key = $access
secret_key = $secret
bucket_location = $region
use_https = True
stop_on_error = False
" >$file
			fi
		done
	fi
done


entries=`grep ^azure $list |grep ' files ' |awk '{ print $2 ":" $7 }' |sort |uniq`
for entry in $entries; do

	account="${entry%:*}"
	storage="${entry##*:}"
	password=`/opt/polynimbus/drivers/azure/storage/get-storage-account-key.sh $account $storage`

	file="/var/cache/polynimbus/azure/storage-accounts/$account-$storage.cifs"
	if [ ! -f $file ]; then
		echo "configuring new Azure Storage account: $account/$storage"
		echo "username=$storage
password=$password" >$file
	fi
done
