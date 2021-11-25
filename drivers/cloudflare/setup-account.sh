#!/bin/sh
. /opt/polynimbus/common/functions

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f ~/.polynimbus/accounts/cloudflare/$1.sh ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

AUTH_EMAIL="`input \"enter Cloudflare auth email\" put-your-email-here`"
AUTH_KEY="`input \"enter Cloudflare auth key\" put-your-key-here`"

mkdir -p ~/.polynimbus/accounts/cloudflare
echo "#!/bin/sh
#
# Cloudflare API credentials:
#
export CLOUDFLARE_EMAIL=$AUTH_EMAIL
export CLOUDFLARE_KEY=$AUTH_KEY
" >~/.polynimbus/accounts/cloudflare/$1.sh
chmod 0600 ~/.polynimbus/accounts/cloudflare/$1.sh
