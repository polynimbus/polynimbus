#!/bin/sh
. /opt/polynimbus/common/functions

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f /etc/polynimbus/alibaba/$1.sh ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

account=$1
aliyuncli configure --profile $account

if ! grep -q "\[profile $account\]" /root/.aliyuncli/credentials; then
	echo "error: cloud account \"$account\" left unconfigured"
	exit 1
fi

DEFAULT_INSTANCE_TYPE="`input \"enter Alibaba Cloud default instance type\" ecs.g5.large`"

echo "#!/bin/sh
#
# Polynimbus requires aliyuncli command line client, which support
# multiple configured Alibaba Cloud accounts. This variable links this
# profile with account configuration.
#
export ALIBABA_PROFILE_NAME=$account
#
# default instance type to use, when type isn't explicitely specified
#
export ALIBABA_DEFAULT_INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE
" >/etc/polynimbus/alibaba/$account.sh
chmod 0600 /etc/polynimbus/alibaba/$account.sh
