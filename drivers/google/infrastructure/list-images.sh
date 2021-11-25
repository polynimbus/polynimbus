#!/bin/bash

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/google/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1

if grep -qxF $account ~/.polynimbus/settings/google/api.blacklist; then
	exit 0
fi

gcloud compute images list --configuration $account --quiet |grep -v windows-
