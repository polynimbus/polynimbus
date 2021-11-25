#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <cache-file>"
	exit 1
elif ! grep -q "\[$1\]" ~/.aws/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
file=$2

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 hours' +%s` ]; then
	aws --profile $account iam list-policies --only-attached --no-paginate >$file
fi

cat $file
