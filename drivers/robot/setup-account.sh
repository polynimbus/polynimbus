#!/bin/sh
. /opt/polynimbus/common/functions

config=/etc/polynimbus/robot/$1.ini

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f $config ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

USERNAME="`input \"enter Hetzner Online account username\" put-your-username-here`"
PASSWORD="`input \"enter Hetzner Online account password\" put-your-password-here`"

mkdir -p /etc/polynimbus/robot
hetznerctl config -c $config login.username $USERNAME
hetznerctl config -c $config login.password $PASSWORD
chmod 0600 $config
