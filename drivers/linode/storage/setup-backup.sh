#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <cloud-account> <api-key> <secret-key>"
	exit 1
elif [ ! -f /etc/polynimbus/linode/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
apikey=$2
secret=$3
. /etc/polynimbus/linode/$account.sh

file=~/.polynimbus/cache/linode/s3cmd/$account.ini

if [ -f $file ]; then
	echo "error: account \"$account\" already configured"
	exit 1
fi

echo "[default]
access_key = $apikey
secret_key = $secret
bucket_location = US
host_base = us-east-1.linodeobjects.com
host_bucket = %(bucket)s.us-east-1.linodeobjects.com
stop_on_error = False
use_https = True
" >$file
chmod 0400 $file
