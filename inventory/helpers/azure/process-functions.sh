#!/bin/bash

account=$1
. ~/.polynimbus/accounts/azure/$account.sh

out=~/.polynimbus/inventory
SAVE=/opt/polynimbus/common/save.sh

map=`cat $out/functions.list |grep "^azure $account " |awk '{ print $4 ":" $7 }'`
for entry in $map; do

	function="${entry%:*}"
	group="${entry##*:}"

	az functionapp show --name $function --resource-group $group --subscription $AZURE_SUBSCRIPTION \
		|$SAVE 10 $out raw-azure-functions-$account-$function-details.json

	az functionapp config show --name $function --resource-group $group --subscription $AZURE_SUBSCRIPTION \
		|$SAVE 10 $out raw-azure-functions-$account-$function-config.json

	az functionapp config appsettings list --name $function --resource-group $group --subscription $AZURE_SUBSCRIPTION \
		|$SAVE 10 $out raw-azure-functions-$account-$function-settings.json

	az functionapp cors show --name $function --resource-group $group --subscription $AZURE_SUBSCRIPTION \
		|$SAVE 10 $out raw-azure-functions-$account-$function-cors.json

	az functionapp deployment list-publishing-profiles --name $function --resource-group $group --subscription $AZURE_SUBSCRIPTION \
		|$SAVE 10 $out raw-azure-functions-$account-$function-profiles.json

	az functionapp deployment list-publishing-credentials --name $function --resource-group $group --subscription $AZURE_SUBSCRIPTION \
		|$SAVE 10 $out raw-azure-functions-$account-$function-credentials.json

	az functionapp deployment source show --name $function --resource-group $group --subscription $AZURE_SUBSCRIPTION \
		|$SAVE 10 $out raw-azure-functions-$account-$function-source.json

done
