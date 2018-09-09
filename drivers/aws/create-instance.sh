#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type]"
	exit 1
fi

account=$1
key=$2

. /etc/polynimbus/aws/$account.sh

if [ "$3" != "" ]; then
	type=$3
else
	type=$EC2_DEFAULT_INSTANCE_TYPE
fi

amiid=`/opt/polynimbus/drivers/aws/get-ubuntu-image.sh $account`

aws ec2 run-instances \
	--profile $account \
	--instance-type $type \
	--image-id $amiid \
	--key-name $key \
	--security-groups default \
	--enable-api-termination \
	--associate-public-ip-address \
	--count 1 \
	|/opt/polynimbus/drivers/aws/internal/parse-reservation.php
