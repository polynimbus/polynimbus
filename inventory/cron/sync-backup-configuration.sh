#!/bin/sh

key=$1
target=root@$2
port=$3

rsync -e "ssh -i $key -p $port" -a --delete ~/.polynimbus/cache/aws/s3cmd $target:/var/cache/polynimbus/cache/aws
rsync -e "ssh -i $key -p $port" -a --delete ~/.polynimbus/cache/linode/s3cmd $target:/var/cache/polynimbus/cache/linode
rsync -e "ssh -i $key -p $port" -a --delete ~/.polynimbus/cache/azure/storage-accounts $target:/var/cache/polynimbus/cache/azure
rsync -e "ssh -i $key -p $port" -a --delete ~/.polynimbus/accounts/b2 $target:/var/cache/polynimbus/accounts
rsync -e "ssh -i $key -p $port" -a --delete ~/.gsutil $target:/root
rsync -e "ssh -i $key -p $port" -a --delete ~/.config/gcloud $target:/root/.config
scp -p -i $key -P $port ~/.polynimbus/inventory/storage.list $target:/var/cache/polynimbus/inventory
scp -p -i $key -P $port ~/.polynimbus/settings/aws/s3-backup.blacklist $target:/var/cache/polynimbus/settings/aws
