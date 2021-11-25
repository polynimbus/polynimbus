#!/bin/bash
. /opt/polynimbus/common/functions

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
fi

account=$1
if [ "$account" = "default" ]; then

	if [ ! -d ~/.config/gcloud ]; then
		gcloud init
	fi

	if [ "`gcloud auth list 2>/dev/null |grep ACTIVE`" = "" ]; then
		gcloud auth login
	fi

else   # $account != default

	if [ ! -d ~/.config/gcloud ] || [ "`gcloud auth list 2>/dev/null |grep ACTIVE`" = "" ]; then
		echo "error: first configuration profile must be called \"default\""
		exit 1
	fi

	if [ "`gcloud config configurations list |grep ^$account`" != "" ]; then
		echo "warning: account $account already configured"
	else
		gcloud config configurations create $account
		gcloud init
		gcloud config configurations activate default
	fi
fi

if [ -f /etc/polynimbus/google/$account.sh ]; then
	exit 0
fi

REGION="`input \"enter Google Compute Engine region to use\" europe-west1-c`"
DEFAULT_INSTANCE_TYPE="`input \"enter Google Compute Engine default instance type\" n1-standard-1`"

mkdir -p /etc/polynimbus/google
echo "#!/bin/sh
#
# Default region to use:
#
export GCE_REGION=$REGION
#
# Ubuntu project (mostly you don't need to change this):
#
export GCE_PROJECT=ubuntu-os-cloud
#
# Default instance type to use, when type isn't explicitely specified
# (use list-instance-types.sh script to discover all instance types):
#
export GCE_DEFAULT_INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE
" >/etc/polynimbus/google/$account.sh
chmod 0600 /etc/polynimbus/google/$account.sh
