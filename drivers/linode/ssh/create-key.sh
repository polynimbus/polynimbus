#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name>"
	exit 1
elif [ ! -f /etc/polynimbus/linode/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
name=$2
key=~/.polynimbus/ssh/id_linode_$name

if [ -f $name ] || [ -f $key ]; then
	echo "warning: ssh key $key already exists"
	exit 0
fi

ssh-keygen -q -t rsa -f $key -b 4096 -N ""
public="`cat $key.pub`"

. /etc/polynimbus/linode/$account.sh
curl -sS -X POST \
	-H "Authorization: Bearer $LINODE_API_TOKEN" \
	-H "Content-Type: application/json" \
	-d "{\"label\": \"$name\", \"ssh_key\": \"$public\"}" \
	https://api.linode.com/v4/profile/sshkeys |python -m json.tool
