#!/bin/bash

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <zone-id> [--raw]"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/cloudflare/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
zoneid=$2
page=1

while [ $page -lt 10 ]; do
	file=~/.polynimbus/cache/cloudflare/records-$account-$zoneid-$page.cache

	if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 minutes' +%s` ]; then
		/opt/polynimbus/drivers/cloudflare/get.sh $account "zones/$zoneid/dns_records?page=$page&per_page=1000&order=type&direction=asc" >$file
	fi

	# show all records in parsed mode, but only first 1000 (page 1) in raw mode
	if [ "$3" != "--raw" ]; then
		cat $file |/opt/polynimbus/drivers/cloudflare/internal/parse-records.php
	elif [ $page -eq 1 ]; then
		cat $file |python2 -m json.tool
	fi

	total=`cat $file |/opt/polynimbus/drivers/cloudflare/internal/parse-pages.php`
	if [ $total -eq 1 ] || [ $total -eq $page ]; then break; fi
	page=$[$page + 1]
done
