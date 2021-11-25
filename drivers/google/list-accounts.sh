#!/bin/sh

if [ -d ~/.config/gcloud ]; then
	ls ~/.config/gcloud/configurations |sed s/config_//g
fi
