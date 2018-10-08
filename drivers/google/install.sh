#!/bin/bash
# https://cloud.google.com/sdk/downloads

mkdir -p /etc/polynimbus/google /var/cache/polynimbus/google
chmod 0700 /var/cache/polynimbus/google
touch      /var/cache/polynimbus/google/get-iam-policy.blacklist

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
