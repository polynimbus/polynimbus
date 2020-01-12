#!/bin/sh

key=$1
target=root@$2

rsync -e "ssh -i $key" -a --delete /var/cache/polynimbus/aws/s3cmd $target:/var/cache/polynimbus/aws
rsync -e "ssh -i $key" -a --delete /var/cache/polynimbus/linode/s3cmd $target:/var/cache/polynimbus/linode
rsync -e "ssh -i $key" -a --delete /var/cache/polynimbus/azure/storage-accounts $target:/var/cache/polynimbus/azure
rsync -e "ssh -i $key" -a --delete /etc/polynimbus/b2 $target:/etc/polynimbus
rsync -e "ssh -i $key" -a --delete /root/.gsutil $target:/root
rsync -e "ssh -i $key" -a --delete /root/.config/gcloud $target:/root/.config
scp -p -i $key /var/cache/polynimbus/inventory/storage.list $target:/var/cache/polynimbus/inventory
scp -p -i $key /var/cache/polynimbus/aws/s3-backup.blacklist $target:/var/cache/polynimbus/aws
