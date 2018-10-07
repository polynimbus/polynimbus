#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
fi

account=$1
file=/root/.config/gcloud/configurations/config_$account

if [ -s $file ]; then
	grep -i ^project $file |sed "s/\ //g" |cut -d= -f2
else
	echo "-"
fi
