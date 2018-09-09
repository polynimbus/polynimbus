#!/bin/bash
# http://docs.aws.amazon.com/cli/latest/userguide/installing.html

mkdir -p /etc/polynimbus/aws /var/cache/polynimbus

if ! grep -q /opt/polynimbus/drivers/aws/cron /etc/crontab; then
	echo "setting up crontab entry"
	echo "$((RANDOM%60)) 8 * * * root /opt/polynimbus/drivers/aws/cron/update.sh" >>/etc/crontab
fi

# TODO: this will work on Debian/Ubuntu only
REL=`lsb_release -cs`

if grep -qFx $REL /opt/polynimbus/drivers/aws/config/awscli-system-repo.conf; then
	/opt/polynimbus/common/install-packages.sh awscli
else
	# TODO: these package names are good for Debian/Ubuntu only
	/opt/polynimbus/common/install-packages.sh libyaml-dev libpython-dev python-yaml python-pip

	echo "checking for pip package awscli"
	if [ "`pip list |grep awscli`" = "" ]; then
		pip install awscli
	else
		pip install --upgrade awscli
	fi
fi
