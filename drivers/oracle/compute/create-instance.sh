#!/bin/sh
. ~/.polynimbus/accounts/oracle/default.sh

if [ "$4" = "" ]; then
	echo "usage: $0 <unused> <ssh-key-name> <instance-type> <image-name>"
	exit 1
fi

unused=$1
key=$2
type=$3
image=$4

privkey=`/opt/polynimbus/drivers/oracle/ssh/get-key-path.sh $key`
pubkey=$privkey.pub
random=`date +%s |md5sum |head -c 4`
alias=$key-$random

if [ "$privkey" = "-" ] || [ ! -f $pubkey ]; then
	echo "error: ssh key for \"$key\" not found"
	exit 0
fi

path=/opt/polynimbus/drivers/oracle/compute

region=`/opt/polynimbus/drivers/oracle/infrastructure/get-configured-region.sh`
compartment=`/opt/polynimbus/drivers/oracle/get-compartment-id.sh`

# TODO: pass region/compartment as arguments to below scripts

vcn=`$path/list-virtual-networks.sh`
avdomain=`$path/list-availability-domains.sh |head -n1`
subnet=`$path/list-subnets.sh $unused $vcn $avdomain`

oci compute instance launch \
	--compartment-id $compartment \
	--shape $type \
	--display-name $alias \
	--image-id $image \
	--ssh-authorized-keys-file $pubkey \
	--availability-domain $avdomain \
	--assign-public-ip true \
	--subnet-id $subnet \
	|/opt/polynimbus/drivers/oracle/internal/parse-create.php

# example output:
# - pending test2018 us-phoenix-1 VM.Standard1.1 ocid1.instance.oc1.phx.abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz12345678 18.04
