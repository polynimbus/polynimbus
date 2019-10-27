#!/bin/bash

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ami-id> [--quiet]"
	exit 1
elif ! grep -q "\[$1\]" /root/.aws/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
elif ! [[ $2 =~ ^ami-[0-9a-f]+$ ]]; then
	echo "error: parameter $2 not conforming ami-id format"
	exit 1
fi

account=$1
amiid=$2

file=/var/cache/polynimbus/aws/describe-images/$amiid.json

#
# if this request fails for any reason (invalid account, no permissions,
# invalid ami-id, network problem etc.), it won't be retried unless you
# run clean-empty-describe-images.sh script (or manually remove $file)
#
if [ ! -f $file ]; then
	aws --profile $account ec2 describe-images --image-ids $amiid >$file
fi

if [ -s $file ] && [ "$3" != "--quiet" ]; then
	image=`grep '"Name":' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g`
	echo ${image##*/}
fi
