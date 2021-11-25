#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [--raw]"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
file=~/.polynimbus/cache/azure/functions-$account.cache
. ~/.polynimbus/accounts/azure/$account.sh

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-30 minutes' +%s` ]; then
	az functionapp list --subscription $AZURE_SUBSCRIPTION >$file
fi

if [ "$2" = "--raw" ]; then
	cat $file
else
	cat $file |/opt/polynimbus/drivers/azure/internal/parse-functions.php ~/.polynimbus/cache/azure/locations.cache
fi
