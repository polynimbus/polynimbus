#!/bin/bash
. /etc/polynimbus/google/default.sh

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

if [ "$1" = "--full" ]; then
	gcloud compute machine-types list |egrep "($GCE_REGION|DEPRECATED)"
else
	gcloud compute machine-types list |grep $GCE_REGION |awk '{ print $1 }'
fi
