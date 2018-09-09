#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [--full]"
	exit 1
elif [ ! -f /etc/polynimbus/alibaba/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
file=/root/.aliyuncli/instance-types.$account.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 hours' +%s` ]; then
	aliyuncli ecs DescribeInstanceTypes --profile $account >$file
fi

if [ "$2" = "--full" ]; then
	cat $file
else
	grep InstanceTypeId $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g
fi
