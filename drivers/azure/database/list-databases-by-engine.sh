#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <engine>"
	exit 1
elif [ "$2" != "mssql" ] && [ "$2" != "mysql" ] && [ "$2" != "mariadb" ] && [ "$2" != "postgres" ]; then
	echo "error: invalid database engine type"
	exit 1
elif [ ! -f /etc/polynimbus/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
engine=$2
file=/var/cache/polynimbus/azure/databases-$account-$engine.cache
. /etc/polynimbus/azure/$account.sh

if [ "$engine" = "mssql" ]; then
	type="sql"
else
	type=$engine
fi

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-10 minutes' +%s` ]; then
	az $type server list --subscription $AZURE_SUBSCRIPTION >$file
fi

cat $file |/opt/polynimbus/drivers/azure/internal/parse-databases.php
