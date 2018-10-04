#!/bin/sh

if [ -d /root/.config/gcloud ]; then
	ls /root/.config/gcloud/configurations |sed s/config_//g
fi
