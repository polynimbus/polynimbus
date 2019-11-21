#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account> [region]"
	exit 1
elif [ ! -f /etc/polynimbus/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
region=$2
LIST=/opt/polynimbus/drivers/azure/list-databases-by-engine.sh

if [ "$region" != "" ]; then
	$LIST $account mssql |grep $region
	$LIST $account mysql |grep $region
	$LIST $account mariadb |grep $region
	$LIST $account postgres |grep $region
else
	$LIST $account mssql
	$LIST $account mysql
	$LIST $account mariadb
	$LIST $account postgres
fi
