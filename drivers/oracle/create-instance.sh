#!/bin/sh
. /etc/polynimbus/oracle/default.sh

if [ "$2" = "" ]; then
	echo "usage: $0 <unused> <ssh-key-name> [instance-type]"
	exit 1
fi

unused=$1
key=$2
pubkey=/etc/polynimbus/ssh/id_oracle_$key.pub
random=`date +%s |md5sum |head -c 4`
alias=$key-$random

if [ ! -f $pubkey ]; then
	echo "error: ssh public key for \"$key\" not found"
	exit 0
fi

if [ "$3" != "" ]; then
	type=$3
else
	type=$OCI_DEFAULT_INSTANCE_TYPE
fi

path=/opt/polynimbus/drivers/oracle

region=`$path/get-configured-region.sh`
compartment=`$path/get-compartment-id.sh`
image=`$path/get-ubuntu-image.sh $unused`

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
