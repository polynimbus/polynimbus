#!/bin/sh

key=$1
target=$2
port=$3

rsync -e "ssh -i $key -p $port" -a --delete \
	\
	--exclude "*.7z" \
	--exclude "*.xz" \
	--exclude "*.gz" \
	--exclude "*.tgz" \
	--exclude "ssh/" \
	--exclude "aws/s3cmd" \
	--exclude "linode/s3cmd" \
	--exclude "azure/storage-accounts" \
	--exclude "aws/20*/" \
	--exclude "inventory/20*/" \
	--exclude "storage/20*/" \
	\
	/var/cache/polynimbus $target:/var/cache
