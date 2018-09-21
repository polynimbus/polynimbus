#!/bin/bash

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

if [ "$1" = "--full" ]; then
	gcloud compute regions list
else
	gcloud compute regions list |awk '{ print $1 }' |grep -v ^NAME
fi
