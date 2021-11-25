#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <storage-account>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
storage=$2
. ~/.polynimbus/accounts/azure/$account.sh

az storage account keys list --account-name $storage --subscription $AZURE_SUBSCRIPTION --query "[0].value" |tr -d '"'
