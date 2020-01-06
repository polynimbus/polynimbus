#!/bin/bash

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <project>"
	exit 1
elif [ ! -f /etc/polynimbus/google/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
project=$2

if grep -qxF $project /var/cache/polynimbus/google/storage.blacklist; then
	exit 0
fi

gsutil ls -p $project |tr -d '/' |cut -d: -f2
