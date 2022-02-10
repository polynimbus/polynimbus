#!/bin/sh

file=~/.polynimbus/cache/azure/locations.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d yesterday +%s` ]; then
	az account list-locations >$file
fi

cat $file |/opt/polynimbus/drivers/azure/internal/parse-regions.php |sort
