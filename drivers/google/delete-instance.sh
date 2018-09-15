#!/bin/sh
. /etc/polynimbus/google/default.sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-name>"
	exit 1
fi

name=$2
gcloud compute instances delete $name --zone $GCE_REGION --quiet
