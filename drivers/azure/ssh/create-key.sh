#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name>"
	exit 1
elif [ ! -f ~/.polynimbus/accounts/azure/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

name=$2
key=~/.polynimbus/ssh/id_azure_$name

if [ -f $name ] || [ -f $key ]; then
	echo "warning: ssh key $key already exists"
	exit 0
fi

ssh-keygen -q -t rsa -f $key -b 4096 -N ""
