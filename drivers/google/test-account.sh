#!/bin/sh

# TODO: detect trial account expiration

if [ ! -d /root/.config/gcloud ] || [ "`gcloud auth list 2>/dev/null |grep ACTIVE`" = "" ]; then
	exit 0
fi

if [ "`gcloud compute regions list </dev/null 2>/dev/null |grep europe`" = "" ]; then
	echo "error: Google Cloud account not configured, or without active projects"
fi
