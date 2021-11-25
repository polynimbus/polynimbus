#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/e24/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
name=$2
key=~/.polynimbus/ssh/id_e24_$name

if [ -f $name ] || [ -f $key ]; then
	echo "warning: ssh key $key already exists"
	exit 0
fi

/opt/polynimbus/drivers/e24/internal/create-ssh-key.php $account $key

if [ ! -f $key ]; then
	echo "error: cannot create ssh key $name"
	exit 1
fi
