#!/bin/sh
. /opt/polynimbus/common/functions

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f ~/.polynimbus/accounts/linode/$1.sh ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

API_TOKEN="`input \"enter Linode API token\" put-your-token-here`"
REGION="`input \"enter Linode region to use\" eu-central`"
INSTANCE_TYPE="`input \"enter Linode default instance type\" g6-nanode-1`"

mkdir -p ~/.polynimbus/accounts/linode
echo "#!/bin/sh
#
# Linode API credentials:
#
export LINODE_API_TOKEN=$API_TOKEN
#
# Default region to use:
#
export LINODE_DEFAULT_REGION=$REGION
#
# default instance type to use, when type isn't explicitely specified:
#
export LINODE_DEFAULT_INSTANCE_TYPE=$INSTANCE_TYPE
#
# default root password for compute instances launched by Polynimbus:
#
export LINODE_DEFAULT_ROOT_PASSWORD=`openssl rand -base64 33 |tr '=' '!' |tr '/' '_'`
" >~/.polynimbus/accounts/linode/$1.sh
chmod 0600 ~/.polynimbus/accounts/linode/$1.sh
