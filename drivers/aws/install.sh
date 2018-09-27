#!/bin/bash
# http://docs.aws.amazon.com/cli/latest/userguide/installing.html

mkdir -p /etc/polynimbus/aws /var/cache/polynimbus/aws/tmp /var/cache/polynimbus/aws/describe-images
chown root:www-data /var/cache/polynimbus/aws
chmod 0710 /var/cache/polynimbus/aws
chmod 0700 /var/cache/polynimbus/aws/tmp


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
	/opt/polynimbus/common/install-pip.sh awscli
fi
