#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <domain>"
	exit 1
elif [ ! -f /etc/polynimbus/cloudflare/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
domain=$2
. /etc/polynimbus/cloudflare/$account.sh

file=/etc/local/.cloudflare/$domain.headers

if [ -f $file ]; then
	echo "error: domain \"$domain\" already configured"
	exit 1
fi

mkdir -p -m 0700 /etc/local/.cloudflare
echo "X-Auth-Email: $CLOUDFLARE_EMAIL" >$file
echo "X-Auth-Key: $CLOUDFLARE_KEY" >>$file
chmod 0400 $file
