#!/bin/sh
# https://docs.microsoft.com/pl-pl/cli/azure/install-azure-cli-apt?view=azure-cli-latest

mkdir -p /etc/polynimbus/azure /var/cache/polynimbus/azure
chmod 0700 /var/cache/polynimbus/azure
touch /var/cache/polynimbus/azure/created.list

KEY="https://packages.microsoft.com/keys/microsoft.asc"
echo "checking for Microsoft Azure repository"

if [ -f /etc/redhat-release ] && [ ! -f /etc/yum.repos.d/azure-cli.repo ]; then
	echo "setting up Microsoft yum repository"
	rpm --import $KEY
	echo "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=$KEY" >/etc/yum.repos.d/azure-cli.repo

elif [ -f /etc/debian_version ] && [ ! -f /etc/apt/sources.list.d/azure-cli.list ]; then
	/opt/polynimbus/common/install-packages.sh apt-transport-https
	REL=`lsb_release -cs`
	if grep -qFx $REL /opt/polynimbus/drivers/azure/config/azcli-system-repo.conf; then
		echo "setting up Microsoft apt repository"
		echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $REL main" >/etc/apt/sources.list.d/azure-cli.list
		curl -sS -L $KEY |apt-key add -
		apt-get update
	fi
fi

/opt/polynimbus/common/install-packages.sh keyutils azure-cli
