#!/bin/sh
# https://cloud.google.com/sdk/downloads

mkdir -p /etc/polynimbus/google

if [ "`which gcloud 2>/dev/null`" != "" ]; then
	echo "checking updates for Google Cloud SDK"
	gcloud components update
else
	echo "installing Google Cloud SDK"
	curl https://sdk.cloud.google.com |bash
fi
