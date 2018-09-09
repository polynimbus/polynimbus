#!/bin/sh

install_deb() {
	pkg=$1
	echo "checking for debian package $pkg"
	if [ "`dpkg -l $pkg 2>/dev/null |grep ^ii`" = "" ]; then
		echo "installing package $pkg"
		apt-get install $pkg
	fi
}

install_rpm() {
	pkg=$1
	echo "checking for rpm package $pkg"
	if ! rpm --quiet -q $pkg; then
		echo "installing package $pkg"
		yum install $pkg
	fi
}

install_suse() {
	pkg=$1
	echo "checking for suse package $pkg"
	if ! rpm --quiet -q $pkg; then
		echo "installing package $pkg"
		aptitude install $pkg
	fi
}


if [ "$1" = "" ]; then
	echo "usage: $0 <package> [package] [...]"
	exit
fi

for package in $@; do
	if [ -f /etc/debian_version ]; then
		install_deb $package
	elif [ -f /etc/redhat-release ]; then
		install_rpm $package
	elif [ -f /etc/SuSE-release ]; then
		install_suse $package
	fi
done
