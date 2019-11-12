#!/bin/sh

account=$1
groupsfile=$2
usersfile=$3

for entry in `cat $groupsfile |cut -d' ' -f1`; do
	/opt/polynimbus/drivers/aws/list-iam-policies.php $account group $entry |sed -e "s/^/group $entry /"
done

for entry in `cat $usersfile |cut -d' ' -f1`; do
	/opt/polynimbus/drivers/aws/list-iam-policies.php $account user $entry |sed -e "s/^/user $entry /"
done
