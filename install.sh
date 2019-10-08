#!/bin/bash

# don't try to install php-cli automatically - there are
# too many different versions and possible configurations
if [ "`which php 2>/dev/null`" = "" ]; then
	echo "error: php not found"
	exit 1
fi

echo "setting up Polynimbus directories"
mkdir -p -m 0700 /etc/polynimbus /var/cache/polynimbus/ssh

/opt/polynimbus/drivers/alibaba/install.sh
/opt/polynimbus/drivers/aws/install.sh
/opt/polynimbus/drivers/azure/install.sh
/opt/polynimbus/drivers/e24/install.sh
/opt/polynimbus/drivers/google/install.sh
/opt/polynimbus/drivers/hetzner/install.sh
/opt/polynimbus/drivers/oracle/install.sh
/opt/polynimbus/drivers/rackspace/install.sh

if ! grep -q /opt/polynimbus/common /etc/crontab; then
	echo "setting up crontab entries"
	echo "$((RANDOM%60)) */8 * * * root /opt/polynimbus/common/cron-test-accounts.sh" >>/etc/crontab
	echo "$((RANDOM%60)) 8 * * * root /opt/polynimbus/common/cron-daily.sh" >>/etc/crontab
fi
