#!/bin/sh

user=`whoami`

if [ "$user" != "root" ]; then
	file=~/.crontab
else
	file=/etc/crontab
fi

# avoid updating modification time if file exists
if [ ! -e $file ]; then
	touch $file
fi

echo $file
