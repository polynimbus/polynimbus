#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif ! grep -q "\[$1\]" /root/.rack/config; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
grep -A3 "\[$account\]" /root/.rack/config |grep region |sed s/\ //g |cut -d= -f2
