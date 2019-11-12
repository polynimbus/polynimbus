#!/bin/sh
# This script needs to be added to crontab manually. It prepares configuration
# files for s3cmd tool, that are used by separate polynimbus-backup subproject,
# possibly on another server (s3cmd sync operation is memory exhaustive).

out=/var/cache/polynimbus/inventory
path=/var/cache/polynimbus/aws/s3cmd
mkdir -p -m 0700 $path

accounts=`cat $out/object-storage.list |grep ^aws |grep " s3 " |cut -d' ' -f2 |sort |uniq`
for account in $accounts; do

	access=`/opt/polynimbus/drivers/aws/get-account-credentials.sh $account access`
	secret=`/opt/polynimbus/drivers/aws/get-account-credentials.sh $account secret`

	buckets=`cat $out/object-storage.list |grep "^aws $account s3 " |cut -d' ' -f5`
	for bucket in $buckets; do

		file="$path/$account-$bucket.ini"
		if [ ! -f $file ]; then

			region=`/opt/polynimbus/drivers/aws/get-s3-region.php $account $bucket`
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
done
