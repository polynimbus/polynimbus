#!/bin/sh

key=$1
target=root@$2
port=$3

rsync -e "ssh -i $key -p $port" -a --delete ~/.polynimbus/cache/aws/s3cmd $target:/root/.polynimbus/cache/aws
rsync -e "ssh -i $key -p $port" -a --delete ~/.polynimbus/cache/linode/s3cmd $target:/root/.polynimbus/cache/linode
rsync -e "ssh -i $key -p $port" -a --delete ~/.polynimbus/cache/azure/storage-accounts $target:/root/.polynimbus/cache/azure
rsync -e "ssh -i $key -p $port" -a --delete /etc/polynimbus/b2 $target:/etc/polynimbus
rsync -e "ssh -i $key -p $port" -a --delete ~/.gsutil $target:/root
rsync -e "ssh -i $key -p $port" -a --delete ~/.config/gcloud $target:/root/.config

# use /root/.polynimbus fixed path for Polynimbus Backup
scp -p -i $key -P $port ~/.polynimbus/inventory/storage.list $target:/root/.polynimbus/inventory
scp -p -i $key -P $port ~/.polynimbus/settings/aws/s3-backup.blacklist $target:/root/.polynimbus/settings/aws
