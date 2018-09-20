#!/bin/sh

if [ "$4" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> <instance-type> <ami-id>"
	exit 1
elif [ ! -f /etc/polynimbus/e24/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
key=$2
type=$3
amiid=$4

/opt/polynimbus/drivers/e24/internal/create-instance.php $account $key $type $amiid

# example output:
# - pending test2018 eu-poland-1poznan m1.small 5c7254cb-5cba-42a8-a481-aaaafc6e5919 ami-00000bb7
