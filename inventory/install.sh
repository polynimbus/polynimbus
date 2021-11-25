#!/bin/bash
# optional Polynimbus Inventory component

/opt/polynimbus/install.sh

echo "setting up Polynimbus Inventory directories and files"
if [ ! -e ~/.polynimbus/inventory ]; then
	mkdir -p -m 0700 \
		~/.polynimbus/inventory \
		~/.polynimbus/storage \
		~/.polynimbus/settings \
		~/.polynimbus/settings/aws \
		~/.polynimbus/settings/google \
		~/.polynimbus/cache/aws/tmp \
		~/.polynimbus/cache/aws/s3cmd \
		~/.polynimbus/cache/linode/s3cmd \
		~/.polynimbus/cache/azure/storage-accounts
fi

chmod 0710 ~/.polynimbus
chown root:www-data ~/.polynimbus
chown www-data:www-data ~/.polynimbus/inventory ~/.polynimbus/storage

touch \
	~/.polynimbus/settings/aws/list-nosql.blacklist \
	~/.polynimbus/settings/aws/list-users.blacklist \
	~/.polynimbus/settings/aws/list-zones.blacklist \
	~/.polynimbus/settings/aws/list-trails.blacklist \
	~/.polynimbus/settings/aws/list-cognito.blacklist \
	~/.polynimbus/settings/aws/list-compute.blacklist \
	~/.polynimbus/settings/aws/list-storage.blacklist \
	~/.polynimbus/settings/aws/list-databases.blacklist \
	~/.polynimbus/settings/aws/list-encryption.blacklist \
	~/.polynimbus/settings/aws/list-serverless.blacklist \
	~/.polynimbus/settings/aws/s3-backup.blacklist \
	~/.polynimbus/settings/google/api.blacklist \
	~/.polynimbus/settings/google/storage.blacklist \
	~/.polynimbus/settings/google/get-iam-policy.blacklist

crontab=`/opt/polynimbus/common/get-crontab-name.sh`
if ! grep -q /opt/polynimbus/inventory/cron $crontab; then
	echo "setting up crontab entries"
	echo "$((RANDOM%60))  */6 * * * root /opt/polynimbus/inventory/cron/process-compute-instances.sh" >>$crontab
	echo "$((RANDOM%60))  */4 * * * root /opt/polynimbus/inventory/cron/process-storage.sh" >>$crontab
	echo "$((RANDOM%60)) 7,17 * * * root /opt/polynimbus/inventory/cron/process-dns.sh" >>$crontab
	echo "$((RANDOM%60)) 7,17 * * * root /opt/polynimbus/inventory/cron/process-pools.sh" >>$crontab
	echo "$((RANDOM%60)) 7,17 * * * root /opt/polynimbus/inventory/cron/process-databases.sh" >>$crontab
	echo "$((RANDOM%60)) 8,18 * * * root /opt/polynimbus/inventory/cron/process-serverless.sh" >>$crontab
	echo "$((RANDOM%60)) 8,18 * * * root /opt/polynimbus/inventory/cron/process-users.sh" >>$crontab
	echo "$((RANDOM%60))    8 * * * root /opt/polynimbus/inventory/cron/daily.sh" >>$crontab
fi
