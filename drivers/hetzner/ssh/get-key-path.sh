#!/bin/sh

key=~/.polynimbus/ssh/id_hetzner_$1

if [ -f $key ]; then
	echo $key
else
	echo "-"
fi
