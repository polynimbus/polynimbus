#!/bin/sh

if [ "`az account list |grep Enabled`" != "" ]; then
	/opt/polynimbus/drivers/azure/list-available-regions.sh
fi
