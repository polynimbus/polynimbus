#!/bin/bash
# optional Polynimbus Inventory component

/opt/polynimbus/install.sh

echo "setting up Polynimbus Inventory directories and files"
mkdir -p -m 0700 \
	/var/cache/polynimbus/inventory \
	/var/cache/polynimbus/storage \
	/var/cache/polynimbus/aws/s3cmd \
	/var/cache/polynimbus/linode/s3cmd \
	/var/cache/polynimbus/azure/storage-accounts

chmod 0710 /var/cache/polynimbus
chown root:www-data /var/cache/polynimbus
chown www-data:www-data /var/cache/polynimbus/inventory /var/cache/polynimbus/storage

touch \
	/var/cache/polynimbus/aws/list-nosql.blacklist \
	/var/cache/polynimbus/aws/list-users.blacklist \
	/var/cache/polynimbus/aws/list-zones.blacklist \
	/var/cache/polynimbus/aws/list-trails.blacklist \
	/var/cache/polynimbus/aws/list-cognito.blacklist \
	/var/cache/polynimbus/aws/list-compute.blacklist \
	/var/cache/polynimbus/aws/list-storage.blacklist \
	/var/cache/polynimbus/aws/list-databases.blacklist \
	/var/cache/polynimbus/aws/list-encryption.blacklist \
	/var/cache/polynimbus/aws/list-serverless.blacklist \
	/var/cache/polynimbus/aws/s3-backup.blacklist \
	/var/cache/polynimbus/google/api.blacklist \
	/var/cache/polynimbus/google/storage.blacklist \
	/var/cache/polynimbus/google/get-iam-policy.blacklist

if ! grep -q /opt/polynimbus/inventory/cron /etc/crontab; then
	echo "setting up crontab entries"
	echo "$((RANDOM%60))  */6 * * * root /opt/polynimbus/inventory/cron/process-compute-instances.sh" >>/etc/crontab
	echo "$((RANDOM%60))  */4 * * * root /opt/polynimbus/inventory/cron/process-storage.sh" >>/etc/crontab
	echo "$((RANDOM%60)) 7,17 * * * root /opt/polynimbus/inventory/cron/process-dns.sh" >>/etc/crontab
	echo "$((RANDOM%60)) 7,17 * * * root /opt/polynimbus/inventory/cron/process-pools.sh" >>/etc/crontab
	echo "$((RANDOM%60)) 7,17 * * * root /opt/polynimbus/inventory/cron/process-databases.sh" >>/etc/crontab
	echo "$((RANDOM%60)) 8,18 * * * root /opt/polynimbus/inventory/cron/process-serverless.sh" >>/etc/crontab
	echo "$((RANDOM%60)) 8,18 * * * root /opt/polynimbus/inventory/cron/process-users.sh" >>/etc/crontab
	echo "$((RANDOM%60))    8 * * * root /opt/polynimbus/inventory/cron/daily.sh" >>/etc/crontab
fi
