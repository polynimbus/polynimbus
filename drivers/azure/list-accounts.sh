#!/bin/sh

if [ "`which az 2>/dev/null`" != "" ] && [ "`az account list |grep Enabled`" != "" ]; then
	/opt/polynimbus/drivers/azure/list-available-regions.sh
fi
