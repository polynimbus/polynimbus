#!/bin/bash

# don't try to install php-cli automatically - there are
# too many different versions and possible configurations
if [ "`which php 2>/dev/null`" = "" ]; then
	echo "error: php not found"
	exit 1
fi

if [ ! -e ~/.polynimbus ]; then
	echo "setting up Polynimbus directories"
	mkdir -p -m 0700 ~/.polynimbus ~/.polynimbus/ssh
fi

for vendor in `ls /opt/polynimbus/drivers`; do
	/opt/polynimbus/drivers/$vendor/install.sh
done

if ! grep -q /opt/polynimbus/common /etc/crontab; then
	echo "setting up crontab entries"
	echo "$((RANDOM%60)) */8 * * * root /opt/polynimbus/common/cron-test-accounts.sh" >>/etc/crontab
	echo "$((RANDOM%60)) 8 * * * root /opt/polynimbus/common/cron-daily.sh" >>/etc/crontab
fi
