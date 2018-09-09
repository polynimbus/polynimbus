#!/bin/sh
# https://www.alibabacloud.com/help/doc-detail/40654.htm

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/polynimbus/alibaba/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
file=/root/.aliyuncli/regions.$account.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 hours' +%s` ]; then
	aliyuncli ecs DescribeRegions --profile $account >$file
fi

grep RegionId $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g
