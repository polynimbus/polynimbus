#!/bin/sh
. /opt/polynimbus/common/functions

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f /etc/polynimbus/godaddy/$1.sh ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

API_KEY="`input \"enter GoDaddy api key\" put-your-key-here`"
API_SECRET="`input \"enter GoDaddy api secret\" put-your-secret-here`"

mkdir -p /etc/polynimbus/godaddy
echo "#!/bin/sh
#
# GoDaddy API credentials:
#
export GODADDY_API_KEY=$API_KEY
export GODADDY_API_SECRET=$API_SECRET
" >/etc/polynimbus/godaddy/$1.sh
chmod 0600 /etc/polynimbus/godaddy/$1.sh
