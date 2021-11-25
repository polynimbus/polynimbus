#!/bin/bash

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-name>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/google/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
name=$2

if grep -qxF $account ~/.polynimbus/settings/google/api.blacklist; then
	echo "error: API disabled for account $account"
	exit 0
fi

# TODO: allow zone from $3 instead of GCE_REGION

. ~/.polynimbus/accounts/google/$account.sh

gcloud compute instances delete $name --configuration $account --zone $GCE_REGION --quiet
