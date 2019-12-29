#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif ! grep -q "\[$1\]" /root/.aws/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
file=/var/cache/polynimbus/aws/tmp/attached-managed-policies-$account.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 hours' +%s` ]; then
	aws --profile $account iam list-policies --only-attached --no-paginate >$file
fi

cat $file
