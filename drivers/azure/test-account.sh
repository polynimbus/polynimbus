#!/bin/sh

if [ "`which az 2>/dev/null`" = "" ]; then
	echo "error: Azure command line client not found"
	exit 0
fi

if [ -f /root/.azure/accessTokens.json ] && [ "`az account list-locations`" = "" ]; then
	echo "error: Azure account not configured, or without active subscriptions"
fi
