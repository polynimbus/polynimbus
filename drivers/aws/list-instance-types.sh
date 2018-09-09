#!/bin/sh

# TODO: implement caching similar to get-ami-id.sh, in case if cron entry is disabled

file=/var/cache/polynimbus/aws/ec2-instance-types.html

egrep '<td>(t3|t2|m5|c5|x1|z1|r5|r4|p2|i3|h1|g3|f1|d2)' $file |sed -e s/td\>/\ /g -e s/\</\ /g |awk '{ print $1 }' |sort |uniq
