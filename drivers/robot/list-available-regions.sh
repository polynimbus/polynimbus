#!/bin/sh

file=/var/cache/polynimbus/robot/datacenters.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d yesterday +%s` ]; then
	curl -s https://wiki.hetzner.de/index.php/Rechenzentren_und_Anbindung/en >$file
fi

egrep -o '<th colspan="2"> (.+)' $file |awk '{ print $3 }' |tr '[:upper:]' '[:lower:]'
