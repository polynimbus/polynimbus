#!/bin/sh

if [ "`which az 2>/dev/null`" = "" ]; then
	echo "error: Azure command line client not found"
	exit 0
fi

if [ ! -f ~/.azure/accessTokens.json ]; then
	exit 0
fi

if [ "$1" != "" ]; then
	account=$1
else
	account=default
fi

if [ ! -f /etc/polynimbus/azure/$account.sh ]; then
	echo "error: cloud account \"$account\" not configured"
	exit 1
fi

. /etc/polynimbus/azure/$account.sh
az account set --subscription $AZURE_SUBSCRIPTION

if [ "`az account list-locations`" = "" ]; then
	echo "error: Azure account \"$account\" has expired access token, or without active subscriptions"
fi
