#!/bin/sh

# TODO: support for other vendors (even with empty implementations in drivers)

# format:
# - vendor
# - account
# - service type
# - region (optional)
# - share/bucket/other name (optional)
# - created date (optional)
# - group/contract/parent/other id (optional)

accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf ~/.polynimbus/settings/aws/list-storage.blacklist`
for account in $accounts; do
	/opt/polynimbus/drivers/aws/storage/list-s3-buckets.php $account |sed -e "s/^/aws $account s3 - /" -e "s/$/ -/"
done

accounts=`/opt/polynimbus/api/v1/account/list.sh azure`
for account in $accounts; do
	/opt/polynimbus/inventory/helpers/azure/list-storage.sh $account
done

accounts=`/opt/polynimbus/api/v1/account/list.sh b2`
for account in $accounts; do
	/opt/polynimbus/drivers/b2/storage/list-buckets.sh $account |sed -e "s/^/backblaze $account b2 - /" -e "s/$/ - -/"
done

projects=`/opt/polynimbus/drivers/google/list-projects.sh default`
for project in $projects; do
	/opt/polynimbus/drivers/google/storage/list-gs-buckets.sh default $project |sed -e "s/^/google default gs - /" -e "s/$/ - $project/"
done

accounts=`/opt/polynimbus/api/v1/account/list.sh linode`
for account in $accounts; do
	/opt/polynimbus/drivers/linode/storage/list-buckets.sh $account |sed -e "s/^/linode $account beta /" -e "s/$/ -/"
done
