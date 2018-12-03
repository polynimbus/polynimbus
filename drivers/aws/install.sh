#!/bin/sh
# http://docs.aws.amazon.com/cli/latest/userguide/installing.html

mkdir -p /etc/polynimbus/aws /var/cache/polynimbus/aws/tmp /var/cache/polynimbus/aws/describe-images
chown root:www-data /var/cache/polynimbus/aws
chmod 0710 /var/cache/polynimbus/aws
chmod 0700 /var/cache/polynimbus/aws/tmp
touch      /var/cache/polynimbus/aws/list-users.blacklist
touch      /var/cache/polynimbus/aws/list-zones.blacklist
touch      /var/cache/polynimbus/aws/list-sg.blacklist

# TODO: this will work on Debian/Ubuntu only
REL=`lsb_release -cs`

if grep -qFx $REL /opt/polynimbus/drivers/aws/config/awscli-system-repo.conf; then
	/opt/polynimbus/common/install-packages.sh awscli
else
	# TODO: these package names are good for Debian/Ubuntu only
	/opt/polynimbus/common/install-packages.sh libyaml-dev libpython-dev python-yaml python-pip
	/opt/polynimbus/common/install-pip.sh awscli
fi
