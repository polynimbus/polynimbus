#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name>"
	exit 1
elif [ ! -f /etc/polynimbus/hetzner/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
name=$2
key=/etc/polynimbus/ssh/id_hetzner_$name

if [ -f $name ] || [ -f $key ]; then
	echo "warning: ssh key $key already exists"
	exit 0
fi

ssh-keygen -q -t rsa -f $key -b 4096 -N ""

. /etc/polynimbus/hetzner/$account.sh
/opt/polynimbus/drivers/hetzner/support/hcloud ssh-key create --name $name --public-key-from-file $key.pub
