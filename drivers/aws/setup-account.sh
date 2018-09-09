#!/bin/sh
. /opt/polynimbus/common/functions

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f /etc/polynimbus/aws/$1.sh ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

account=$1
aws configure --profile $account

if ! grep -q "\[$account\]" /root/.aws/credentials; then
	echo "error: cloud account \"$account\" left unconfigured"
	exit 1
fi

DEFAULT_INSTANCE_TYPE="`input \"enter EC2 default instance type\" t2.micro`"

echo "#!/bin/sh
#
# Polynimbus requires awscli AWS command line client, which support
# multiple configured AWS accounts. This variable links this profile
# with account configuration.
#
export EC2_PROFILE_NAME=$account
#
# default instance type to use, when type isn't explicitely specified
#
export EC2_DEFAULT_INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE
" >/etc/polynimbus/aws/$account.sh
chmod 0600 /etc/polynimbus/aws/$account.sh
