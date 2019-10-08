#!/bin/sh

path=/var/cache/polynimbus/aws
table=ubuntu-ec2-images.json

if [ ! -s $path/$table ] || [ `stat -c %Y $path/$table` -le `date -d yesterday +%s` ]; then
	/opt/polynimbus/drivers/aws/internal/download-ami-table.sh |/opt/polynimbus/common/save.sh 14 $path $table
fi

if [ "$1" = "--all" ]; then
	cat $path/$table
else
	grep hvm:ebs-ssd $path/$table |grep amd64
fi
