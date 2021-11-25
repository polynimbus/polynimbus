#!/bin/sh

out=~/.polynimbus/inventory

/opt/polynimbus/inventory/helpers/aws/list-trails.sh \
	|/opt/polynimbus/common/save.sh 0 $out trails.list

/opt/polynimbus/inventory/helpers/list-encryption-keys.sh \
	|/opt/polynimbus/common/save.sh 0 $out encryption-keys.list


accounts=`/opt/polynimbus/api/v1/account/list.sh aws |grep -vxFf ~/.polynimbus/settings/aws/list-compute.blacklist`
for account in $accounts; do
	regions=`/opt/polynimbus/inventory/helpers/aws/list-active-regions.sh $account`
	for region in $regions; do
		/opt/polynimbus/inventory/helpers/aws/process-raw-data.sh $account $region
	done
done


accounts=`/opt/polynimbus/api/v1/account/list.sh azure`
for account in $accounts; do
	/opt/polynimbus/inventory/helpers/azure/list-usage.sh $account \
		|/opt/polynimbus/common/save.sh 200 $out usage-azure-$account.list

	. /etc/polynimbus/azure/$account.sh
	az aks list --subscription $AZURE_SUBSCRIPTION \
		|/opt/polynimbus/common/save.sh 0 $out raw-azure-kubernetes-$account.json
done


accounts=`/opt/polynimbus/api/v1/account/list.sh b2`
for account in $accounts; do
	/opt/polynimbus/drivers/b2/client.sh $account get-account-info \
		|/opt/polynimbus/common/save.sh 10 $out raw-b2-user-$account.json
done
