#!/bin/bash

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/google/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
project=`/opt/polynimbus/drivers/google/get-configured-project.sh $account`

gcloud compute instances list --configuration $account --format json --quiet \
	|/opt/polynimbus/drivers/google/internal/parse-instances.php $project
