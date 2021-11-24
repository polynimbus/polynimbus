#!/bin/sh

key=$1
target=root@$2
port=$3

rsync -e "ssh -i $key -p $port" -a --delete /var/cache/polynimbus/aws/s3cmd $target:/var/cache/polynimbus/aws
rsync -e "ssh -i $key -p $port" -a --delete /var/cache/polynimbus/linode/s3cmd $target:/var/cache/polynimbus/linode
rsync -e "ssh -i $key -p $port" -a --delete /var/cache/polynimbus/azure/storage-accounts $target:/var/cache/polynimbus/azure
rsync -e "ssh -i $key -p $port" -a --delete /etc/polynimbus/b2 $target:/etc/polynimbus
rsync -e "ssh -i $key -p $port" -a --delete /root/.gsutil $target:/root
rsync -e "ssh -i $key -p $port" -a --delete /root/.config/gcloud $target:/root/.config

# use /root/.polynimbus fixed path for Polynimbus Backup
scp -p -i $key -P $port ~/.polynimbus/inventory/storage.list $target:/root/.polynimbus/inventory
scp -p -i $key -P $port /var/cache/polynimbus/aws/s3-backup.blacklist $target:/var/cache/polynimbus/aws
