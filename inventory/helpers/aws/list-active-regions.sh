#!/bin/sh

account=$1

(
/opt/polynimbus/drivers/aws/infrastructure/get-configured-region.sh $account

if [ -f ~/.polynimbus/inventory/instances.list ]; then
	cat ~/.polynimbus/inventory/instances.list |grep "^aws $account " |cut -d' ' -f6 |sed 's/.$//'
fi

if [ -f ~/.polynimbus/inventory/databases.list ]; then
	cat ~/.polynimbus/inventory/databases.list |grep "^aws $account " |cut -d' ' -f12 |sed 's/.$//'
fi

if [ -f ~/.polynimbus/inventory/functions.list ]; then
	cat ~/.polynimbus/inventory/functions.list |grep "^aws $account " |cut -d' ' -f3
fi

) |sort |uniq
