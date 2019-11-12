#!/bin/sh

account=$1
file=$2

for entry in `cat $file |cut -d' ' -f1`; do
	/opt/polynimbus/drivers/aws/list-iam-access-keys.php $account $entry |sed -e "s/^/$entry /"
done
