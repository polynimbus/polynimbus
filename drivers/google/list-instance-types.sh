#!/bin/sh
. /etc/polynimbus/google/default.sh

if [ "$1" = "--full" ]; then
	gcloud compute machine-types list |egrep "($GCE_REGION|DEPRECATED)"
else
	gcloud compute machine-types list |grep $GCE_REGION |awk '{ print $1 }'
fi
