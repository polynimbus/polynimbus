#!/bin/sh
. /opt/polynimbus/common/functions

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f /etc/polynimbus/rackspace/$1.sh ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

account=$1
/opt/polynimbus/drivers/rackspace/support/rack configure

if ! grep -q "\[$account\]" /root/.rack/config; then
	echo "error: cloud account \"$account\" left unconfigured"
	exit 1
fi

DEFAULT_INSTANCE_TYPE="`input \"enter Rackspace default instance type\" 2`"

mkdir -p /etc/polynimbus/rackspace
echo "#!/bin/sh
#
# Rackspace Cloud requires \"rack\" command line client. You can find more
# information about this tool here:
#
#    https://developer.rackspace.com/docs/rack-cli/
#
# This variable should point to valid, configured Rackspace Cloud profile.
#
export RACKSPACE_PROFILE_NAME=$account
#
#
############################################################################
#
# Default instance type to use, when type isn't explicitely specified
# (use list-instance-types.sh script to discover all instance types):
#
export RACKSPACE_DEFAULT_INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE
" >/etc/polynimbus/rackspace/$account.sh
chmod 0600 /etc/polynimbus/rackspace/$account.sh
