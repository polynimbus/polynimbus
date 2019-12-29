#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <unused> <instance-id>"
	exit 1
fi

id=$2
oci compute instance terminate --instance-id $id --force
