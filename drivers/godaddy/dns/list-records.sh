#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <domain>"
	exit 1
elif [ ! -f /etc/polynimbus/godaddy/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
domain=$2
file=~/.polynimbus/cache/godaddy/records-$account-$domain.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 minutes' +%s` ]; then
	/opt/polynimbus/drivers/godaddy/get.sh $account domains/$domain/records >$file
fi

if ! grep -q UNKNOWN_DOMAIN $file; then
	cat $file |/opt/polynimbus/drivers/godaddy/internal/parse-records.php $domain
fi
