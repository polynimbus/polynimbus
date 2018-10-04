#!/bin/bash

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-name>"
	exit 1
elif [ ! -f /etc/polynimbus/google/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
name=$2

. /etc/polynimbus/google/$account.sh

gcloud compute instances delete $name --configuration $account --zone $GCE_REGION --quiet
