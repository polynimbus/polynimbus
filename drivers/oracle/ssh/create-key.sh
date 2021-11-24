#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <unused> <ssh-key-name>"
	exit 1
fi

name=$2
key=~/.polynimbus/ssh/id_oracle_$name

if [ -f $name ] || [ -f $key ]; then
	echo "warning: ssh key $key already exists"
	exit 0
fi

ssh-keygen -q -t rsa -f $key -N "" -C ubuntu@`hostname`
