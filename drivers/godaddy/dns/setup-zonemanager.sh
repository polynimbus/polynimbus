#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <domain>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/godaddy/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
domain=$2
. ~/.polynimbus/accounts/godaddy/$account.sh

file=/etc/local/.godaddy/$domain.headers

if [ -f $file ]; then
	echo "error: domain \"$domain\" already configured"
	exit 1
fi

mkdir -p -m 0700 /etc/local/.godaddy
echo "Authorization: sso-key $GODADDY_API_KEY:$GODADDY_API_SECRET" >$file
chmod 0400 $file
