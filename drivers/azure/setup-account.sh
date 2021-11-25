#!/bin/sh
# This script can only create "default" account. If you want to create
# more accounts, you have to do it manually - just copy default.sh file
# and replace $AZURE_SUBSCRIPTION variable with any other ID (which has
# to be already configured using "az" tool).

if [ "`az account list |grep Enabled`" = "" ]; then
	az login
fi

SUBSCRIPTION=`az account show |/opt/polynimbus/drivers/azure/internal/parse-subscription.php`

if [ "$SUBSCRIPTION" = "" ]; then
	echo "error: something is wrong with your Azure subscription configuration"
	exit 1
fi

if [ ! -f ~/.polynimbus/cache/azure/locations.cache ]; then
	az account list-locations >~/.polynimbus/cache/azure/locations.cache
fi

if [ -f /etc/polynimbus/azure/default.sh ]; then
	echo "error: cloud account \"default\" already configured"
	exit 1
fi

mkdir -p /etc/polynimbus/azure
echo "#!/bin/sh
#
# Default region to use.
#
export AZURE_LOCATION=westeurope
#
# Azure subscription ID - configured as default \"az\" profile at the time
# of configuring this account. Use \"az account list\" to see all profiles.
#
export AZURE_SUBSCRIPTION=$SUBSCRIPTION
" >/etc/polynimbus/azure/default.sh
chmod 0600 /etc/polynimbus/azure/default.sh
