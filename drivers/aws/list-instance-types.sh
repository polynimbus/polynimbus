#!/bin/sh

path=/var/cache/polynimbus/aws
file=ec2-instance-types.html

if [ ! -s $path/$file ] || [ `stat -c %Y $path/$file` -le `date -d yesterday +%s` ]; then
	/opt/polynimbus/drivers/aws/internal/download-instance-types.sh |/opt/polynimbus/common/save.sh $path $file
fi

egrep '<td>(t3|t2|m5|c5|x1|z1|r5|r4|p2|i3|h1|g3|f1|d2)' $path/$file |sed -e s/td\>/\ /g -e s/\</\ /g |awk '{ print $1 }' |sort |uniq
