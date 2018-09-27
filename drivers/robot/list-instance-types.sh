#!/bin/sh

file=/var/cache/polynimbus/robot/hardware.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d yesterday +%s` ]; then
	curl -s https://wiki.hetzner.de/index.php/Root_Server_Hardware/en >$file
fi

egrep -o '<p><b>(.+)</b>' $file |grep -v href |sed -e 's/<p><b>//g' -e 's/<\/b>//g' -e s/\ //g |tr '[:upper:]' '[:lower:]'
