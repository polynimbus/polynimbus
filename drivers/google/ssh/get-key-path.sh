#!/bin/sh

key=~/.polynimbus/ssh/id_google_$1

if [ -f $key ]; then
	echo $key
else
	echo "-"
fi
