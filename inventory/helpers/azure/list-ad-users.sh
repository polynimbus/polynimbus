#!/bin/sh

rawusers=$1
roles=$2

users=`cat $rawusers |/opt/polynimbus/drivers/azure/internal/parse-users.php |tr ' ' ':'`
for U in $users; do
	umail=`echo $U |cut -d: -f1`
	ucreated=`echo $U |cut -d: -f2`
	ulast=`echo $U |cut -d: -f3`
	utype=`echo $U |cut -d: -f4`
	uid=`echo $U |cut -d: -f5`
	uenabled=`echo $U |cut -d: -f6`

	assigned=`grep ^$uid $roles |cut -d' ' -f3`
	if [ "$assigned" = "" ]; then
		assigned="-"
	fi

	echo "$umail $ucreated $ulast $utype $assigned $uenabled"
done
