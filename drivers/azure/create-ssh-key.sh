#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <region> <ssh-key-name>"
	exit 1
fi

name=$2
key=/etc/polynimbus/ssh/id_azure_$name

if [ -f $name ] || [ -f $key ]; then
	echo "warning: ssh key $key already exists"
	exit 0
fi

ssh-keygen -q -t rsa -f $key -b 4096 -N ""
