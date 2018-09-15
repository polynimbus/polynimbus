#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <vendor> <cloud-account> <instance-name>"
	exit 1
elif [ ! -d /opt/polynimbus/drivers/$1 ]; then
	echo "error: invalid cloud vendor \"$1\" specified"
	exit 1
fi

vendor=$1
account=$2
instance=$3

for S in 8 7 7 7 7 7 6 6 6 6 5 5 5 5 5 4 4 4 4 4 8; do
	sleep $S
	out=`/opt/polynimbus/api/v1/instance/list.sh $vendor $account |grep running |grep $instance`
	if [ "$out" != "" ]; then
		echo $out
		exit 0
	fi
done
