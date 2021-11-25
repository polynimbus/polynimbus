#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif ! grep -q "\[profile $1\]" ~/.aliyuncli/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
file=~/.polynimbus/cache/alibaba/images.$account.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 hours' +%s` ]; then
	aliyuncli ecs DescribeImages --profile $account >$file
fi

grep ImageId $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g |grep -v winsvr |grep -v _32_ |sort
