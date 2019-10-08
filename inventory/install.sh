#!/bin/bash
# optional Polynimbus Inventory component

/opt/polynimbus/install.sh

echo "setting up Polynimbus Inventory directories and files"
mkdir -p -m 0700 /var/cache/polynimbus/inventory
chmod 0710 /var/cache/polynimbus
chown root:www-data /var/cache/polynimbus
chown www-data:www-data /var/cache/polynimbus/inventory

touch \
	/var/cache/polynimbus/aws/list-sg.blacklist \
	/var/cache/polynimbus/aws/list-users.blacklist \
	/var/cache/polynimbus/aws/list-zones.blacklist \
	/var/cache/polynimbus/google/get-iam-policy.blacklist

if ! grep -q /opt/polynimbus/inventory/cron /etc/crontab; then
	echo "setting up crontab entries"
	echo "$((RANDOM%60)) * * * * root /opt/polynimbus/inventory/cron/hourly.sh" >>/etc/crontab
	echo "$((RANDOM%60)) 8 * * * root /opt/polynimbus/inventory/cron/daily.sh" >>/etc/crontab
fi
