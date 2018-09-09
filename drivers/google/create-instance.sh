#!/bin/sh
. /etc/polynimbus/google/default.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name> [instance-type]"
	exit 1
fi

key=$1
random=`date +%s |md5sum |head -c 4`
name=$key-$random

if [ "$2" != "" ]; then
	type=$2
else
	type=$GCE_DEFAULT_INSTANCE_TYPE
fi

osver=`/opt/polynimbus/drivers/google/get-ubuntu-image.sh`

instance="$(gcloud compute instances create $name \
	--image-family $osver \
	--image-project $GCE_PROJECT \
	--zone $GCE_REGION \
	--machine-type $type \
	--format json 2>/dev/null \
	|/opt/polynimbus/drivers/google/internal/parse-instances.php)"

id=`echo "$instance" |cut -f6 -d' '`

gcloud compute instances add-metadata $id \
	--zone $GCE_REGION \
	--metadata-from-file ssh-keys=/etc/polynimbus/ssh/id_google_$key.meta 2>/dev/null

echo $instance
