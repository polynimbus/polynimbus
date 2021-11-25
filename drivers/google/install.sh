#!/bin/bash
# https://cloud.google.com/sdk/downloads

mkdir -p ~/.polynimbus/accounts/google ~/.polynimbus/cache/google
chmod 0700 ~/.polynimbus/cache/google

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

if [ "`which gcloud 2>/dev/null`" != "" ]; then
	echo "checking updates for Google Cloud SDK"
	gcloud components update
else
	echo "installing Google Cloud SDK"
	curl https://sdk.cloud.google.com |bash
fi
