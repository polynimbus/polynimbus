#!/bin/sh
. /etc/polynimbus/google/default.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <instance-name>"
	exit 1
fi

name=$1
gcloud compute instances delete $name --zone $GCE_REGION --quiet
