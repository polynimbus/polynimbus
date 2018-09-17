#!/bin/sh

if [ -d /root/.config/gcloud ] && [ "`gcloud auth list |grep ACTIVE`" = "" ]; then
	echo "error: Google Cloud account not configured, or without active projects"
fi
