#!/bin/bash

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

if [ -d ~/.config/gcloud ] && [ "`gcloud auth list 2>/dev/null |grep ACTIVE`" = "" ]; then
	echo "error: Google Cloud account not configured, or without active projects"
fi
