#!/bin/sh

if [ "$1" = "--full" ]; then
	gcloud compute regions list
else
	gcloud compute regions list |awk '{ print $1 }' |grep -v ^NAME
fi
