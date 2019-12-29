#!/bin/sh

key=/etc/polynimbus/ssh/id_rack_$1

if [ -f $key ]; then
	echo $key
else
	echo "-"
fi
