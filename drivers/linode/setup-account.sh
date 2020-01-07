#!/bin/sh
. /opt/polynimbus/common/functions

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f /etc/polynimbus/linode/$1.sh ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

REGION="`input \"enter Linode region to use\" eu-central`"
API_TOKEN="`input \"enter Linode API token\" put-your-token-here`"

mkdir -p /etc/polynimbus/linode
echo "#!/bin/sh
#
# Default region to use:
#
export LINODE_REGION=$REGION
#
# Linode API credentials:
#
export LINODE_API_TOKEN=$API_TOKEN
" >/etc/polynimbus/linode/$1.sh
chmod 0600 /etc/polynimbus/linode/$1.sh
