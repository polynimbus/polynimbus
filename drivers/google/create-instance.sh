#!/bin/bash

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

if [ "$4" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> <instance-type> <image-name>"
	exit 1
elif [ ! -f /etc/polynimbus/google/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
key=$2
type=$3
osver=$4

. /etc/polynimbus/google/$account.sh

random=`date +%s |md5sum |head -c 4`
name=$key-$random

instance="$(gcloud compute instances create $name \
	--configuration $account \
	--image-family $osver \
	--image-project $GCE_PROJECT \
	--zone $GCE_REGION \
	--machine-type $type \
	--format json 2>/dev/null \
	|/opt/polynimbus/drivers/google/internal/parse-instances.php)"

id=`echo "$instance" |cut -f6 -d' '`

gcloud compute instances add-metadata $id \
	--configuration $account \
	--zone $GCE_REGION \
	--metadata-from-file ssh-keys=/etc/polynimbus/ssh/id_google_$key.meta 2>/dev/null

echo $instance

# example output:
# 230.201.241.35.bc.googleusercontent.com running test2018 europe-west1-c n1-standard-1 test2018-7f19 ubuntu-1804-lts
