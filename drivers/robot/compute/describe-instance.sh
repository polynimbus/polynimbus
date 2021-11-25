#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-name>"
	exit 1
elif [ ! -f /etc/polynimbus/robot/$1.ini ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
name=$2

path=~/.polynimbus/cache/robot/describe
mkdir -p $path

file=$path/$account-$name.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-1 hour' +%s` ]; then
	hetznerctl show -c /etc/polynimbus/robot/$account.ini $name >$file
fi

cat $file |tr '[:upper:]' '[:lower:]'
