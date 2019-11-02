#!/bin/sh

account=$1

(
/opt/polynimbus/drivers/aws/get-configured-region.sh $account

if [ -f /var/cache/polynimbus/inventory/instances.list ]; then
	cat /var/cache/polynimbus/inventory/instances.list |grep "^aws $account " |cut -d' ' -f6 |sed 's/.$//'
fi

if [ -f /var/cache/polynimbus/inventory/databases.list ]; then
	cat /var/cache/polynimbus/inventory/databases.list |grep "^aws $account " |cut -d' ' -f12 |sed 's/.$//'
fi

if [ -f /var/cache/polynimbus/inventory/functions.list ]; then
	cat /var/cache/polynimbus/inventory/functions.list |grep "^aws $account " |cut -d' ' -f3
fi

) |sort |uniq
