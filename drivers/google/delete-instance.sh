#!/bin/bash
. /etc/polynimbus/google/default.sh

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-name>"
	exit 1
fi

name=$2
gcloud compute instances delete $name --zone $GCE_REGION --quiet
