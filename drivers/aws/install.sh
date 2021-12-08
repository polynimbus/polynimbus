#!/bin/sh
# http://docs.aws.amazon.com/cli/latest/userguide/installing.html

mkdir -p ~/.polynimbus/cache/aws/tmp ~/.polynimbus/cache/aws/describe-images ~/.aws
chown root:www-data ~/.polynimbus/cache/aws
chmod 0710 ~/.polynimbus/cache/aws
chmod 0700 ~/.polynimbus/cache/aws/tmp

touch ~/.aws/credentials
chmod 0600 ~/.aws/credentials

# TODO: this will work on Debian/Ubuntu only
REL=`lsb_release -cs`

if grep -qFx $REL /opt/polynimbus/drivers/aws/config/awscli-system-repo.conf; then
	/opt/polynimbus/common/install-packages.sh awscli
else
	# TODO: these package names are good for Debian/Ubuntu only
	/opt/polynimbus/common/install-packages.sh libyaml-dev libpython2-dev python2
	/opt/polynimbus/compat/python2/install-compat-pip2.sh
	/opt/polynimbus/common/install-pip.sh awscli
fi
