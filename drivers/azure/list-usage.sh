#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <region>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
region=$2
. ~/.polynimbus/accounts/azure/$account.sh

az vm list-usage --subscription $AZURE_SUBSCRIPTION --location $region \
	|/opt/polynimbus/drivers/azure/internal/parse-usage.php
