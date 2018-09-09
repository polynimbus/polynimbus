#!/bin/sh
. /opt/polynimbus/common/functions

if [ ! -s /root/.oci/config ]; then
	oci setup config
fi

echo "OCI client configured, now enter this key in the user configuration:"
cat `/opt/polynimbus/drivers/oracle/get-signing-key.sh`

if [ -f /etc/polynimbus/oracle/default.sh ]; then
	exit 0
fi

DEFAULT_INSTANCE_TYPE="`input \"enter Oracle Cloud default instance type\" VM.Standard1.1`"

mkdir -p /etc/polynimbus/oracle
echo "#!/bin/sh
#
# Filter for Ubuntu images (mostly you don't need to change this):
#
export OCI_SYSTEM=\"Canonical Ubuntu\"
#
# Default instance type to use, when type isn't explicitely specified
# (use list-instance-types.sh script to discover all instance types):
#
export OCI_DEFAULT_INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE
" >/etc/polynimbus/oracle/default.sh
chmod 0600 /etc/polynimbus/oracle/default.sh
