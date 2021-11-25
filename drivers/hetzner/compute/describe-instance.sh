#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-name>"
	exit 1
elif [ ! -f /etc/polynimbus/hetzner/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
name=$2

path=~/.polynimbus/cache/hetzner/describe
mkdir -p $path

file=$path/$account-$name.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-1 hour' +%s` ]; then
	. /etc/polynimbus/hetzner/$account.sh
	/opt/polynimbus/drivers/hetzner/support/hcloud server describe $name >$file
fi

cat $file
