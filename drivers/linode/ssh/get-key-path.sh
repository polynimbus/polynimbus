#!/bin/sh

key=~/.polynimbus/ssh/id_linode_$1

if [ -f $key ]; then
	echo $key
else
	echo "-"
fi
